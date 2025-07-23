/**
 * @(#)emma_sp_sjs.sql
 * Copyright 2008 InfoBank Corporation. All rights reserved.
 * emma statistics job scheduler table ddl & dml.
 *
 * 일통계 제공을 위한 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */


-- USE imds
-- GO

/****************************************************************************/
/* NAME : sp_em_stat_create                                                 */
/* DESC : 엠마 통계에서 사용하는 테이블을 생성한다.                         */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_create
GO

CREATE PROCEDURE sp_em_stat_create
AS

    IF NOT EXISTS (
        SELECT name
        FROM   sysobjects 
        WHERE  name = 'em_statistics_m' 
        AND    type = 'U' )
    BEGIN
        /* create em_statistics_m(일별 통계 마스터) */
        CREATE TABLE em_statistics_m
        ( stat_date         varchar(8)  COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_servicetype  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_payment_code varchar(20) COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_carrier      int                                      NOT NULL
        , stat_success      int
        , stat_failure      int
        , stat_invalid      int
        , stat_invalid_ib   int
        , stat_remained     int
        , stat_regdate      datetime NOT NULL default getdate()
        )
        
        ALTER TABLE em_statistics_m  ADD PRIMARY KEY(stat_date, stat_servicetype, stat_payment_code, stat_carrier)

    END

    /* create em_statistics_d (일별 통계 상세) */
    IF NOT EXISTS (
        SELECT name
        FROM   sysobjects 
        WHERE  name = 'em_statistics_d' 
        AND    type = 'U' )
    BEGIN
        CREATE TABLE em_statistics_d
        ( stat_date         varchar(8)  COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_servicetype  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_payment_code varchar(20) COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_carrier      int                                      NOT NULL
        , stat_fail_code    varchar(10) COLLATE Korean_Wansung_CS_AS NOT NULL
        , stat_fail_cnt     int
        , stat_regdate      datetime    NOT NULL default getdate()
        )
        
        ALTER TABLE em_statistics_d  ADD PRIMARY KEY(stat_date, stat_servicetype, stat_payment_code, stat_carrier, stat_fail_code)

    END

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_stat_execute                                                */
/* DESC : 일별 통계 데이터를 생성한다.                                      */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_execute' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_execute
GO

CREATE PROCEDURE sp_em_stat_execute
    @p_smt_use_yn	char(1)
  , @p_url_use_yn	char(1)
  , @p_mmt_use_yn	char(1)
  , @p_smo_use_yn	char(1)
  , @p_mmo_use_yn	char(1)
AS

    /** SMS MT */
    IF @p_smt_use_yn = 'Y'
    EXEC sp_em_stat_mt_insert '0'

    /** CALLBACK URL MT */
    IF @p_url_use_yn = 'Y'
    EXEC sp_em_stat_mt_insert '1'

    /** MMS MT */
    IF @p_mmt_use_yn = 'Y'
    EXEC sp_em_stat_mt_insert '2'

    /** MMS MT */
    IF @p_mmt_use_yn = 'Y'
    EXEC sp_em_stat_mt_insert '3'

    /** SMS MO */
    IF @p_smo_use_yn = 'Y'
    EXEC sp_em_stat_mo_insert '4'

    /** MMS MO */
    IF @p_mmo_use_yn = 'Y'
    EXEC sp_em_stat_mo_insert '5'

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_stat_mt_insert                                              */
/* DESC : MT 로그테이블에서 일별통계 마스터 및 디테일테이블 데이터 입력.    */
/* PARAMETERS                                                               */
/*   IN p_prc_date : 처리일자                                               */
/*   IN p_service_type : 서비스 종류                                        */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_mt_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_mt_insert
GO

CREATE PROCEDURE sp_em_stat_mt_insert
    @p_service_type char(2)
AS

    DECLARE @v_prc_date   varchar(8)
          , @v_table_name varchar(20)
          , @v_cnt        int
          , @i            int

    /** set processing date count */
    IF (@p_service_type = '2' OR @p_service_type = '3')
        SET @v_cnt = 5
    ELSE
        SET @v_cnt = 2
    
    SET @i=0;
    
    while (@i<@v_cnt)
    begin

    /** set process date */
    SELECT @v_prc_date = CONVERT(varchar, DATEADD(DAY, -@i, GETDATE()), 112) 

    /*SET @v_prc_date = '20090720'*/

    /** set table name */
    IF (@p_service_type = '2' OR @p_service_type = '3')
        SET @v_table_name = 'em_mmt_log_' + substring(@v_prc_date,1,6)
    ELSE
        SET @v_table_name = 'em_smt_log_' + substring(@v_prc_date,1,6)


    /** call insert */
    EXEC sp_em_stat_mt_insert_day @p_service_type, @v_prc_date, @v_table_name
    
    SET @i=@i+1;
    
    end

RETURN
GO


/********************************************************************************/
/* NAME : sp_em_stat_mt_insert_day                                              */
/* DESC : MT 로그테이블에서 일별통계 마스터 및 디테일테이블 데이터를 입력한다.  */
/* PARAMETERS                                                                   */
/*   IN p_prc_date     : 처리일자                                               */
/*   IN p_service_type : 서비스 종류                                            */
/* REMARK                                                                       */
/*   N/A                                                                        */
/********************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_mt_insert_day' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_mt_insert_day
GO

CREATE PROCEDURE sp_em_stat_mt_insert_day
    @p_service_type char(2)
  , @p_prc_date     varchar(8)
  , @p_table_name	varchar(20)
AS

    DECLARE @dsql nvarchar(4000)

    EXEC sp_em_stat_create

    BEGIN TRAN

    EXEC sp_em_stat_delete @p_service_type, @p_prc_date

    if @@error != 0
    begin
        rollback tran
        return
    end

    SELECT  @dsql = '
        INSERT INTO em_statistics_m
                  ( stat_date
                  , stat_servicetype
                  , stat_payment_code
                  , stat_carrier
                  , stat_success
                  , stat_failure
                  , stat_invalid
                  , stat_invalid_ib
                  , stat_remained
                  , stat_regdate )
         SELECT '''+@p_prc_date+''',
                '''+@p_service_type+'''
                  , CASE WHEN mt_refkey IS NULL THEN ''NONE'' ELSE mt_refkey END AS payment_code
                  , carrier
                  , SUM(CASE WHEN mt_report_code_ib =''1000'' THEN 1 ELSE 0 END) AS success
                  , SUM(CASE WHEN mt_report_code_ib >=''2000'' AND mt_report_code_ib < ''3000'' THEN 1 ELSE 0 END) AS failure
                  , SUM(CASE WHEN mt_report_code_ib >=''3000'' AND mt_report_code_ib < ''4000'' OR mt_report_code_ib >=''5000'' AND mt_report_code_ib < ''6000'' THEN 1 ELSE 0 END) AS invalid
                  , SUM(CASE WHEN mt_report_code_ib >=''1001'' AND mt_report_code_ib < ''2000'' OR mt_report_code_ib >=''4000'' AND mt_report_code_ib < ''5000'' OR mt_report_code_ib >=''E900'' AND mt_report_code_ib < ''E999'' THEN 1 ELSE 0 END) AS invalid_ib
                  , SUM(CASE WHEN msg_status=''2'' THEN 1 ELSE 0 END) AS remained
                  , getdate()
            FROM '+@p_table_name+'
            WHERE convert(varchar, date_mt_report, 112) = '''+@p_prc_date+'''
            AND   service_type = '''+@p_service_type+'''
            GROUP BY mt_refkey, carrier '

    EXEC (@dsql)

    if @@error != 0
    begin
        rollback tran
        return
    end

    SELECT  @dsql = '
        INSERT INTO em_statistics_d
                  ( stat_date
                  , stat_servicetype
                  , stat_payment_code
                  , stat_carrier
                  , stat_fail_code
                  , stat_fail_cnt
                  , stat_regdate )
        SELECT 
                  '''+@p_prc_date+''',
                  '''+@p_service_type+''',
                  
                  CASE WHEN mt_refkey IS NULL THEN ''NONE'' ELSE mt_refkey END AS payment_code, 
                  
                  carrier,
                  mt_report_code_ib,
                  count(mt_report_code_ib),
                  getdate()
       FROM   '+@p_table_name+'
       WHERE  convert(varchar, date_mt_report, 112) = '''+@p_prc_date+'''
       AND    service_type = '''+@p_service_type+'''
       AND    mt_report_code_ib <> ''1000'' 
       GROUP BY mt_refkey, carrier, mt_report_code_ib '

    EXEC (@dsql)

    if @@error != 0
    begin
        rollback tran
        return
    end

    commit tran

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_stat_mo_insert                                              */
/* DESC : MO 로그테이블에서 일별통계 마스터 및 디테일테이블 데이터를 입력한다.   */
/* PARAMETERS                                                               */
/*   IN p_prc_date : 처리일자                                               */
/*   IN p_service_type : 서비스 종류                                        */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_mo_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_mo_insert
GO

CREATE PROCEDURE sp_em_stat_mo_insert
    @p_service_type  char(2)
AS

    DECLARE @v_prc_date   varchar(8)
          , @v_table_name varchar(20)
          , @dsql         nvarchar(4000)
 
    SELECT @v_prc_date = CONVERT(varchar, getdate(), 112)

    IF @p_service_type = '4'
        SELECT @v_table_name = 'em_mo_log_' + substring(@v_prc_date, 1, 6)
    ELSE IF @p_service_type = '5'
        SELECT @v_table_name = 'em_mo_log_' + substring(@v_prc_date, 1, 6)

    EXEC sp_em_stat_create

    /** insert em_statistics_m */
    SELECT  @dsql = '
        INSERT INTO em_statistics_m
                  ( stat_date
                  , stat_servicetype
                  , stat_payment_code
                  , stat_carrier
                  , stat_success
                  , stat_failure
                  , stat_invalid
                  , stat_invalid_ib
                  , stat_remained
                  , stat_regdate )
       SELECT 
                  '''+@v_prc_date+''',
                  '''+@p_service_type+''',
                  ''NONE'',
                  carrier,
                  SUM(CASE WHEN msg_status = ''3'' THEN 1 ELSE 0 END) AS success,
                  SUM(CASE WHEN msg_status <> ''3'' THEN 1 ELSE 0 END) AS failure,
                  0 AS invalid,
                  0 AS invalid_ib,
                  0 AS remained,
                  getdate()
      FROM   '+@v_table_name+'
      WHERE  convert(varchar, date_mo_recv, 112) = '''+@v_prc_date+'''
      AND    service_type = '''+@p_service_type+'''
      GROUP BY carrier '

    EXEC (@dsql)

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_stat_delete                                                 */
/* DESC : 기존에 남은 통계정보를 삭제한다.                                  */
/* PARAMETERS                                                               */
/*   IN p_prc_date : 처리일자                                               */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_stat_delete' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_stat_delete
GO

CREATE PROCEDURE sp_em_stat_delete
    @p_service_type  char(2)
  , @p_prc_date      varchar(8)
AS

    EXEC sp_em_stat_create

    BEGIN TRAN

    /* delete em_statistics_m */
    DELETE
    FROM   em_statistics_m
    WHERE  stat_date = @p_prc_date
    AND    stat_servicetype = @p_service_type;

    if @@error != 0
    begin
        rollback tran
        return
    end

    /* delete em_statistics_d */
    DELETE
    FROM   em_statistics_d
    WHERE  stat_date = @p_prc_date
    AND    stat_servicetype = @p_service_type;

    if @@error != 0
    begin
        rollback tran
        return
    end

    COMMIT TRAN

RETURN
GO
