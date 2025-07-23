/**
 * 메시지 서비스를 위한 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */

-- !!!!!!!!!!!!!!!!!!!!!!!!!! 필수 확인 !!!!!!!!!!!!!!!!!!!
-- 돌리기 전에 반드시 sms 연락처 확인할 것

-- USE imds
-- GO

/****************************************************************************/
/* NAME : sp_mmt_create                                                  */
/* DESC : 메시지 서비스 관련 테이블을 생성한다.                              */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   ata_mmt_tran :  메시지 전송 테이블                                       */
/*   ata_mmt_client : 동보 전송을 위한 수신번호 테이블(ata_mmt_tran의 Detail) */
/****************************************************************************/
IF EXISTS (
    SELECT name FROM sysobjects 
    WHERE  name = 'sp_mmt_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_create
GO

CREATE PROCEDURE sp_mmt_create
AS

    IF NOT EXISTS (
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ata_mmt_tran'
    )
    BEGIN
        CREATE TABLE ata_mmt_tran
        ( mt_pr                 int identity(1,1)                          NOT NULL 
        , mt_refkey             varchar(20)   COLLATE Korean_Wansung_CS_AS
        , priority              char(2)       COLLATE Korean_Wansung_CS_AS NOT NULL default 'S'
        , date_client_req       datetime                                   NOT NULL default '1970-01-01 00:00:00'
        , subject               varchar(40)   COLLATE Korean_Wansung_CS_AS NOT NULL default ' '
        , content               varchar(4000) COLLATE Korean_Wansung_CS_AS NOT NULL
		, content2              varchar(4000) COLLATE Korean_Wansung_CS_AS NOT NULL
        , callback              varchar(25)   COLLATE Korean_Wansung_CS_AS NOT NULL
        , msg_status            char(1)       COLLATE Korean_Wansung_CS_AS NOT NULL default '1'
        , recipient_num         varchar(25)   COLLATE Korean_Wansung_CS_AS
        , date_mt_sent          datetime
        , date_rslt             datetime
        , date_mt_report        datetime
        , report_code           char(4)       COLLATE Korean_Wansung_CS_AS
        , rs_id                 varchar(20)   COLLATE Korean_Wansung_CS_AS
        , country_code          varchar(8)    COLLATE Korean_Wansung_CS_AS NOT NULL default '82'
        , msg_type              int                                        NOT NULL default '1008'
        , crypto_yn             char(1)       COLLATE Korean_Wansung_CS_AS          default 'Y'
        , ata_id                char(2)       COLLATE Korean_Wansung_CS_AS          default ' '
        , reg_date              datetime                                            default getdate()
        , sender_key            varchar(40)   COLLATE Korean_Wansung_CS_AS NOT NULL
        , template_code         varchar(30)   COLLATE Korean_Wansung_CS_AS
        , response_method       varchar(20)   COLLATE Korean_Wansung_CS_AS NOT NULL default 'push'
        , ad_flag               char(1)       COLLATE Korean_Wansung_CS_AS NOT NULL default 'N'
		, kko_btn_type          char(1)       COLLATE Korean_Wansung_CS_AS
		, kko_btn_info          varchar(4000) COLLATE Korean_Wansung_CS_AS
		, img_url               varchar(200)  COLLATE Korean_Wansung_CS_AS
        , img_link              varchar(100)  COLLATE Korean_Wansung_CS_AS
        , etc_text_1            varchar(100)  COLLATE Korean_Wansung_CS_AS
        , etc_text_2            varchar(100)  COLLATE Korean_Wansung_CS_AS
        , etc_text_3            varchar(100)  COLLATE Korean_Wansung_CS_AS
        , etc_num_1             int
        , etc_num_2             int
        , etc_num_3             int
        , etc_date_1            datetime
        )
        
        ALTER TABLE ata_mmt_tran  ADD PRIMARY KEY ( mt_pr )
        
        CREATE INDEX idx_ata_mmt_tran_1 ON ata_mmt_tran (msg_status, date_client_req)
        CREATE INDEX idx_ata_mmt_tran_2 ON ata_mmt_tran (recipient_num)
        CREATE INDEX idx_ata_mmt_tran_3 ON ata_mmt_tran (ata_id)
        CREATE INDEX idx_ata_mmt_tran_4 ON ata_mmt_tran (sender_key, template_code)

    END

RETURN
GO
    

/****************************************************************************/
/* NAME : sp_mmt_log_create                                              */
/* DESC : 메시지 로그 테이블을 생성한다.                                     */
/* PARAMETERS                                                               */
/*   p_log_table : 로그테이블 변경 postfix(년월)                            */
/* REMARK                                                                   */
/*   p_log_table이 YYYYMM이 default이지만 값을 변경하면 YYYY등의 확장 가능  */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_log_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_log_create
GO

CREATE PROCEDURE sp_mmt_log_create
    @p_log_table varchar(6) 
AS

    --DECLARE @dsql nvarchar(4000)
	DECLARE @dsql varchar(8000)

    IF @p_log_table <> ''
    BEGIN
    IF NOT EXISTS (
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ata_mmt_log_'+@p_log_table
    )
        BEGIN
            select @dsql = '
                CREATE TABLE ata_mmt_log_' + @p_log_table + '
                ( mt_pr                 int NOT NULL
                , mt_refkey             varchar(20)   COLLATE Korean_Wansung_CS_AS
                , priority              char(2)       COLLATE Korean_Wansung_CS_AS NOT NULL default ''S''
                , date_client_req       datetime                                   NOT NULL default ''1970-01-01 00:00:00''
                , subject               varchar(40)   COLLATE Korean_Wansung_CS_AS NOT NULL default '' ''
                , content               varchar(4000) COLLATE Korean_Wansung_CS_AS NOT NULL
				, content2              varchar(4000) COLLATE Korean_Wansung_CS_AS NOT NULL
                , callback              varchar(25)   COLLATE Korean_Wansung_CS_AS NOT NULL
                , msg_status            char(1)       COLLATE Korean_Wansung_CS_AS NOT NULL default ''1''
                , recipient_num         varchar(25)   COLLATE Korean_Wansung_CS_AS
                , date_mt_sent          datetime
                , date_rslt             datetime
                , date_mt_report        datetime
                , report_code           char(4)       COLLATE Korean_Wansung_CS_AS
                , rs_id                 varchar(20)   COLLATE Korean_Wansung_CS_AS
                , country_code          varchar(8)    COLLATE Korean_Wansung_CS_AS NOT NULL default ''82''
                , msg_type              int                                        NOT NULL default ''1008''
                , crypto_yn             char(1)       COLLATE Korean_Wansung_CS_AS          default ''Y''
                , ata_id                char(2)       COLLATE Korean_Wansung_CS_AS          default '' ''
                , reg_date_tran         datetime
                , reg_date              datetime                                            default getdate() 
                , sender_key            varchar(40)   COLLATE Korean_Wansung_CS_AS NOT NULL
                , template_code         varchar(30)   COLLATE Korean_Wansung_CS_AS
                , response_method       varchar(20)   COLLATE Korean_Wansung_CS_AS NOT NULL default ''push''
                , ad_flag               char(1)       COLLATE Korean_Wansung_CS_AS NOT NULL default ''N''
		        , kko_btn_type          char(1)       COLLATE Korean_Wansung_CS_AS
		        , kko_btn_info          varchar(4000) COLLATE Korean_Wansung_CS_AS
                , img_url               varchar(200)  COLLATE Korean_Wansung_CS_AS
                , img_link              varchar(100)  COLLATE Korean_Wansung_CS_AS
				, etc_text_1            varchar(100)  COLLATE Korean_Wansung_CS_AS
                , etc_text_2            varchar(100)  COLLATE Korean_Wansung_CS_AS
                , etc_text_3            varchar(100)  COLLATE Korean_Wansung_CS_AS
				, etc_num_1             int
                , etc_num_2             int
                , etc_num_3             int
                , etc_date_1            datetime )'
    
            EXEC (@dsql)
    
            EXEC ('ALTER TABLE ata_mmt_log_'+@p_log_table+' ADD PRIMARY KEY ( mt_pr )')

            EXEC ('CREATE INDEX idx_ata_mmt_log_'+@p_log_table+'_1 ON ata_mmt_log_'+@p_log_table+' (date_client_req, recipient_num)')
            EXEC ('CREATE INDEX idx_ata_mmt_log_'+@p_log_table+'_2 ON ata_mmt_log_'+@p_log_table+' (date_mt_report, report_code)')
            EXEC ('CREATE INDEX idx_ata_mmt_log_'+@p_log_table+'_3 ON ata_mmt_log_'+@p_log_table+' (msg_status)')
            EXEC ('CREATE INDEX idx_ata_mmt_log_'+@p_log_table+'_4 ON ata_mmt_log_'+@p_log_table+' (sender_key, template_code)')

        END
    END

RETURN
GO


/**********************************************************************************************/
/* NAME : sp_mmt_tran_select                                                               */
/* DESC : 메시지 전송 테이블로 부터 전송할 메시지를 조회한다.                                  */
/* PARAMETERS                                                                                 */
/*   OUT p_list       : Resultset                                                             */
/*   IN p_priority    : 메시지 우선순위(VF/F/S)                                               */
/*   IN p_ttl         : 전송 유효 시간 (단위: 분)                                             */
/*   IN p_ata_id     : ATA 이중화시 사용되는 ATA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/*   IN p_bancheck_yn : 수신차단테이블 체크 여부                                              */
/* REMARK                                                                                     */
/*   조회 결과의 필드명은 꼭 지켜져야 한다.                                                   */
/*   한번에 쿼리할 수 있는 개수는 조절 가능하지만, 변경 후 테스트가 필요                      */
/**********************************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_tran_select' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_tran_select
GO

CREATE PROCEDURE sp_mmt_tran_select
    @p_priority char(2)
  , @p_ttl int
  , @p_ata_id char(2)
  , @p_bancheck_yn char(1)
AS

    /** update ata_id */
    IF @p_ata_id <> ' '
    BEGIN
    
    SET NOCOUNT ON

    BEGIN TRAN

    UPDATE ata_mmt_tran 
    SET    ata_id = @p_ata_id
    WHERE  mt_pr in ( SELECT TOP 300
                             mt_pr 
                      FROM   ata_mmt_tran
                      WHERE  priority = @p_priority
                      AND    msg_status = '1' 
                      AND   date_client_req BETWEEN ( getdate() -  ( @p_ttl/24/60 ) ) AND getdate() 
                      AND   ata_id = ' ' ) AND   ata_id = ' '

    if @@error != 0
    begin
        rollback tran
        return
    end

    COMMIT TRAN

    END
    
    /** real select */
    SELECT TOP 300
           A.mt_pr                 AS mt_pr
         , A.mt_refkey             AS mt_refkey
         , A.subject               AS subject
         , 0                       AS content_type
         , A.content               AS content
		 , A.content2              AS content2
         , A.priority              AS priority
         , 'N'                     AS broadcast_yn
         , A.callback              AS callback
         , A.recipient_num         AS recipient_num
         , NULL                    AS recipient_net
         , NULL                    AS recipient_npsend
         , A.country_code          AS country_code
         , A.date_client_req       AS date_client_req
         , NULL                    AS charset
         , '1'                     AS msg_class
         , NULL                    AS attach_file_group_key
         , A.msg_type              AS msg_type
         , A.crypto_yn             AS crypto_yn
         , '3'                     AS service_type
         , NULL                    AS ttl
         , A.sender_key            AS sender_key
         , A.template_code         AS template_code
         , A.response_method       AS response_method
         , B.ban_type              AS ban_type
         , B.send_yn               AS send_yn
         , A.kko_btn_info          AS kko_btn_info
		 , A.kko_btn_type          AS kko_btn_type
		 , A.ad_flag               AS ad_flag
		 , A.img_url               AS img_url
         , A.img_link              AS img_link
    FROM   ata_mmt_tran A 
    LEFT OUTER JOIN ata_banlist B 
    ON     A.recipient_num = B.content
    AND    '3' = B.service_type
    AND    B.ban_type = 'R'
    AND    B.ban_status_yn = 'Y'
    WHERE  A.ata_id = @p_ata_id
    AND    A.priority = @p_priority
    AND    A.msg_status = '1' 
    AND    A.date_client_req BETWEEN (dateadd(n, (-1) * @p_ttl, getdate())) AND getdate()

RETURN
GO


/*************************************************************************************/
/* NAME : sp_mmt_update                                                           */
/* DESC : 메시지 발송을 위한 큐에 데이터 적재 후 상태정보를 업데이트 한다.            */
/* PARAMETERS                                                                        */
/*   IN p_table_divi            : 업데이트할 테이블(마스터/디테일 ) 구분             */
/*   IN p_update_all            : 동보테이블 전체 업데이트 여부                      */
/*   IN p_mt_pr                 : 마스터 테이블 키                                   */
/*   IN p_mt_seq                : 디테일 테이블 키(개별전송시 0, 동보전송시 해당순번 */
/*   IN p_msg_status            : 메시지 상태 (정상-2, 실패-3)                       */
/*   IN p_mt_report_code_ib     : 오류시 결과 코드                                   */
/*   IN p_mt_report_code_ibtype : 오류결과코드분류                                   */
/* REMARK                                                                            */
/*   N/A                                                                             */
/*************************************************************************************/  
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_update' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_update
GO

CREATE PROCEDURE sp_mmt_update
    @p_table_divi             char(1)
  , @p_update_all_yn          char(1)
  , @p_mt_pr                  int
  , @p_mt_seq                 int
  , @p_msg_status             char(1)
  , @p_mt_report_code_ib      char(4)
  , @p_mt_report_code_ibtype  char(1)
AS

    DECLARE @dsql nvarchar(1000)
    DECLARE @v_params as nvarchar(200)

    SET @dsql = ' UPDATE ata_mmt_tran SET  '
 
    SET @dsql = @dsql + '
        msg_status            = @pp_msg_status,
        report_code     = @pp_mt_report_code_ib,
        date_mt_sent = getdate() '

    IF @p_msg_status = '3'
        SET @dsql = @dsql + ' , date_rslt  = getdate() '

    SET @dsql = @dsql + ' WHERE mt_pr  = @pp_mt_pr '

    
    SET @v_params = '@pp_msg_status char(1)
      , @pp_mt_report_code_ib char(4)
      , @pp_mt_pr int'

    EXECUTE sp_executesql @dsql, @v_params
                        , @pp_msg_status            = @p_msg_status
                        , @pp_mt_report_code_ib     = @p_mt_report_code_ib
                        , @pp_mt_pr                 = @p_mt_pr

RETURN
GO


/****************************************************************************/
/* NAME : sp_mmt_tran_rslt_update                                        */
/* DESC : 메시지 전송 결과를 업데이트 한다.                           */
/* PARAMETERS                                                               */
/*   IN p_mt_report_code_ib     : 결과코드                           */
/*   IN p_mt_report_code_ibtype : 결과코드 분류                      */
/*   IN p_rs_id                 : 전송 RS아이디                          */
/*   IN p_client_msg_key        : 전송키(mt_pr)                             */
/*   IN p_msg_status            : 전송키의 하위 순번(mt_seq)                */
/*   IN p_carrier               : 전송 코드                          */
/*   IN p_date_rslt             : 단말기 도착시각                           */
/*   IN p_mt_res_cnt            : 중국 국제 문자 report count                     */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_tran_rslt_update' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_tran_rslt_update
GO

CREATE PROCEDURE sp_mmt_tran_rslt_update
    @p_mt_report_code_ib        char(4)
  , @p_mt_report_code_ibtype    char(1)
  , @p_rs_id                    varchar(20)
  , @p_client_msg_key           int
  , @p_recipient_order          int
  , @p_carrier                  int
  , @p_date_rslt                datetime
  , @p_mt_res_cnt               int
AS

    UPDATE ata_mmt_tran
    SET    msg_status              = '3'
         , date_rslt               = @p_date_rslt
         , date_mt_report          = getdate()
         , report_code             = @p_mt_report_code_ib
         , rs_id                   = @p_rs_id
    WHERE mt_pr = @p_client_msg_key

RETURN
GO

/****************************************************************************/
/* NAME : sp_mmt_tran_log_move                                           */
/* DESC : ata_mmt_tran테이블의 전송 완료된 메시지를 로그 테이블로 이동한다.  */
/* PARAMETERS                                                               */
/*   IN p_ata_id : ATA 이중화시 사용되는 ATA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/  
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_tran_log_move' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_tran_log_move
GO

CREATE PROCEDURE sp_mmt_tran_log_move
    @p_ata_id char(2)
AS

    SET NOCOUNT ON      
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       

    DECLARE @dsql nvarchar(4000)
          , @v_date_client_req varchar(8)
          , @v_log_table varchar(6)

    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT top 5
               A.DATE_CLIENT_REQ
    FROM( SELECT TOP 1000    
                     convert(varchar, date_client_req, 112) AS date_client_req 
              FROM   ata_mmt_tran WITH(NOLOCK)
              WHERE  ata_id = @p_ata_id
              AND    msg_status = '3'
            ) A
    GROUP BY A.DATE_CLIENT_REQ

    open csr_obj
    FETCH next FROM csr_obj into @v_date_client_req

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)

    SELECT TOP 2000 
           mt_pr
         , mt_refkey
         , priority
         , date_client_req
         , subject
         , content
		 , content2
         , callback
         , msg_status
         , recipient_num
         , date_mt_sent
         , date_rslt
         , date_mt_report
         , report_code
         , rs_id
         , country_code
         , msg_type
         , crypto_yn
         , ata_id
         , reg_date
         , sender_key
         , template_code
         , response_method
         , ad_flag
         , kko_btn_type
         , kko_btn_info
         , img_url
         , img_link
         , etc_text_1
         , etc_text_2
         , etc_text_3
         , etc_num_1
         , etc_num_2
         , etc_num_3
         , etc_date_1
    INTO   #ata_mmt_log_temp
    FROM   ata_mmt_tran WITH(NOLOCK) 
    WHERE  ata_id = @p_ata_id
    AND    msg_status = '3'
    AND    convert(varchar, date_client_req, 112) = @v_date_client_req

    SELECT  @dsql = '
        INSERT ata_mmt_log_'+@v_log_table+' 
               SELECT temp.mt_pr
                    , temp.mt_refkey
                    , temp.priority
                    , temp.date_client_req
                    , temp.subject
                    , temp.content
					, temp.content2
                    , temp.callback
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.report_code
                    , temp.rs_id
                    , temp.country_code
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ata_id
                    , temp.reg_date
                    , getdate()
                    , temp.sender_key
                    , temp.template_code
                    , temp.response_method
                    , temp.ad_flag
                    , temp.kko_btn_type
                    , temp.kko_btn_info
					, temp.img_url
                    , temp.img_link
                    , temp.etc_text_1
                    , temp.etc_text_2
                    , temp.etc_text_3
                    , temp.etc_num_1
                    , temp.etc_num_2
                    , temp.etc_num_3
                    , temp.etc_date_1
               FROM   #ata_mmt_log_temp temp WITH(NOLOCK) 
               WHERE NOT EXISTS( SELECT A.mt_pr FROM ata_mmt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr) '

    EXEC sp_mmt_log_create @v_log_table

    BEGIN TRAN

    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    DELETE ata_mmt_tran FROM ata_mmt_tran A, #ata_mmt_log_temp B
    WHERE A.mt_pr = B.mt_pr

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN

    DROP TABLE #ata_mmt_log_temp

    fetch next from csr_obj into @v_date_client_req

    end

    close csr_obj
    deallocate csr_obj

RETURN
GO


/****************************************************************************/
/* NAME : sp_mmt_tran_log_move_past                                      */
/* DESC : ata_mmt_tran테이블의 유효기간이 지난 메시지를 로그 테이블로 이동한다.  */
/* PARAMETERS                                                               */
/*   IN p_ata_id : ATA 이중화시 사용되는 ATA ID (' ' 인 경우: 이중화 사용안함, ' ' 아닌 경우: 이중화 사용함) */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/  
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_mmt_tran_log_move_past' 
    AND    type = 'P' )
    DROP PROCEDURE sp_mmt_tran_log_move_past
GO

CREATE PROCEDURE sp_mmt_tran_log_move_past
    @p_ata_id char(2)
AS

    SET NOCOUNT ON      
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED       

    DECLARE @dsql nvarchar(4000)
          , @v_date_client_req varchar(8)
          , @v_log_table varchar(6)

    -- set up cursor 
    DECLARE csr_obj cursor local for
        SELECT top 300
               convert(varchar, date_client_req, 112) AS date_client_req 
        FROM   ata_mmt_tran WITH(NOLOCK)
        WHERE  ata_id = @p_ata_id
        AND    date_client_req < getdate() - 3
        AND    msg_status <> '3'
        GROUP BY convert(varchar, date_client_req, 112)

    open csr_obj
    FETCH next FROM csr_obj into @v_date_client_req

    while (@@fetch_status = 0)
    begin
    SET @v_log_table = substring(@v_date_client_req, 1, 6)

    SELECT TOP 50000 
           mt_pr
         , mt_refkey
         , priority
         , date_client_req
         , subject
         , content
		 , content2
         , callback
         , msg_status
         , recipient_num
         , date_mt_sent
         , date_rslt
         , date_mt_report
         , report_code
         , rs_id
         , country_code
         , msg_type
         , crypto_yn
         , ata_id
         , reg_date
         , sender_key
         , template_code
         , response_method
         , ad_flag
         , kko_btn_type
         , kko_btn_info
		 , img_url
         , img_link
         , etc_text_1
         , etc_text_2
         , etc_text_3
         , etc_num_1
         , etc_num_2
         , etc_num_3
         , etc_date_1
    INTO   #ata_mmt_log_temp_past
    FROM   ata_mmt_tran WITH(NOLOCK) 
    WHERE  ata_id = @p_ata_id
    AND    convert(varchar, date_client_req, 112) = @v_date_client_req
    AND    msg_status <> '3'
    
    SELECT  @dsql = '
        INSERT ata_mmt_log_'+@v_log_table+' 
               SELECT temp.mt_pr
                    , temp.mt_refkey
                    , temp.priority
                    , temp.msg_class
                    , temp.date_client_req
                    , temp.subject
                    , temp.content
					, temp.content2
                    , temp.callback
                    , temp.msg_status
                    , temp.recipient_num
                    , temp.date_mt_sent
                    , temp.date_rslt
                    , temp.date_mt_report
                    , temp.report_code
                    , temp.rs_id
                    , temp.country_code
                    , temp.msg_type
                    , temp.crypto_yn
                    , temp.ata_id
                    , temp.reg_date
                    , getdate()
                    , temp.sender_key
                    , temp.template_code
                    , temp.response_method
                    , temp.ad_flag
                    , temp.kko_btn_type
                    , temp.kko_btn_info
					, temp.img_url
                    , temp.img_link
                    , temp.etc_text_1
                    , temp.etc_text_2
                    , temp.etc_text_3
                    , temp.etc_num_1
                    , temp.etc_num_2
                    , temp.etc_num_3
                    , temp.etc_date_1
               FROM   #ata_mmt_log_temp_past temp WITH(NOLOCK) 
               WHERE NOT EXISTS( SELECT A.mt_pr FROM ata_mmt_log_'+@v_log_table+'  A WHERE A.mt_pr = temp.mt_pr) '

    EXEC sp_mmt_log_create @v_log_table

    BEGIN TRAN

    EXEC sp_executesql @dsql

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    DELETE ata_mmt_tran FROM ata_mmt_tran A, #ata_mmt_log_temp_past B
    WHERE A.mt_pr = B.mt_pr

    if @@error != 0
    begin
        rollback tran
        close csr_obj
        deallocate csr_obj
        return
    end

    COMMIT TRAN

    DROP TABLE #ata_mmt_log_temp_past

        fetch next from csr_obj into @v_date_client_req

    end

    close csr_obj
    deallocate csr_obj

RETURN
GO

/**************************************************************************/
/* NAME : sp_custom_failback_insert										  */
/* DESC : 알림톡 실패 건 문자 메시지 재 전송							  */
/* PARAMETERS															  */
/*   IN p_client_msg_key        : 전송키(mt_pr) 						  */
/*   IN p_mt_report_code_ib     : 결과코드								  */
/* REMARK																  */
/*   N/A																  */	
/**************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_custom_failback_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_custom_failback_insert
GO

CREATE PROCEDURE sp_custom_failback_insert
    @p_client_msg_key int
  , @p_mt_report_code_ib char(4)
AS
      DECLARE
      @v_len int
    , @v_subject nvarchar(40)
	, @v_content nvarchar(4000)
	, @v_callback nvarchar(25)
	, @v_recipient_num nvarchar(25)

    -- 결과코드 성공 이외의 건만 재 전송
    IF @p_mt_report_code_ib = '1000'
    BEGIN
        RETURN;
    END
	
		SELECT 
		@v_len = DATALENGTH(content)
		 , @v_subject = subject
		 , @v_content = content2
		 , @v_callback = callback
		 , @v_recipient_num = recipient_num
				 
	FROM   ata_mmt_tran 
	WHERE  mt_pr = @p_client_msg_key;
	
	IF @@ROWCOUNT = 0
	BEGIN 
    RETURN
	END
    	 -- LMS     
	IF @v_len > 90 
	BEGIN
		INSERT INTO em_mmt_tran 
		(
		   date_client_req, 
		   subject, 
		   content,  
		   callback, 
		   service_type, 
		   broadcast_yn, 
		   msg_status, 
		   recipient_num, 
		   crypto_yn
		) 
		VALUES
		(
			getdate(), 
			@v_subject, 
			@v_content,  
			'0317865630', 
			'3', 
			'N', 
			'1', 
			@v_recipient_num, 
			'Y'
		); 
	END
	
				 -- SMS    
	IF @v_len <= 90 
	BEGIN
		INSERT INTO em_smt_tran
		(
		  date_client_req, 
		  content,  
		  callback, 
		  service_type, 
		  broadcast_yn, 
		  msg_status, 
		  recipient_num, 
		  crypto_yn
		) 
		VALUES
		(
			getdate(), 
			@v_content, 
			'0317865630', 
			'0', 
			'N', 
			'1', 
			@v_recipient_num, 
			'Y'
		);
		
		END

          
RETURN
GO