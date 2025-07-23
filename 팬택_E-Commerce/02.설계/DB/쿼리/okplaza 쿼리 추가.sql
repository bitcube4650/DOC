ALTER TABLE SMPWORKINFO ADD CUST_CATE_MAST_CD VARCHAR(3);
ALTER TABLE SMPWORKINFO ADD SITE_ID INT DEFAULT '0';

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 마스터 CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPWORKINFO', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPWORKINFO', @level2type = N'COLUMN', @level2name = 'SITE_ID';

CREATE INDEX IDX_SMPWORKINFO_SITE_ID ON SMPWORKINFO (SITE_ID);
-- 기존 데이터에서 SITE_ID가 NULL인 경우 0으로 업데이트
UPDATE SMPWORKINFO SET SITE_ID = 0 WHERE SITE_ID IS NULL;
--UPDATE SMPWORKINFO SET SITE_ID = 1 WHERE WORKNM LIKE '%HNS%';  

-------------------------------------------------------------------------------

ALTER TABLE MRORDT ADD MATERIAL VARCHAR(20);
ALTER TABLE MRORDT ADD MATERIAL_DETL_CD VARCHAR(20);


----------------------------------------------------------------------------------


ALTER TABLE MRORDTLIST ADD MATERIAL VARCHAR(20);
ALTER TABLE MRORDTLIST ADD MATERIAL_DETL_CD VARCHAR(20);

----------------------------------------------------------------------------------

--SELECT * FROM SMP_SEQUENCE ss WHERE TABLE_NAME LIKE '%SITE%'
INSERT INTO SMP_SEQUENCE VALUES ('SEQMP_SITEID', 1);

--------------------------------------------------------------------------

CREATE TABLE SMP_SITE (
    SITE_ID INT PRIMARY KEY,              -- 사이트ID
    SITE_NM VARCHAR(100),                 -- 사이트명
    SITE_DESC VARCHAR(500),               -- 사이트설명
    CSS VARCHAR(20),                      -- CSS
    LOGO_ID VARCHAR(100),                 -- 로고이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME                  -- 수정일시
);

INSERT INTO SMP_SITE VALUES ( '0', 'OK플라자(기본)', 'OK플라자 일반구매사를 대상으로 합니다.', 0, 0, '2', GETDATE(), '2', GETDATE() ); 

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'SITE_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'SITE_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'CSS', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'CSS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'로고이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'LOGO_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

--------------------------------------------------------------------
CREATE TABLE SMP_SITE_TEMP (
    SITE_ID INT PRIMARY KEY,              -- 사이트ID
    SITE_NM VARCHAR(100),                 -- 사이트명
    SITE_DESC VARCHAR(500),               -- 사이트설명
    CSS VARCHAR(20),                      -- CSS
    LOGO_ID VARCHAR(100),                 -- 로고이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    APPLY_YN VARCHAR(1)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'CSS', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'CSS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'로고이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'LOGO_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'APPLY_YN';

--------------------------------------------------------------------
CREATE TABLE SMP_SITE_BANNER (
    SITE_ID INT,				-- 사이트ID
    BANNER_NM VARCHAR(100),		-- 배너명
    SEARCH_WORD VARCHAR(100),	-- 검색어
    DISORDER INT,				-- 순서
    BANNER_ID VARCHAR(10),		-- 배너이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (SITE_ID, BANNER_NM)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'BANNER_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'검색어', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'SEARCH_WORD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'DISORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'BANNER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

------------------------------------------------------------------------------------
--drop table SMP_SITE_BANNER_TEMP
CREATE TABLE SMP_SITE_BANNER_TEMP (
    SITE_ID INT,				-- 사이트ID
    BANNER_NM VARCHAR(100),		-- 배너명
    SEARCH_WORD VARCHAR(100),	-- 검색어
    DISORDER INT,				-- 순서
    BANNER_ID VARCHAR(10),		-- 배너이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (SITE_ID, BANNER_NM)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'BANNER_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'검색어', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'SEARCH_WORD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'DISORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'BANNER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

------------------------------------------------------------------------------------
drop table SMP_SITE_GOOD
CREATE TABLE SMP_SITE_GOOD (
    SITE_ID INT,				-- 사이트ID
    GOOD_IDEN_NUMB BIGINT,		-- 상품코드
    PRIMARY KEY (SITE_ID, GOOD_IDEN_NUMB)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_GOOD', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_GOOD', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';

-----------------------------------------------------------------------------------------
CREATE TABLE SMP_SITE_GOOD_TEMP (
    SITE_ID INT,				-- 사이트ID
    GOOD_IDEN_NUMB BIGINT,		-- 상품코드
    PRIMARY KEY (SITE_ID, GOOD_IDEN_NUMB)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_GOOD_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_GOOD_TEMP', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';

-----------------------------------------------------------------------------------------


CREATE TABLE MCGOOD_MATERIAL (
	MATERIAL VARCHAR(20) NOT NULL,			-- 지정품종코드
	MATERIAL_NM VARCHAR(100) NOT NULL,		-- 품종명
	MATERIAL_DESC VARCHAR(100) NOT NULL,	-- 품종내역
	MANAGE_CD VARCHAR(20) NOT NULL,			-- 관리구분CD
	USED_CD VARCHAR(20) NOT NULL,			-- 사용처CD
	AUTO_DIST_YN VARCHAR(1) NOT NULL,		-- 자동물량YN
	DEL_YN VARCHAR(1) NOT NULL DEFAULT 'N',	-- 삭제YN
	DISP_ORDER INT,							-- 조회순서
	BID_TYPE_CD VARCHAR(20),				-- 입찰형태
	SELL_DATE DATETIME,						-- 공급시작일
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'MATERIAL_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종내역', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'관리구분CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'MANAGE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용처CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'USED_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'자동물량YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'AUTO_DIST_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'삭제YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'DEL_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'조회순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'DISP_ORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'입찰형태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'BID_TYPE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'SELL_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

INSERT INTO MCGOOD_MATERIAL
SELECT 	A.CODEVAL1 AS MATERIAL
,		A.CODENM1 AS MATERIAL_NM
,		A.CODENM3 AS MATERIAL_DESC -- 
,		B.CODEVAL1 AS MANAGE_CD
,		C.CODEVAL1 AS USED_CD
,		A.CODEVAL3 AS AUTO_DIST_YN
,		CASE WHEN A.ISUSE = 1 THEN 'N' ELSE 'Y' END AS DEL_YN
,		A.DISORDER AS DISP_ORDER
,		'ALL' AS BID_TYPE_CD
,		D.STA_DT AS SELL_DATE
,		'2' AS INSERT_USER_ID
,		GETDATE() AS INSERT_DATE
,		'2' AS UPDATE_USER_ID
,		GETDATE() AS UPDATE_DATE
FROM SMPCODES A
LEFT OUTER JOIN SMPCODES B
	ON B.CODETYPECD = 'MATERIAL_MANAGE'
	AND A.CODENM2 = B.CODENM1
LEFT OUTER JOIN SMPCODES C
	ON C.CODETYPECD = 'MATERIAL_USED'
	AND A.CODEVAL2 = C.CODENM1 
LEFT OUTER JOIN MCAUTO_RATE_INFO D 
	ON A.CODEVAL1 = D.MATERIAL
LEFT OUTER JOIN MCGOOD_MATERIAL E
	ON A.CODEVAL1 = E.MATERIAL 
WHERE A.CODETYPECD = 'SMPMATERIAL'
AND A.AGENT_ID = '13'
AND E.MATERIAL IS NULL
AND B.CODEVAL1 IS NOT NULL
AND C.CODEVAL1 IS NOT NULL
ORDER BY A.DISORDER ;

----------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_VENDOR (
	MATERIAL VARCHAR(20) NOT NULL,		-- 지정품종코드
	VENDORID VARCHAR(10) NOT NULL,		-- 공급사ID
	SUIT_STATS_CD VARCHAR(20) NOT NULL,	-- 적격공급상태
	SUIT_SEL_CD VARCHAR(20),			-- 선정
	DISTRL_RATE INT NOT NULL,			-- 배분율
	EXCEPT_START_DATE DATETIME,			-- 제외시작일
	EXCEPT_END_DATE DATETIME,			-- 제외종료일
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL, VENDORID)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'적격공급상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'SUIT_STATS_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'선정', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'SUIT_SEL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배분율', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'DISTRL_RATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'EXCEPT_START_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'EXCEPT_END_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

----------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_DETL (
    MATERIAL_DETL_CD varchar(20) NOT NULL,	-- 세부품종코드
    MATERIAL varchar(20) NOT NULL,			-- 지정품종코드
    MATERIAL_DETL_NM varchar(50) NOT NULL,	-- 세부품종명
    MATERIAL_DETL_DESC varchar(100) NULL,	-- 세부품종내역
    USE_YN varchar(1) NOT NULL,				-- 사용YN
    INSERT_USER_ID varchar(20) NOT NULL,	-- 등록자ID
    INSERT_DATE datetime NOT NULL,			-- 등록일시
    UPDATE_USER_ID varchar(20) NULL,		-- 수정자ID
    UPDATE_DATE datetime NULL,				-- 수정일시
    PRIMARY KEY (MATERIAL_DETL_CD)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종내역', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

-- 마이그레이션
INSERT INTO MCGOOD_MATERIAL_DETL 
SELECT	A.CODEVAL1 AS MATERIAL_DETL_CD
,		A.CODENM3 AS MATERIAL
,		A.CODENM2 AS MATERIAL_DETL_NM
,		A.CODENM1 AS MATERIAL_DETL_DESC
,		CASE WHEN A.ISUSE = 1 THEN 'Y' ELSE 'N' END AS DEL_YN
,		'2' AS INSERT_USER_ID
,		GETDATE() AS INSERT_DATE
,		'2' AS UPDATE_USER_ID
,		GETDATE() AS UPDATE_DATE
FROM SMPCODES A
WHERE A.CODETYPECD = 'SMPMATERIAL_SUB'

--------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_HIST (
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    HIST_DATE datetime NOT NULL,		--이력등록일시
    MATERIAL_NM varchar(100) NOT NULL,	--품종명
    MATERIAL_DESC varchar(100) NULL,	--품종내역
    MANAGE_CD varchar(20) NOT NULL,		--관리구분CD
    USED_CD varchar(20) NOT NULL,		--사용처CD
    AUTO_DIST_YN varchar(1) NOT NULL,	--자동물량YN
    DEL_YN varchar(1) NOT NULL,			--삭제YN
    DISP_ORDER int NOT NULL,			--조회순서
    BID_TYPE_CD varchar(20) NULL,		--입찰형태
    SELL_DATE datetime NULL,			--공급시작일
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (MATERIAL, HIST_DATE)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'이력등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'HIST_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'MATERIAL_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종내역', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'MATERIAL_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'관리구분CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'MANAGE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용처CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'USED_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'자동물량YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'AUTO_DIST_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'삭제YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'DEL_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'조회순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'DISP_ORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'입찰형태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'BID_TYPE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'SELL_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

-----------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_COMP (
    MATERIAL varchar(20) NOT NULL,			--지정품종코드
    COMP_ID int NOT NULL,					--콤포넌트ID
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    PRIMARY KEY (MATERIAL, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

--------------------------------------------------------------------

CREATE TABLE MCGOOD_COMP (
    COMP_ID int NOT NULL,					--콤포넌트ID
    COMP_NM varchar(100) NOT NULL,			--콤포넌트명
    COMP_UNIT varchar(20) NOT NULL,			--단위
    BUY_PRIS DECIMAL(15,4) NOT NULL,		--매입낱개단가
    COMP_DESC varchar(500) NULL,			--콤포넌트설명
    USE_YN varchar(1) NOT NULL,				--사용여부YN
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    UPDATE_USER_ID varchar(20) NULL,		--수정자ID
    UPDATE_DATE datetime NULL,				--수정일시
    PRIMARY KEY (COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'COMP_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'단위', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'COMP_UNIT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'COMP_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용여부YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


------------------------------------------------------------------------


CREATE TABLE MCGOOD_COMP_HIST (
    COMP_ID int NOT NULL,					--콤포넌트ID
    COMP_NM varchar(100) NOT NULL,			--콤포넌트명
    COMP_UNIT varchar(20) NOT NULL,			--단위
    BUY_PRIS DECIMAL(15,4) NOT NULL,		--매입낱개단가
    COMP_DESC varchar(500) NULL,			--콤포넌트설명
    USE_YN varchar(1) NOT NULL,				--사용여부YN
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    UPDATE_USER_ID varchar(20) NULL,		--수정자ID
    UPDATE_DATE datetime NULL,				--수정일시
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'COMP_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'단위', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'COMP_UNIT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'COMP_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용여부YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_DAY_STATIST (
    MATERIAL varchar(20) NOT NULL,		-- 지정품종코드
    good_iden_numb bigint NOT NULL,		--상품코드
    vendorid varchar(10) NOT NULL,		--공급사ID
    RACE_REGI_DAY date NOT NULL,		--인수일
    SELL_DATE date NOT NULL,			--취합시 공급시작일
    BATCH_QUAN decimal(12,0) NULL,		--주문수량함
    SELL_PRIS decimal(15,4) NULL,		--매출단가
    SELL_AMOUNT decimal(15,0) NULL,		--매출금액
    BUY_PRIS decimal(15,4) NULL,		--매입단가
    BUY_AMOUNT decimal(15,0) NULL,		--매입금액
    INSERT_DATE datetime NOT NULL,		--등록일시
    PRIMARY KEY (MATERIAL, good_iden_numb, vendorid, RACE_REGI_DAY),
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'good_iden_numb';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'vendorid';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'인수일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'RACE_REGI_DAY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'취합시 공급시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'주문수량함', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BATCH_QUAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매출단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매출금액', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_AMOUNT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입금액', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BUY_AMOUNT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_COMP_DAY_STATIST (
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    good_iden_numb bigint NOT NULL,		--상품코드
    vendorid varchar(10) NOT NULL,		--공급사ID
    RACE_REGI_DAY date NOT NULL,		--인수일
    COMP_ID int NOT NULL,				--콤포넌트ID
    SELL_DATE date NOT NULL,			--취합시 공급시작일
    BATCH_QUAN decimal(12,0) NULL,		--콤포넌트낱개수량합
    SELL_PRIS decimal(15,4) NULL,		--콤포넌트 매출단가
    SELL_AMOUNT decimal(15,0) NULL,		--콤포넌트 매출금액
    BUY_PRIS decimal(15,4) NULL,		--콤포넌트 매입단가
    BUY_AMOUNT decimal(15,0) NULL,		--콤포넌트 매입금액
    INSERT_DATE datetime NOT NULL,		--등록일시
    PRIMARY KEY (MATERIAL, good_iden_numb, vendorid, RACE_REGI_DAY, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'good_iden_numb';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'vendorid';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'인수일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'RACE_REGI_DAY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'취합시 공급시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트낱개수량합', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BATCH_QUAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트 매출단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트 매출금액', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'SELL_AMOUNT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트 매입단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트 매입금액', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'BUY_AMOUNT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_GOOD_COMP (
    good_iden_numb bigint NOT NULL,		--상품코드
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    COMP_ID int NOT NULL,				--콤포넌트ID
    VENDORID VARCHAR(10) NOT NULL,		--공급사ID
    UNIT_QUAN int NOT NULL,				--기본수량
    SELL_PRIS decimal(15,4) NOT NULL,	--매출낱개단가
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (good_iden_numb, MATERIAL, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'good_iden_numb';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기본수량', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'UNIT_QUAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매출낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'SELL_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_GOOD_COMP_HIST (
    good_iden_numb bigint NOT NULL,		--상품코드
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    COMP_ID int NOT NULL,				--콤포넌트ID
    VENDORID VARCHAR(10) NOT NULL,		--공급사ID
    HIST_DATE datetime NOT NULL,		--이력등록일시
    UNIT_QUAN int NOT NULL,				--기본수량
    BUY_PRIS decimal(15,4) NOT NULL,	--매입낱개단가
    SELL_PRIS decimal(15,4) NOT NULL,	--매출낱개단가
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (good_iden_numb, MATERIAL, COMP_ID, HIST_DATE)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'good_iden_numb';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'이력등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'HIST_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기본수량', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'UNIT_QUAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매출낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'SELL_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_COMP_PAST (
    COMP_ID int NOT NULL,					--콤포넌트ID
    PAST_YYYY VARCHAR(4) NOT NULL,			--과거년도
    COMP_NM varchar(100) NOT NULL,			--콤포넌트명
    COMP_UNIT varchar(20) NOT NULL,			--단위
    BUY_PRIS DECIMAL(15,4) NOT NULL,		--매입낱개단가
    COMP_DESC varchar(500) NULL,			--콤포넌트설명
    USE_YN varchar(1) NOT NULL,				--사용여부YN
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    UPDATE_USER_ID varchar(20) NULL,		--수정자ID
    UPDATE_DATE datetime NULL,				--수정일시
    PRIMARY KEY (COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'단위', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_UNIT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매입낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'BUY_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용여부YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_GOOD_COMP_PAST (
    good_iden_numb bigint NOT NULL,		--상품코드
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    COMP_ID int NOT NULL,				--콤포넌트ID
    PAST_YYYY VARCHAR(4) NOT NULL,		--과거년도
    VENDORID VARCHAR(10) NOT NULL,		--공급사ID
    UNIT_QUAN int NOT NULL,				--기본수량
    SELL_PRIS decimal(15,4) NOT NULL,	--매출낱개단가
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (good_iden_numb, MATERIAL, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'good_iden_numb';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기본수량', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'UNIT_QUAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'매출낱개단가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'SELL_PRIS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

---------------------------------------------------------------------------------


CREATE TABLE MCGOOD_MATERIAL_COMP_PAST (
    MATERIAL varchar(20) NOT NULL,			--지정품종코드
    COMP_ID int NOT NULL,					--콤포넌트ID
    PAST_YYYY VARCHAR(4) NOT NULL,					--콤포넌트ID
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    PRIMARY KEY (MATERIAL, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_PAST (
	MATERIAL VARCHAR(20) NOT NULL,			-- 지정품종코드
	PAST_YYYY VARCHAR(4) NOT NULL,			-- 지정품종코드
	MATERIAL_NM VARCHAR(100) NOT NULL,		-- 품종명
	MATERIAL_DESC VARCHAR(100) NOT NULL,	-- 품종내역
	MANAGE_CD VARCHAR(20) NOT NULL,			-- 관리구분CD
	USED_CD VARCHAR(20) NOT NULL,			-- 사용처CD
	AUTO_DIST_YN VARCHAR(1) NOT NULL,		-- 자동물량YN
	DEL_YN VARCHAR(1) NOT NULL DEFAULT 'N',	-- 삭제YN
	DISP_ORDER INT,							-- 조회순서
	BID_TYPE_CD VARCHAR(20),				-- 입찰형태
	SELL_DATE DATETIME,						-- 공급시작일
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종내역', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'관리구분CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'MANAGE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용처CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'USED_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'자동물량YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'AUTO_DIST_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'삭제YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'DEL_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'조회순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'DISP_ORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'입찰형태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'BID_TYPE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'SELL_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


---------------------------------------------------------------------------------


CREATE TABLE MCGOOD_MATERIAL_VENDOR_PAST (
	MATERIAL VARCHAR(20) NOT NULL,		-- 지정품종코드
	VENDORID VARCHAR(10) NOT NULL,		-- 공급사ID
	PAST_YYYY VARCHAR(4) NOT NULL,		-- 공급사ID
	SUIT_STATS_CD VARCHAR(20) NOT NULL,	-- 적격공급상태
	SUIT_SEL_CD VARCHAR(20),			-- 선정
	DISTRL_RATE INT NOT NULL,			-- 배분율
	EXCEPT_START_DATE DATETIME,			-- 제외시작일
	EXCEPT_END_DATE DATETIME,			-- 제외종료일
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL, VENDORID)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'적격공급상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'SUIT_STATS_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'선정', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'SUIT_SEL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배분율', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'DISTRL_RATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'EXCEPT_START_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'EXCEPT_END_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';



---------------------------------------------------------------------------------
CREATE TABLE MCCUST_CATE_MAST (
    CUST_CATE_MAST_CD varchar(3) NOT NULL,		--구매사 카테코리 마스터CD
    CUST_CATE_MAST_NM varchar(100) NOT NULL,	--카테고리 마스터명
    USE_YN varchar(1) NOT NULL,					--사용여부YN
    ORDERING int NULL,							--순서
    CUST_CATE_MAST_DESC varchar(500) NULL,		--마스터 설명
    INSERT_USER_ID varchar(20) NOT NULL,		--등록자ID
    INSERT_DATE datetime NOT NULL,				--등록일시
    UPDATE_USER_ID varchar(20) NULL,			--수정자ID
    UPDATE_DATE datetime NULL,					--수정일시
    PRIMARY KEY (CUST_CATE_MAST_CD)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 마스터CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'카테고리 마스터명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용여부YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'ORDERING';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'마스터 설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_MAST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


---------------------------------------------------------------------------------

CREATE TABLE MCCUST_CATE_NEW (
    CUST_CATE_CD varchar(20) NOT NULL,			--구매사 카테고리 CD
    CUST_CATE_MAST_CD varchar(3) NOT NULL,		--구매사 카테고리 마스터CD
    PAR_CUST_CATE_CD varchar(20) NULL,			--상위카테고리CD
    CUST_CATE_NM varchar(100) NOT NULL,			--카테고리명
    CATE_LEVEL int NOT NULL,					--카테고리레벌
    USE_YN varchar(1) NOT NULL,					--사용여부YN
    ORDERING int NULL,							--순서
    CUST_CATE_DESC varchar(500) NULL,			--카테고리설명
    INSERT_USER_ID varchar(20) NOT NULL,		--등록자ID
    INSERT_DATE datetime NOT NULL,				--등록일시
    UPDATE_USER_ID varchar(20) NULL,			--수정자ID
    UPDATE_DATE datetime NULL,					--수정일시
    PRIMARY KEY (CUST_CATE_CD)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'CUST_CATE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 마스터CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상위카테고리CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'PAR_CUST_CATE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'카테고리명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'CUST_CATE_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'카테고리레벨', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'CATE_LEVEL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용여부YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'ORDERING';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'카테고리설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'CUST_CATE_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


-------------------------------------------------------------------------------------

CREATE TABLE MCCUST_CATE_NEW_CONN (
    CUST_CATE_CD varchar(20) NOT NULL,		--구매사 카테고리 CD
    CATE_ID int NOT NULL,					--표준카테고리SEQ
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    PRIMARY KEY (CUST_CATE_CD, CATE_ID)
);
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN', @level2type = N'COLUMN', @level2name = 'CUST_CATE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'표준카테고리SEQ', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN', @level2type = N'COLUMN', @level2name = 'CATE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

-------------------------------------------------------------

CREATE TABLE MCCUST_CATE_NEW_CONN_HIST (
    HIST_ID int NOT NULL,					--HIST ID
    CUST_CATE_CD varchar(20) NOT NULL,		--구매사 카테고리 CD
    CATE_ID int NOT NULL,					--표준카테고리SEQ
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    PRIMARY KEY (HIST_ID)
);
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'HIST ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN_HIST', @level2type = N'COLUMN', @level2name = 'HIST_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN_HIST', @level2type = N'COLUMN', @level2name = 'CUST_CATE_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'표준카테고리SEQ', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN_HIST', @level2type = N'COLUMN', @level2name = 'CATE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCCUST_CATE_NEW_CONN_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';


------------------------------------------------------------------

CREATE TABLE SMPPART_REQ (
    APPLID int NOT NULL,						--신청ID
    ITEMID int NOT NULL,						--품목ID
    PARTSTATE VARCHAR(10) NULL,					--참가상태
    PART_USERID varchar(10) NULL,				--참가자ID
    VENDORNM varchar(100) NULL,					--공급사명
    BUSINESSNUM varchar(100) NULL,				--사업자등록번호
    VENDORBUSITYPE VARCHAR(100) NULL,			--업종
    VENDORBUSICLAS VARCHAR(100) NULL,			--업태
    PRESENTNM VARCHAR(100) NULL,				--대표자명
    PHONENUM varchar(150) NULL,					--대표연락처
    BUSICHARGER VARCHAR(50) NULL,				--영업담당자
    BUSIPHONENUM VARCHAR(150) NULL,				--영업연락처
    BUSICHARGERMAIL VARCHAR(150) NULL,			--영엄담당이메일
    BUSINESSATTACHFILESEQ varchar(10) NULL,		--사업자등록첨부
    COMPINTROATTACHSEQ varchar(10) NULL,		--회사소개서
    PRODINTROATTACHSEQ varchar(10) NULL,		--제품소개서
    CREDITGRADE VARCHAR(30) NULL,				--신용등급
    CREDITGRADEATTACHSEQ VARCHAR(10) NULL,		--신용등급서
    FACTORYREGIDDATE VARCHAR(6) NULL,			--공장등록년월
    FACTORYREGIATTACHSEQ VARCHAR(10) NULL,		--공장등록증
    LABREGIDATE varchar(6) NULL,				--기업부설연구소등록년월
	LABREGIATTACHSEQ varchar(6) NULL,			--기업부설연구소증
    QCPOSSE VARCHAR(200) NULL,					--품질인증보유
    QCCERTIATTACHSEQ VARCHAR(10)  NULL,			--품질인정서
	PRODTYPE VARCHAR(10) NULL,					--동일 유사 제품구분
	DELIVERYRESULT DECIMAL(15)  NULL,			--납품실적
	DELIVERYCERTIATTACHSEQ VARCHAR(10)  NULL,	--납품증명서
	QUALITYVENIPOSSEATTACHSEQ VARCHAR(10) NULL,	--품질검증기기보유
	SECRETMEMOATTACHSEQ VARCHAR(10) NULL,		--비밀유지각서
    COMMITMEMOATTACHSEQ VARCHAR(10) NULL,		--평가결과승복확약각서
    ATTACHFILE1 varchar(10) NULL,				--첨부파일1
    ATTACHFILE2 varchar(10) NULL,				--첨부파일2
    ATTACHFILE3 varchar(10) NULL,				--첨부파일3
    ATTACHFILE4 varchar(10) NULL,				--첨부파일4
    REGIUSERID varchar(20) NOT NULL,			--등록자ID
    REGIDATE datetime NOT NULL,					--등록일시
    MODIUSERID varchar(20) NULL,				--수정자ID
    MODIFYDATE datetime NULL,					--수정일시
    PRIMARY KEY (APPLID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'신청ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'APPLID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품목ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'ITEMID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'참가상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PARTSTATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'참가자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PART_USERID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'VENDORNM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사업자등록번호', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'BUSINESSNUM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'업종', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'VENDORBUSITYPE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'업태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'VENDORBUSICLAS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'대표자명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PRESENTNM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'대표연락처', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PHONENUM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'영업담당자', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'BUSICHARGER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'영업연락처', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'BUSIPHONENUM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'영업담당이메일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'BUSICHARGERMAIL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사업자등록첨부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'BUSINESSATTACHFILESEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'회사소개서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'COMPINTROATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제품소개서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PRODINTROATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'신용등급', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'CREDITGRADE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'신용등급서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'CREDITGRADEATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공장등록년월', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'FACTORYREGIDDATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공장등록증', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'FACTORYREGIATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기업부설연구소등록년월', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'LABREGIDATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기업부설연구소증', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'LABREGIATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품질인증보유', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'QCPOSSE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품질인정서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'QCCERTIATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'동일 유사 제품구분', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'PRODTYPE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'납품실적', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'DELIVERYRESULT';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'납품증명서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'DELIVERYCERTIATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품질검증기기보유', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'QUALITYVENIPOSSEATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'비밀유지각서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'SECRETMEMOATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'평가결과승복확약각서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'COMMITMEMOATTACHSEQ';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'첨부파일1', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'ATTACHFILE1';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'첨부파일2', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'ATTACHFILE2';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'첨부파일3', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'ATTACHFILE3';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'첨부파일4', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'ATTACHFILE4';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'REGIUSERID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'REGIDATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'MODIUSERID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPPART_REQ', @level2type = N'COLUMN', @level2name = 'MODIFYDATE';


--------------------------------------------------------------------------------


CREATE TABLE SMPPART_BIZ_APPL
( 
	APPLID               int  NOT NULL ,
	COMPINTROSCORE       int  NULL ,
	CREDITGRADESCORE     int  NULL ,
	FACTORYREGISCORE     int  NULL ,
	LABSCORE             int  NULL ,
	QCINTRNTLSCORE       int  NULL ,
	QCDOMESTCSCORE       int  NULL ,
	QCETCSCORE           int  NULL ,
	DELIVERYRESULTSCORE  int  NULL ,
	OWNEQUIPSCORE        int  NULL ,
	QUALITYMAGTSCORE     int  NULL ,
	CREDITSCORE          int  NULL ,
	BUSIEVALSTATE        varchar(10)  NULL ,
	BUSIEVALID           varchar(20)  NULL ,
	BUSIEVALDATE         datetime  NULL ,
	BUSIEVALSCORE        int  NULL ,
	REGIUSERID           varchar(20)  NULL ,
	REGIDATE             datetime  NULL ,
	MODIUSERID           varchar(20)  NULL ,
	MODIDATE             datetime  NULL ,
    PRIMARY KEY (APPLID)
);

CREATE TABLE SMPPART_FINA_APPL
( 
	APPLID               int  NOT NULL ,
	LASTEVAL             varchar(10)  NULL ,
	EVALBASIS            text  NULL ,
	LAST1APPRVID         varchar(20)  NULL ,
	LAST1APPRVSTATE      varchar(10)  NULL ,
	LAST1APPRVCOMMENT    varchar(200)  NULL ,
	LAST2APPRVID         varchar(20)  NULL ,
	LAST2APPRVSTATE      varchar(10)  NULL ,
	LAST2APPRVCOMMENT    varchar(200)  NULL ,
	LASTEVALSTATE        varchar(10)  NULL ,
	LASTEVALID           varchar(20)  NULL ,
	LASTEVALDATE         datetime  NULL ,
	REGIUSERID           varchar(20)  NULL ,
	REGIDATE             datetime  NULL ,
	MODIUSERID           varchar(20)  NULL ,
	MODIDATE             datetime  NULL  ,
    PRIMARY KEY (APPLID)
);

CREATE TABLE SMPPART_MIDD_APPL
( 
	APPLID               int  NOT NULL ,
	MIDDLEEVAL           varchar(10)  NULL ,
	MIDDLE1APPRVID       varchar(20)  NULL ,
	MIDDLE1APPRVSTATE    varchar(10)  NULL ,
	MIDDLE1APPRVCOMMENT  varchar(200)  NULL ,
	MIDDLE2APPRVID       varchar(20)  NULL ,
	MIDDLE2APPRVSTATE    varchar(10)  NULL ,
	MIDDLE2APPRVCOMMENT  varchar(200)  NULL ,
	MIDDLEEVALSTATE      varchar(10)  NULL ,
	MIDDLEEVALID         varchar(20)  NULL ,
	MIDDLEEVALDATE       datetime  NULL ,
	REGIUSERID           varchar(20)  NULL ,
	REGIDATE             datetime  NULL ,
	MODIUSERID           varchar(20)  NULL ,
	MODIDATE             datetime  NULL ,
    PRIMARY KEY (APPLID)
);

CREATE TABLE SMPPART_PROD_APPL
( 
	APPLID               int  NOT NULL ,
	EVALSTARTDATE        varchar(10)  NULL ,
	EVALENDDATE          varchar(10)  NULL ,
	EVALLOCATION         varchar(100)  NULL ,
	TESTARTICLE          int  NULL ,
	PASS                 int  NULL ,
	FAIL                 int  NULL ,
	TESTRESULTATTACHSEQ  varchar(10)  NULL ,
	TESTREPORTATTACHSEQ  varchar(10)  NULL ,
	PRODEVALSTATE        varchar(10)  NULL ,
	PRODEVALID           varchar(20)  NULL ,
	PRODEVALDATE         datetime  NULL ,
	REGIUSERID           varchar(20)  NULL ,
	REGIDATE             datetime  NULL ,
	MODIUSERID           varchar(20)  NULL ,
	MODIDATE             datetime  NULL ,
    PRIMARY KEY (APPLID)
);

CREATE TABLE SMPPART_QLAL_APPL
( 
	APPLID               int  NOT NULL ,
	QUALITYMAGTATTACHSEQ varchar(10)  NULL ,
	GENERAL1             int  NULL ,
	GENERAL2             int  NULL ,
	GENERAL3             int  NULL ,
	GENERAL4             int  NULL ,
	GENERAL5             int  NULL ,
	DOCUMNT1             int  NULL ,
	DOCUMNT2             int  NULL ,
	DOCUMNT3             int  NULL ,
	DOCUMNT4             int  NULL ,
	DOCUMNT5             int  NULL ,
	MATERIL1             int  NULL ,
	MATERIL2             int  NULL ,
	MATERIL3             int  NULL ,
	MATERIL4             int  NULL ,
	MATERIL5             int  NULL ,
	PRODUCE1             int  NULL ,
	PRODUCE2             int  NULL ,
	PRODUCE3             int  NULL ,
	PRODUCE4             int  NULL ,
	PRODUCE5             int  NULL ,
	PRODUCE6             int  NULL ,
	PRODUCE7             int  NULL ,
	PRODUCE8             int  NULL ,
	EQUIPMT1             int  NULL ,
	EQUIPMT2             int  NULL ,
	EQUIPMT3             int  NULL ,
	EQUIPMT4             int  NULL ,
	EQUIPMT5             int  NULL ,
	TEST1                int  NULL ,
	TEST2                int  NULL ,
	TEST3                int  NULL ,
	TEST4                int  NULL ,
	TEST5                int  NULL ,
	SUITAB1              int  NULL ,
	SUITAB2              int  NULL ,
	SUITAB3              int  NULL ,
	SUITAB4              int  NULL ,
	SUITAB5              int  NULL ,
	ETC1                 int  NULL ,
	ETC2                 int  NULL ,
	ETC3                 int  NULL ,
	ETC4                 int  NULL ,
	ECT5                 int  NULL ,
	REGIUSERID           varchar(20)  NULL ,
	REGIDATE             datetime  NULL ,
	MODIUSERID           varchar(20)  NULL ,
	MODIDATE             datetime  NULL ,
    PRIMARY KEY (APPLID)
);
