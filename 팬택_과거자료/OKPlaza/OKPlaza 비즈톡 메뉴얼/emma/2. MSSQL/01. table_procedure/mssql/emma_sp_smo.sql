/**
 * @(#)emma_sp_smo.sql
 * Copyright 2008 InfoBank Corporation. All rights reserved.
 * emma smo table ddl & dml.
 *
 * SMS MO 서비스를 위한 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */


-- USE imds
-- GO

/****************************************************************************/
/* NAME : sp_em_smo_create                                                  */
/* DESC : SMSMO 서비스 관련 테이블을 생성한다.                              */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   em_mo_tran :  SMSMO, 수신 테이블                                       */
/*   SMSMO, MMSMO 는 em_mo_tran, em_mo_log_yyyymm을 같이 사용한다.          */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smo_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smo_create
GO

CREATE PROCEDURE sp_em_smo_create
AS

    IF NOT EXISTS (
          SELECT TABLE_NAME
          FROM   INFORMATION_SCHEMA.TABLES
          WHERE  TABLE_NAME = 'em_mo_tran'
    )
    BEGIN
        CREATE TABLE em_mo_tran
        ( mo_key        varchar(50) COLLATE Korean_Wansung_CS_AS NOT NULL
        , service_type  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , mo_recipient  varchar(32) COLLATE Korean_Wansung_CS_AS NOT NULL
        , emo_recipient varchar(80) COLLATE Korean_Wansung_CS_AS
        , mo_originator varchar(32) COLLATE Korean_Wansung_CS_AS NOT NULL
        , mo_callback   varchar(32) COLLATE Korean_Wansung_CS_AS
        , msg_status    char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL default '3'
        , subject       varchar(80) COLLATE Korean_Wansung_CS_AS
        , content       text
        , date_mo       datetime                                 NOT NULL
        , date_mo_recv  datetime                                 NOT NULL default '1970-01-01 00:00:00'
        , carrier       int
        , rs_id         varchar(20) COLLATE Korean_Wansung_CS_AS
        , ems_id        int
        , ems_total     int
        , ems_seq       int
        , emma_id       char(2) default ' '
        )
        
        ALTER TABLE em_mo_tran  ADD PRIMARY KEY( mo_key )
        
        CREATE INDEX idx_em_mo_tran_1 ON em_mo_tran(date_mo, mo_originator)
        CREATE INDEX idx_em_mo_tran_2 ON em_mo_tran(carrier)

    END

RETURN
GO
    

/****************************************************************************/
/* NAME : sp_em_smo_log_create                                              */
/* DESC : SMSMO 로그 테이블을 생성한다.                                     */
/* PARAMETERS                                                               */
/*   p_log_table : 로그테이블 변경 postfix(년월)                            */
/* REMARK                                                                   */
/*   p_log_table이 YYYYMM이 default이지만 값을 변경하면 YYYY등의 확장 가능  */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smo_log_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smo_log_create
GO

CREATE PROCEDURE sp_em_smo_log_create
    @p_log_table varchar(6) 
AS

    DECLARE @dsql nvarchar(2000)

    IF @p_log_table <> ''
    BEGIN

    IF NOT EXISTS (
        SELECT TABLE_NAME
        FROM   INFORMATION_SCHEMA.TABLES
        WHERE  TABLE_NAME = 'em_mo_log_'+@p_log_table
    )
    BEGIN
 
        select @dsql = '
               CREATE TABLE em_mo_log_' + @p_log_table + '
               ( mo_key        varchar(50) COLLATE Korean_Wansung_CS_AS NOT NULL
               , service_type  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
               , mo_recipient  varchar(32) COLLATE Korean_Wansung_CS_AS NOT NULL
               , emo_recipient varchar(80) COLLATE Korean_Wansung_CS_AS
               , mo_originator varchar(32) COLLATE Korean_Wansung_CS_AS NOT NULL
               , mo_callback   varchar(32) COLLATE Korean_Wansung_CS_AS
               , msg_status    char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL default ''3''
               , subject       varchar(80) COLLATE Korean_Wansung_CS_AS
               , content       text
               , date_mo       datetime    NOT NULL
               , date_mo_recv  datetime    NOT NULL default ''1970-01-01 00:00:00''
               , carrier       int
               , rs_id         varchar(20) COLLATE Korean_Wansung_CS_AS
               , ems_id        int
               , ems_total     int
               , ems_seq       int
               , emma_id       char(2)     default '' ''
               )'
    
            EXEC (@dsql)
    
            EXEC ('ALTER TABLE em_mo_log_'+@p_log_table+' ADD PRIMARY KEY ( mo_key )')

            EXEC ('CREATE INDEX idx_em_mo_log_'+@p_log_table+'_1 ON em_mo_log_'+@p_log_table+' (date_mo, mo_originator)')
            EXEC ('CREATE INDEX idx_em_mo_log_'+@p_log_table+'_2 ON em_mo_log_'+@p_log_table+' (carrier)')

        END
    END

RETURN
GO


/*******************************************************************************************************************************************/
/* NAME : sp_em_smo_tran_insert                                                                                                            */
/* DESC : SMS MO 수신 데이터를 em_mo_log_yyyymm 테이블에 Insert한다.                                                                       */
/* PARAMETERS                                                                                                                              */
/*   IN p_rs_id : 수신된 인포뱅크 G/W (RS) 정보                                                                                            */
/*   IN p_client_msg_key : 인포뱅크 G/W가 보내온 메시지 키                                                                                 */
/*   IN p_mo_recipient   : mo 번호 (특번)                                                                                                  */
/*   IN p_emo_recipient  : mo 추가 번호 (특번), emo 번호                                                                                   */
/*   IN p_originator     : mo 보낸 핸드폰 원래 번호                                                                                        */
/*   IN p_mo_callback    : mo 보낸 핸드폰에서 입력된 회신번호                                                                              */
/*   IN p_msg_status     : 메시지 상태 3 MO 접수                                                                                           */
/*   IN p_content        : 메시지 내용                                                                                                     */
/*   IN p_date_mo        : mo 발생 시간                                                                                                    */
/*   IN p_carrier        : 착신망 정보 10001(SKT), 10002(KTF), 10003(LGT), 10000(ETC)                                                      */
/*   IN p_emsvalue       : LGU+ EMS MO 인 경우 사용.                                                                                       */
/*                         LGU+ 일부 단말에서 sms mo 를 80바이트 이상 장문으로 보내면 80바이트씩 나누어 보내주는 경우에 사용되는 value 값. */
/*                         메시지 내용의 앞부분 1byte 값이 sequence 이며, 1byte 값을 받음.                                                 */
/*   IN p_emma_id        : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함)                     */
/* REMARK                                                                                                                                  */
/*   N/A                                                                                                                                   */
/*******************************************************************************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smo_tran_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smo_tran_insert
GO

CREATE PROCEDURE sp_em_smo_tran_insert
    @p_rs_id VARCHAR(20)
  , @p_client_msg_key VARCHAR(50)
  , @p_mo_recipient   VARCHAR(32)
  , @p_emo_recipient  VARCHAR(80)
  , @p_originator     VARCHAR(32)
  , @p_mo_callback    VARCHAR(32)
  , @p_msg_status     CHAR(1)
  , @p_content        text
  , @p_date_mo        DATETIME
  , @p_carrier        int
  , @p_emsvalue       int
  , @p_emma_id        CHAR(2)
AS

    DECLARE @dsql        nvarchar(3000)
          , @v_param     nvarchar(1000)
          , @v_log_table varchar(6)
          , @v_ems_id    int
          , @v_ems_total int
          , @v_ems_seq   int
          , @v_mokey     varchar(50)
    
    /* set log table name */
    SET @v_log_table = convert(varchar, @p_date_mo, 112)

    IF @p_emsvalue <> 0
    BEGIN
        SET @v_ems_id    = @p_emsvalue/256
        SET @v_ems_total = (@p_emsvalue%128)/16
        SET @v_ems_seq   = (@p_emsvalue%128)%16
    END
    ELSE BEGIN 
        SET @v_ems_id    = 0
        SET @v_ems_total = 0
        SET @v_ems_seq   = 0
    END

    /* log table check */
    EXEC sp_em_smo_log_create @v_log_table

    /* Check if record already exists. Avoids duplicate */
    SELECT @dsql = 'SELECT @pp_mokey = mo_key FROM em_mo_log_' + @v_log_table + ' WHERE mo_key = @pp_client_msg_key';
    SET    @v_param = '
           @pp_mokey VARCHAR(50) OUTPUT
         , @pp_client_msg_key VARCHAR(50)'
    EXECUTE sp_executesql @dsql
                        , @v_param
                        , @pp_mokey = @v_mokey OUTPUT
                        , @pp_client_msg_key = @p_client_msg_key;

    /* Exit , if mokey already exists */
    IF @v_mokey IS NOT NULL 
        SET @p_client_msg_key = @p_client_msg_key + '_' + Replace(Convert(varchar(12),Getdate(),114),':','') + '_' + Convert(varchar, ROUND(RAND()*10000, 0));

    SET @dsql = ' INSERT INTO em_mo_log_' + @v_log_table + ' ( '
 
    SET @dsql = @dsql + '
                              mo_key
                            , service_type
                            , mo_recipient
                            , emo_recipient
                            , mo_originator
                            , mo_callback
                            , msg_status
                            , subject
                            , content
                            , date_mo
                            , date_mo_recv
                            , carrier
                            , rs_id
                            , ems_id
                            , ems_total
                            , ems_seq
                            , emma_id )
                  VALUES    ( @pp_client_msg_key
                            , ''4''
                            , @pp_mo_recipient
                            , @pp_emo_recipient
                            , @pp_originator
                            , @pp_mo_callback
                            , @pp_msg_status
                            , ''''
                            , @pp_content
                            , @pp_date_mo
                            , getdate()
                            , @pp_carrier
                            , @pp_rs_id
                            , @pp_ems_id
                            , @pp_ems_total
                            , @pp_ems_seq
                            , @pp_emma_id ) '

    SET @v_param = '
        @pp_client_msg_key VARCHAR(50)
      , @pp_mo_recipient VARCHAR(32)
      , @pp_emo_recipient VARCHAR(80)
      , @pp_originator VARCHAR(32)
      , @pp_mo_callback VARCHAR(32)
      , @pp_msg_status CHAR(1)
      , @pp_content text
      , @pp_date_mo DATETIME
      , @pp_carrier int
      , @pp_rs_id VARCHAR(20)
      , @pp_ems_id INT
      , @pp_ems_total INT
      , @pp_ems_seq INT
      , @pp_emma_id CHAR(2)'

    EXECUTE sp_executesql @dsql, @v_param
                        , @pp_client_msg_key = @p_client_msg_key
                        , @pp_mo_recipient   = @p_mo_recipient
                        , @pp_emo_recipient  = @p_emo_recipient
                        , @pp_originator     = @p_originator
                        , @pp_mo_callback    = @p_mo_callback
                        , @pp_msg_status     = @p_msg_status
                        , @pp_content        = @p_content
                        , @pp_date_mo        = @p_date_mo
                        , @pp_carrier        = @p_carrier
                        , @pp_rs_id          = @p_rs_id
                        , @pp_ems_id         = @v_ems_id
                        , @pp_ems_total      = @v_ems_total
                        , @pp_ems_seq        = @v_ems_seq
                        , @pp_emma_id        = @p_emma_id


RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smo_tran_delete                                             */
/* DESC : 수신된 SMS MO Packet을 SMO Tran 테이블에서 Delete, 중복키 방지    */
/* PARAMETERS                                                               */
/*   IN p_client_msg_key : 인포뱅크 G/W가 보내온 메시지 키                  */
/*   IN p_date_mo : mo 발생 시간                                            */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smo_tran_delete' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smo_tran_delete
GO

CREATE PROCEDURE sp_em_smo_tran_delete
    @p_client_msg_key VARCHAR(50)
  , @p_date_mo        DATETIME
AS

    DECLARE @dsql nvarchar(200)
          , @v_param  nvarchar(100)
          , @v_log_table varchar(6)

    /* set log table name */
    SET @v_log_table = convert(varchar, @p_date_mo, 112)

    /* log table check */
    EXEC sp_em_smo_log_create @v_log_table

    SET @dsql = ' DELETE FROM em_mo_log_' + @v_log_table + ' WHERE mo_key = @pp_client_msg_key '

    SET @v_param = ' @pp_client_msg_key VARCHAR(50) '

    EXECUTE sp_executesql @dsql, @v_param, @pp_client_msg_key = @p_client_msg_key

RETURN
