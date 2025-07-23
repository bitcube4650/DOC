/**
 * @(#)emma_sp_mon.sql
 * Copyright 2008 InfoBank Corporation. All rights reserved.
 * emma status monitor table ddl & dml.
 *
 * 실시간 상태정보 제공을 위한 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */


-- USE imds
-- GO

/****************************************************************************/
/* NAME : sp_em_mon_create                                                  */
/* DESC : 실시간 상태정보 모니터링 관련 테이블 생성한다.                    */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_mon_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_mon_create
GO

CREATE PROCEDURE sp_em_mon_create
AS

    IF NOT EXISTS (
        SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'em_status'
    )
    BEGIN
        CREATE TABLE em_status
        ( emma_id       char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL default ' '
        , process_name  varchar(40) COLLATE Korean_Wansung_CS_AS NOT NULL
        , pid           varchar(20) COLLATE Korean_Wansung_CS_AS NOT NULL
        , service_type  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , cnt_today     int
        , cnt_total     int
        , cnt_resent_1  int
        , cnt_resent_10 int
        , que_size      int
        , conn_time     varchar(20) COLLATE Korean_Wansung_CS_AS
        , update_time   varchar(20) COLLATE Korean_Wansung_CS_AS
        , conn_gw_info  varchar(40) COLLATE Korean_Wansung_CS_AS
        , reg_date      datetime NOT NULL default getdate()
        )
        
        ALTER TABLE em_status  ADD PRIMARY KEY(emma_id, process_name, pid, service_type)

    END

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_mon_status_insert                                           */
/* DESC : 엠마가 최초 실행시 각 프로세스의 상태정보를 Insert 한다.          */
/* PARAMETERS                                                               */
/*   IN p_process_name : 엠마 프로세스 이름                                 */
/*   IN p_pid          : 엠마 프로세스 PID(Thread ID)                       */
/*   IN p_service_type : 수행 서비스(0:sms, 1:MMS                           */
/*   IN p_conn_time    : 최초 연결 시각                                     */
/*   IN p_conn_gw_info : 연결 G/W 정보                                      */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_mon_status_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_mon_status_insert
GO

CREATE PROCEDURE sp_em_mon_status_insert
    @p_emma_id       char(2)
  , @p_process_name  varchar(40)
  , @p_pid           varchar(20)
  , @p_service_type  char(2)
  , @p_conn_time     varchar(20)
  , @p_conn_gw_info  varchar(40)
AS

    /** delete previous entry */
    EXEC sp_em_mon_status_delete @p_emma_id, @p_process_name, @p_pid, @p_service_type

    INSERT INTO em_status
              ( emma_id
              , process_name
              , pid
              , service_type
              , cnt_today
              , cnt_total
              , cnt_resent_1
              , cnt_resent_10
              , que_size
              , conn_time
              , update_time
              , conn_gw_info
              , reg_date)
    values    ( @p_emma_id
              , @p_process_name
              , @p_pid
              , @p_service_type
              , 0
              , 0
              , 0
              , 0
              , 0
              , @p_conn_time
              , convert(varchar, getdate(), 20)
              , @p_conn_gw_info
              , getdate())

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_mon_status_update                                           */
/* DESC : 각 프로세스(스레드)의 상태 정보를 설정한 주기별로 업데이트 한다.  */
/* PARAMETERS                                                               */
/*   IN p_process_name  : 엠마 프로세스 이름                                */
/*   IN p_pid           : 엠마 프로세스 PID(Thread ID)                      */
/*   IN p_service_type  : 수행 서비스(0:sms, 1:MMS                          */
/*   IN p_cnt_today     : 당일 처리 건수                                    */
/*   IN p_cnt_total     : 엠마가 실행 후 현재까지 처리 건수                 */
/*   IN p_cnt_resent_1  : 최근 1분간 처리건수                               */
/*   IN p_cnt_resent_10 : 최근 10분간 처리건수                              */
/*   IN p_que_size      : 큐에 남은 건수                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_mon_status_update' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_mon_status_update
GO

CREATE PROCEDURE sp_em_mon_status_update
    @p_emma_id        char(2)
  , @p_process_name   varchar(40)
  , @p_pid            varchar(20)
  , @p_service_type   char(2)
  , @p_cnt_today      int
  , @p_cnt_total      int
  , @p_cnt_resent_1   int
  , @p_cnt_resent_10  int
  , @p_que_size       int
AS

     UPDATE em_status
     SET    cnt_today     = @p_cnt_today
          , cnt_total     = @p_cnt_total
          , cnt_resent_1  = @p_cnt_resent_1
          , cnt_resent_10 = @p_cnt_resent_10
          , que_size      = @p_que_size
          , update_time   = getdate()
     WHERE  emma_id       = @p_emma_id
     AND  process_name    = @p_process_name
     AND  pid             = @p_pid
     AND  service_type    = @p_service_type

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_mon_status_delete_all                                       */
/* DESC : 엠마 기동시 기존 상태정보를 모두 삭제한다.                        */
/* PARAMETERS                                                               */
/*   N/A                                                                    */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_mon_status_delete_all' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_mon_status_delete_all
GO

CREATE PROCEDURE sp_em_mon_status_delete_all
    @p_emma_id  char(2)
AS

    DELETE
    FROM   em_status
    WHERE  emma_id = @p_emma_id

RETURN
GO


/****************************************************************************/
/* NAME : sp_em_mon_status_delete                                           */
/* DESC : 기존에 남은 상태정보를 삭제한다.                                  */
/* PARAMETERS                                                               */
/*   IN p_process_name  : 엠마 프로세스 이름                                */
/*   IN p_pid           : 엠마 프로세스 PID(Thread ID)                      */
/*   IN p_service_type  : 수행 서비스(0:sms, 1:MMS)                         */
/* REMARK                                                                   */
/*   N/A                                                                    */
/****************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_em_mon_status_delete' 
    AND    type = 'P' )
    DROP PROCEDURE sp_em_mon_status_delete
GO

CREATE PROCEDURE sp_em_mon_status_delete
    @p_emma_id       char(2)
  , @p_process_name  varchar(40)
  , @p_pid           varchar(20)
  , @p_service_type  char(2)
AS

    /* delete record */
    DELETE
    FROM   em_status
    WHERE  emma_id      = @p_emma_id 
    AND    process_name = @p_process_name
    AND    pid          = @p_pid
    AND    service_type = @p_service_type

RETURN
GO
