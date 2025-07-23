/**
 * @(#)emma_sp_smt.sql
 * Copyright 2008 InfoBank Corporation. All rights reserved.
 * emma smt table ddl & dml.
 *
 * SMS MT 서비스를 위한 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */


-- USE imds
-- GO

/****************************************************************************/
/* NAME : sp_em_smt_create                                                  */
/* DESC : SMSMT 서비스 관련 테이블을 생성한다.                              */  
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   em_smt_tran   :  SMSMT 전송 테이블                                     */
/*   em_smt_client : 동보 전송을 위한 수신번호 테이블(em_smt_tran의 Detail) */
/****************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_create
GO

CREATE PROCEDURE sp_em_smt_create
AS

    IF NOT EXISTS (
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'em_smt_tran'
	)
    BEGIN
        CREATE TABLE em_smt_tran
        ( mt_pr                 int identity(1,1)                         NOT NULL
        , msg_key               varchar(20)  COLLATE Korean_Wansung_CS_AS
        , input_type            char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default '0' 
        , mt_refkey             varchar(20)  COLLATE Korean_Wansung_CS_AS
        , priority              char(2)      COLLATE Korean_Wansung_CS_AS NOT NULL default 'S'
        , date_client_req       datetime                                  NOT NULL default '1970-01-01 00:00:00'
        , content               varchar(255) COLLATE Korean_Wansung_CS_AS NOT NULL
        , callback              varchar(25)  COLLATE Korean_Wansung_CS_AS NOT NULL
        , service_type          char(2)      COLLATE Korean_Wansung_CS_AS NOT NULL
        , broadcast_yn          char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default 'N'
        , msg_status            char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default '1'
        , recipient_num         varchar(25)  COLLATE Korean_Wansung_CS_AS
        , date_mt_sent          datetime
        , date_rslt             datetime
        , date_mt_report        datetime
        , mt_report_code_ib     char(4)      COLLATE Korean_Wansung_CS_AS
        , mt_report_code_ibtype char(1)      COLLATE Korean_Wansung_CS_AS
        , carrier               int
        , rs_id                 varchar(20)  COLLATE Korean_Wansung_CS_AS
        , recipient_net         int
        , recipient_npsend      char(1)      COLLATE Korean_Wansung_CS_AS
        , country_code          varchar(8)   COLLATE Korean_Wansung_CS_AS NOT NULL default '82'
        , charset               varchar(20)  COLLATE Korean_Wansung_CS_AS
        , msg_type              int
        , crypto_yn             char(1)      COLLATE Korean_Wansung_CS_AS          default 'Y'
        , ttl                   int
        , emma_id               char(2)      COLLATE Korean_Wansung_CS_AS          default ' '
        , reg_date              datetime                                           DEFAULT getdate()
        , mt_res_cnt            int
        , client_sub_id         varchar(20)  COLLATE Korean_Wansung_CS_AS
        )
        
        ALTER TABLE em_smt_tran  ADD PRIMARY KEY ( mt_pr )
        
        CREATE INDEX idx_em_smt_tran_1 ON em_smt_tran (msg_status, date_client_req)
        CREATE INDEX idx_em_smt_tran_2 ON em_smt_tran (recipient_num)
        CREATE INDEX idx_em_smt_tran_3 ON em_smt_tran (emma_id)
        CREATE INDEX idx_em_smt_tran_4 ON em_smt_tran (msg_key)

    END

    IF NOT EXISTS (
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'em_smt_client'
    )
    BEGIN
        CREATE TABLE em_smt_client
        ( mt_pr                 int                                      NOT NULL
        , mt_seq                int                                      NOT NULL
        , msg_status            char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL default '1'
        , recipient_num         varchar(25) COLLATE Korean_Wansung_CS_AS NOT NULL
        , change_word1          varchar(20) COLLATE Korean_Wansung_CS_AS
        , change_word2          varchar(20) COLLATE Korean_Wansung_CS_AS
        , change_word3          varchar(20) COLLATE Korean_Wansung_CS_AS
        , change_word4          varchar(20) COLLATE Korean_Wansung_CS_AS
        , change_word5          varchar(20) COLLATE Korean_Wansung_CS_AS
        , date_mt_sent          datetime
        , date_rslt             datetime
        , date_mt_report        datetime
        , mt_report_code_ib     char(4)     COLLATE Korean_Wansung_CS_AS
        , mt_report_code_ibtype char(1)     COLLATE Korean_Wansung_CS_AS
        , carrier               int
        , rs_id                 varchar(20) COLLATE Korean_Wansung_CS_AS
        , recipient_net         int
        , recipient_npsend      char(1)     COLLATE Korean_Wansung_CS_AS
        , country_code          varchar(8)  COLLATE Korean_Wansung_CS_AS NOT NULL default '82'
        , reg_date              datetime                                          DEFAULT getdate()
        , mt_res_cnt            int
        )
        
        ALTER TABLE em_smt_client  ADD PRIMARY KEY ( mt_pr, mt_seq )

        CREATE INDEX idx_em_smt_client_1 ON em_smt_client (recipient_num)
        CREATE INDEX idx_em_smt_client_2 ON em_smt_client (msg_status)
    END

RETURN
GO
    

/****************************************************************************/
/* NAME : sp_em_smt_log_create                                              */
/* DESC : SMSMT 로그 테이블을 생성한다.                                     */
/* PARAMETERS                                                               */
/*   p_log_table : 로그테이블 변경 postfix(년월)                            */
/* REMARK                                                                   */
/*   p_log_table이 YYYYMM이 default이지만 값을 변경하면 YYYY등의 확장 가능  */
/****************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_log_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_log_create
GO

CREATE PROCEDURE sp_em_smt_log_create
    @p_log_table varchar(6) 
AS

    DECLARE @dsql nvarchar(4000)

    IF @p_log_table <> ''
    BEGIN

        IF NOT EXISTS (
            SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'em_smt_log_'+@p_log_table
        )
        BEGIN
 
            select @dsql = '
                CREATE TABLE em_smt_log_' + @p_log_table + '
                ( mt_pr                 int NOT NULL
                , mt_seq                int NOT NULL
                , msg_key               varchar(20)  COLLATE Korean_Wansung_CS_AS
        		, input_type            char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default ''0'' 
                , mt_refkey             varchar(20)  COLLATE Korean_Wansung_CS_AS
                , priority              char(2)      COLLATE Korean_Wansung_CS_AS NOT NULL default ''S''
                , date_client_req       datetime                                  NOT NULL default ''1970-01-01 00:00:00''
                , content               varchar(255) COLLATE Korean_Wansung_CS_AS NOT NULL
                , callback              varchar(25)  COLLATE Korean_Wansung_CS_AS NOT NULL
                , service_type          char(2)      COLLATE Korean_Wansung_CS_AS NOT NULL
                , broadcast_yn          char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default ''N''
                , msg_status            char(1)      COLLATE Korean_Wansung_CS_AS NOT NULL default ''1''
                , recipient_num         varchar(25)  COLLATE Korean_Wansung_CS_AS
                , change_word1          varchar(20)  COLLATE Korean_Wansung_CS_AS
                , change_word2          varchar(20)  COLLATE Korean_Wansung_CS_AS
                , change_word3          varchar(20)  COLLATE Korean_Wansung_CS_AS
                , change_word4          varchar(20)  COLLATE Korean_Wansung_CS_AS
                , change_word5          varchar(20)  COLLATE Korean_Wansung_CS_AS
                , date_mt_sent          datetime
                , date_rslt             datetime
                , date_mt_report        datetime
                , mt_report_code_ib     char(4)      COLLATE Korean_Wansung_CS_AS
                , mt_report_code_ibtype char(1)      COLLATE Korean_Wansung_CS_AS
                , carrier               int
                , rs_id                 varchar(20)  COLLATE Korean_Wansung_CS_AS
                , recipient_net         int
                , recipient_npsend      char(1)      COLLATE Korean_Wansung_CS_AS
                , country_code          varchar(8)   COLLATE Korean_Wansung_CS_AS NOT NULL default ''82''
                , charset               varchar(20)  COLLATE Korean_Wansung_CS_AS
                , msg_type              int
                , crypto_yn             char(1)      COLLATE Korean_Wansung_CS_AS          default ''Y''
                , ttl                   int
                , emma_id               char(2)      COLLATE Korean_Wansung_CS_AS          default '' ''
                , reg_date_tran         datetime
                , reg_date              datetime                                           DEFAULT getdate()
                , mt_res_cnt            int
                , client_sub_id         varchar(20)  COLLATE Korean_Wansung_CS_AS
                )'
    
            EXEC (@dsql)
    
            EXEC ('ALTER TABLE em_smt_log_'+@p_log_table+' ADD PRIMARY KEY ( mt_pr, mt_seq )')

            EXEC ('CREATE INDEX idx_em_smt_log_'+@p_log_table+'_1 ON em_smt_log_'+@p_log_table+' (date_client_req, recipient_num)')
            EXEC ('CREATE INDEX idx_em_smt_log_'+@p_log_table+'_2 ON em_smt_log_'+@p_log_table+' (date_mt_report, mt_report_code_ib)')
            EXEC ('CREATE INDEX idx_em_smt_log_'+@p_log_table+'_3 ON em_smt_log_'+@p_log_table+' (msg_status)')
            EXEC ('CREATE INDEX idx_em_smt_log_'+@p_log_table+'_4 ON em_smt_log_'+@p_log_table+' (msg_key)')

        END
    END

RETURN
GO


/**********************************************************************************************/
/* NAME : sp_em_smt_tran_select                                                               */
/* DESC : SMSMT 전송 테이블로 부터 전송할 메시지를 조회한다.                                  */
/* PARAMETERS                                                                                 */
/*   OUT p_list : Resultset                                                                   */
/*   IN p_service_type : 서비스 구분 (SMT, URL, SMT|URL)                                      */
/*   IN p_priority : 메시지 우선순위(VF/F/S)                                                  */
/*   IN p_ttl : 전송 유효 시간 (단위: 분)                                                     */
/*   IN p_emma_id : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/*   IN p_bancheck_yn : 수신차단테이블 체크 여부                                              */
/* REMARK                                                                                     */
/*   조회 결과의 필드명은 꼭 지켜져야 한다.                                                   */
/*   한번에 쿼리할 수 있는 개수는 조절 가능하지만, 변경 후 테스트가 필요하다.                 */
/**********************************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_tran_select' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_tran_select
GO

CREATE PROCEDURE sp_em_smt_tran_select
    @p_service_type varchar(20)
  , @p_priority char(2)
  , @p_ttl int
  , @p_emma_id char(2)
  , @p_bancheck_yn char(1)
  
AS

    DECLARE @dsql nvarchar(4000)
    DECLARE @v_params as nvarchar(500)

    /** update emma_id */
    IF @p_emma_id <> ' '
    BEGIN

    SET NOCOUNT ON

    SET  @dsql = '
         UPDATE em_smt_tran 
         SET    emma_id = @pp_emma_id
         WHERE  mt_pr in ( SELECT TOP 300 mt_pr 
         FROM   em_smt_tran
         WHERE  priority = @pp_priority
         AND    msg_status = @pp_msg_status 
         AND    date_client_req BETWEEN ( getdate() -  @pp_ttl/24/60) AND getdate() 
         AND    emma_id = '' '' '

    IF @p_service_type = 'SMT'
        SET @dsql = @dsql + ' AND service_type = ''0'' '
    
    IF @p_service_type = 'URL'
        SET @dsql = @dsql + ' AND service_type = ''1'' '
    
    SET @dsql = @dsql + ' ) '

    SET @v_params = '
        @pp_emma_id char(2)
      , @pp_priority char(2)
      , @pp_msg_status char(1)
      , @pp_ttl int '


    EXECUTE sp_executesql @dsql, @v_params
            , @pp_emma_id = @p_emma_id
            , @pp_priority = @p_priority
            , @pp_msg_status = '1'
            , @pp_ttl = @p_ttl

    /*
        if @@error != 0
        begin
            ROLLBACK TRAN
            RETURN
        end
        
        COMMIT TRAN
    */

    END

	/** real select */
    SET @dsql = '
        SELECT TOP 300
               A.mt_pr             AS mt_pr
             , A.mt_refkey         AS mt_refkey
             , A.content           AS content
             , A.priority          AS priority
             , A.broadcast_yn      AS broadcast_yn
             , A.callback          AS callback
             , A.recipient_num     AS recipient_num
             , A.recipient_net     AS recipient_net
             , A.recipient_npsend  AS recipient_npsend
             , A.country_code      AS country_code
             , A.date_client_req   AS date_client_req
             , A.charset           AS charset
             , A.msg_type          AS msg_type
             , A.crypto_yn         AS crypto_yn
             , A.service_type      AS service_type
             , A.ttl               AS ttl
             , A.client_sub_id     AS client_sub_id
             , B.ban_type          AS ban_type
             , B.send_yn           AS send_yn
        FROM   em_smt_tran A 
        LEFT OUTER JOIN em_banlist B 
        ON    A.recipient_num = B.content
        AND   A.service_type = B.service_type
        AND   B.ban_type = @pp_ban_type
        AND   B.ban_status_yn = @pp_ban_status_yn
        WHERE A.emma_id = @pp_emma_id
        AND   A.priority = @pp_priority
        AND   A.msg_status = @pp_msg_status 
        AND   A.date_client_req BETWEEN (dateadd(n, (-1) * @pp_ttl, getdate())) AND getdate() '

    IF @p_service_type = 'SMT'
        SET @dsql = @dsql + ' AND   A.service_type = ''0'' '
    
    IF @p_service_type = 'URL'
        SET @dsql = @dsql + ' AND   A.service_type = ''1'' '

    SET @v_params = '
          @pp_ban_type char(1)
        , @pp_ban_status_yn char(1)
        , @pp_emma_id char(2)
        , @pp_priority char(2)
        , @pp_msg_status char(1)
        , @pp_ttl int'

    EXECUTE sp_executesql @dsql, @v_params
                        , @pp_ban_type = 'R'
                        , @pp_ban_status_yn = 'Y'
                        , @pp_emma_id = @p_emma_id
                        , @pp_priority = @p_priority
                        , @pp_msg_status = '1'
                        , @pp_ttl = @p_ttl

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smt_client_select                                           */
/* DESC : SMSMT 동보 전송 테이블로 부터 전송할 메시지를 조회한다.           */
/* PARAMETERS                                                               */
/*   OUT p_list        : Resultset                                          */
/*   IN p_mt_pr        : 마스터테이블(EM_SMT_TRAN)의 전송키                 */
/*   IN p_service_type : 서비스 구분 (0: SMT, 1:URL, 2:MMT)                 */
/*   IN p_bancheck_yn  : 수신차단TABLE 체크 여부                            */
/* REMARK                                                                   */
/*   조회 결과의 필드명은 꼭 지켜져야 한다.                                 */
/*   한번에 쿼리할 수 있는 개수는 조절 가능하지만, 변경 후 테스트가 필요    */
/****************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_client_select' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_client_select
GO

CREATE PROCEDURE sp_em_smt_client_select
    @p_mt_pr int
  , @p_service_type char(2)
  , @p_bancheck_yn char(1)
AS

    SELECT top 300
           A.mt_pr             AS mt_pr
         , A.mt_seq            AS mt_seq
         , A.recipient_num     AS recipient_num
         , A.recipient_net     AS recipient_net
         , A.recipient_npsend  AS recipient_npsend
         , A.country_code      AS country_code
         , A.change_word1      AS change_word1
         , A.change_word2      AS change_word2
         , A.change_word3      AS change_word3
         , A.change_word4      AS change_word4
         , A.change_word5      AS change_word5
         , B.ban_type          AS ban_type
         , B.send_yn           AS send_yn
    FROM   em_smt_client A 
    LEFT OUTER JOIN em_banlist B 
    ON    A.recipient_num = B.content
    AND   B.service_type = @p_service_type
    AND   B.ban_type = 'R'
    AND   B.ban_status_yn = 'Y'
    WHERE A.mt_pr = @p_mt_pr
    AND   A.msg_status = '1'

RETURN
GO


/*************************************************************************************/
/* NAME : sp_em_smt_update                                                           */
/* DESC : SMS MT 발송을 위한 큐에 데이터 적재 후 상태정보를 업데이트 한다.           */
/* PARAMETERS                                                                        */
/*   IN p_table_divi            : 업데이트할 테이블(마스터/디테일 ) 구분             */
/*   IN p_update_all            : 동보테이블 전체 업데이트 여부                      */
/*   IN p_mt_pr                 : 마스터 테이블 키                                   */
/*   IN p_mt_seq                : 디테일 테이블 키(개별전송시 0, 동보전송시 해당순번 */
/*   IN p_msg_status            : 메시지 상태 (정상-2, 실패-3)                       */
/*   IN p_mt_report_code_ib     : 오류시 결과 코드                                   */
/*   IN p_mt_report_code_ibtype : 오류결과코드분류                                   */
/*   IN p_msg_key 				: 전송키                                   */
/* REMARK                                                                            */
/*   N/A                                                                             */
/*************************************************************************************/    
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_update' 
    AND    type = 'P' )
    DROP   PROCEDURE sp_em_smt_update
GO

CREATE PROCEDURE sp_em_smt_update
    @p_table_divi               char(1)
  , @p_update_all_yn            char(1)
  , @p_mt_pr                    int
  , @p_mt_seq                   int
  , @p_msg_status               char(1)
  , @p_mt_report_code_ib        char(4)
  , @p_mt_report_code_ibtype    char(1)
  , @p_msg_key				  varchar(20)
AS

    DECLARE @dsql        nvarchar(1000)
    DECLARE @v_params as nvarchar(200)

    IF @p_table_divi = 'M'
        SET @dsql = ' UPDATE em_smt_tran SET  msg_key = @pp_msg_key, '
    ELSE
        SET @dsql = ' UPDATE em_smt_client SET '
 
    SET @dsql = @dsql + '
        msg_status            = @pp_msg_status,
        mt_report_code_ib     = @pp_mt_report_code_ib,
        mt_report_code_ibtype = @pp_mt_report_code_ibtype,
        date_mt_sent          = getdate() '

    IF @p_msg_status = '3'
        SET @dsql = @dsql + ' , date_rslt  = getdate() '

    SET @dsql = @dsql + ' WHERE mt_pr  = @pp_mt_pr '

    IF ( @p_table_divi = 'D' AND @p_update_all_yn = 'N' )
        SET @dsql = @dsql + ' AND mt_seq  = ' + convert(varchar(11), @p_mt_seq) 

    SET @v_params = '@pp_msg_status char(1)
                   , @pp_mt_report_code_ib char(4)
                   , @pp_mt_report_code_ibtype char(1)
                   , @pp_mt_pr int'

     IF @p_table_divi = 'M'
     
      BEGIN
    	 SET @v_params = @v_params + ', @pp_msg_key varchar(20) '
    	 EXECUTE sp_executesql @dsql
                        , @v_params
                        , @pp_msg_status = @p_msg_status
                        , @pp_mt_report_code_ib = @p_mt_report_code_ib
                        , @pp_mt_report_code_ibtype = @p_mt_report_code_ibtype
                        , @pp_mt_pr = @p_mt_pr
                        , @pp_msg_key               = @p_msg_key
      END                        
    ELSE
	    EXECUTE sp_executesql @dsql
                        , @v_params
                        , @pp_msg_status = @p_msg_status
                        , @pp_mt_report_code_ib = @p_mt_report_code_ib
                        , @pp_mt_report_code_ibtype = @p_mt_report_code_ibtype
                        , @pp_mt_pr = @p_mt_pr
	                        
    

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smt_tran_rslt_update                                        */
/* DESC : SMS MT 이통사 전송 결과를 업데이트 한다.                          */
/* PARAMETERS                                                               */
/*   IN p_mt_report_code_ib     : 이통사 결과코드                           */
/*   IN p_mt_report_code_ibtype : 이통사 결과코드 분류                      */
/*   IN p_rs_id                 : 전송 IB RS아이디                          */
/*   IN p_client_msg_key        : 전송키(msg_key)                             */
/*   IN p_msg_status            : 전송키의 하위 순번(mt_seq)                */
/*   IN p_carrier               : 전송 이통사 코드                          */
/*   IN p_date_rslt             : 단말기 도착시각                           */
/*   IN p_mt_res_cnt            : 중국 국제 문자 report count                     */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/    
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_tran_rslt_update' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_tran_rslt_update
GO

CREATE PROCEDURE sp_em_smt_tran_rslt_update
    @p_mt_report_code_ib        char(4)
  , @p_mt_report_code_ibtype    char(1)
  , @p_rs_id                    varchar(20)
  , @p_client_msg_key           varchar(20)
  , @p_recipient_order          int
  , @p_carrier                  int
  , @p_date_rslt                datetime
  , @p_mt_res_cnt               int
AS

    UPDATE em_smt_tran
    SET    msg_status             = '3'
         , date_rslt              = @p_date_rslt
         , date_mt_report         = getdate() 
         , mt_report_code_ib      = @p_mt_report_code_ib
         , mt_report_code_ibtype  = @p_mt_report_code_ibtype
         , carrier                = @p_carrier
         , rs_id                  = @p_rs_id
         , mt_res_cnt             = @p_mt_res_cnt
    WHERE  msg_key = @p_client_msg_key

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smt_client_rslt_update                                      */
/* DESC : SMS MT 동보 이통사 전송 결과를 업데이트 한다.                     */
/* PARAMETERS                                                               */
/*   IN p_mt_report_code_ib     : 이통사 결과코드                           */
/*   IN p_mt_report_code_ibtype : 이통사 결과코드 분류                      */
/*   IN p_rs_id                 : 전송 IB RS아이디                          */
/*   IN p_client_msg_key        : 전송키(msg_key)                             */
/*   IN p_msg_status            : 전송키의 하위 순번(mt_seq)                */
/*   IN p_carrier               : 전송 이통사 코드                          */
/*   IN p_date_rslt             : 단말기 도착시각                           */
/*   IN p_mt_res_cnt            : 중국 국제 문자 report count                     */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_client_rslt_update' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_client_rslt_update
GO

CREATE PROCEDURE sp_em_smt_client_rslt_update
    @p_mt_report_code_ib        char(4)
  , @p_mt_report_code_ibtype    char(1)
  , @p_rs_id                    varchar(20)
  , @p_client_msg_key           varchar(20)
  , @p_recipient_order          int
  , @p_carrier                  int
  , @p_date_rslt                datetime
  , @p_mt_res_cnt               int
AS

    UPDATE em_smt_client
    SET    msg_status             = '3'
         , date_rslt              = @p_date_rslt
         , date_mt_report         = getdate()
         , mt_report_code_ib      = @p_mt_report_code_ib
         , mt_report_code_ibtype  = @p_mt_report_code_ibtype
         , carrier                = @p_carrier
         , rs_id                  = @p_rs_id
         , mt_res_cnt             = @p_mt_res_cnt
    WHERE  mt_pr  = (SELECT mt_pr FROM em_smt_tran where msg_key = @p_client_msg_key)
    AND    mt_seq = @p_recipient_order

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smt_tran_log_move                                           */
/* DESC : em_smt_tran테이블의 전송 완료된 메시지를 로그 테이블로 이동한다.  */
/* PARAMETERS                                                               */
/*   IN p_emma_id : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/    
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smt_tran_log_move' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_tran_log_move
GO

CREATE PROCEDURE sp_em_smt_tran_log_move
    @p_emma_id char(2)
AS

    SET NOCOUNT ON      
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       

    DECLARE @dsql nvarchar(2000)
          , @v_date_client_req varchar(8)
          , @v_log_table varchar(6)
          , @v_table_suffix varchar(5)
          
    IF len(Ltrim(rtrim(@p_emma_id))) > 0
    	SET @v_table_suffix = ''
    ELSE
    	SET @v_table_suffix = '_' + @p_emma_id
    	

    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT TOP 5
               A.DATE_CLIENT_REQ
        FROM ( SELECT TOP 1000
                      convert(varchar, date_client_req, 112) AS date_client_req 
               FROM   em_smt_tran WITH(NOLOCK)
               WHERE  ((msg_status = '3'  AND input_type = '0') OR  (msg_status = '4'  AND input_type = '1'))
               AND    (broadcast_yn = 'N' OR broadcast_yn is NULL)
             ) A
        GROUP BY A.DATE_CLIENT_REQ

    open csr_obj
    FETCH next FROM csr_obj into @v_date_client_req

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)
	
	SELECT  @dsql = ' 
    SELECT TOP 2000  
           mt_pr
         , 0 as mt_seq
         , msg_key
         , input_type
         , mt_refkey
         , priority
         , date_client_req
         , content
         , callback
         , service_type
         , broadcast_yn
         , msg_status
         , recipient_num
         , NULL AS change_word1
         , NULL AS change_word2
         , NULL AS change_word3
         , NULL AS change_word4
         , NULL AS change_word5
         , date_mt_sent
         , date_rslt
         , date_mt_report
         , mt_report_code_ib
         , mt_report_code_ibtype
         , carrier
         , rs_id
         , recipient_net
         , recipient_npsend
         , country_code
         , charset
         , msg_type
         , crypto_yn
         , ttl
         , emma_id
         , reg_date
         , mt_res_cnt
         , client_sub_id
    INTO   ##em_smt_log_temp' + @v_table_suffix + '
    FROM   em_smt_tran WITH(NOLOCK) 
    WHERE  ((msg_status = ''3''  AND input_type = ''0'') OR  (msg_status = ''4''  AND input_type = ''1''))
    AND    (broadcast_yn = ''N'' OR broadcast_yn is NULL)
    AND    convert(varchar, date_client_req, 112) = ' + @v_date_client_req
    
    
    EXEC sp_executesql @dsql
    
    SELECT  @dsql = '
        INSERT em_smt_log_'+@v_log_table+'
               SELECT temp.mt_pr
                    , temp.mt_seq
                    , temp.msg_key
         			, temp.input_type
                    , temp.mt_refkey
                    , temp.priority
                    , temp.date_client_req
                    , temp.content
                    , temp.callback
                    , temp.service_type
                    , temp.broadcast_yn
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.change_word1
                    , temp.change_word2
                    , temp.change_word3
                    , temp.change_word4
                    , temp.change_word5
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.mt_report_code_ib
                    , temp.mt_report_code_ibtype
                    , temp.carrier
                    , temp.rs_id
                    , temp.recipient_net
                    , temp.recipient_npsend
                    , temp.country_code
                    , temp.charset
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ttl
                    , temp.emma_id
                    , temp.reg_date
                    , getdate()
					, temp.mt_res_cnt
					, temp.client_sub_id
               FROM   ##em_smt_log_temp' + @v_table_suffix + ' temp WITH(NOLOCK)
               WHERE  NOT EXISTS( SELECT A.mt_pr FROM em_smt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr) '

    EXEC sp_em_smt_log_create @v_log_table

    BEGIN TRAN

    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end
	
	SELECT @dsql = '
    DELETE em_smt_tran FROM em_smt_tran A, ##em_smt_log_temp' + @v_table_suffix + ' B
    WHERE A.mt_pr = B.mt_pr'
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN

	SELECT @dsql = '
    DROP TABLE ##em_smt_log_temp' + @v_table_suffix
    
    EXEC sp_executesql @dsql

        fetch next from csr_obj into @v_date_client_req

    end

    close csr_obj
    deallocate csr_obj

RETURN
GO


/*****************************************************************************/
/* NAME : sp_em_smt_client_log_move                                          */
/* DESC : em_smt_client테이블의 전송 완료된 메시지를 로그 테이블로 이동한다. */
/* PARAMETERS                                                                */
/*   IN p_emma_id : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                    */
/*   N/A                                                                     */
/*****************************************************************************/    
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smt_client_log_move' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_client_log_move
GO

CREATE PROCEDURE sp_em_smt_client_log_move
    @p_emma_id char(2)
AS

	SET NOCOUNT ON      
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       

    DECLARE @dsql nvarchar(4000)
          , @v_date_client_req varchar(8)
          , @v_mt_pr int
          , @v_cnt int
          , @v_log_table varchar(6)
          , @v_table_suffix varchar(5)
          
    IF len(Ltrim(rtrim(@p_emma_id))) > 0
    	SET @v_table_suffix = ''
    ELSE
    	SET @v_table_suffix = '_' + @p_emma_id
    	
    SELECT  @v_cnt = 1000


    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT TOP 100
               A.DATE_CLIENT_REQ
             , A.MT_PR
             , COUNT(A.B_MT_PR) AS CNT
        FROM ( SELECT top 1000
                      convert(varchar, A.date_client_req, 112) AS date_client_req
                    , A.mt_pr as mt_pr
                    , B.mt_pr as b_mt_pr
               FROM   em_smt_tran A WITH(NOLOCK), em_smt_client B WITH(NOLOCK)
               WHERE  A.msg_status = '2'
               AND    A.broadcast_yn = 'Y'
               AND    ((B.msg_status = '3'  AND A.input_type = '0') OR  (B.msg_status = '4'  AND A.input_type = '1'))
               AND    A.mt_pr = B.mt_pr
             ) A
        GROUP BY A.DATE_CLIENT_REQ, A.MT_PR

    OPEN csr_obj
    FETCH next FROM csr_obj INTO @v_date_client_req, @v_mt_pr, @v_cnt

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)
	
	SELECT @dsql = '
    SELECT TOP 1000 
           B.mt_pr                 AS mt_pr
         , B.mt_seq                AS mt_seq
         , A.mt_refkey             AS mt_refkey
         , A.msg_key	           AS msg_key
         , A.input_type            AS input_type
         , A.priority              AS priority
         , A.date_client_req       AS date_client_req
         , A.content               AS content
         , A.callback              AS callback
         , A.service_type          AS service_type
         , A.broadcast_yn          AS broadcast_yn
         , B.msg_status            AS msg_status
         , B.recipient_num         AS recipient_num
         , B.change_word1          AS change_word1
         , B.change_word2          AS change_word2
         , B.change_word3          AS change_word3
         , B.change_word4          AS change_word4
         , B.change_word5          AS change_word5
         , B.date_mt_sent          AS date_mt_sent
         , B.date_rslt             AS date_rslt
         , B.date_mt_report        AS date_mt_report
         , B.mt_report_code_ib     AS mt_report_code_ib
         , B.mt_report_code_ibtype AS mt_report_code_ibtype
         , B.carrier               AS carrier
         , B.rs_id                 AS rs_id
         , B.recipient_net         AS recipient_net
         , B.recipient_npsend      AS recipient_npsend
         , B.country_code          AS country_code
         , A.charset               AS charset
         , A.msg_type              AS msg_type
         , A.crypto_yn             AS crypto_yn
         , A.ttl                   AS ttl
         , A.emma_id               AS emma_id
         , B.reg_date              AS reg_date
         , B.mt_res_cnt            AS mt_res_cnt
         , A.client_sub_id         AS client_sub_id
    INTO   ##em_smt_log_temp' + @v_table_suffix + '
    FROM   em_smt_tran A WITH(NOLOCK), em_smt_client B WITH(NOLOCK)
    WHERE  A.mt_pr = B.mt_pr
    AND    B.mt_pr = ' + CAST( @v_mt_pr as varchar) + '
    AND    ((B.msg_status = ''3''  AND A.input_type = ''0'') OR  (B.msg_status = ''4''  AND A.input_type = ''1''))
    AND    A.broadcast_yn = ''Y'' '
    
    EXEC sp_executesql @dsql

    SELECT  @dsql = '
        INSERT em_smt_log_'+@v_log_table+'
               SELECT temp.mt_pr
                    , temp.mt_seq
                    , temp.msg_key
                    , temp.input_type
                    , temp.mt_refkey
                    , temp.priority
                    , temp.date_client_req
                    , temp.content
                    , temp.callback
                    , temp.service_type
                    , temp.broadcast_yn
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.change_word1
                    , temp.change_word2
                    , temp.change_word3
                    , temp.change_word4
                    , temp.change_word5
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.mt_report_code_ib
                    , temp.mt_report_code_ibtype
                    , temp.carrier
                    , temp.rs_id
                    , temp.recipient_net
                    , temp.recipient_npsend
                    , temp.country_code
                    , temp.charset
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ttl
                    , temp.emma_id
                    , temp.reg_date
                    , getdate()
					, temp.mt_res_cnt
					, temp.client_sub_id
               FROM   ##em_smt_log_temp' + @v_table_suffix + ' temp WITH(NOLOCK)
               WHERE  NOT EXISTS( SELECT A.mt_pr FROM em_smt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr AND A.mt_seq = temp.mt_seq) '
               
    EXEC sp_em_smt_log_create @v_log_table
    
    BEGIN TRAN
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end
    
	SELECT @dsql = '
    DELETE em_smt_client
    FROM  em_smt_client A
       ,  ##em_smt_log_temp' + @v_table_suffix + ' B
    WHERE A.mt_pr = ' + CAST(@v_mt_pr as varchar)+ '
    AND   A.mt_pr = B.mt_pr
    AND   A.mt_seq = B.mt_seq'
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN
    
	SELECT @dsql = '
    DROP TABLE ##em_smt_log_temp' + @v_table_suffix
    EXEC sp_executesql @dsql

        fetch next from csr_obj into @v_date_client_req, @v_mt_pr, @v_cnt

    end

    close csr_obj
    deallocate csr_obj

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_smt_tran_rslt_delete                                        */
/* DESC : 동보전송완료된 마스터 테이블의 레코드를 삭제한다.                 */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/    
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smt_tran_rslt_delete' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_tran_rslt_delete
GO

CREATE PROCEDURE sp_em_smt_tran_rslt_delete
AS

    DELETE FROM em_smt_tran
    WHERE mt_pr IN ( SELECT TOP 1000
                            A.mt_pr
                     FROM   em_smt_tran A
                     WHERE  (A.msg_status = 2 OR ((msg_status = '3'  AND input_type = '0') OR  (msg_status = '4'  AND input_type = '1')))
                     AND    A.broadcast_yn = 'Y'
                     AND    ( SELECT COUNT(*) FROM em_smt_client WHERE mt_pr = A.mt_pr) = 0 )

RETURN
GO


/*******************************************************************************/
/* NAME : sp_em_smt_tran_log_move_past                                         */
/* DESC : em_smt_tran테이블의 유효기간이 지난 메시지를 로그 테이블로 이동한다. */
/* PARAMETERS                                                                  */
/*   IN p_emma_id : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                      */
/*   N/A                                                                       */
/*******************************************************************************/    
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_smt_tran_log_move_past' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_smt_tran_log_move_past
GO

CREATE PROCEDURE sp_em_smt_tran_log_move_past
    @p_emma_id char(2)
AS

    SET NOCOUNT ON      
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       

    DECLARE @dsql nvarchar(2000)
          , @v_date_client_req varchar(8)
          , @v_log_table varchar(6)
          , @v_table_suffix varchar(5)
          
    IF len(Ltrim(rtrim(@p_emma_id))) > 0
    	SET @v_table_suffix = ''
    ELSE
    	SET @v_table_suffix = '_' + @p_emma_id

    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT top 300
               convert(varchar, date_client_req, 112) AS date_client_req 
        FROM   em_smt_tran WITH(NOLOCK)
        WHERE  date_client_req < getdate() - 10
        AND    ((msg_status <> '3'  AND input_type = '0') OR  (msg_status <> '4'  AND input_type = '1'))
        AND   (broadcast_yn = 'N' OR broadcast_yn is NULL)
        GROUP BY convert(varchar, date_client_req, 112)

    open csr_obj
    FETCH next FROM csr_obj into @v_date_client_req

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)
	SELECT  @dsql = ' 
    SELECT TOP 50000  
           mt_pr
         , 0 as mt_seq
         , msg_key
         , input_type
         , mt_refkey
         , priority
         , date_client_req
         , content
         , callback
         , service_type
         , broadcast_yn
         , msg_status
         , recipient_num
         , NULL AS change_word1
         , NULL AS change_word2
         , NULL AS change_word3
         , NULL AS change_word4
         , NULL AS change_word5
         , date_mt_sent
         , date_rslt
         , date_mt_report
         , mt_report_code_ib
         , mt_report_code_ibtype
         , carrier
         , rs_id
         , recipient_net
         , recipient_npsend
         , country_code
         , charset
         , msg_type
         , crypto_yn
         , ttl
         , emma_id
         , reg_date
         , mt_res_cnt
         , client_sub_id
    INTO   ##em_smt_log_temp_past' + @v_table_suffix + '
    FROM   em_smt_tran WITH(NOLOCK) 
    WHERE  convert(varchar, date_client_req, 112) = ' + @v_date_client_req + '
    AND    ((msg_status <> ''3''  AND input_type = ''0'') OR  (msg_status <> ''4''  AND input_type = ''1''))
    AND    (broadcast_yn = ''N'' OR broadcast_yn is NULL)'
    
    EXEC sp_executesql @dsql

    SELECT  @dsql = '
        INSERT em_smt_log_'+@v_log_table+'
               SELECT temp.mt_pr
                    , temp.mt_seq
                    , temp.msg_key
                    , temp.input_type
                    , temp.mt_refkey
                    , temp.priority
                    , temp.date_client_req
                    , temp.content
                    , temp.callback
                    , temp.service_type
                    , temp.broadcast_yn
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.change_word1
                    , temp.change_word2
                    , temp.change_word3
                    , temp.change_word4
                    , temp.change_word5
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.mt_report_code_ib
                    , temp.mt_report_code_ibtype
                    , temp.carrier
                    , temp.rs_id
                    , temp.recipient_net
                    , temp.recipient_npsend
                    , temp.country_code
                    , temp.charset
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ttl
                    , temp.emma_id
                    , temp.reg_date
                    , getdate()
					, temp.mt_res_cnt
					, temp.client_sub_id
               FROM   ##em_smt_log_temp_past' + @v_table_suffix + ' temp WITH(NOLOCK)
               WHERE  NOT EXISTS( SELECT A.mt_pr FROM em_smt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr) '

    EXEC sp_em_smt_log_create @v_log_table

    BEGIN TRAN
    
    EXEC sp_executesql @dsql
    
    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end
	
	SELECT @dsql = '
    DELETE em_smt_tran
    FROM   em_smt_tran A
       ,  ##em_smt_log_temp_past' + @v_table_suffix + ' B
    WHERE A.mt_pr = B.mt_pr'
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN
	
	SELECT @dsql = '
    DROP TABLE ##em_smt_log_temp_past' + @v_table_suffix
    EXEC sp_executesql @dsql

        fetch next from csr_obj into @v_date_client_req

    end

    close csr_obj
    deallocate csr_obj

RETURN
GO


/*********************************************************************************/
/* NAME : sp_em_smt_client_log_move_past                                         */
/* DESC : em_smt_client테이블의 유효기간이 지난 메시지를 로그 테이블로 이동한다. */
/* PARAMETERS                                                                    */
/*   IN p_emma_id : EMMA 이중화시 사용되는 EMMA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                        */
/*   N/A                                                                         */
/*********************************************************************************/    
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_em_smt_client_log_move_past' 
    AND    type = 'P' )
    DROP   PROCEDURE sp_em_smt_client_log_move_past
GO

CREATE PROCEDURE sp_em_smt_client_log_move_past
    @p_emma_id char(2)
AS

    SET NOCOUNT ON      
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       
    
      DECLARE @dsql              nvarchar(4000)
            , @v_date_client_req varchar(8)
            , @v_mt_pr           int
            , @v_cnt             int
            , @v_log_table       varchar(6)
            , @v_table_suffix varchar(5)
          
    IF len(Ltrim(rtrim(@p_emma_id))) > 0
    	SET @v_table_suffix = ''
    ELSE
    	SET @v_table_suffix = '_' + @p_emma_id
    	
      SELECT  @v_cnt = 1000

    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT top 300
               convert(varchar, A.date_client_req, 112) AS date_client_req
              , A.mt_pr as mt_pr
              , count(B.mt_pr) as cnt
         FROM   em_smt_tran A WITH(NOLOCK), em_smt_client B WITH(NOLOCK)
         WHERE  A.date_client_req < getdate() - 10
        AND     A.broadcast_yn = 'Y'
        AND     ((B.msg_status <> '3'  AND input_type = '0') OR  (B.msg_status <> '4'  AND input_type = '1'))
        AND     A.mt_pr = B.mt_pr
        GROUP BY convert(varchar, A.date_client_req, 112), A.mt_pr

    OPEN csr_obj
    FETCH next FROM csr_obj INTO @v_date_client_req, @v_mt_pr, @v_cnt

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)

	SELECT @dsql = '
    SELECT TOP 50000 
           B.mt_pr                 AS mt_pr
         , B.mt_seq                AS mt_seq
         , A.msg_key               AS msg_key
         , A.input_type            AS input_type
         , A.mt_refkey             AS mt_refkey
         , A.priority              AS priority
         , A.date_client_req       AS date_client_req
         , A.content               AS content
         , A.callback              AS callback
         , A.service_type          AS service_type
         , A.broadcast_yn          AS broadcast_yn
         , B.msg_status            AS msg_status
         , B.recipient_num         AS recipient_num
         , B.change_word1          AS change_word1
         , B.change_word2          AS change_word2
         , B.change_word3          AS change_word3
         , B.change_word4          AS change_word4
         , B.change_word5          AS change_word5
         , B.date_mt_sent          AS date_mt_sent
         , B.date_rslt             AS date_rslt
         , B.date_mt_report        AS date_mt_report
         , B.mt_report_code_ib     AS mt_report_code_ib
         , B.mt_report_code_ibtype AS mt_report_code_ibtype
         , B.carrier               AS carrier
         , B.rs_id                 AS rs_id
         , B.recipient_net         AS recipient_net
         , B.recipient_npsend      AS recipient_npsend
         , B.country_code          AS country_code
         , A.charset               AS charset
         , A.msg_type              AS msg_type
         , A.crypto_yn             AS crypto_yn
         , A.ttl                   AS ttl
         , A.emma_id               AS emma_id
         , B.reg_date              AS reg_date
         , B.mt_res_cnt            AS mt_res_cnt
         , A.client_sub_id         AS client_sub_id
     INTO  ##em_smt_log_temp_past' + @v_table_suffix + '
     FROM  em_smt_tran A WITH(NOLOCK), em_smt_client B WITH(NOLOCK)
     WHERE A.mt_pr = B.mt_pr
     AND   B.mt_pr = ' + CAST(@v_mt_pr as varchar) + '
     AND   ((B.msg_status <> ''3''  AND input_type = ''0'') OR  (B.msg_status <> ''4''  AND input_type = ''1''))
     AND   A.broadcast_yn = ''Y'' '
     
     EXEC sp_executesql @dsql

    SELECT  @dsql = '
        INSERT em_smt_log_'+@v_log_table+'
               SELECT temp.mt_pr
                    , temp.mt_seq
                    , temp.msg_key
                    , temp.input_type
                    , temp.mt_refkey
                    , temp.priority
                    , temp.date_client_req
                    , temp.content
                    , temp.callback
                    , temp.service_type
                    , temp.broadcast_yn
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.change_word1
                    , temp.change_word2
                    , temp.change_word3
                    , temp.change_word4
                    , temp.change_word5
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.mt_report_code_ib
                    , temp.mt_report_code_ibtype
                    , temp.carrier
                    , temp.rs_id
                    , temp.recipient_net
                    , temp.recipient_npsend
                    , temp.country_code
                    , temp.charset
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ttl
                    , temp.emma_id
                    , temp.reg_date
                    , getdate()
					, temp.mt_res_cnt
					, temp.client_sub_id
               FROM   ##em_smt_log_temp_past' + @v_table_suffix + ' temp WITH(NOLOCK)
               WHERE  NOT EXISTS( SELECT A.mt_pr FROM em_smt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr AND A.mt_seq = temp.mt_seq) '

    EXEC sp_em_smt_log_create @v_log_table
    
    BEGIN TRAN
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end
	
	SELECT @dsql = '
    DELETE em_smt_client
    FROM   em_smt_client A
       ,  ##em_smt_log_temp_past' + @v_table_suffix + ' B
    WHERE  A.mt_pr = ' + CAST(@v_mt_pr as varchar) + '
    AND    A.mt_pr = B.mt_pr
    AND    A.mt_seq = B.mt_seq'
    
    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN
    
    SELECT @dsql = '
    DROP TABLE ##em_smt_log_temp_past' + @v_table_suffix
    EXEC sp_executesql @dsql
    
        fetch next from csr_obj into @v_date_client_req, @v_mt_pr, @v_cnt
    
    end
    
    close csr_obj
    deallocate csr_obj

RETURN
GO
