/**
 * ATA가 공통으로 사용하는 SQLServer 2000 Stored Procedure 이다.
 * 고객사의 표준 프로시저를 이용하여 테이블 변경을 원할 경우
 * 아래의 프로시저를 수정하여 반영할 수 있으나,
 * INPUT PARAMETER 및 RESULTSET 결과는 아래 정의된
 * 대로 꼭 제공해 주어야 한다.
 */


-- USE imds
-- GO

/**************************************************************************/
/* NAME : sp_common_create                                             */
/* DESC : 각 서비스에서 공통적으로 사용하는 테이블을 사용한다.            */
/* PARAMETERS                                                             */
/*   N/A                                                                  */
/* REMARK                                                                 */
/*   N/A                                                                  */
/**************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_common_create' 
    AND    type = 'P' )
    DROP PROCEDURE sp_common_create
GO

CREATE PROCEDURE sp_common_create
AS

    IF NOT EXISTS (
        SELECT name
        FROM   sysobjects 
        WHERE  name = 'ata_banlist' 
        AND    type = 'U' )
    BEGIN
        CREATE TABLE ata_banlist
        ( service_type  char(2)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , ban_seq       int                                      NOT NULL
        , ban_type      char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL
        , content       varchar(45) COLLATE Korean_Wansung_CS_AS NOT NULL
        , send_yn       char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL default 'N'
        , ban_status_yn char(1)     COLLATE Korean_Wansung_CS_AS NOT NULL default 'Y'
        , reg_date      datetime                                 NOT NULL default getdate()
        , reg_user      varchar(20) COLLATE Korean_Wansung_CS_AS
        , update_date   datetime                                 NOT NULL default '1970-01-01 00:00:00'
        , update_user   varchar(20) COLLATE Korean_Wansung_CS_AS
        )
        
        ALTER TABLE ata_banlist  ADD PRIMARY KEY(service_type, ban_seq)
        CREATE INDEX idx_ata_banlist_1 ON ata_banlist(ban_type, service_type, ban_status_yn)
        CREATE INDEX idx_ata_banlist_2 ON ata_banlist(content)

    END

RETURN
GO


/**************************************************************************/
/* NAME : sp_common_banlist                                            */
/* DESC : 전송차단테이블에서 전송차단 리스트 조회한다.                    */
/* PARAMETERS                                                             */
/*   OUT p_list : Resultset                                               */
/*   IN p_service_type : 서비스 구분 (0: SMT, 1:URL, 2:MMT)               */
/* REMARK                                                                 */
/*   N/A                                                                  */
/**************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_common_banlist' 
    AND    type = 'P' )
    DROP PROCEDURE sp_common_banlist
GO

CREATE PROCEDURE sp_common_banlist
    @p_service_type char(2)
AS
    
    SELECT service_type
         , ban_type
         , content
         , send_yn
    FROM   ata_banlist
    WHERE  service_type = @p_service_type
    AND    ban_type  <> 'R'
    AND    ban_status_yn = 'Y'

RETURN
GO


/**************************************************************************/
/* NAME : sp_common_checkprivilege                                     */
/* DESC : 테이블 관리 권한을 체크한다.                                    */
/* PARAMETERS                                                             */
/*   N/A                                                                  */
/* REMARK                                                                 */
/*   N/A                                                                  */
/**************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_common_checkprivilege' 
    AND    type = 'P' )
    DROP PROCEDURE sp_common_checkprivilege
GO

CREATE PROCEDURE sp_common_checkprivilege
AS

    IF NOT EXISTS (
        SELECT name
        FROM   sysobjects 
        WHERE  name = 'ata_temp' 
        AND type = 'U' )
    BEGIN
        CREATE TABLE ata_temp (a char(1))

    DROP TABLE ata_temp
    END

RETURN
GO
