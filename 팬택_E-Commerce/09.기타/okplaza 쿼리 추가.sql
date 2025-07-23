/*
1)
As-Is Dev DB 백업 (OKPlaza, K-Link)	> 9시 시작 > 9시 10분 완료
To-Be Dev DB (1차 OKPlaza) Backup => 문제 시 복원을 위해	> 2시26분 시작 > 2시 29분 완료
To-Be Dev 1차 OKPlaza 검색엔진 테이블 Backup	> 

2) 
Backup Data To-Be Dev DB 서버로 이동 > 2시 20분 시작 > 3시 1분 완료

3)
연결된 모든 서비스(To-Be Dev) 종료
To-Be Dev DB (OKPlaza, K-Link) Restore > 3시 5분 시작 > 3시 10분 완료
*/

-- 팬타온 사업장 만들기 >> 기존 사업장 복사해서 만들것 PTO000001 / PTO000002 참조
-- 레벨2 borg
SELECT *
FROM SMPBORGS
WHERE BORGID = '304533';
-- 레벨3 borg
SELECT *
FROM SMPBORGS
WHERE BORGID = '305219';
-- branch
select * 
from SMPBRANCHS 
where BRANCHID = '308000';

INSERT INTO SMPBORGS (BORGID,BORGCD,BORGNM,TOPBORGID,PARBORGID,BORGLEVEL,BORGTYPECD,SVCTYPECD,GROUPID,CLIENTID,BRANCHID,DEPTID,REMOTEIP,CREATEDATE,CREATORID,UPDATEDATE,UPDATERID,ISUSE,ISKEY,ISLIMIT,CLOSEREASON,LOAN,ISPREPAY,ISLOAN,TRUSTGRADE,AGENT_ID,OTHERTRUSTGRADE,TRUST_DATE,TRUST_LIMIT_DATE,ISADJUSTDAY,[JOIN],DO_JOIN) VALUES (N'PTO000001',N'PTO',N'팬타온',N'304452',N'304452',N'2',N'CLT',N'BUY',N'304452',N'0',N'PTO000002',N'0',N'172.0.0.1',getdate(),N'2',NULL,NULL,N'1',NULL,N'0',NULL,0.00,N'0',NULL,N'ETC',N'13',N'ETC',NULL,NULL,N'30',N'',NULL);
INSERT INTO SMPBORGS (BORGID,BORGCD,BORGNM,TOPBORGID,PARBORGID,BORGLEVEL,BORGTYPECD,SVCTYPECD,GROUPID,CLIENTID,BRANCHID,DEPTID,REMOTEIP,CREATEDATE,CREATORID,UPDATEDATE,UPDATERID,ISUSE,ISKEY,ISLIMIT,CLOSEREASON,LOAN,ISPREPAY,ISLOAN,TRUSTGRADE,AGENT_ID,OTHERTRUSTGRADE,TRUST_DATE,TRUST_LIMIT_DATE,ISADJUSTDAY,[JOIN],DO_JOIN) VALUES (N'PTO000002',N'PTO0000001',N'팬타온_브런치',N'304452',N'PTO000001',N'3',N'BCH',N'BUY',N'304452',N'PTO000001',N'PTO000002',N'0',N'172.0.0.1',getdate(),N'2',getdate(),N'2',N'1',N'1',N'0',NULL,NULL,NULL,NULL,NULL,N'13',NULL,NULL,NULL,NULL,N'OKP',NULL);

INSERT INTO smpbranchs (BRANCHID,BRANCHNM,BRANCHCD,AREATYPE,BRANCHGRAD,BUSINESSNUM,REGISTNUM,BRANCHBUSITYPE,BRANCHBUSICLAS,PRESSENTNM,PHONENUM,E_MAIL,HOMEPAGE,POSTADDRNUM,ADDRES,ADDRESDESC,FAXNUM,LOGINAUTHTYPE,ORDERAUTHTYPE,REFERECEDESC,PAYBILLTYPE,PAYBILLDAY,PREPAY,ACCOUNTMANAGENM,ACCOUNTTELNUM,BANKCD,RECIPIENT,ACCOUNTNUM,BUSINESSATTACHFILESEQ,APPRAISALATTACHFILESEQ,ETCFIRSTSEQ,ETCSECONDSEQ,ETCTHIRDSEQ,AREA_MOD_DATE,WORKID,ACCMANAGEUSERID,ISORDERLIMIT,AUTORDERLIMITPERIOD,CONTRACTSPECIAL,SHARP_MAIL,EBILL_EMAIL,ISSTOCK,ISBUDGET,AGENT_ID,BUSINESS_TYPE,OPEN_DATE,WORKMANAGENM,WORKMANAGETELNUM,WORKMANAGEEMAIL,BRANCH_LEVEL,PAR_BRANCHID,ACCOUNTMANAGERPOSITION,BRANCH_RECCOTAXREGNO,POINT_COMP_YN,SAFE_BRANCH_YN,OTHER_DIRECT_YN) VALUES (N'PTO000002',N'팬타온_브런치',N'PTO0000001',N'80',N'1',N'3FF08641DC385A66846F8138E9199FC0',N'72EA66E75C9AE009DABD08935979BEE5',N'통신자재 및 통신기기',N'도소매',N'신광식',N'',N'6C979109A29E8E6BC80D029B707CDEF4',N'',N'1487B832E61320D28BF5EC00E40949F5',N'16F9DDC14E6FF5C1073B1D5AFC7CBAF5ACB8D0518E5CA803D177B18701919C8DAC591D9D8D719DA46C2222B3A5D35A0B38A8FCC920AA3D60661EDC083FD0CED15C2392F997100244A15D03306BB4D5FA',N'C6B85E5DEE2067D40AD93A2DACFBCC3C',N'',N'20',N'20',N'펜타온 법인 등록',N'1060',N'',N'0',N'테스트',N'8494EC7BC92E76DA5D1ABB7EC041A590',NULL,NULL,N'',N'38664',N'',NULL,N'',N'','1900-01-01',1,N'rokmc',0,30,N'40',N'72EA66E75C9AE009DABD08935979BEE5',N'',1,0,N'13',NULL,NULL,NULL,NULL,NULL,0,N'0',NULL,NULL,N'N',N'N',N'N');

--select * from SMPBORGS where borgid in ('PTO000001', 'PTO000002') 
--select * from SMPBORGS where  [JOIN] = '' and BORGTYPECD != 'CLT';;
-- smpborgs - join > HNS 컬럼 마이그레이션
UPDATE S
SET [JOIN] = 'HNS'
from SMPBORGS s
inner join SMPBRANCHS s2 
	on s.BORGID = s2.BRANCHID 
where S.PARBORGID = '305952';

-- smpborgs - join > SAF 컬럼 마이그레이션
UPDATE S
SET [JOIN] = 'SAF'
from SMPBORGS s
inner join SMPBRANCHS s2 
	on s.BORGID = s2.BRANCHID 	
WHERE s2.WORKID = '63'
and BORGTYPECD = 'BCH'


-- 안전몰 / 홈앤서비스 외 업체는 일반업체로 마이그레이션
UPDATE SMPBORGS 
SET  [JOIN] = 'OKP'
WHERE ISNULL([JOIN], '') = ''
AND		BORGTYPECD = 'BCH';


-- SMPBORGS > [JOIN] 컬럼에 쓰는 코드 추가해야함 > 밑에 코드 마이그레이션문 있음
/*SELECT * FROM SMPCODES s WHERE s.CODETYPECD = 'BUY_SVC';
SELECT * FROM SMPCODETYPES s WHERE s.CODETYPECD = 'BUY_SVC';*/

-- 권한 관련 코드 수정
UPDATE SMPROLES
SET BORGSCOPECD = (
	CASE
		WHEN ROLECD LIKE 'SAF%' THEN 'SAF'
		WHEN ROLECD LIKE '%HNS%' THEN 'HNS'
		ELSE 'BUY'
	END
)
WHERE SVCTYPECD = 'BUY';

-- 사용자_조직_역할 의 조직허용범위코드(BORGSCOPECD) 수정
update a
set BORGSCOPECD = (CASE
		WHEN ROLECD LIKE 'SAF%' THEN 'SAF'
		WHEN ROLECD LIKE '%HNS%' THEN 'HNS'
		ELSE 'BUY'
	END)
from smpborgs_users_roles a
inner join smproles b
	on a.roleid = b.roleid
where b.SVCTYPECD = 'BUY';

/*select *
from smpborgs_users_roles a
inner join smproles b
	on a.roleid = b.roleid
where b.SVCTYPECD = 'BUY'
and borgid = '305695';
rollback*/

-- 사업유형 마이그레이션
UPDATE   A
SET      A.BUSINESS_TYPE = (CASE WHEN B.SVCTYPECD = 'CEN' THEN 'C'
                     ELSE
                        CASE WHEN A.REGISTNUM IS NOT NULL THEN 'C'
                        ELSE 'G' END
                  END)
FROM    smpvendors A 
INNER JOIN SMPBORGS B
   ON   B.BORGID = A.VENDORID
where    (A.BUSINESS_TYPE  is null or A.BUSINESS_TYPE ='') 
AND      B.ISUSE = '1';


-- 조직배송지 - 배송지주소 복호화 처리  > 어드민에서 돌릴것
-- /common/decriptAddress.sys


------------------------------------------------------------------------------------------------

-- 안전몰 권한 마이그레이션

-- 권한
SELECT * FROM SMPROLES s WHERE SVCTYPECD = 'SAF';  -- 테스트 포함 6
SELECT * FROM SMPROLES s WHERE ROLECD LIKE 'SAF%'; -- 5
-- 영역
SELECT * FROM SMPSCOPES s WHERE SVCTYPECD = 'SAF';
SELECT * FROM SMPSCOPES s WHERE SCOPECD LIKE  'SAF%';
-- 메뉴
SELECT * FROM SMPMENUS s WHERE SVCTYPECD = 'SAF'; -- 31
SELECT * FROM SMPMENUS s WHERE MENUCD LIKE 'SAF%' OR MENUCD = 'SKB_ADM_MNGT_USE'; -- 31
SELECT * FROM SMPMENUS s WHERE MENUCD LIKE '%SAF%' AND SVCTYPECD != 'SAF'; -- 2

update SMPROLES
set SVCTYPECD = 'BUY'
WHERE SVCTYPECD = 'SAF';

update SMPSCOPES 
set SVCTYPECD = 'BUY'
WHERE SVCTYPECD = 'SAF';

update SMPMENUS 
set SVCTYPECD = 'BUY'
--,	DISORDER = DISORDER + 4000  
WHERE SVCTYPECD = 'SAF';

-- 기존 메뉴 안쓰게 처리함
update SMPMENUS 
set DISORDER = DISORDER + 3000
WHERE SVCTYPECD = 'BUY';

update SMPMENUS 
set ISUSE = 0
WHERE SVCTYPECD = 'BUY'
and DISORDER > 3000;

-- 기존 권한 명칭 및 영역 세팅 조절해야함 !!!!

----------------------------

-- 복원쿼리 ( 기존 buy 코드에서도 saf 가 들어가거나, saf 메뉴인데 메뉴코드에 saf 가 없는게 있음)
/*
update SMPROLES
set SVCTYPECD = 'SAF'
WHERE ROLECD LIKE 'SAF%';

update SMPSCOPES 
set SVCTYPECD = 'SAF'
WHERE SCOPECD LIKE  'SAF%';

update SMPMENUS 
set SVCTYPECD = 'SAF'
WHERE MENUCD LIKE 'SAF%' OR MENUCD = 'SKB_ADM_MNGT_USE';*/

----------------------------------------------------------------------------------
-- 지점장을 제외한 사용자들 감독관 테이블로 인서트
INSERT INTO SMPDIRECTINFO (BRANCHID, USERID, DIRECTORID) 
select	A.BORGID AS BRANCHID
,		A.USERID
,		B.USERID AS DIRECTORID
from smpborgs_users A
inner join (
	SELECT AA.BORGID, AA.USERID
	from smpborgs_users_roles AA
	INNER JOIN SMPUSERS BB
			ON AA.USERID = BB.USERID
			AND BB.ISUSE = 1
	INNER JOIN SMPBORGS_USERS CC
		ON AA.BORGID = CC.BORGID
		AND AA.USERID = CC.USERID
		AND CC.USE_YN = 'Y'
	where AA.roleid = '15357' -- 지점장권한 보유자
	AND ISNULL(AA.BORGID, '') != '' 
	AND ISNULL(AA.USERID, '') != ''
) B
	on A.BORGID = B.borgid
	AND A.USERID != B.userid
INNER JOIN SMPUSERS C
		ON A.USERID = C.USERID
		AND C.ISUSE = 1
WHERE A.USE_YN = 'Y';

-- 지점장 권한 사용자 일반권한으로 인서트
insert into smpborgs_users_roles
select	'15358' as roleid
,		AA.BORGID
,		AA.USERID
,		AA.ISDEFAULT
,		AA.BORGSCOPECD
,		AA.AGENT_ID
from	smpborgs_users_roles AA
INNER JOIN SMPUSERS BB
	ON AA.USERID = BB.USERID
	AND BB.ISUSE = 1
INNER JOIN SMPBORGS_USERS CC
	ON AA.BORGID = CC.BORGID
	AND AA.USERID = CC.USERID
	AND CC.USE_YN = 'Y'
WHERE	AA.ROLEID = '15357'
AND 	ISNULL(AA.BORGID, '') != '' 
AND 	ISNULL(AA.USERID, '') != '';

------------------------------------------------------------------------------

-- SMPBRANCH 주문인증 ORDERAUTHTYPE 은 다 일반(20)으로 마이그레이션 및 DISABLED 처리
--SELECT COUNT(1) FROM SMPBRANCHS WHERE ORDERAUTHTYPE != '20'
UPDATE SMPBRANCHS SET ORDERAUTHTYPE = '20' WHERE ORDERAUTHTYPE != '20'

------------------------------------------------------------------------------
--select * from attachinfo order by attachInfo.insert_date desc
-- 첨부파일 s3 루트로 업데이트 
--begin tran
UPDATE attachinfo
SET attach_file_path = 
	CASE 
		WHEN CHARINDEX('upload/file/attach/', REPLACE(attach_file_path, '\', '/')) > 0 THEN
			SUBSTRING(REPLACE(attach_file_path, '\', '/'), 
				CHARINDEX('upload/file/attach/', REPLACE(attach_file_path, '\', '/')), 
				LEN(attach_file_path)
			)
		WHEN CHARINDEX('upload/image/image', REPLACE(attach_file_path, '\', '/')) > 0 THEN
			SUBSTRING(REPLACE(attach_file_path, '\', '/'), 
				CHARINDEX('upload/image/image', REPLACE(attach_file_path, '\', '/')), 
				LEN(attach_file_path)
			)
		ELSE attach_file_path
	END;
--commit;

------------------------------------------------------------------------------

-- MCGOOD 테이블에 컬럼 추가
ALTER TABLE MCGOOD ADD GOOD_TEXT_DESC VARCHAR(1); -- 특이사항
ALTER TABLE MCGOOD ADD MATERIAL_YN VARCHAR(1); -- 품종 여부
ALTER TABLE MCGOOD ADD COMP_YN VARCHAR(1); -- 컴포넌트 상품 여부
ALTER TABLE MCGOOD ADD SUB1_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지1 메인
ALTER TABLE MCGOOD ADD SUB2_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지2 메인
ALTER TABLE MCGOOD ADD SUB3_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지3 메인
ALTER TABLE MCGOOD ADD SUB4_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지4 메인

-- 컬럼 설명 추가
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품종 여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'MATERIAL_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'컴포넌트 상품 여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'COMP_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지1 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'SUB1_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지2 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'SUB2_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지3 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'SUB3_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지4 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mcgood', @level2type = N'COLUMN', @level2name = 'SUB4_MAIN_IMG_PATH';

CREATE NONCLUSTERED INDEX IX_MCGOOD_MATERIAL ON MCGOOD(material); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MCGOOD_MATERIAL_SUB ON MCGOOD(MATERIAL_SUB); -- 인덱스추가


-- MCGOOD_HIST 
ALTER TABLE MCGOOD_HIST ADD MATERIAL_YN VARCHAR(1); -- 품종 여부
ALTER TABLE MCGOOD_HIST ADD COMP_YN VARCHAR(1); -- 컴포넌트 상품 여부
ALTER TABLE MCGOOD_HIST ADD SUB1_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지1 메인
ALTER TABLE MCGOOD_HIST ADD SUB2_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지2 메인
ALTER TABLE MCGOOD_HIST ADD SUB3_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지3 메인
ALTER TABLE MCGOOD_HIST ADD SUB4_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지4 메인
------------------------------------------------------------------------------

-- MCGOODVENDOR 테이블에 컬럼 추가
ALTER TABLE MCGOODVENDOR ADD SUB1_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지1 메인
ALTER TABLE MCGOODVENDOR ADD SUB2_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지2 메인
ALTER TABLE MCGOODVENDOR ADD SUB3_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지3 메인
ALTER TABLE MCGOODVENDOR ADD SUB4_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지4 메인
ALTER TABLE MCGOODVENDOR ADD PANTA_DISP_YN VARCHAR(1) DEFAULT 'N'; -- 팬타온 진열여부
--ALTER TABLE MCGOODVENDOR ADD GOOD_DESC_YN VARCHAR(1) NOT NULL DEFAULT 'N';	-- 상품상세설명

-- 디폴트값 업데이트
UPDATE MCGOODVENDOR SET PANTA_DISP_YN = 'N' WHERE  PANTA_DISP_YN IS NULL
--UPDATE MCGOODVENDOR SET GOOD_DESC_YN = 'N' WHERE  GOOD_DESC_YN IS NULL

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'팬타온 진열여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'PANTA_DISP_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지1 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'SUB1_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지2 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'SUB2_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지3 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'SUB3_MAIN_IMG_PATH';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'서브이미지4 메인', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'SUB4_MAIN_IMG_PATH';
--EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품상세설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR', @level2type = N'COLUMN', @level2name = 'GOOD_DESC_YN';

-- select * from MCGOODVENDOR where LEN(good_desc) > 20;
-- 설명 길이 기준으로 YN 처리
/*update MCGOODVENDOR 
set GOOD_DESC_YN = case when LEN(good_desc) > 20 then 'Y' else 'N' END
where good_desc IS NOT NULL;*/

-- MCGOODVENDOR_HIST 테이블에 컬럼 추가
ALTER TABLE MCGOODVENDOR_HIST ADD SUB1_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지1 메인
ALTER TABLE MCGOODVENDOR_HIST ADD SUB2_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지2 메인
ALTER TABLE MCGOODVENDOR_HIST ADD SUB3_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지3 메인
ALTER TABLE MCGOODVENDOR_HIST ADD SUB4_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지4 메인
ALTER TABLE MCGOODVENDOR_HIST ADD PANTA_DISP_YN VARCHAR(1); -- 팬타온 진열여부
--ALTER TABLE MCGOODVENDOR_HIST ADD GOOD_DESC_YN VARCHAR(1) NOT NULL DEFAULT 'N'; -- 상품상세설명

--UPDATE MCGOODVENDOR_HIST SET GOOD_DESC_YN = 'N' WHERE  GOOD_DESC_YN IS NULL;

-- mcgoodrequest 테이블에 컬럼 추가
ALTER TABLE mcgoodrequest ADD SUB1_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지1 메인
ALTER TABLE mcgoodrequest ADD SUB2_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지2 메인
ALTER TABLE mcgoodrequest ADD SUB3_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지3 메인
ALTER TABLE mcgoodrequest ADD SUB4_MAIN_IMG_PATH VARCHAR(500); -- 서브이미지4 메인
ALTER TABLE mcgoodrequest ADD PANTA_DISP_YN VARCHAR(1); -- 팬타온 진열여부
--ALTER TABLE mcgoodrequest ADD GOOD_DESC_YN VARCHAR(1) NOT NULL DEFAULT 'N'; -- 상품상세설명

--UPDATE mcgoodrequest SET GOOD_DESC_YN = 'N' WHERE  GOOD_DESC_YN IS NULL;

------------------------------------------------------------------------------
CREATE TABLE MCGOODVENDOR_PANTA (
	GOOD_IDEN_NUMB BIGINT NOT NULL,	-- 상품코드
	VENDORID VARCHAR(10) NOT NULL,	-- 공급사ID
	SALE_YN VARCHAR(1) NOT NULL DEFAULT 'N', -- 할인여부
	SELL_PRICE DECIMAL(15,2) NOT NULL, -- 판매가
	ORI_SELL_PRICE DECIMAL(15,2) DEFAULT 0, -- 원판매가
	REPRE_GOOD_IDEN_NUMB BIGINT,		  -- 대표상품코드
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME                  -- 수정일시
	PRIMARY KEY (GOOD_IDEN_NUMB, VENDORID)
);

-- 컬럼 설명 추가
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'할인여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'SALE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'판매가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'SELL_PRICE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'원판매가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'ORI_SELL_PRICE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'대표상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA', @level2type = N'COLUMN', @level2name = 'REPRE_GOOD_IDEN_NUMB';

----------------------------------------------------------------------------------
CREATE TABLE MCGOODVENDOR_PANTA_HIST (
	GOOD_IDEN_NUMB BIGINT NOT NULL,	-- 상품코드
	VENDORID VARCHAR(10) NOT NULL,	-- 공급사ID
	SALE_YN VARCHAR(1) NOT NULL DEFAULT 'N', -- 할인여부
	SELL_PRICE DECIMAL(15,2) NOT NULL, -- 판매가
	ORI_SELL_PRICE DECIMAL(15,2) DEFAULT 0, -- 원판매가
	REPRE_GOOD_IDEN_NUMB BIGINT,		  -- 대표상품코드
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME                  -- 수정일시
);

-- 컬럼 설명 추가
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'판매가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'SELL_PRICE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'할인여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'SALE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'원판매가', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'ORI_SELL_PRICE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'대표상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_HIST', @level2type = N'COLUMN', @level2name = 'REPRE_GOOD_IDEN_NUMB';
----------------------------------------------------------------------------------

CREATE TABLE MCGOODVENDOR_PANTA_NOTI (
	GOOD_IDEN_NUMB BIGINT NOT NULL,	-- 상품코드
	VENDORID VARCHAR(10) NOT NULL,	-- 공급사ID
	PACKAGE_YN VARCHAR(1) NOT NULL DEFAULT 'N', -- 묶음배송여부
	GOOD_NOTI_YN VARCHAR(1) NOT NULL DEFAULT 'N',
	GOOD_NM VARCHAR(200),
	GOOD_LAW VARCHAR(200),
	GOOD_COUNTRY VARCHAR(100),
	GOOD_MAN VARCHAR(50),
	GOOD_AS_TELNUM VARCHAR(50),
	META_TAG VARCHAR(400),
	ALT_IMG_TEXT VARCHAR(100),
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME                  -- 수정일시
	PRIMARY KEY (GOOD_IDEN_NUMB, VENDORID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품고시정보체크여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'PACKAGE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'품명 및 모델명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_NOTI_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'법에의한사항', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제조국또는원산지', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_LAW';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제조자', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_COUNTRY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'as책임자 전화번호', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'GOOD_MAN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'메타태그', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'META_TAG';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품이미지alt텍스트', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOODVENDOR_PANTA_NOTI', @level2type = N'COLUMN', @level2name = 'ALT_IMG_TEXT';

---------------------------------------------------------------------------------

ALTER TABLE SMPWORKINFO ADD CUST_CATE_MAST_CD VARCHAR(3);
ALTER TABLE SMPWORKINFO ADD SITE_ID INT DEFAULT '1';
ALTER TABLE SMPWORKINFO ADD INSERT_USER_ID VARCHAR(20);
ALTER TABLE SMPWORKINFO ADD INSERT_DATE DATETIME;
ALTER TABLE SMPWORKINFO ADD UPDATE_USER_ID VARCHAR(20);
ALTER TABLE SMPWORKINFO ADD UPDATE_DATE DATETIME;

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'구매사 카테고리 마스터 CD', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPWORKINFO', @level2type = N'COLUMN', @level2name = 'CUST_CATE_MAST_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPWORKINFO', @level2type = N'COLUMN', @level2name = 'SITE_ID';

-- 기존 데이터에서 SITE_ID가 NULL인 경우 1으로 업데이트
UPDATE SMPWORKINFO SET SITE_ID = 1 WHERE SITE_ID IS NULL;
--UPDATE SMPWORKINFO SET SITE_ID = 1 WHERE WORKNM LIKE '%HNS%';  
-- SITE_ID 디폴트 1(OKPLAZA 기본)

CREATE NONCLUSTERED INDEX IDX_SMPWORKINFO_SITE_ID ON SMPWORKINFO (SITE_ID);
CREATE NONCLUSTERED INDEX IX_SMPWORKINFO_CUST_CATE_MAST_CD ON SMPWORKINFO(CUST_CATE_MAST_CD);	-- 인텍스추가
CREATE NONCLUSTERED INDEX IX_SMPWORKINFO_SITE_ID ON SMPWORKINFO(SITE_ID);	-- 인텍스추가

---------------------------------------------------------------------------------------------

-- 팬타온 공사유형 추가
select * from SMPWORKINFO s ; 
select * from SMPUSERS s where usernm = '정연백' and loginid = 'j723';
select * from SMPUSERS s where usernm = '윤찬혁' and loginid = 'micheal0312';
-- 1	302637	팬타온	1	70	10	01	13	1	57	PTO	0				
INSERT INTO SMPWORKINFO (WORKID, USERID, WORKNM, IS_SKTS_MANAGE, MAT_KIND, CONTRACT_CD, WORK_KIND, AGENT_ID, ISUSE, WORK_ORDER, CUST_CATE_MAST_CD, SITE_ID) 
VALUES (1, '300217', '팬타온', 1, 70, 10, '01', 13, 1, 57, 'PTO', '0');


-------------------------------------------------------------------------------

ALTER TABLE MRORDT ADD MATERIAL VARCHAR(20);
ALTER TABLE MRORDT ADD MATERIAL_DETL_CD VARCHAR(20);
ALTER TABLE MRORDT ADD PTO_CANCEL_QUAN int;

CREATE NONCLUSTERED INDEX IX_MRORDT_MATERIAL ON MRORDT(MATERIAL);
CREATE NONCLUSTERED INDEX IX_MRORDT_MATERIAL_DETL_CD ON MRORDT(MATERIAL_DETL_CD);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRORDT', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRORDT', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'팬타온 취소수량', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRORDT', @level2type = N'COLUMN', @level2name = 'PTO_CANCEL_QUAN';
----------------------------------------------------------------------------------

ALTER TABLE MRORDTLIST ADD MATERIAL VARCHAR(20);
ALTER TABLE MRORDTLIST ADD MATERIAL_DETL_CD VARCHAR(20);

CREATE NONCLUSTERED INDEX IX_MRORDTLIST_MATERIAL ON MRORDTLIST(MATERIAL); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRORDTLIST_MATERIAL_DETL_CD ON MRORDTLIST(MATERIAL_DETL_CD); -- 인덱스추가

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRORDTLIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRORDTLIST', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_CD';
---------------------------------------------------------------------------------------------

ALTER TABLE SMPUSERS ADD EMPLOY_YN VARCHAR(1) DEFAULT 'N';
ALTER TABLE SMPUSERS ADD EMPLOY_EMAIL VARCHAR(50);
ALTER TABLE SMPUSERS ADD EMPLOY_CERT_CODE VARCHAR(6);
ALTER TABLE SMPUSERS ADD EMPLOY_CERT_TIME DATETIME;

update SMPUSERS set EMPLOY_YN = 'N' WHERE EMPLOY_YN IS NULL;	-- 임직원 이메일 인증여부 마이그레이션

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'임직원여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPUSERS', @level2type = N'COLUMN', @level2name = 'EMPLOY_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'임직원이메일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPUSERS', @level2type = N'COLUMN', @level2name = 'EMPLOY_EMAIL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'임직원이메일 인증코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPUSERS', @level2type = N'COLUMN', @level2name = 'EMPLOY_CERT_CODE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'임직원이메일 발송시간', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPUSERS', @level2type = N'COLUMN', @level2name = 'EMPLOY_CERT_TIME';

----------------------------------------------------------------------------------

--SELECT * FROM SMP_SEQUENCE ss WHERE TABLE_NAME LIKE '%SITE%'
INSERT INTO SMP_SEQUENCE ( TABLE_NAME,   NEXT_ID ) VALUES ('SEQMP_SITEID', 1);
INSERT INTO SMP_SEQUENCE ( TABLE_NAME,   NEXT_ID ) VALUES ('SEQ_MRCOMP_INFO',   1);
INSERT INTO SMP_SEQUENCE ( TABLE_NAME,   NEXT_ID ) VALUES ('SEQ_ORDE_NUMB',   1);	--	주문번호 SEQ

--------------------------------------------------------------------------

CREATE TABLE SMP_SITE (
    SITE_ID INT PRIMARY KEY,              -- 사이트ID
    SITE_NM VARCHAR(100),                 -- 사이트명
    SITE_DESC VARCHAR(500),               -- 사이트설명
    CSS VARCHAR(20),                      -- CSS
    LOGO_ID VARCHAR(100),                 -- 로고이미지ID
    RECOMM_GOODS_YN VARCHAR(1) default 'Y',           -- 추천상품사용여부
    SALE_RATE INT default 0,           -- 기준할인율
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME                  -- 수정일시
);

-- 기본값 설명 밑에서 css 코드 인서트하고 그걸로 처리
/*INSERT INTO SMP_SITE (SITE_ID, SITE_NM, SITE_DESC, CSS, LOGO_ID, RECOMM_GOODS_YN, SALE_RATE, INSERT_USER_ID, INSERT_DATE, UPDATE_USER_ID, UPDATE_DATE) VALUES ( '0', '팬타온', '팬타온 기본 설정입니다.', 0, 0,'Y', 0, '2', GETDATE(), '2', GETDATE() );
INSERT INTO SMP_SITE VALUES ( '1', 'OK플라자(기본)', 'OK플라자 고객사 기본 설정입니다.', 0, 0, 'Y', 0, '2', GETDATE(), '2', GETDATE() ); */

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
    RECOMM_GOODS_YN VARCHAR(1) default 'Y',           -- 추천상품사용여부
    SALE_RATE INT default 0,           -- 기준할인율
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    APPLY_YN VARCHAR(1)					-- 반영여부
);

INSERT INTO SMP_SITE_TEMP VALUES ( '0', '팬타온', '팬타온을 대상으로 합니다.', 0, 0,'Y', 0, '2', GETDATE(), '2', GETDATE(), 'Y' );
INSERT INTO SMP_SITE_TEMP VALUES ( '1', 'OK플라자(기본)', 'OK플라자 일반구매사를 대상으로 합니다.', 0, 0, 'Y', 0 , '2', GETDATE(), '2', GETDATE(), 'Y' ); 

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트설명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'CSS', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'CSS';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'로고이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'LOGO_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'반영여부', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_TEMP', @level2type = N'COLUMN', @level2name = 'APPLY_YN';

--------------------------------------------------------------------
CREATE TABLE SMP_SITE_BANNER (
    SITE_ID INT,				-- 사이트ID
    BANNER_NM VARCHAR(100),		-- 배너명
    BANNER_FLAG VARCHAR(1) DEFAULT 0, -- 배너 FLAG
    SEARCH_WORD VARCHAR(100),	-- 배너링크값
    DISORDER INT,				-- 순서
    BANNER_ID VARCHAR(10),		-- 배너이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (SITE_ID, BANNER_NM, BANNER_FLAG)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'BANNER_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너FLAG', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'BANNER_FLAG';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너링크값', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'SEARCH_WORD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'DISORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'BANNER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

------------------------------------------------------------------------------------

CREATE TABLE SMP_SITE_BANNER_TEMP (
    SITE_ID INT,				-- 사이트ID
    BANNER_NM VARCHAR(100),		-- 배너명
    BANNER_FLAG VARCHAR(1) DEFAULT 0, -- 배너 FLAG
    SEARCH_WORD VARCHAR(100),	-- 배너링크값
    DISORDER INT,				-- 순서
    BANNER_ID VARCHAR(10),		-- 배너이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (SITE_ID, BANNER_NM, BANNER_FLAG)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사이트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'SITE_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'BANNER_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너FLAG', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'BANNER_FLAG';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너링크값', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'SEARCH_WORD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'DISORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'BANNER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_SITE_BANNER_TEMP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

------------------------------------------------------------------------------------

CREATE TABLE SMP_RECOMM_GOODS (
    WORKID INT NOT NULL,				-- 공사유형ID
    GOOD_IDEN_NUMB BIGINT NOT NULL,		-- 상품코드
    VENDORID VARCHAR(20) NOT NULL DEFAULT '0',
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (WORKID, GOOD_IDEN_NUMB, VENDORID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공사유형ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS', @level2type = N'COLUMN', @level2name = 'WORKID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS', @level2type = N'COLUMN', @level2name = 'VENDORID';

-----------------------------------------------------------------------------------------
CREATE TABLE SMP_RECOMM_GOODS_TEMP (
    WORKID INT NOT NULL,				-- 공사유형ID
    GOOD_IDEN_NUMB BIGINT NOT NULL,		-- 상품코드
    VENDORID VARCHAR(20) NOT NULL DEFAULT '0',
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    PRIMARY KEY (WORKID, GOOD_IDEN_NUMB, VENDORID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공사유형ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS_TEMP', @level2type = N'COLUMN', @level2name = 'WORKID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS_TEMP', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_RECOMM_GOODS_TEMP', @level2type = N'COLUMN', @level2name = 'VENDORID';

-----------------------------------------------------------------------------------------
/*
CREATE TABLE MCGOOD_PUP_BAT (
    WORKID INT NOT NULL,				-- 공사유형ID
    GOOD_IDEN_NUMB BIGINT NOT NULL,		-- 상품코드
    RANKING INT NULL,           -- 등록자ID
    INSERT_DATE DATETIME ,                 -- 등록일시
    PRIMARY KEY (WORKID, GOOD_IDEN_NUMB)
) 미사용테이블
*/

-----------------------------------------------------------------------------------------

INSERT INTO SMP_SEQUENCE VALUES ('SEQMP_DISPID', 1);

CREATE TABLE SMP_PLAN_DISP (
	DISP_ID INT NOT NULL,				-- 기획전ID
	DISP_NM VARCHAR(200),				-- 기획전명
	DISP_START_YMD VARCHAR(10),			-- 전시시작일
	DISP_END_YMD VARCHAR(10),			-- 전시종료일
	BANNER_ID VARCHAR(10),				-- 배너이미지ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                 -- 수정일시
	PRIMARY KEY (DISP_ID)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기획전ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'DISP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기획전명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'DISP_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'전시시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'DISP_START_YMD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'전시종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'DISP_END_YMD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배너이미지ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'BANNER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


-----------------------------------------------------------------------------------------

CREATE TABLE SMP_PLAN_DISP_PROD (
	DISP_ID INT NOT NULL,				-- 기획전ID
    GOOD_IDEN_NUMB BIGINT NOT NULL,		-- 상품코드
    VENDORID VARCHAR(10) NOT NULL,		-- 공급사ID
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
	PRIMARY KEY (DISP_ID, GOOD_IDEN_NUMB, VENDORID)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'기획전ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP_PROD', @level2type = N'COLUMN', @level2name = 'DISP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP_PROD', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP_PROD', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP_PROD', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMP_PLAN_DISP_PROD', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

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
,		A.CODENM3 AS MATERIAL_NM
,		A.CODENM1 AS MATERIAL_DESC 
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
	NOTE VARCHAR(500),					-- 비고
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL, VENDORID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'적격공급상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'SUIT_STATS_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'선정', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'SUIT_SEL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배분율', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'DISTRL_RATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'EXCEPT_START_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'EXCEPT_END_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'비고', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'NOTE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

-- 자동물량배분 테이블 기준으로 마이그레이션
INSERT INTO MCGOOD_MATERIAL_VENDOR (
	MATERIAL, VENDORID, SUIT_STATS_CD, SUIT_SEL_CD, DISTRL_RATE, EXCEPT_START_DATE, EXCEPT_END_DATE, NOTE, INSERT_USER_ID, INSERT_DATE
)
select 
	A.MATERIAL
,	A.VENDORID
,	'USE' AS SUIT_STATS_CD
,	'SUPP' AS SUIT_SEL_CD
,	A.ratio AS DISTRL_RATE
,	NULL AS EXCEPT_START_DATE
,	NULL AS EXCEPT_END_DATE
,	'' AS NOTE
,	'2' AS INSERT_USER_ID
,	GETDATE() AS INSERT_DATE
from (
	SELECT MATERIAL, VENDORID, MAX(ratio) AS ratio, MIN(ord_num) AS ord_num
	FROM (
		SELECT MATERIAL, BP1 AS VENDORID, ratio1 as ratio, cast(1 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP1, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP2 AS VENDORID, ratio2 as ratio, cast(2 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP2, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP3 AS VENDORID, ratio3 as ratio, cast(3 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP3, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP4 AS VENDORID, ratio4 as ratio, cast(4 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP4, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP5 AS VENDORID, ratio5 as ratio, cast(5 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP5, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP6 AS VENDORID, ratio6 as ratio, cast(6 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP6, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP7 AS VENDORID, ratio7 as ratio, cast(7 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP7, '') != '' and sta_dt is not null
	) AA
	GROUP BY MATERIAL, VENDORID
) A
ORDER BY A.MATERIAL, A.VENDORID;
----------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_VENDOR_HIST (
	MATERIAL VARCHAR(20) NOT NULL,		-- 지정품종코드
	VENDORID VARCHAR(10) NOT NULL,		-- 공급사ID
	HIST_DATE DATETIME NOT NULL,        -- 이력등록일시
	SUIT_STATS_CD VARCHAR(20) NOT NULL,	-- 적격공급상태
	SUIT_SEL_CD VARCHAR(20),			-- 선정
	DISTRL_RATE INT NOT NULL,			-- 배분율
	EXCEPT_START_DATE DATETIME,			-- 제외시작일
	EXCEPT_END_DATE DATETIME,			-- 제외종료일
	NOTE VARCHAR(500),					-- 비고
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL, VENDORID, HIST_DATE)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'이력등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'HIST_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'적격공급상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'SUIT_STATS_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'선정', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'SUIT_SEL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배분율', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'DISTRL_RATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'EXCEPT_START_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'EXCEPT_END_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'비고', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'NOTE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_HIST', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';


-- 자동물량배분 테이블 기준으로 마이그레이션
INSERT INTO MCGOOD_MATERIAL_VENDOR_HIST (
	MATERIAL, VENDORID, HIST_DATE, SUIT_STATS_CD, SUIT_SEL_CD, DISTRL_RATE, EXCEPT_START_DATE, EXCEPT_END_DATE, NOTE, INSERT_USER_ID, INSERT_DATE
)
select 
	A.MATERIAL
,	A.VENDORID
,	GETDATE() AS HIST_DATE
,	'USE' AS SUIT_STATS_CD
,	'SUPP' AS SUIT_SEL_CD
,	A.ratio AS DISTRL_RATE
,	NULL AS EXCEPT_START_DATE
,	NULL AS EXCEPT_END_DATE
,	'' AS NOTE
,	'2' AS INSERT_USER_ID
,	GETDATE() AS INSERT_DATE
from (
	SELECT MATERIAL, VENDORID, MAX(ratio) AS ratio, MIN(ord_num) AS ord_num
	FROM (
		SELECT MATERIAL, BP1 AS VENDORID, ratio1 as ratio, cast(1 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP1, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP2 AS VENDORID, ratio2 as ratio, cast(2 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP2, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP3 AS VENDORID, ratio3 as ratio, cast(3 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP3, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP4 AS VENDORID, ratio4 as ratio, cast(4 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP4, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP5 AS VENDORID, ratio5 as ratio, cast(5 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP5, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP6 AS VENDORID, ratio6 as ratio, cast(6 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP6, '') != '' and sta_dt is not null UNION ALL
		SELECT MATERIAL, BP7 AS VENDORID, ratio7 as ratio, cast(7 as int) as ord_num FROM MCAUTO_RATE_INFO WHERE isnull(BP7, '') != '' and sta_dt is not null
	) AA
	GROUP BY MATERIAL, VENDORID
) A
ORDER BY A.MATERIAL, A.VENDORID;
----------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_DETL (
    MATERIAL_DETL_CD varchar(20) NOT NULL,	-- 세부품종코드
    MATERIAL varchar(20) NOT NULL,			-- 지정품종코드
    MATERIAL_DETL_NM varchar(50) NOT NULL,	-- 세부품종명
    MATERIAL_DETL_DESC varchar(100) NULL,	-- 세부품종내역
    USE_YN varchar(1) DEFAULT 'Y' NOT NULL,	-- 사용YN
	DISP_ORDER INT,							-- 조회순서
    INSERT_USER_ID varchar(20) NOT NULL,	-- 등록자ID
    INSERT_DATE datetime NOT NULL,			-- 등록일시
    UPDATE_USER_ID varchar(20) NULL,		-- 수정자ID
    UPDATE_DATE datetime NULL,				-- 수정일시
    PRIMARY KEY (MATERIAL_DETL_CD)
);

CREATE NONCLUSTERED INDEX IX_MCGOOD_MATERIAL_DETL_MATERIAL ON MCGOOD_MATERIAL_DETL(MATERIAL); -- 인덱스추가

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종명', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_NM';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'세부품종내역', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'MATERIAL_DETL_DESC';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'사용YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'USE_YN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'조회순서', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'DISP_ORDER';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'수정일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DETL', @level2type = N'COLUMN', @level2name = 'UPDATE_DATE';

-- 마이그레이션
INSERT INTO MCGOOD_MATERIAL_DETL (
	MATERIAL_DETL_CD
,	MATERIAL
,	MATERIAL_DETL_NM
,	MATERIAL_DETL_DESC
,	USE_YN
,	DISP_ORDER
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT	A.CODEVAL1 AS MATERIAL_DETL_CD
,		A.CODENM3 AS MATERIAL
,		A.CODENM2 AS MATERIAL_DETL_NM
,		A.CODENM1 AS MATERIAL_DETL_DESC
,		CASE WHEN A.ISUSE = 1 THEN 'Y' ELSE 'N' END AS USE_YN
,		A.DISORDER AS DISP_ORDER
,		'2' AS INSERT_USER_ID
,		GETDATE() AS INSERT_DATE
,		'2' AS UPDATE_USER_ID
,		GETDATE() AS UPDATE_DATE
FROM SMPCODES A
WHERE A.CODETYPECD = 'SMPMATERIAL_SUB'

UPDATE MCGOOD_MATERIAL_DETL 
SET DISP_ORDER = B.DISORDER 
FROM MCGOOD_MATERIAL_DETL A, SMPCODES B
WHERE A.MATERIAL_DETL_CD = B.CODEVAL1 
AND B.CODETYPECD = 'SMPMATERIAL_SUB'

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
    GOOD_IDEN_NUMB bigint NOT NULL,		--상품코드
    VENDORID varchar(10) NOT NULL,		--공급사ID
    RACE_REGI_DAY date NOT NULL,		--인수일
    SELL_DATE date NOT NULL,			--취합시 공급시작일
    MATERIAL varchar(20) NULL,			-- 지정품종코드
    BATCH_QUAN decimal(12,0) NULL,		--주문수량함
    SELL_PRIS decimal(15,4) NULL,		--매출단가
    SELL_AMOUNT decimal(15,0) NULL,		--매출금액
    BUY_PRIS decimal(15,4) NULL,		--매입단가
    BUY_AMOUNT decimal(15,0) NULL,		--매입금액
    INSERT_DATE datetime NOT NULL,		--등록일시
    PRIMARY KEY (GOOD_IDEN_NUMB, VENDORID, RACE_REGI_DAY),
);

CREATE NONCLUSTERED INDEX IX_MCGOOD_MATERIAL_DAY_STATIST_MATERIAL ON MCGOOD_MATERIAL_DAY_STATIST(MATERIAL); -- 인덱스추가

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'VENDORID';
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
    GOOD_IDEN_NUMB bigint NOT NULL,		--상품코드
    VENDORID varchar(10) NOT NULL,		--공급사ID
    RACE_REGI_DAY date NOT NULL,		--인수일
    COMP_ID int NOT NULL,				--콤포넌트ID
    SELL_DATE date NOT NULL,			--취합시 공급시작일
    BATCH_QUAN decimal(12,0) NULL,		--콤포넌트낱개수량합
    SELL_PRIS decimal(15,4) NULL,		--콤포넌트 매출단가
    SELL_AMOUNT decimal(15,0) NULL,		--콤포넌트 매출금액
    BUY_PRIS decimal(15,4) NULL,		--콤포넌트 매입단가
    BUY_AMOUNT decimal(15,0) NULL,		--콤포넌트 매입금액
    INSERT_DATE datetime NOT NULL,		--등록일시
    PRIMARY KEY (MATERIAL, GOOD_IDEN_NUMB, VENDORID, RACE_REGI_DAY, COMP_ID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_COMP_DAY_STATIST', @level2type = N'COLUMN', @level2name = 'VENDORID';
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
    GOOD_IDEN_NUMB bigint NOT NULL,		--상품코드
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    COMP_ID int NOT NULL,				--콤포넌트ID
    VENDORID VARCHAR(10) NOT NULL,		--공급사ID
    UNIT_QUAN int NOT NULL,				--기본수량
    SELL_PRIS decimal(15,4) NOT NULL,	--매출낱개단가
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (GOOD_IDEN_NUMB, MATERIAL, COMP_ID, VENDORID)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
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
    PRIMARY KEY (good_iden_numb, MATERIAL, COMP_ID, VENDORID, HIST_DATE)
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
    PRIMARY KEY (COMP_ID, PAST_YYYY)
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
    GOOD_IDEN_NUMB bigint NOT NULL,		--상품코드
    MATERIAL varchar(20) NOT NULL,		--지정품종코드
    COMP_ID int NOT NULL,				--콤포넌트ID
    VENDORID VARCHAR(10) NOT NULL,		--공급사ID
    PAST_YYYY VARCHAR(4) NOT NULL,		--과거년도
    UNIT_QUAN int NOT NULL,				--기본수량
    SELL_PRIS decimal(15,4) NOT NULL,	--매출낱개단가
    INSERT_USER_ID varchar(20) NOT NULL,--등록자ID
    INSERT_DATE datetime NOT NULL,		--등록일시
    UPDATE_USER_ID varchar(20) NULL,	--수정자ID
    UPDATE_DATE datetime NULL,			--수정일시
    PRIMARY KEY (GOOD_IDEN_NUMB, MATERIAL, COMP_ID, VENDORID, PAST_YYYY)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'상품코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_GOOD_COMP_PAST', @level2type = N'COLUMN', @level2name = 'GOOD_IDEN_NUMB';
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
    PAST_YYYY VARCHAR(4) NOT NULL,					--과거년도
    INSERT_USER_ID varchar(20) NOT NULL,	--등록자ID
    INSERT_DATE datetime NOT NULL,			--등록일시
    PRIMARY KEY (MATERIAL, COMP_ID, PAST_YYYY)
);

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'콤포넌트ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'COMP_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록자ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_USER_ID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'등록일시', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_COMP_PAST', @level2type = N'COLUMN', @level2name = 'INSERT_DATE';

---------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MATERIAL_PAST (
	MATERIAL VARCHAR(20) NOT NULL,			-- 지정품종코드
	PAST_YYYY VARCHAR(4) NOT NULL,			-- 과거년도
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
    PRIMARY KEY (MATERIAL, PAST_YYYY)
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
	PAST_YYYY VARCHAR(4) NOT NULL,		-- 과거년도
	SUIT_STATS_CD VARCHAR(20) NOT NULL,	-- 적격공급상태
	SUIT_SEL_CD VARCHAR(20),			-- 선정
	DISTRL_RATE INT NOT NULL,			-- 배분율
	EXCEPT_START_DATE DATETIME,			-- 제외시작일
	EXCEPT_END_DATE DATETIME,			-- 제외종료일
	NOTE VARCHAR(500),					-- 비고
    INSERT_USER_ID VARCHAR(20),           -- 등록자ID
    INSERT_DATE DATETIME,                 -- 등록일시
    UPDATE_USER_ID VARCHAR(20),           -- 수정자ID
    UPDATE_DATE DATETIME,                  -- 수정일시
    PRIMARY KEY (MATERIAL, VENDORID, PAST_YYYY)
)

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'지정품종코드', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'MATERIAL';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'공급사ID', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'VENDORID';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'과거년도', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'PAST_YYYY';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'적격공급상태', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'SUIT_STATS_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'선정', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'SUIT_SEL_CD';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배분율', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'DISTRL_RATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외시작일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'EXCEPT_START_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'제외종료일', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'EXCEPT_END_DATE';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'비고', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MCGOOD_MATERIAL_VENDOR_PAST', @level2type = N'COLUMN', @level2name = 'NOTE';
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

INSERT INTO MCCUST_CATE_MAST VALUES ('OKP', '구매사 기본 카테고리', 'Y', 1, '구매사 기본 카테고리', '2', GETDATE(), '2', GETDATE());
INSERT INTO MCCUST_CATE_MAST VALUES ('HNS', '홈앤서비스 카테고리', 'Y', 2, '홈앤서비스 카테고리', '2', GETDATE(), '2', GETDATE());
INSERT INTO MCCUST_CATE_MAST VALUES ('SAF', 'OKSAFETY 카테고리', 'Y', 3, 'OKSAFETY 카테고리', '2', GETDATE(), '2', GETDATE());
INSERT INTO MCCUST_CATE_MAST VALUES ('PTO', '팬타온 카테고리', 'Y', 99, '팬타온 카테고리', '2', GETDATE(), '2', GETDATE());
---------------------------------------------------------------------------------

CREATE TABLE MCCUST_CATE_NEW (
    CUST_CATE_CD varchar(20) NOT NULL,			--구매사 카테고리 CD
    CUST_CATE_MAST_CD varchar(3) NOT NULL,		--구매사 카테고리 마스터CD
    PAR_CUST_CATE_CD varchar(20) NULL,			--상위카테고리CD
    CUST_CATE_NM varchar(100) NOT NULL,			--카테고리명
    CATE_LEVEL int NOT NULL,					--카테고리레벌
    USE_YN varchar(1) NOT NULL,					--사용여부YN
    PANTA_BEST_YN varchar(1) DEFAULT 'Y' NOT NULL,					--사용여부YN
    ORDERING int NULL,							--순서
    CUST_CATE_DESC varchar(500) NULL,			--카테고리설명
    INSERT_USER_ID varchar(20) NOT NULL,		--등록자ID
    INSERT_DATE datetime NOT NULL,				--등록일시
    UPDATE_USER_ID varchar(20) NULL,			--수정자ID
    UPDATE_DATE datetime NULL,					--수정일시
    PRIMARY KEY (CUST_CATE_CD)
);

CREATE NONCLUSTERED INDEX IX_MCCUST_CATE_NEW_CUST_CATE_MAST_CD ON MCCUST_CATE_NEW(CUST_CATE_MAST_CD); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MCCUST_CATE_NEW_PAR_CUST_CATE_CD ON MCCUST_CATE_NEW(PAR_CUST_CATE_CD);

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

-------------------------------------------------------------

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

------------------------------------------------------------------

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


--SELECT * FROM MCCUST_CATE_NEW where CUST_CATE_CD like 'PTO%'
-- delete MCCUST_CATE_NEW_CONN where CUST_CATE_CD like 'PTO%'
-- delete MCCUST_CATE_NEW where CUST_CATE_CD like 'PTO%'

-- 구매사 카테고리 기본
INSERT INTO MCCUST_CATE_NEW (
	CUST_CATE_CD
,	CUST_CATE_MAST_CD
,	PAR_CUST_CATE_CD
,	CUST_CATE_NM
,	CATE_LEVEL
,	USE_YN
,	ORDERING
,	PANTA_BEST_YN
,	CUST_CATE_DESC
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT  
    'OKP' + RIGHT('00' + CAST(ROW_NUMBER() OVER (ORDER BY M.ORD_NUM) AS VARCHAR), 2) AS CUST_CATE_CD,
    'OKP' AS CUST_CATE_MAST_CD,
    'OKP' AS PAR_CUST_CATE_CD,
    M.majo_code_name AS CUST_CATE_NM,
    M.CATE_LEVEL - 1 AS CATE_LEVEL,
    'Y' AS USE_YN,
    M.ORD_NUM AS ORDERING,
    'N' AS PANTA_BEST_YN,
    CATE_ID AS CUST_CATE_DESC,
    '2' AS INSERT_USER_ID, 
    GETDATE() AS INSERT_DATE,
    '2' AS UPDATE_USER_ID,
    GETDATE() AS UPDATE_DATE
FROM mccategorymaster M 
WHERE M.AGENT_ID = '13'
AND M.cate_level = 1
ORDER BY M.ORD_NUM;

-- 2레벨 카테고리
INSERT INTO MCCUST_CATE_NEW (
	CUST_CATE_CD
,	CUST_CATE_MAST_CD
,	PAR_CUST_CATE_CD
,	CUST_CATE_NM
,	CATE_LEVEL
,	USE_YN
,	ORDERING
,	PANTA_BEST_YN
,	CUST_CATE_DESC
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT  
    B.CUST_CATE_CD + RIGHT('00' + CAST(ROW_NUMBER() OVER (PARTITION BY B.CUST_CATE_CD ORDER BY CONVERT(INT, A.ORD_NUM)) AS VARCHAR), 2) AS CUST_CATE_CD,
    'OKP' AS CUST_CATE_MAST_CD,
    B.CUST_CATE_CD AS PAR_CUST_CATE_CD,
    A.majo_code_name AS CUST_CATE_NM,
    A.CATE_LEVEL - 1 AS CATE_LEVEL,
    'Y' AS USE_YN,
    A.ORD_NUM AS ORDERING,
    'N' AS PANTA_BEST_YN,
    CATE_ID AS CUST_CATE_DESC,
    '2' AS INSERT_USER_ID, 
    GETDATE() AS INSERT_DATE,
    '2' AS UPDATE_USER_ID,
    GETDATE() AS UPDATE_DATE
FROM mccategorymaster A 
INNER JOIN MCCUST_CATE_NEW B
	ON A.ref_cate_seq = B.CUST_CATE_DESC
	AND B.CUST_CATE_MAST_CD = 'OKP'
WHERE A.AGENT_ID = '13'
AND A.cate_level = 2
ORDER BY B.CUST_CATE_CD,CONVERT(INT, A.ORD_NUM);


-- 3레벨 카테고리
INSERT INTO MCCUST_CATE_NEW (
	CUST_CATE_CD
,	CUST_CATE_MAST_CD
,	PAR_CUST_CATE_CD
,	CUST_CATE_NM
,	CATE_LEVEL
,	USE_YN
,	ORDERING
,	PANTA_BEST_YN
,	CUST_CATE_DESC
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT  
    B.CUST_CATE_CD + RIGHT('00' + CAST(ROW_NUMBER() OVER (PARTITION BY B.CUST_CATE_CD ORDER BY CONVERT(INT, A.ORD_NUM)) AS VARCHAR), 2) AS CUST_CATE_CD,
    'OKP' AS CUST_CATE_MAST_CD,
    B.CUST_CATE_CD AS PAR_CUST_CATE_CD,
    A.majo_code_name AS CUST_CATE_NM,
    A.CATE_LEVEL - 1 AS CATE_LEVEL,
    'Y' AS USE_YN,
    A.ORD_NUM AS ORDERING,
    'N' AS PANTA_BEST_YN,
    CATE_ID AS CUST_CATE_DESC,
    '2' AS INSERT_USER_ID, 
    GETDATE() AS INSERT_DATE,
    '2' AS UPDATE_USER_ID,
    GETDATE() AS UPDATE_DATE
FROM mccategorymaster A 
INNER JOIN MCCUST_CATE_NEW B
	ON A.ref_cate_seq = B.CUST_CATE_DESC
	AND B.CUST_CATE_MAST_CD = 'OKP'
WHERE A.AGENT_ID = '13'
AND A.cate_level = 3
ORDER BY B.CUST_CATE_CD,CONVERT(INT, A.ORD_NUM);

-- 구매사카테고리 - 표준카테고리 연결
INSERT MCCUST_CATE_NEW_CONN
SELECT	A.CUST_CATE_CD
,		B.cate_id
,		'2' AS INSERT_USER_ID 
,		GETDATE() AS INSERT_DATE 
FROM MCCUST_CATE_NEW A
INNER JOIN mccategorymaster B
	ON A.CUST_CATE_DESC = B.cate_id 
	AND B.AGENT_ID = '13'
WHERE A.CUST_CATE_MAST_CD = 'OKP'
AND A.CATE_LEVEL = 2
ORDER BY A.CUST_CATE_CD,CONVERT(INT, B.ORD_NUM);


-- 팬타온 구매사 카테고리
-- 1레벨 구매사 카테고리
INSERT INTO MCCUST_CATE_NEW (
	CUST_CATE_CD
,	CUST_CATE_MAST_CD
,	PAR_CUST_CATE_CD
,	CUST_CATE_NM
,	CATE_LEVEL
,	USE_YN
,	ORDERING
,	PANTA_BEST_YN
,	CUST_CATE_DESC
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT  
    'PTO' + RIGHT('00' + CAST(ROW_NUMBER() OVER (ORDER BY M.ORD_NUM) AS VARCHAR), 2) AS CUST_CATE_CD,
    'PTO' AS CUST_CATE_MAST_CD,
    'PTO' AS PAR_CUST_CATE_CD,
    M.majo_code_name AS CUST_CATE_NM,
    M.CATE_LEVEL - 1 AS CATE_LEVEL,
    'Y' AS USE_YN,
    M.ORD_NUM AS ORDERING,
    'N' AS PANTA_BEST_YN,
    CATE_ID AS CUST_CATE_DESC,
    '2' AS INSERT_USER_ID, 
    GETDATE() AS INSERT_DATE,
    '2' AS UPDATE_USER_ID,
    GETDATE() AS UPDATE_DATE
FROM mccategorymaster M 
WHERE M.AGENT_ID = '13'
AND M.cate_level = 1
ORDER BY M.ORD_NUM;

-- 2레벨 카테고리
INSERT INTO MCCUST_CATE_NEW (
	CUST_CATE_CD
,	CUST_CATE_MAST_CD
,	PAR_CUST_CATE_CD
,	CUST_CATE_NM
,	CATE_LEVEL
,	USE_YN
,	ORDERING
,	PANTA_BEST_YN
,	CUST_CATE_DESC
,	INSERT_USER_ID
,	INSERT_DATE
,	UPDATE_USER_ID
,	UPDATE_DATE
)
SELECT  
    B.CUST_CATE_CD + RIGHT('00' + CAST(ROW_NUMBER() OVER (PARTITION BY B.CUST_CATE_CD ORDER BY CONVERT(INT, A.ORD_NUM)) AS VARCHAR), 2) AS CUST_CATE_CD,
    'PTO' AS CUST_CATE_MAST_CD,
    B.CUST_CATE_CD AS PAR_CUST_CATE_CD,
    A.majo_code_name AS CUST_CATE_NM,
    A.CATE_LEVEL - 1 AS CATE_LEVEL,
    'Y' AS USE_YN,
    A.ORD_NUM AS ORDERING,
    'N' AS PANTA_BEST_YN,
    CATE_ID AS CUST_CATE_DESC,
    '2' AS INSERT_USER_ID, 
    GETDATE() AS INSERT_DATE,
    '2' AS UPDATE_USER_ID,
    GETDATE() AS UPDATE_DATE
FROM mccategorymaster A 
INNER JOIN MCCUST_CATE_NEW B
	ON A.ref_cate_seq = B.CUST_CATE_DESC
	AND B.CUST_CATE_MAST_CD = 'PTO'
WHERE A.AGENT_ID = '13'
AND A.cate_level = 2
ORDER BY B.CUST_CATE_CD,CONVERT(INT, A.ORD_NUM);

-- 구매사카테고리 - 팬타온 표준카테고리 연결
INSERT MCCUST_CATE_NEW_CONN
SELECT	A.CUST_CATE_CD
,		B.cate_id
,		'2' AS INSERT_USER_ID 
,		GETDATE() AS INSERT_DATE 
FROM MCCUST_CATE_NEW A
INNER JOIN mccategorymaster B
	ON A.CUST_CATE_DESC = B.cate_id 
	AND B.AGENT_ID = '13'
WHERE A.CUST_CATE_MAST_CD = 'PTO'
AND A.CATE_LEVEL = 2
ORDER BY A.CUST_CATE_CD,CONVERT(INT, B.ORD_NUM);
-------------------------------------------------------------------------------------
/*

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
*/

-----------------------------------------------------------------------------
--SELECT * FROM SMPDELIVERYINFO s 
ALTER TABLE SMPDELIVERYINFO ADD USERID VARCHAR(10) NULL ;
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사용자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPDELIVERYINFO', @level2type=N'COLUMN', @level2name=N'USERID';

CREATE NONCLUSTERED INDEX IX_SMPDELIVERYINFO_USERID ON SMPDELIVERYINFO(USERID);	-- 인텍스추가
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 시큅스 키 추가
INSERT SMP_SEQUENCE (TABLE_NAME,   NEXT_ID) VALUES ('SEQ_NEW_CART_ID',   1);

CREATE TABLE MRCART_NEW
( 
	CART_ID              int  NOT NULL ,						--장바구니ID
	CART_NM              varchar(100) DEFAULT '기본' NOT NULL ,	--장바구니명
	BRANCHID             varchar(10)  NOT NULL ,				--사업장ID
	USERID               varchar(10)  NOT NULL ,				--사용자ID
	IS_DEFAULT_YN        char(1) DEFAULT 'Y' NOT NULL ,			--기본YN
	COMP_ID				 INT  NULL ,							--공사ID
	ORDE_TEXT_DESC       varchar(500)  NULL ,					--주문요청사항
	ORDE_DESC            varchar(500)  NULL ,					--주문사유_HNS 필수
	DELIVERYID           varchar(10)  NULL ,					--배송처ID
	TRAN_USER_NAME       varchar(50)  NULL ,					--인수자명
	TRAN_TELE_NUMB       varchar(150)  NULL ,					--인수자연락처
	FIRST_ATTACH_SEQ     varchar(10)  NULL ,					--첨부파일1
	SECOND_ATTACH_SEQ    varchar(10)  NULL ,					--첨부파일2
	THIRD_ATTACH_SEQ     varchar(10)  NULL ,					--첨부파일3
	SAFETY_HEALTH_ID     int  NULL ,							--안전보건ID
	SAF_TEAM_CO          varchar(20)  NULL ,					--SAF 팀코드
	PRIMARY KEY (CART_ID)
);

CREATE NONCLUSTERED INDEX IX_MRCART_NEW_BRANCHID ON MRCART_NEW(BRANCHID); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRCART_NEW_USERID ON MRCART_NEW(USERID); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRCART_NEW_COMP_ID ON MRCART_NEW(COMP_ID); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRCART_NEW_DELIVERYID ON MRCART_NEW(DELIVERYID); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRCART_NEW_SAFETY_HEALTH_ID ON MRCART_NEW(SAFETY_HEALTH_ID); -- 인덱스추가

EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'장바구니 정보를 저장하는 테이블', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'장바구니ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'CART_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'장바구니명', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'CART_NM';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사업장ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'BRANCHID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사용자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'USERID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'기본YN', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'IS_DEFAULT_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'COMP_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'주문요청사항', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'ORDE_TEXT_DESC';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'주문사유_HNS 필수', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'ORDE_DESC';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'배송처ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'DELIVERYID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'인수자명', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'TRAN_USER_NAME';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'인수자연락처', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'TRAN_TELE_NUMB';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'FIRST_ATTACH_SEQ';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'SECOND_ATTACH_SEQ';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'첨부파일3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'THIRD_ATTACH_SEQ';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'안전보건ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'SAFETY_HEALTH_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'SAF 팀코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW', @level2type=N'COLUMN', @level2name=N'SAF_TEAM_CO';

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 공사정보
CREATE TABLE MRCOMP_INFO (
	COMP_ID INT NOT NULL,			-- 공사ID
	BRANCHID VARCHAR(10) NULL,		--사업장ID
	USERID VARCHAR(10) NULL,		--사용자ID
	COMP_IDEN_NAME VARCHAR(500) NULL,	-- 공사명
	COMP_YYYYMM VARCHAR(6)  NULL,		--사업년월
	COMP_SI VARCHAR(20)  NULL,			--공사시도
	COMP_GU VARCHAR(20)  NULL,			--공사시군구
	PRIMARY KEY (COMP_ID)
)

CREATE NONCLUSTERED INDEX IX_MRCOMP_INFO_BRANCHID ON MRCOMP_INFO(BRANCHID); -- 인덱스추가
CREATE NONCLUSTERED INDEX IX_MRCOMP_INFO_USERID ON MRCOMP_INFO(USERID); -- 인덱스추가

EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사정보', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'COMP_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사업장ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'BRANCHID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사용자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'USERID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사명', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'COMP_IDEN_NAME';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사업년월', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'COMP_YYYYMM';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사시도', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'COMP_SI';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공사시군구', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCOMP_INFO', @level2type=N'COLUMN', @level2name=N'COMP_GU';

--SELECT * FROM MRCOMP_INFO
--delete MRCOMP_INFO where comp_id > 21
-- 기존 장바구니에서 공사정보 마이그레이션
WITH CTE AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + (SELECT ISNULL(MAX(COMP_ID), 0) FROM MRCOMP_INFO) AS COMP_ID,
        A.BRANCHID,
        A.USERID,
        A.COMP_IDEN_NAME,
        A.COMP_YYYY + A.COMP_MM AS COMP_YYYYMM,
        A.COMP_SI,
        A.COMP_GU
    FROM MRCART A
    WHERE A.IS_DEFAULT_YN = 'Y'
)
INSERT INTO MRCOMP_INFO (
    COMP_ID,
    BRANCHID,
    USERID,
    COMP_IDEN_NAME,
    COMP_YYYYMM,
    COMP_SI,
    COMP_GU
)
SELECT COMP_ID, BRANCHID, USERID, COMP_IDEN_NAME, COMP_YYYYMM, COMP_SI, COMP_GU
FROM CTE;


-- 공사정보 테이블 마이그레이션 먼저하고 할 것
INSERT MRCART_NEW 
(
	CART_ID
,	CART_NM
,	BRANCHID
,	USERID
,	IS_DEFAULT_YN
,	COMP_ID
,	ORDE_TEXT_DESC
,	orde_desc 
,	DELIVERYID
,	tran_user_name 
,	tran_tele_numb 
,	FIRST_ATTACH_SEQ 
,	SECOND_ATTACH_SEQ 
,	THIRD_ATTACH_SEQ 
,	safety_health_id 
,	SAF_TEAM_CO 
)
SELECT 
	A.CART_ID
,	'기본 장바구니' AS CARTNM
,	A.BRANCHID
,	A.USERID
,	'Y' AS IS_DEFAULT_YN
,	B.COMP_ID
,	'' AS ORDE_TEXT_DESC
,	A.orde_desc 
,	(SELECT MAX(AA.DELIVERYID) FROM SMPDELIVERYINFO AA WHERE A.branchid = AA.BRANCHID AND A.userid = AA.USERID) AS DELIVERYID
,	A.tran_user_name 
,	A.tran_tele_numb 
,	A.firstattachseq 
,	A.secondattachseq 
,	A.thirdattachseq 
,	A.safety_health_id 
,	A.SAF_TEAM_CD 
FROM MRCART A
LEFT OUTER JOIN MRCOMP_INFO B
	ON A.BRANCHID = B.BRANCHID
	AND A.USERID = B.USERID
	AND ISNULL(A.COMP_IDEN_NAME, '') = ISNULL(B.COMP_IDEN_NAME, '')
	AND (ISNULL(A.COMP_YYYY, '')+ISNULL(A.COMP_MM, '')) = ISNULL(B.COMP_YYYYMM, '')
	AND ISNULL(A.COMP_SI, '') = ISNULL(B.COMP_SI, '')
	AND ISNULL(A.COMP_GU, '') = ISNULL(B.COMP_GU, '')
	AND ISNULL(B.COMP_IDEN_NAME, '') != ''
WHERE A.is_default_YN = 'Y'
;

-- 시퀀스테이블 업데이트
update SMP_SEQUENCE set next_id = (select max(cart_id)+1 from MRCART_NEW) where table_name = 'SEQ_NEW_CART_ID'

---------------------------------------------------------------------------------------------
CREATE TABLE MRCART_NEW_PROD
( 
	CART_ID              int  NOT NULL ,					-- 장바구니ID
	GOOD_IDEN_NUMB       bigint  NOT NULL ,					-- 상품코드
	VENDORID             varchar(10)  NOT NULL ,			-- 공급사ID
	JOJANG_M             varchar(10) DEFAULT 0 NOT NULL,	-- 조장미터
	REPRE_GOOD_IDEN_NUMB bigint  NULL ,						-- 옵션대표상품코드
	ADD_MASTER_YN        char(1)  NULL ,					-- 추가구성마스터YN
	ADD_REPRE_GOOD_IDEN_NUMB bigint  DEFAULT 0 NOT NULL,	-- 추가구성마스터 상품코드
	ADD_REPRE_VENDORID varchar(10) DEFAULT '' NOT NULL,		-- 추가구성마스터 공급사
	COMMON_OPTION        varchar(100) DEFAULT '' NOT NULL ,				-- 공통옵션
	ORDE_REQU_QUAN       decimal(7)  NOT NULL ,				-- 주문수량
	RECEIVER_IDS         varchar(1000)  NULL ,				--지급자IDS
	REGI_DATE_TIME       datetime  NOT NULL ,				--등록일시
	PRIMARY KEY (CART_ID, GOOD_IDEN_NUMB, VENDORID, JOJANG_M, ADD_REPRE_GOOD_IDEN_NUMB, ADD_REPRE_VENDORID, COMMON_OPTION)
)

EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'장바구니_NEW_품목', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'장바구니ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'CART_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'상품코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공급사ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'VENDORID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'조장미터', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'JOJANG_M';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'옵션대표상품코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'REPRE_GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'추가구성마스터YN', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'ADD_MASTER_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'추가구성마스터 상품코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'ADD_REPRE_GOOD_IDEN_NUMB';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공통옵션', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'COMMON_OPTION';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'주문수량', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'ORDE_REQU_QUAN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'지급자IDS', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'RECEIVER_IDS';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MRCART_NEW_PROD', @level2type=N'COLUMN', @level2name=N'REGI_DATE_TIME';

--SELECT * FROM mrcartprod
INSERT MRCART_NEW_PROD (
	CART_ID            
,	GOOD_IDEN_NUMB     
,	VENDORID           
,	JOJANG_M           
,	REPRE_GOOD_IDEN_NUMB
,	ADD_MASTER_YN      
,	ADD_REPRE_GOOD_IDEN_NUMB
,	ADD_REPRE_VENDORID 
,	COMMON_OPTION      
,	ORDE_REQU_QUAN     
,	RECEIVER_IDS   
,	REGI_DATE_TIME
)          
SELECT 
	B.CART_ID
,	A.GOOD_IDEN_NUMB
,	A.VENDORID
,	A.JOJANG_M
,	A.REPRE_GOOD_IDEN_NUMB AS REPRE_GOOD_IDEN_NUMB
,	A.ADD_MASTER_YN AS ADD_MASTER_YN
,	ISNULL(A.ADD_REPRE_GOOD_IDEN_NUMB, 0) AS ADD_REPRE_GOOD_IDEN_NUMB
,	ISNULL(A.ADD_VENDOR_ID, '') AS ADD_VENDOR_ID
,	ISNULL(A.COMMON_OPTION, '') AS COMMON_OPTION
,	A.ORDE_REQU_QUAN
,	REPLACE(A.RECEIVER_IDS, '‡', '') AS RECEIVER_IDS
,	A.REGI_DATE_TIME
FROM mrcartprod A
LEFT OUTER JOIN MRCART_NEW B
	ON A.BRANCHID = B.BRANCHID 
	AND A.USERID = B.USERID 
	AND B.CART_ID  > 21
WHERE B.CART_ID IS NOT NULL
ORDER BY CART_ID DESC;

-- 지급자정보 특문 삭제
update MRORDT set RECEIVER_IDS = replace(RECEIVER_IDS, '‡', '') where isnull(RECEIVER_IDS,'') != '';
update mrarem set RECEIVER_IDS = replace(RECEIVER_IDS, '‡', '') where isnull(RECEIVER_IDS,'') != '';

--SELECT * FROM mrcart m WHERE branchid = '305954' AND USERID = '302027'

--SELECT BRANCHID , USERID , COUNT(BRANCHID) FROM MRCART_NEW GROUP BY BRANCHID , USERID  HAVING COUNT(BRANCHID) > 1;
--SELECT * FROM MRCART_NEW mn WHERE BRANCHID = '304456' AND USERID = '301799';
-----------------------------------------------------------------------------------------------

-- 팬타온 주문 관련 쿼리
ALTER TABLE mrordm ADD PANTA_YN VARCHAR(1) NOT NULL DEFAULT 'N';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'팬타온주문YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'mrordm', @level2type = N'COLUMN', @level2name = 'PANTA_YN';
-- 마이그레이션
UPDATE mrordm SET PANTA_YN = 'N' WHERE PANTA_YN IS NULL;

/* 사용안함
ALTER TABLE MRAREM ADD CHANGE_RETURN VARCHAR(20);
ALTER TABLE MRAREM ADD DELI_MAIN VARCHAR(20);
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'교환반품', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRAREM', @level2type = N'COLUMN', @level2name = 'CHANGE_RETURN';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'배송비주체', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'MRAREM', @level2type = N'COLUMN', @level2name = 'DELI_MAIN';
*/
SELECT * FROM MRAREM WHERE DELI_MAIN IS NOT NULL

CREATE TABLE MRAREM_DTL (
	RETU_IDEN_NUM INT NOT NULL
,	CHANGE_RETURN VARCHAR(20) DEFAULT 'RETURN' NULL
,	REQ_REASON VARCHAR(MAX) NULL
,	ATT1_ID INT NULL
,	ATT2_ID INT NULL
,	ATT3_ID INT NULL
,	ATT4_ID INT NULL
,	ATT5_ID INT NULL
,	PRIMARY KEY (RETU_IDEN_NUM)
)

/*CREATE TABLE MRORDM_DELI_FEE
( 
	ORDE_IDEN_NUMB       varchar(13)  NOT NULL ,
	VENDORID             varchar(10)  NOT NULL ,
	DELI_FEE             decimal(15,4)  NULL 
);

CREATE TABLE MRORDM_PAYMENT
( 
	ORDE_IDEN_NUMB       varchar(13)  NOT NULL ,
	PG_NUM               varchar(500)  NULL ,
	PAY_TYPE             varchar(1)  NULL ,
	PAY_PRIC             decimal(15,4)  NULL ,
	PAY_APPR_NUM         varchar(500)  NULL ,
	PAY_APPR_DT          datetime  NULL ,
	PAY_CARD_NM          varchar(500)  NULL ,
	NO_INTEREST_YN       varchar(1)  NULL ,
	MONTHLY_PAY_CNT      varchar(10)  NULL 
);

CREATE TABLE MRORDM_PAYMENT_HIST
( 
	ORDE_IDEN_NUMB       varchar(13)  NULL ,
	PG_NUM               varchar(500)  NULL ,
	PAY_TYPE             varchar(1)  NULL ,
	PAY_PRIC             decimal(15,4)  NULL ,
	PAY_APPR_NUM         varchar(500)  NULL ,
	PAY_APPR_DT          datetime  NULL ,
	PAY_CARD_NUM         varchar(500)  NULL ,
	NO_INTEREST_YN       varchar(1)  NULL ,
	MONTHLY_PAY_CNT      varchar(10)  NULL 
);
SELECT * FROM MRORDM_DELI_FEE
*/
--select * from SMPVENDORS s ;

ALTER TABLE SMPVENDORS ADD PANTA_YN VARCHAR(1) DEFAULT 'N';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'팬타온 판매여부 YN', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'SMPVENDORS', @level2type = N'COLUMN', @level2name = 'PANTA_YN';
UPDATE SMPVENDORS SET PANTA_YN = 'N' WHERE PANTA_YN IS NULL;

CREATE TABLE SMPVENDORS_PANTA (
	VENDORID VARCHAR(10) NOT NULL,				--공급사ID
	PANTA_AGREE_DATE DATETIME, 					--택배사코드
	DELI_TYPE VARCHAR(10),					--배송유형
	DELI_COMP_CLAS VARCHAR(10),					--택배사코드
	BASE_DELI_AMOUNT DECIMAL(15,2),				--기본배송비
	PACKAGE_YN VARCHAR(1) DEFAULT 'N',			--묶음배송가능여부
	HILL_YN VARCHAR(1) DEFAULT 'N',				--도서산간배송여부
	JEJU_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,	--제주배송비
	JEJU_OTHER_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,--제주외배송비
	FREE_DELI_YN VARCHAR(1) DEFAULT 'N',		--무료배송정책여부
	FREE_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,	--무료배송주문금액
	DEAL_CANCEL VARCHAR(800)  NULL, -- 주문 취소
	DEAL_RETURN_FEE_POLICY VARCHAR(800)  NULL, -- 반품/교환 비용 정책
	DEAL_RETURN_PERIOD VARCHAR(800)  NULL, -- 반품/교환 가능 기간
	DEAL_RETURN_REASON VARCHAR(800)  NULL, -- 반품/교환 불가 사유
	DEAL_REFERENCE VARCHAR(800)  NULL, -- 참고사항
	DEAL_RETURN_SHIPPING_PLACE VARCHAR(200)  NULL, -- 반품/교환 배송지
	DEAL_RETURN_SHIPPING_PLACE_DTL VARCHAR(200)  NULL, -- 상세주소
	DEAL_AS_TELNUM VARCHAR(50)  NULL, -- A/S 관련 전화번호
	EMAIL VARCHAR(100)  NULL, -- 이메일
	ASK_TIME VARCHAR(100)  NULL, -- 고객문의 가능시간
	TEL_ORDER_BUSI_NUM VARCHAR(30)  NULL, -- 통신판매업신고번호
	REASON VARCHAR(500),						--사유
    INSERT_USER_ID varchar(20) NOT NULL,		--등록자ID
    INSERT_DATE datetime NOT NULL,				--등록일시
    UPDATE_USER_ID varchar(20) NULL,			--수정자ID
    UPDATE_DATE datetime NULL,					--수정일시
    PRIMARY KEY (VENDORID)
);

EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공급사_팬타온', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공급사ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'VENDORID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'택배사코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'PANTA_AGREE_DATE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'택배사코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DELI_COMP_CLAS';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'기본배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'BASE_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'도서산간배송여부', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'HILL_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'제주배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'JEJU_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'제주외배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'JEJU_OTHER_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'무료배송정책여부', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'FREE_DELI_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'무료배송주문금액', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'FREE_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'주문 취소', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_CANCEL';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'반품/교환 비용 정책', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_RETURN_FEE_POLICY';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'반품/교환 가능 기간', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_RETURN_PERIOD';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'반품/교환 불가 사유', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_RETURN_REASON';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'참고사항', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_REFERENCE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'반품/교환 배송지', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_RETURN_SHIPPING_PLACE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'상세주소', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_RETURN_SHIPPING_PLACE_DTL';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'A/S 관련 전화번호', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'DEAL_AS_TELNUM';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'이메일', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'EMAIL';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'고객문의 가능시간', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'ASK_TIME';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'통신판매업신고번호', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'TEL_ORDER_BUSI_NUM';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사유', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'REASON';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'등록자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'INSERT_USER_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'INSERT_DATE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'수정자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA', @level2type=N'COLUMN', @level2name=N'UPDATE_DATE';


CREATE TABLE SMPVENDORS_PANTA_HIST (
	VENDORID VARCHAR(10) NOT NULL,				--공급사ID
	PANTA_AGREE_DATE DATETIME, 					--택배사코드
	DELI_TYPE VARCHAR(10),					--배송유형
	DELI_COMP_CLAS VARCHAR(10),					--택배사코드
	BASE_DELI_AMOUNT DECIMAL(15,2),				--기본배송비
	PACKAGE_YN VARCHAR(1) DEFAULT 'N',			--묶음배송가능여부
	HILL_YN VARCHAR(1) DEFAULT 'N',				--도서산간배송여부
	JEJU_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,	--제주배송비
	JEJU_OTHER_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,--제주외배송비
	FREE_DELI_YN VARCHAR(1) DEFAULT 'N',		--무료배송정책여부
	FREE_DELI_AMOUNT DECIMAL(15,2) DEFAULT 0,	--무료배송주문금액
	DEAL_CANCEL VARCHAR(800)  NULL, -- 주문 취소
	DEAL_RETURN_FEE_POLICY VARCHAR(800)  NULL, -- 반품/교환 비용 정책
	DEAL_RETURN_PERIOD VARCHAR(800)  NULL, -- 반품/교환 가능 기간
	DEAL_RETURN_REASON VARCHAR(800)  NULL, -- 반품/교환 불가 사유
	DEAL_REFERENCE VARCHAR(800)  NULL, -- 참고사항
	DEAL_RETURN_SHIPPING_PLACE VARCHAR(200)  NULL, -- 반품/교환 배송지
	DEAL_RETURN_SHIPPING_PLACE_DTL VARCHAR(200)  NULL, -- 상세주소
	DEAL_AS_TELNUM VARCHAR(50)  NULL, -- A/S 관련 전화번호
	EMAIL VARCHAR(100)  NULL, -- 이메일
	ASK_TIME VARCHAR(100)  NULL, -- 고객문의 가능시간
	TEL_ORDER_BUSI_NUM VARCHAR(30)  NULL, -- 통신판매업신고번호
	REASON VARCHAR(500),						--사유
    INSERT_USER_ID varchar(20) NOT NULL,		--등록자ID
    INSERT_DATE datetime NOT NULL,				--등록일시
    UPDATE_USER_ID varchar(20) NULL,			--수정자ID
    UPDATE_DATE datetime NULL,					--수정일시
);


EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공급사_팬타온_HIST', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'공급사ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'VENDORID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'택배사코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'PANTA_AGREE_DATE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'택배사코드', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'DELI_COMP_CLAS';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'기본배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'BASE_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'도서산간배송여부', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'HILL_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'제주배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'JEJU_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'제주외배송비', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'JEJU_OTHER_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'무료배송정책여부', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'FREE_DELI_YN';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'무료배송주문금액', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'FREE_DELI_AMOUNT';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'사유', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'REASON';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'등록자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'INSERT_USER_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'INSERT_DATE';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'수정자ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'UPDATE_USER_ID';
EXEC sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'SMPVENDORS_PANTA_HIST', @level2type=N'COLUMN', @level2name=N'UPDATE_DATE';


-- smpvendors / smpvendor_panta 물류센터 추가 (운영사 id 13 으로 추가함)
select * from SMPVENDORS_PANTA;
insert smpvendors (vendorid, vendornm ) values (13, '물류센터');
insert SMPVENDORS_PANTA (vendorid, panta_agree_date ,DEAL_CANCEL, DEAL_RETURN_FEE_POLICY, DEAL_RETURN_PERIOD, DEAL_RETURN_REASON, DEAL_REFERENCE, DEAL_RETURN_SHIPPING_PLACE, DEAL_RETURN_SHIPPING_PLACE_DTL, DEAL_AS_TELNUM, INSERT_USER_ID, INSERT_DATE) 
values (13, getdate() ,'DEAL_CANCEL', 'DEAL_RETURN_FEE_POLICY', 'DEAL_RETURN_PERIOD', 'DEAL_RETURN_REASON', 'DEAL_REFERENCE', 'DEAL_RETURN_SHIPPING_PLACE', 'DEAL_RETURN_SHIPPING_PLACE_DTL', 'DEAL_AS_TELNUM', '2', getdate())

---------------------------------------------------------------------------------------------
-- 팬타온 배송 기준표
CREATE TABLE SMPVENDORS_PANTA_DELI (
	VENDORID VARCHAR(10) NOT NULL
,	POST_ADDR VARCHAR(10) NOT NULL
,	JEJU_YN VARCHAR(1) NOT NULL
,	OTHER_YN VARCHAR(1) NOT NULL
,	PRIMARY KEY(VENDORID, POST_ADDR)
);

---------------------------------------------------------------------------------------------

-- 매입헤더 배송비 추가
ALTER TABLE MSBUYM ADD DELIVERY_AMOUNT DECIMAL(15,0) DEFAULT 0 ;
UPDATE MSBUYM SET DELIVERY_AMOUNT = 0 WHERE DELIVERY_AMOUNT IS NULL;
---------------------------------------------------------------------------------------------------


-- 운영사 일괄등록 관련 테이블 
CREATE TABLE MCBAT_MAST (
	BAT_MAST_ID INT NOT NULL					--마스터ID
,	BAT_STATE VARCHAR(1) NOT NULL DEFAULT '0'	--상태
,	BAT_AMST_NM VARCHAR(100) NOT NULL			--일괄등록명
,	BAT_DATE DATETIME NOT NULL					--적용일시
,   INSERT_USER_ID varchar(20) NOT NULL			--등록자ID
,   INSERT_DATE datetime NOT NULL				--등록일시
,   TRANS_DATE DATETIME NULL
,	PRIMARY KEY(BAT_MAST_ID)
);

CREATE TABLE MCGOOD_BAT (
	BAT_SEQ INT NOT NULL
,	BAT_MAST_ID INT NOT NULL
,	INS_UPD VARCHAR(10)
,	ERR_CONT VARCHAR(200)
,	GOOD_IDEN_NUMB BIGINT NULL
,	CATE_CD VARCHAR(10)
,	SAF_MGMT_ITM VARCHAR(500)
,	GOOD_NAME VARCHAR(200)
,	GOOD_REG_YEAR VARCHAR(4)
,	NEW_BUSI VARCHAR(10)
,	GOOD_SPEC VARCHAR(500)
,	SPEC_PI VARCHAR(10)
,	SPEC_WIDTH VARCHAR(10)
,	SPEC_DEEP VARCHAR(10)
,	SPEC_HEIGHT VARCHAR(10)
,	SPEC_TON VARCHAR(10)
,	SPEC_METER VARCHAR(10)
,	SPEC_WEIGHT_REAL VARCHAR(10)
,	SPEC_WEIGHT_SUM VARCHAR(10)
,	SPEC_MATERIAL VARCHAR(20)
,	SPEC_SIZE VARCHAR(50)
,	SPEC_COLOR VARCHAR(10)
,	SPEC_TYPE VARCHAR(20)
,	SPEC_PAK_WIDTH VARCHAR(10)
,	SPEC_PAK_DEEP VARCHAR(10)
,	SPEC_PAK_HEIGHT VARCHAR(10)
,	SPEC_PAK_QUAN VARCHAR(10)
,	SPEC_PLT_QUAN VARCHAR(10)
,	SPEC_PAK_CODE VARCHAR(500)
,	MATERIAL VARCHAR(20)
,	MATERIAL_DETL_CD VARCHAR(20)
,	VTAX_CLAS_CODE VARCHAR(10)
,	PRODUCT_MANAGER VARCHAR(100)
,	ORDER_UNIT VARCHAR(10)
,	STOCK_YN VARCHAR(1)
,	STOCK_CHECK_YN VARCHAR(1)
,	GOOD_TYPE VARCHAR(10)
,	VENDOR_EXPOSE VARCHAR(10)
,	ISDISTRIBUTE VARCHAR(10)
,	ADD_GOOD VARCHAR(10)
,	SKTS_IMG VARCHAR(10)
,	T_CODE VARCHAR(20)
,	VENDORCD VARCHAR(10)
,	ISUSE VARCHAR(10)
,	SELL_PRICE DECIMAL(15,2)
,	SALE_UNIT_PRIC DECIMAL(15,2)
,	DELI_MINI_QUAN DECIMAL(10,2)
,	DELI_MINI_DAY DECIMAL(2,0)
,	DISTRI_RATE INT 
,	MAKE_COMP_NAME VARCHAR(100)
,	VENDOR_STOCK_YN CHAR(1)
,	GOOD_INVENTORY_CNT DECIMAL(15,2) 
,	UPD_REASON VARCHAR(200)
,	primary key(BAT_SEQ)
);

CREATE NONCLUSTERED INDEX IX_MCGOOD_BAT_MAST_ID ON MCGOOD_BAT(BAT_MAST_ID); -- 인덱스추가

INSERT INTO [dbo].[BUDGET_ITEM]
   ([GOOD_TYPE]
   ,[TYPE_NM]
   ,[ITEM_TYPE]
   ,[TYPE_VALUE]
   ,[SORT]
   ,[USE_YN]
   ,[CREATE_USERID]
   ,[CREATE_DATE]
   ,[UPDATE_USERID]
   ,[UPDATE_DATE])
 VALUES
       ('00'
   ,'사업장'
   ,'1'
   , null
   ,1
   ,'Y'
   ,'0'
   ,getdate()
   , null
   , null);
   
-------------------------------------------------------------------------------------
-- 공지사항 상단고정여부 추가
-- SELECT * FROM NOTICEBOARD
ALTER TABLE NOTICEBOARD ADD TOP_FIX_YN VARCHAR(1) DEFAULT 'N';
update NOTICEBOARD set TOP_FIX_YN = 'N' where TOP_FIX_YN is null;
 
-- FAQ 컬럼 추가 및 삭제
--select * from FAQ_MANAGE fm
ALTER TABLE FAQ_MANAGE ADD DISPLAY_YN VARCHAR(1) DEFAULT 'Y';
ALTER TABLE FAQ_MANAGE DROP COLUMN READ_CNT;
ALTER TABLE FAQ_MANAGE DROP COLUMN AGENT_ID;
update FAQ_MANAGE set DISPLAY_YN = 'N' where DISPLAY_YN is null;
   
-------------------------------------------------------------------------------------

-- 구매사 메인 베스트, 인기 상품 관련 통계 테이블 3개 
CREATE TABLE BAT_RECENT3_ORDE (
	GOOD_IDEN_NUMB BIGINT NOT NULL
,	WORKID INT NOT NULL
,	CUST_CATE_CD VARCHAR(20) NOT NULL
,	VENDORID VARCHAR(20) NOT NULL
,	REGI_DATE_TIME DATETIME NOT NULL
,	ORDE_QUAN DECIMAL(7,0) NOT NULL
,	PRIMARY KEY(GOOD_IDEN_NUMB, WORKID, CUST_CATE_CD, VENDORID)
);


CREATE TABLE BAT_POPULAR_GOOD (
	WORKID INT NOT NULL
,	GOOD_IDEN_NUMB BIGINT NOT NULL
,	RANK INT NOT NULL
,	REGI_DATE_TIME DATETIME NOT NULL
,	PRIMARY KEY(WORKID, GOOD_IDEN_NUMB)
);

CREATE TABLE BAT_BEST_GOOD (
	CUST_CATE_CD VARCHAR(20) NOT NULL
,	WORKID INT NOT NULL
,	GOOD_IDEN_NUMB BIGINT NOT NULL
,	RANK INT NOT NULL
,	REGI_DATE_TIME DATETIME NOT NULL
,	PRIMARY KEY(CUST_CATE_CD, WORKID, GOOD_IDEN_NUMB)
);
-- 팬타온 집계 테이블
CREATE TABLE BAT_PTO_POPULAR_GOOD (
	GOOD_IDEN_NUMB BIGINT NOT NULL
,	VENDORID VARCHAR(20) NOT NULL
,	RANK INT NOT NULL
,	REGI_DATE_TIME DATETIME NOT NULL
,	PRIMARY KEY(VENDORID, GOOD_IDEN_NUMB)
);

CREATE TABLE BAT_PTO_BEST_GOOD (
	CUST_CATE_CD VARCHAR(20) NOT NULL
,	VENDORID VARCHAR(20) NOT NULL
,	GOOD_IDEN_NUMB BIGINT NOT NULL
,	RANK INT NOT NULL
,	REGI_DATE_TIME DATETIME NOT NULL
,	PRIMARY KEY(CUST_CATE_CD, VENDORID, GOOD_IDEN_NUMB)
);

-- 구매사 카테고리 기준
WITH CategoryHierarchy AS (
    SELECT 
        CUST_CATE_CD, 
        CUST_CATE_NM, 
        PAR_CUST_CATE_CD, 
        cate_level,
        PAR_CUST_CATE_CD AS PAR_CATE_ID
    FROM MCCUST_CATE_NEW
    WHERE cate_level = 1
    UNION ALL
    SELECT 
        m.CUST_CATE_CD, 
        m.CUST_CATE_NM, 
        m.PAR_CUST_CATE_CD, 
        m.cate_level,
        c.PAR_CATE_ID
    FROM MCCUST_CATE_NEW m
    JOIN CategoryHierarchy c
        ON m.PAR_CUST_CATE_CD = c.CUST_CATE_CD
)
INSERT BAT_RECENT3_ORDE
SELECT 
	B.good_iden_numb 
,	D.WORKID 
,	G.PAR_CUST_CATE_CD
,	B.VENDORID
,	CONVERT(CHAR(10), GETDATE(), 23) AS REGI_DATE_TIME
,	SUM(B.orde_requ_quan) AS ORDE_QUAN
FROM mrordm A
INNER JOIN mrordt B
	ON A.orde_iden_numb  = B.orde_iden_numb
INNER JOIN mcgood C
	ON B.good_iden_numb = C.good_iden_numb 
INNER JOIN SMPBRANCHS D
	ON A.branchid = D.BRANCHID 
INNER JOIN SMPWORKINFO E -- 물류주문은 제외됨
	ON D.WORKID = E.WORKID 
	AND ISNULL(E.CUST_CATE_MAST_CD, '') != ''
INNER JOIN MCCUST_CATE_MAST F
	ON E.CUST_CATE_MAST_CD = F.CUST_CATE_MAST_CD 
INNER JOIN MCCUST_CATE_NEW G
	ON F.CUST_CATE_MAST_CD = G.CUST_CATE_MAST_CD 
INNER JOIN MCCUST_CATE_NEW_CONN H
	ON G.CUST_CATE_CD = H.CUST_CATE_CD 
	AND C.cate_id = H.CATE_ID 
INNER JOIN CategoryHierarchy I
	ON I.CUST_CATE_CD = H.CUST_CATE_CD 
WHERE B.orde_stat_flag = '10' 
AND A.orde_type_clas  = '10'
AND A.regi_date_time BETWEEN DATEADD(YEAR, -5, GETDATE()) AND GETDATE() 
GROUP BY B.good_iden_numb 
,	D.WORKID 
,	G.PAR_CUST_CATE_CD
,	B.VENDORID
;
-- 구매사 카테고리 기준

-- 구매사 카테고리 없는 기준
WITH CategoryHierarchy AS (
    SELECT 
        cate_id, 
        majo_code_name, 
        ref_cate_seq, 
        cate_level,
        cate_id AS PAR_CATE_ID
    FROM mccategorymaster
    WHERE cate_level = 1
    UNION ALL
    SELECT 
        m.cate_id, 
        m.majo_code_name, 
        m.ref_cate_seq, 
        m.cate_level,
        c.PAR_CATE_ID
    FROM mccategorymaster m
    JOIN CategoryHierarchy c
        ON m.ref_cate_seq = c.cate_id
)
INSERT BAT_RECENT3_ORDE
SELECT 
    B.good_iden_numb,
    D.WORKID,
    F.PAR_CATE_ID,
    B.VENDORID,
    CONVERT(CHAR(10), GETDATE(), 23) AS REGI_DATE_TIME,
    SUM(B.orde_requ_quan) AS ORDE_QUAN
FROM mrordm A
INNER JOIN mrordt B
    ON A.orde_iden_numb  = B.orde_iden_numb
INNER JOIN mcgood C
    ON B.good_iden_numb = C.good_iden_numb 
INNER JOIN SMPBRANCHS D
    ON A.branchid = D.BRANCHID 
INNER JOIN SMPWORKINFO E -- 물류주문은 제외됨
    ON D.WORKID = E.WORKID 
    AND ISNULL(E.CUST_CATE_MAST_CD, '') = ''
INNER JOIN CategoryHierarchy F
    ON C.cate_id = F.cate_id 
WHERE B.orde_stat_flag = '10' 
AND A.orde_type_clas  = '10'
AND A.regi_date_time BETWEEN DATEADD(YEAR, -5, GETDATE()) AND GETDATE() 
GROUP BY 
    B.good_iden_numb, 
    D.WORKID, 
    F.PAR_CATE_ID,
	B.VENDORID;
-- 구매사 카테고리 없는 기준
/*INSERT INTO BAT_RECENT3_ORDE 
SELECT GOOD_IDEN_NUMB, 1, 'PTO01', VENDORID, REGI_DATE_TIME, ORDE_QUAN
FROM BAT_RECENT3_ORDE WHERE WORKID  = 50 AND CUST_CATE_CD = 'OKP01' 임시 데이터*/
-- SELECT * FROM BAT_RECENT3_ORDE


WITH RankedPopularGoods AS (
    SELECT 
        WORKID,
        GOOD_IDEN_NUMB,
        REGI_DATE_TIME,
        DENSE_RANK() OVER (
            PARTITION BY WORKID 
            ORDER BY SUM(ORDE_QUAN) DESC, GOOD_IDEN_NUMB DESC
        ) AS RANK
    FROM BAT_RECENT3_ORDE
    GROUP BY WORKID, GOOD_IDEN_NUMB, REGI_DATE_TIME
)
INSERT INTO BAT_POPULAR_GOOD (WORKID, GOOD_IDEN_NUMB, RANK, REGI_DATE_TIME)
SELECT WORKID, GOOD_IDEN_NUMB, RANK, REGI_DATE_TIME
FROM RankedPopularGoods
WHERE RANK <= 100;  -- 최대 100개까지만 삽입


WITH RankedBestGoods AS (
    SELECT 
        CUST_CATE_CD,
        WORKID,
        GOOD_IDEN_NUMB,
        REGI_DATE_TIME,
        DENSE_RANK() OVER (
            PARTITION BY CUST_CATE_CD, WORKID 
            ORDER BY SUM(ORDE_QUAN) DESC, GOOD_IDEN_NUMB DESC
        ) AS RANK
    FROM BAT_RECENT3_ORDE
    GROUP BY CUST_CATE_CD, WORKID, GOOD_IDEN_NUMB, REGI_DATE_TIME
)
INSERT INTO BAT_BEST_GOOD (CUST_CATE_CD, WORKID, GOOD_IDEN_NUMB, RANK, REGI_DATE_TIME)
SELECT CUST_CATE_CD, WORKID, GOOD_IDEN_NUMB, RANK, REGI_DATE_TIME
FROM RankedBestGoods
WHERE RANK <= 10;  -- 각 PK별 최대 5개

-- 팬타온 집계
WITH RankedPopularGoods AS (
    SELECT 
        WORKID,
        GOOD_IDEN_NUMB,
        VENDORID,
        REGI_DATE_TIME,
        DENSE_RANK() OVER (
            PARTITION BY WORKID 
            ORDER BY SUM(ORDE_QUAN) DESC, GOOD_IDEN_NUMB DESC, VENDORID
        ) AS RANK
    FROM BAT_RECENT3_ORDE
    WHERE WORKID = 1 -- 팬타온
    GROUP BY WORKID, GOOD_IDEN_NUMB, VENDORID, REGI_DATE_TIME
)
INSERT INTO BAT_PTO_POPULAR_GOOD (GOOD_IDEN_NUMB, VENDORID, RANK, REGI_DATE_TIME)
SELECT GOOD_IDEN_NUMB, VENDORID, RANK, REGI_DATE_TIME
FROM RankedPopularGoods
WHERE RANK <= 100;  -- 최대 100개까지만 삽입


WITH RankedBestGoods AS (
    SELECT 
        CUST_CATE_CD,
        WORKID,
        GOOD_IDEN_NUMB,
        VENDORID,
        REGI_DATE_TIME,
        DENSE_RANK() OVER (
            PARTITION BY CUST_CATE_CD, WORKID 
            ORDER BY SUM(ORDE_QUAN) DESC, GOOD_IDEN_NUMB DESC, VENDORID
        ) AS RANK
    FROM BAT_RECENT3_ORDE
    WHERE WORKID = 1 -- 팬타온
    GROUP BY CUST_CATE_CD, WORKID, GOOD_IDEN_NUMB, VENDORID, REGI_DATE_TIME
)
INSERT INTO BAT_PTO_BEST_GOOD (CUST_CATE_CD, GOOD_IDEN_NUMB, VENDORID, RANK, REGI_DATE_TIME)
SELECT CUST_CATE_CD, GOOD_IDEN_NUMB, VENDORID, RANK, REGI_DATE_TIME
FROM RankedBestGoods
WHERE RANK <= 10;  -- 각 PK별 최대 10개

-------------------------------------------------------------------------------------

-- 관심상품
/*SELECT name, type_desc
FROM sys.key_constraints
WHERE type = 'PK' AND parent_object_id = OBJECT_ID('MRUSERGOOD');*/
ALTER TABLE MRUSERGOOD ADD VENDORID VARCHAR(20) NOT NULL DEFAULT 0;
-- 공급사 ID 0 으로 마이그레이션
UPDATE MRUSERGOOD SET VENDORID = 0 where VENDORID is null;

-- pk 수정
ALTER TABLE MRUSERGOOD DROP CONSTRAINT PK_MRUSERGOOD;
ALTER TABLE MRUSERGOOD ADD CONSTRAINT PK_MRUSERGOOD PRIMARY KEY (GOOD_IDEN_NUMB, BRANCHID, USERID, VENDORID);

create table MCGOODVENDOR_PANTA_ASK (
	ASK_SEQ INT NOT NULL
,	GOOD_IDEN_NUMB BIGINT  NOT NULL
,	VENDORID VARCHAR(10)  NOT NULL
,	ASK_DESC VARCHAR(500)  NOT NULL
,	ANSWER_DESC	VARCHAR(500)  NOT NULL
,	ASK_STAT VARCHAR(1) DEFAULT '0'  NOT NULL	-- 0 : 답변대기, 1 : 답변완료
,	HIDDEN_YN VARCHAR(1) DEFAULT 'N' -- N : 공개, Y : 비밀글
,	REGI_USER_ID VARCHAR(20) 
,	REGI_DATE DATETIME
,	UPDATE_USER_ID VARCHAR(20)
,	UPDATE_DATE DATETIME
,	PRIMARY KEY (ASK_SEQ)
)

INSERT INTO SMP_SEQUENCE VALUES ('MCGOODVENDOR_PANTA_ASK', 1)

------------------------------------------------------------------------------------

-- 주문배송비
CREATE TABLE MRDELIVERY_AMOUNT (
	ORDE_IDEN_NUMB VARCHAR(13) NOT NULL
,	VENDORID VARCHAR(20) NOT NULL
,	DELIVERY_AMOUNT DECIMAL(15,2) DEFAULT 0 NOT NULL
,	PAY_YN VARCHAR(1) DEFAULT 'N'
,	ORG_DELIVERY_AMOUNT DECIMAL(15,2) DEFAULT 0 NOT NULL
,	PRIMARY KEY (ORDE_IDEN_NUMB, VENDORID)
)

-- 주문결재내역
CREATE TABLE MRPAYMENT (
	ORDE_IDEN_NUMB VARCHAR(13) NOT NULL,
	PAYMENT_KEY VARCHAR(200)  NULL,
	[METHOD] VARCHAR(50) NULL,
	CARD_NUMBER VARCHAR(20) NULL,
	TOTAL_AMOUNT DECIMAL(15,0) NULL,
	BALANCE_AMOUNT DECIMAL(15,0) NULL,
	REQUESTED_AT DATETIME NULL,
	APPROVED_AT DATETIME NULL,
	LAST_TRANSACTION_KEY VARCHAR(64) NULL,
	SUPPLIED_AMOUNT DECIMAL(15,0) NULL,
	VAT DECIMAL(15,0) NULL,
	IS_PARTIAL_CANCELABLE VARCHAR(1) NULL,
	MOBILE_PHONE VARCHAR(15) NULL,
	RECEIPT_URL VARCHAR(300) NULL,
	CARD_TYPE VARCHAR(10) NULL,
	ISSUER_CODE VARCHAR(2) NULL,
	INSTALLMENT_PLAN_MONTHS INT NULL,
	EASYPAY_PROVIDER VARCHAR(20) NULL,
	INSERT_DATE DATETIME,
	UPDATE_DATE DATETIME,	
	ORG_AMOUNT DECIMAL(15,0) NULL,
	PRIMARY KEY (ORDE_IDEN_NUMB)
);

-- 주문결재내역_HIST
CREATE TABLE MRPAYMENT_HIST (
	ORDE_IDEN_NUMB VARCHAR(13) NOT NULL,
	PAYMENT_KEY VARCHAR(200)  NULL,
	[METHOD] VARCHAR(50) NULL,
	CARD_NUMBER VARCHAR(20) NULL,
	TOTAL_AMOUNT DECIMAL(15,0) NULL,
	BALANCE_AMOUNT DECIMAL(15,0) NULL,
	REQUESTED_AT DATETIME NULL,
	APPROVED_AT DATETIME NULL,
	LAST_TRANSACTION_KEY VARCHAR(64) NULL,
	SUPPLIED_AMOUNT DECIMAL(15,0) NULL,
	VAT DECIMAL(15,0) NULL,
	IS_PARTIAL_CANCELABLE VARCHAR(1) NULL,
	MOBILE_PHONE VARCHAR(15) NULL,
	RECEIPT_URL VARCHAR(300) NULL,
	CARD_TYPE VARCHAR(10) NULL,
	ISSUER_CODE VARCHAR(2) NULL,
	INSTALLMENT_PLAN_MONTHS INT NULL,
	EASYPAY_PROVIDER VARCHAR(20) NULL,
	INSERT_DATE DATETIME,
	UPDATE_DATE DATETIME,
	ORG_AMOUNT DECIMAL(15,0) NULL
);


-- 주문환불내역
CREATE TABLE MRPAY_REFUND (
	ORDE_IDEN_NUMB VARCHAR(13) NOT NULL
,	VENDORID VARCHAR(20) NOT NULL
,	REFUND_AMOUNT DECIMAL(15,2) DEFAULT 0 NOT NULL
,	REFUND_CONTENT VARCHAR(500)
,	RETU_IDEN_NUM INT
,	INSERT_USER_ID VARCHAR(20)
,	INSERT_DATE DATETIME
)

-------------------------------------------------------------------------------

-- 임직원 당근마켓
CREATE TABLE EMPLOY_MARKET (
	MARKET_SEQ INT NOT NULL
,	TITLE VARCHAR(100)
,	CONTENT TEXT
,	HIDDEN_YN VARCHAR(1) DEFAULT 'N'
,	VIEW_CNT INT
,	ATTACH_SEQ1 INT
,	ATTACH_SEQ2 INT
,	ATTACH_SEQ3 INT
,	ATTACH_SEQ4 INT
,	INSERT_USER_ID VARCHAR(20)
,	INSERT_DATE DATETIME
,	UPDATE_USER_ID VARCHAR(20)
,	UPDATE_DATE DATETIME
,	PRIMARY KEY (MARKET_SEQ)
)

CREATE TABLE EMPLOY_MARKET_REPLY (
	REPLY_SEQ INT NOT NULL
,	MARKET_SEQ INT
,	CONTENT VARCHAR(1000)
,	INSERT_USER_ID VARCHAR(20)
,	INSERT_DATE DATETIME
,	PRIMARY KEY (REPLY_SEQ)
);

INSERT INTO [dbo].[SMP_SEQUENCE] ([TABLE_NAME],[NEXT_ID]) VALUES ('SEQ_EMPLOY_MARKET',1);

INSERT INTO [dbo].[SMP_SEQUENCE] ([TABLE_NAME],[NEXT_ID]) VALUES ('SEQ_EMPLOY_MARKET_REPLY',1);

---------------------------------------------------------------------------------------------

CREATE TABLE MCGOOD_MEMO (
	MGOOD_MEMO_SEQ INT NOT NULL,
	GOOD_IDEN_NUMB BIGINT NOT NULL,
	MEMO VARCHAR(2000) NOT NULL,
	ATTACH_SEQ INT,
	INSERT_USER_ID VARCHAR(20) NOT NULL,
	INSERT_DATE DATETIME NOT NULL,
	UPDATE_USER_ID VARCHAR(20),
	UPDATE_DATE DATETIME,
	PRIMARY KEY (MGOOD_MEMO_SEQ)
);

CREATE NONCLUSTERED INDEX IX_MCGOOD_MEMO_GOOD_IDEN_NUMB ON MCGOOD_MEMO(GOOD_IDEN_NUMB); -- 인덱스추가
INSERT INTO [dbo].[SMP_SEQUENCE] ([TABLE_NAME],[NEXT_ID]) VALUES ('SEQ_MCGOOD_MEMO',1);


---------------------------------------------------------------------------------------------

-- 추가 대상
-- 신규 코드
SELECT * FROM SMPCODES s where AGENT_ID = '13' AND s.CODETYPECD in ( 
	'FRONT_CSS_COLOR', 'pto_ORDE_reason', 'TOSS_CARD', 'FRONT_BG', 'PTO_REQU_STAT_FLAG', 'pto_end_cause', 'BUY_SVC', 'CARD_ISSUER', 'MATERIAL_MANAGE', 'MATERIAL_USED', 'BID_RESULT'
) ORDER BY CODETYPEID, DISORDER;
-- 코드값 추가
SELECT * FROM SMPCODES s where AGENT_ID = '13' AND s.CODETYPECD in ( 'FAQ_TYPE', 'BOARD_BORG_TYPE', 'RETURNSTATUSFLAG', 'ORDERCHANGEMESSAGE' ) ORDER BY CODETYPEID, DISORDER;
-- CODENM2 추가
SELECT * FROM SMPCODES s where AGENT_ID = '13' AND s.CODETYPECD in ( 'ORDERSTATUSFLAGCD ' ) ORDER BY CODETYPEID, DISORDER;
--UPDATE SMP_SEQUENCE SET NEXT_ID = (select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b) WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'
select next_id +1 from SMP_SEQUENCE WHERE TABLE_NAME = 'SEQMP_CORESYSTEM';
-- 첫 데이터는 SMP_SEQUENCE > SEQMP_CORESYSTEM 값의 +1
-- 코드 마스터 인서트
INSERT INTO SMPCODETYPES VALUES((select next_id +1 from SMP_SEQUENCE WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'), N'FRONT_CSS_COLOR', N'구매사 CSS 색상', N'구매사 사이트 관리에서 저장할 구매사 CSS 색상', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'pto_ORDE_reason', N'팬타온 주문변경 사유', N'팬타온 주문 취소/교환/반품 시 사유 선택 코드값2 : 주문취소(1) 교환(2) 반품(3) ', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'TOSS_CARD', N'토스페이먼트 카드결제코드', N'', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'FRONT_BG', N'Background 이미지 관리', N'구매사 사이트 관리 랜딩페이지 Background 이미지 관리 ', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'PTO_REQU_STAT_FLAG', N'팬타온 질의응답', N'팬타온 질의응답 유형', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'pto_end_cause', N'팬타온 탈퇴사유', N'팬타온 회원탈퇴 시 사유 선택 리스트', 1, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'BUY_SVC', N'구매사 서비스 타입', N'smpborgs > join 에서 사용되는 코드 hns/saf 구분을 쉽게하기위해 생성', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'CARD_ISSUER', N'결제카드', N'PG연동에서 사용되는 결제카드의 코드값', 1, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'MATERIAL_MANAGE', N'지정자재 품종 관리구분', N'지정자재 품종 관리구분', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'MATERIAL_USED', N'지정자재 품종 사용처', N'지정자재 품종 사용처', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');
INSERT INTO SMPCODETYPES VALUES((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b), N'BID_RESULT', N'입찰 결과값', N'', 0, N'172.0.0.1', getdate(), N'2', getdate(), N'2', 1, N'13');

-- 기존 코드 업데이트 건
UPDATE SMPCODES SET CODENM2 = '주문요청'		WHERE CODEVAL1 =  '10' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '결제완료'		WHERE CODEVAL1 =  '40' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '배송준비중'		WHERE CODEVAL1 =  '50' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '주문취소요청'	WHERE CODEVAL1 =  '59' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '배송중'		WHERE CODEVAL1 =  '60' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '배송완료'		WHERE CODEVAL1 =  '70' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '반품완료'		WHERE CODEVAL1 =  '80' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';
UPDATE SMPCODES SET CODENM2 = '주문취소'		WHERE CODEVAL1 =  '99' AND CODETYPECD = 'ORDERSTATUSFLAGCD' AND AGENT_ID = '13';

-- 기존 코드 추가건
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BOARD_BORG_TYPE' AND AGENT_ID = '13'),N'BOARD_BORG_TYPE',N'PTO',N'',N'',N'팬타온',N'',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1001',N'FAQ_PTO',N'',N'회원',N'',N'',1001,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1002',N'FAQ_PTO',N'',N'상품',N'',N'',1002,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1003',N'FAQ_PTO',N'',N'주문',N'',N'',1003,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1004',N'FAQ_PTO',N'',N'결제',N'',N'',1004,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1005',N'FAQ_PTO',N'',N'배송',N'',N'',1005,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1006',N'FAQ_PTO',N'',N'취소/반품/교환',N'',N'',1006,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FAQ_TYPE' AND AGENT_ID = '13'),N'FAQ_TYPE',N'1009',N'FAQ_PTO',N'',N'기타',N'',N'',1009,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'RETURNSTATUSFLAG' AND AGENT_ID = '13'),N'RETURNSTATUSFLAG',N'2',N'',N'',N'환불완료',N'',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'ORDERCHANGEMESSAGE' AND AGENT_ID = '13'),N'ORDERCHANGEMESSAGE',N'301',N'',N'',N'[교환] 철회 처리.',N'',N'',301,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'ORDERCHANGEMESSAGE' AND AGENT_ID = '13'),N'ORDERCHANGEMESSAGE',N'302',N'',N'',N'[교환] 요청.',N'',N'',302,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'ORDERCHANGEMESSAGE' AND AGENT_ID = '13'),N'ORDERCHANGEMESSAGE',N'303',N'',N'',N'[교환] 완료 처리.',N'',N'',303,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'ORDERCHANGEMESSAGE' AND AGENT_ID = '13'),N'ORDERCHANGEMESSAGE',N'304',N'',N'',N'[환불] 완료 처리.',N'',N'',304,1,N'13');

SELECT * FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'
select CODETYPECD, count(CODETYPECD) as cnt from SMPCODETYPES where agent_id = '13' group by CODETYPECD having count(CODETYPECD) > 1;

select * from SMPCODETYPES s where codetypecd in ('BID_RESULT', 'BUY_SVC', 'MATERIAL_MANAGE', 'MATERIAL_USED', 'TOSS_CARD');

-- 추가코드 인서트
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'10',N'',N'',N'선정중',N'',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'15',N'',N'',N'자율',N'',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'1',N'',N'',N'1순위',N'',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'2',N'',N'',N'2순위',N'',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'3',N'',N'',N'3순위',N'',N'',5,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'4',N'',N'',N'4순위',N'',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'5',N'',N'',N'5순위',N'',N'',7,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'6',N'',N'',N'6순위',N'',N'',8,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'7',N'',N'',N'7순위',N'',N'',9,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'9',N'',N'',N'미수용',N'',N'',10,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BID_RESULT' AND AGENT_ID = '13'),N'BID_RESULT',N'0',N'',N'',N'-',N'',N'',11,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_MANAGE' AND AGENT_ID = '13'),N'MATERIAL_MANAGE',N'10',N'',N'',N'SKT 전용 (무선)',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_MANAGE' AND AGENT_ID = '13'),N'MATERIAL_MANAGE',N'20',N'',N'',N'SKT 전용 (유선)',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_MANAGE' AND AGENT_ID = '13'),N'MATERIAL_MANAGE',N'30',N'',N'',N'T/B 공용',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_MANAGE' AND AGENT_ID = '13'),N'MATERIAL_MANAGE',N'40',N'',N'',N'SKB 전용',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'10',N'',N'',N'전기',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'11',N'',N'',N'A망',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'12',N'',N'',N'전송망',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'13',N'',N'',N'구축',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'14',N'',N'',N'선로',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'15',N'',N'',N'FTTH',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'16',N'',N'',N'광랜',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'17',N'',N'',N'HFC',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'18',N'',N'',N'개통',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'19',N'',N'',N'CATV',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'20',N'',N'',N'관로',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'MATERIAL_USED' AND AGENT_ID = '13'),N'MATERIAL_USED',N'21',N'',N'',N'HNS',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'3K',N'IBK_BC',N'',N'기업 BC',N'기업비씨',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'46',N'GWANGJUBANK',N'',N'광주은행',N'광주',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'71',N'LOTTE',N'',N'롯데카드',N'롯데',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'30',N'KDBBANK',N'',N'KDB산업은행',N'산업',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'31',N'BC',N'',N'BC카드',N'',N'',5,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'51',N'SAMSUNG',N'',N'삼성카드',N'삼성',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'38',N'SAEMAUL',N'',N'새마을금고',N'새마을',N'',7,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'41',N'SHINHAN',N'',N'신한카드',N'신한',N'',8,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'62',N'SHINHYEOP',N'',N'신협',N'신협',N'',9,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'36',N'CITI',N'',N'씨티카드',N'씨티',N'',10,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'33',N'WOORI',N'',N'우리BC카드(BC 매입)',N'우리',N'',11,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'W1',N'WOORI',N'',N'우리카드(우리 매입)',N'우리',N'',12,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'37',N'POST',N'',N'우체국예금보험',N'우체국',N'',13,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'39',N'SAVINGBANK',N'',N'저축은행중앙회',N'저축',N'',15,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'35',N'JEONBUKBANK',N'',N'전북은행',N'전북',N'',16,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'42',N'JEJUBANK',N'',N'제주은행',N'제주',N'',17,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'15',N'KAKAOBANK',N'',N'카카오뱅크',N'카카오뱅크',N'',18,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'3A',N'KBANK',N'',N'케이뱅크',N'케이뱅크',N'',19,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'24',N'TOSSBANK',N'',N'토스뱅크',N'토스뱅크',N'',20,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'21',N'HANA',N'',N'하나카드',N'하나',N'',21,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'61',N'HYUNDAI',N'',N'현대카드',N'현대',N'',22,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'11',N'KOOKMIN',N'',N'KB국민카드',N'국민',N'',23,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'91',N'NONGHYEOP',N'',N'NH농협카드',N'농협',N'',24,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'CARD_ISSUER' AND AGENT_ID = '13'),N'CARD_ISSUER',N'34',N'SUHYEOP',N'',N'Sh수협은행',N'수협',N'',26,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BUY_SVC' AND AGENT_ID = '13'),N'BUY_SVC',N'OKP',N'',N'',N'OKPLAZA 기본',N'',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BUY_SVC' AND AGENT_ID = '13'),N'BUY_SVC',N'HNS',N'',N'',N'홈앤서비스',N'',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BUY_SVC' AND AGENT_ID = '13'),N'BUY_SVC',N'SAF',N'',N'',N'OKSAFETY',N'',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'BUY_SVC' AND AGENT_ID = '13'),N'BUY_SVC',N'PTO',N'',N'',N'팬타온',N'',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'1',N'',N'',N'아이디변경/재가입목적',N'',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'2',N'',N'',N'회원가입의 실질적인 혜택이 없음',N'',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'3',N'',N'',N'광고성 메일, SMS가 많아짐',N'',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'4',N'',N'',N'배송 및 가격불만, 상품부족',N'',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'5',N'',N'',N'응대 불친절',N'',N'',5,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'6',N'',N'',N'잦은 시스템 에러',N'',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_end_cause' AND AGENT_ID = '13'),N'pto_end_cause',N'7',N'',N'',N'기타',N'',N'',7,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'10',N'',N'',N'회원',N'',N'',10,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'20',N'',N'',N'상품',N'',N'',20,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'30',N'',N'',N'주문',N'',N'',30,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'40',N'',N'',N'결제',N'',N'',40,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'50',N'',N'',N'배송',N'',N'',50,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'60',N'',N'',N'취소/반품/교환',N'',N'',60,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'PTO_REQU_STAT_FLAG' AND AGENT_ID = '13'),N'PTO_REQU_STAT_FLAG',N'90',N'',N'',N'기타',N'',N'',90,1,N'13');


-- 실 반영 시, url 수정
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_BG' AND AGENT_ID = '13'),N'FRONT_BG',N'전자입찰 시스템',N'/assets/images/banner_bid.png',N'https://devebid.okplaza.kr/',N'이미지명',N'Background 이미지 src',N'바로가기 링크',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_BG' AND AGENT_ID = '13'),N'FRONT_BG',N'팬타온 ICT 마켓',N'/assets/images/banner_open.png',N'https://devpantaon.okplaza.kr/',N'이미지명',N'Background 이미지 src',N'바로가기 링크',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_BG' AND AGENT_ID = '13'),N'FRONT_BG',N'SK 통신자재 오픈소싱',N'/assets/images/banner_panta.png',N'/suggest',N'이미지명',N'Background 이미지 src',N'바로가기 링크',0,1,N'13');


INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'3K',N'',N'',N'기업 BC',N'',N'',0,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'46',N'',N'',N'광주은행',N'',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'71',N'',N'',N'롯데카드',N'',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'30',N'',N'',N'KDB산업은행',N'',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'31',N'',N'',N'BC카드',N'',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'51',N'',N'',N'삼성카드',N'',N'',5,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'38',N'',N'',N'새마을금고',N'',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'41',N'',N'',N'신한카드',N'',N'',7,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'62',N'',N'',N'신협',N'',N'',8,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'36',N'',N'',N'씨티카드',N'',N'',9,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'33',N'',N'',N'우리BC카드(BC 매입)',N'',N'',10,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'W1',N'',N'',N'우리카드(우리 매입)',N'',N'',11,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'37',N'',N'',N'우체국예금보험',N'',N'',12,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'39',N'',N'',N'저축은행중앙회',N'',N'',13,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'35',N'',N'',N'전북은행',N'',N'',14,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'42',N'',N'',N'제주은행',N'',N'',15,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'15',N'',N'',N'카카오뱅크',N'',N'',16,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'3A',N'',N'',N'케이뱅크',N'',N'',17,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'24',N'',N'',N'토스뱅크',N'',N'',18,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'21',N'',N'',N'하나카드',N'',N'',19,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'61',N'',N'',N'현대카드',N'',N'',20,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'11',N'',N'',N'KB국민카드',N'',N'',21,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'91',N'',N'',N'NH농협카드',N'',N'',22,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'34',N'',N'',N'Sh수협은행',N'',N'',23,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'6D',N'',N'',N'다이너스 클럽',N'',N'',24,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'4M',N'',N'',N'마스터카드',N'',N'',25,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'3C',N'',N'',N'유니온페이',N'',N'',26,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'7A',N'',N'',N'아메리칸 익스프레스',N'',N'',27,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'4J',N'',N'',N'JCB',N'',N'',28,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'TOSS_CARD' AND AGENT_ID = '13'),N'TOSS_CARD',N'4V',N'',N'',N'VISA',N'',N'',29,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'기본',N'/assets/css/common.css',N'',N'색상',N'CSS 경로',N'',1,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'검정',N'/assets/css/common_black.css    ',N'',N'색상',N'CSS 경로',N'',2,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'파랑',N'/assets/css/common_blue.css',N'',N'색상',N'CSS 경로',N'',3,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'초록',N'/assets/css/common_green.css',N'',N'색상',N'CSS 경로',N'',4,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'주황',N'/assets/css/common_orange.css',N'',N'색상',N'CSS 경로',N'',5,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'FRONT_CSS_COLOR' AND AGENT_ID = '13'),N'FRONT_CSS_COLOR',N'보라',N'/assets/css/common_purple.css',N'',N'색상',N'CSS 경로',N'',6,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'10',N'1',N'',N'다른상품 재주문',N'',N'',10,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'20',N'1',N'',N'상품에 이상 없으나 구매 의사 없어짐',N'',N'',20,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'30',N'1',N'',N'상품이 상세정보와 다름',N'',N'',30,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'40',N'1',N'',N'배송지연',N'',N'',40,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'50',N'1',N'',N'기타',N'',N'',50,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'60',N'2',N'',N'상품에 이상 없으나 구매 의사 없어짐',N'',N'',60,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'70',N'2',N'',N'사이즈, 색상 등 규격을 잘못 선택함',N'',N'',70,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'80',N'2',N'',N'상품이 상세정보와 다름',N'',N'',80,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'90',N'2',N'',N'배송된 상품의 파손/하자/포장불량',N'',N'',90,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'100',N'2',N'',N'다른 상품으로 잘못 배송됨',N'',N'',100,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'110',N'2',N'',N'배송지연',N'',N'',110,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'111',N'2',N'',N'기타',N'',N'',111,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'120',N'3',N'',N'사이즈, 색상 등 규격을 잘못 선택',N'',N'',120,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'130',N'3',N'',N'상품이 상세정보와 다름',N'',N'',130,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'140',N'3',N'',N'배송된 상품의 파손/하자/포장불량',N'',N'',140,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'150',N'3',N'',N'다른 상품으로 잘못 배송됨',N'',N'',150,1,N'13');
INSERT INTO SMPCODES VALUES ((select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b),(SELECT CODETYPEID FROM SMPCODETYPES WHERE CODETYPECD = 'pto_ORDE_reason' AND AGENT_ID = '13'),N'pto_ORDE_reason',N'160',N'3',N'',N'기타',N'',N'',160,1,N'13');

-- 시퀸스 키 업데이트
UPDATE SMP_SEQUENCE SET NEXT_ID = (select max(IIF(a.CODEID > b.CODETYPEID , a.CODEID, b.CODETYPEID))+1 from SMPCODES a, SMPCODETYPES b) WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'

-- smp_site css 컬럼 코드값으로 인서트
INSERT INTO SMP_SITE (SITE_ID, SITE_NM, SITE_DESC, CSS, LOGO_ID, RECOMM_GOODS_YN, SALE_RATE, INSERT_USER_ID, INSERT_DATE, UPDATE_USER_ID, UPDATE_DATE) VALUES ( '0', '팬타온', '팬타온 기본 설정입니다.', 0, 0,'Y', 0, '2', GETDATE(), '2', GETDATE() );
INSERT INTO SMP_SITE VALUES ( '1', 'OK플라자(기본)', 'OK플라자 고객사 기본 설정입니다.', (select codeid from SMPCODES where CODETYPECD = 'FRONT_CSS_COLOR' and SMPCODES.CODEVAL1 = '기본'), 0, 'Y', 0, '2', GETDATE(), '2', GETDATE() ); 


-- 메뉴명 수정
update SMPMENUS set MENUNM = '매입실적조회' where MENUNM = '물류매입실적조회' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set MENUNM = '신규업체선정' where MENUNM = '공급협력사 모집' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set MENUNM = '비회원 업체관리' where MENUNM = '임시회원 업체관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set MENUNM = '견적관리' where MENUNM = '입찰관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set MENUNM = '상품제안현황' where MENUNM = '자재혁신제안현황' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set MENUNM = '주문/배송' where menucd = 'VEN_ORD' and agent_id = '13' and SVCTYPECD = 'VEN';

-- 메뉴 비활성화 및 활성화
update SMPMENUS set isuse = '0' where MENUNM = 'Main전시 상품관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = 'OK Safety 메인전시' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '지정자재관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '자동물량배분관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '추천/연관' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '검색로그관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '1' where MENUNM = 'FAQ 관리' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '설문조사' and agent_id = '13' and SVCTYPECD = 'ADM';
update SMPMENUS set isuse = '0' where MENUNM = '스마일지수' and agent_id = '13' and SVCTYPECD = 'ADM';

-- 공급사 url 및 메뉴명 수정
update SMPMENUS set fwdpath = '/vendor/order/purchase' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ORD_PURC'
update SMPMENUS set fwdpath = '/vendor/order/delivery' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ORD_DELI'
update SMPMENUS set fwdpath = '/vendor/order/orderHist' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ORD_SCH'
update SMPMENUS set fwdpath = '/vendor/order/orderProgress' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ORDER_PROC'
update SMPMENUS set fwdpath = '/vendor/order/orderPrint' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PURC_PRINT'
update SMPMENUS set fwdpath = '/venCart/orderReverse' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_REQ_ORD'
update SMPMENUS set fwdpath = '/vendor/order/logiStock' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_LOGI_STOCK'
update SMPMENUS set fwdpath = '/vendor/receive/venOrdReceStandBy' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_RECE_STANDBY'
update SMPMENUS set fwdpath = '/vendor/receive/venRetOrdProcList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_RECE_RETURN'
update SMPMENUS set fwdpath = '/vendor/receive/venReceHist' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_RECE_HIST'
update SMPMENUS set fwdpath = '/vendor/adjust/vendorEbillList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ACC_TAX'
update SMPMENUS set fwdpath = '/vendor/adjust/vendorAdjustDebtOccur' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_ACC_BOND'
update SMPMENUS set fwdpath = '/vendor/product/list' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PDT_MANAGE'
update SMPMENUS set fwdpath = '/vendor/stock/stockList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PDT_STOCK'
update SMPMENUS set fwdpath = '/vendor/product/requestList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PDT_REQ'
update SMPMENUS set fwdpath = '/vendor/productManage/productSuggest' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PDT_PROPOSAL'
update SMPMENUS set fwdpath = '/vendor/productManage/evaluateApplication' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_EVAL'
update SMPMENUS set fwdpath = '/vendor/product/vendorBidList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_PDT_QUO'
update SMPMENUS set fwdpath = '/vendor/venBoard/venNoticeList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_CS_NOTICE'
update SMPMENUS set fwdpath = '/vendor/venBoard/venQnaList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_CS_Q&A'
update SMPMENUS set fwdpath = '/vendor/venBoard/venFreeList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_CS_FREE'
update SMPMENUS set fwdpath = '/vendor/venBoard/venRepairList' where SVCTYPECD = 'VEN' and AGENT_ID = '13' and MENUCD = 'VEN_CS_REPAIR'


update SMPMENUS set MENUNM = '질의응답' where MENUNM = '고객의소리(Q&A)' and agent_id = '13' and SVCTYPECD = 'VEN';
update SMPMENUS set MENUNM = '신규자재 제안' where menucd = 'VEN_PDT_PROPOSAL' and agent_id = '13' and SVCTYPECD = 'VEN';


-- 메뉴 추가 
-- 첫 데이터는 SMP_SEQUENCE > SEQMP_CORESYSTEM 의 +1 값
-- 고객관리 > 중메뉴
INSERT INTO smpmenus (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select next_id +1 from SMP_SEQUENCE WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'),N'ADM_ORAGN_SITE',N'구매사 사이트관리',(select menuid from SMPMENUS where menucd = 'ADM_ORGAN' and agent_id= '13' and svctypecd= 'ADM'),(select menuid from SMPMENUS where menucd = 'ADM_ORGAN' and agent_id= '13' and svctypecd= 'ADM'),1,224,N'ADM',0,1,N'/menu/organ/organClientSiteManage.sys',N'13');

-- 팬타온 대메뉴
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_PTO',N'팬타온',0,0,0,230,N'ADM',0,1,N'',N'13');
-- 팬타온 중메뉴
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_PTO_SITE',N'사이트관리',(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),1,231,N'ADM',0,1,N'/menu/pantaon/pantaonSiteManage.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_PTO_USER',N'사용자',(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),1,232,N'ADM',0,1,N'/menu/organ/pentaonUserList.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_PTO_PROJECT',N'기획전',(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),1,233,N'ADM',0,1,N'/menu/pantaon/pantaonPlanDispManage.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_PTO_ORDER',N'주문관리',(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),1,234,N'ADM',0,1,N'/menu/order/orderRequest/pentaonOrderList.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'AMD_PTO_RTN',N'펜타온 교환/반품',(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),(select s.MENUID  from SMPMENUS s where s.MENUNM = '팬타온'),1,235,N'ADM',0,1,N'/menu/order/returnOrder/pentaonReturnList.sys',N'13');

--  상품관리 > 중메뉴
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_MGT',N'지정자재 품종관리',(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),1,375,N'ADM',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_BID',N'지정자재 입찰',(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),1,378,N'ADM',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_SALE',N'지정자재 품종 실적',(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),1,381,N'ADM',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_BID',N'전자입찰',(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),(select s.MENUID from SMPMENUS s where s.MENUNM = '상품관리' and agent_id = '13' and MENULEVEL = 0 and SVCTYPECD = 'ADM'),1,399,N'ADM',0,1,N'/productManage/biddingSso',N'13');
-- 상품관리 > 소메뉴
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_SETTING',N'지정자재 품종설정',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종관리' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종관리' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,376,N'ADM',0,1,N'/productManage/productMaterialComp.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_VEN',N'품종 적격/공급 관리',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종관리' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종관리' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,377,N'ADM',0,1,N'/productManage/productMaterialVendor.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MCGOOD_BID',N'지정자재 상품 입찰',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 입찰' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 입찰' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,379,N'ADM',0,1,N'/productManage/productMaterialBid.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_COMP_BID',N'품종 콤포넌트 입찰',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 입찰' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 입찰' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,380,N'ADM',0,1,N'/productManage/productCompntBid.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_MATERIAL_PER_SUM',N'품종 상품 실적집계',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종 실적' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종 실적' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,382,N'ADM',0,1,N'/productManage/productMaterialPerformanceSummary.sys',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'ADM_COMP_PER_SUM',N'품종 콤포넌트 실적집계',(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종 실적' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),(select s.MENUID from SMPMENUS s where s.MENUNM = '지정자재 품종 실적' and agent_id = '13' and MENULEVEL = 1 and SVCTYPECD = 'ADM' and isuse = '1'),2,383,N'ADM',0,1,N'/productManage/productComponentPerformanceSummary.sys',N'13');

-- 구매사
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER',N'주문 관리',0,0,0,100,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_CART',N'장바구니',(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),1,110,N'BUY',0,1,N'/buyCart/cart',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_HIST',N'주문이력조회',(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),1,120,N'BUY',0,1,N'/buyOrder/history',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_STEP',N'주문진척도',(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),1,130,N'BUY',0,1,N'/buyOrder/delivery',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_APP',N'주문승인',(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),1,140,N'BUY',0,1,N'/buyOrder/approval',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_PREPAY_ORDER',N'선입금주문내역',(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),(select menuid from SMPMENUS where menucd = 'N_BUY_ORDER'),1,150,N'BUY',0,1,N'/buyOrder/prepay',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_RECEIVE',N'인수/반품',0,0,0,200,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_RECEIVE',N'상품인수',(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),1,210,N'BUY',0,1,N'/buyReceive/receiveList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ORDER_RETURN',N'반품신청/현황',(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),1,220,N'BUY',0,1,N'/buyReceive/returnList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_RECEIVE_HIST',N'인수이력조회',(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),1,230,N'BUY',0,1,N'/buyReceive/receiveHist',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_SAFE_RECEIVE',N'안전(실적)지급조회',(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),(select menuid from SMPMENUS where menucd = 'N_BUY_RECEIVE'),1,240,N'BUY',0,1,N'/buyReceive/safetyReceiverList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_OFFER',N'상품 관리',0,0,0,300,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_NEW_PRODUCT',N'신규상품요청 현황',(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),1,310,N'BUY',0,1,N'/productManage/newProductReq',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_PRODUCT_SUG',N'자재혁신제안',(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),1,320,N'BUY',0,1,N'/productManage/productSuggest',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_QUALITY',N'품질관리',(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),(select menuid from SMPMENUS where menucd = 'N_BUY_OFFER'),1,330,N'BUY',0,1,N'/productManage/qualityList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_INVENTORY',N'재고/예산',0,0,0,400,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_STOCK_MANAGE',N'재고관리',(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),1,410,N'BUY',0,1,N'/stock/stockManage',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_STOCK_HISTORY',N'재고이력',(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),1,420,N'BUY',0,1,N'/stock/stockHistory',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_STOCK_SURVEY',N'재고조사',(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),1,430,N'BUY',0,1,N'/stock/stockSurveyHns',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_BUDGET_MANAGE',N'예산관리',(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),(select menuid from SMPMENUS where menucd = 'N_BUY_INVENTORY'),1,440,N'BUY',0,1,N'/budget/budgetYearList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_COMM',N'고객센터',0,0,0,500,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_NOTICE',N'공지사항',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,510,N'BUY',0,1,N'/board/noticeList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_QNA',N'고객의소리(Q&A)',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,520,N'BUY',0,1,N'/board/qnaList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_FREE',N'자유게시판',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,530,N'BUY',0,1,N'/board/freeList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_REPAIR',N'시스템장애/개선요청',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,540,N'BUY',0,1,N'/board/repairList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_CONTACT',N'담당자안내',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,550,N'BUY',0,1,N'/board/contact',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_FAQ',N'자주 묻는 질문(FAQ)',(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),(select menuid from SMPMENUS where menucd = 'N_BUY_COMM'),1,560,N'BUY',0,1,N'/board/faqList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM',N'운영관리',0,0,0,600,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BORG',N'조직관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,610,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BORG_BRNCH',N'사업장 관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_BORG'),2,611,N'BUY',0,1,N'/buyOrgan/organBuyList?srcIsUse=1',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BORG_USER',N'사용자관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_BORG'),2,612,N'BUY',0,1,N'/buyOrgan/organBuyUserList?srcIsuse=1',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BORG_HNS',N'HNS조직관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,619,N'BUY',0,1,N'/buyOrgan/hnsBorgList?srcIsuse=1',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_RESULT',N'실적관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,620,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_RESULT_SRC',N'실적조회',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_RESULT'),2,621,N'BUY',0,1,N'/manage/result/search',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_RESULT_BIL',N'세금계산서',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_RESULT'),2,622,N'BUY',0,1,N'/manage/result/ebill',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_RESULT_DEB',N'채무관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_RESULT'),2,623,N'BUY',0,1,N'/manage/result/debt',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_INVENTORY',N'재고 조회',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,630,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_STK_MGE',N'사업장별 재고',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_INVENTORY'),2,631,N'BUY',0,1,N'/manage/stock/stockManage',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_STK_INQ',N'재고조회',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_INVENTORY'),2,632,N'BUY',0,1,N'/manage/stock/stockInquiry',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_STK_TRAN',N'재고이동승인',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_INVENTORY'),2,633,N'BUY',0,1,N'/manage/stock/stockTransfer',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_STK_SUR',N'재고조사이력',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_INVENTORY'),2,634,N'BUY',0,1,N'/manage/stock/stockSurvey',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BUDJET',N'예산운영',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,640,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BUD_MGE',N'예산관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_BUDJET'),2,641,N'BUY',0,1,N'/manage/budget/budgetManage',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_BUD_APP',N'예산승인',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_BUDJET'),2,642,N'BUY',0,1,N'/manage/budget/budgetApproval',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_GOOD',N'상품관리',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,650,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_APP',N'상품승인',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_GOOD'),2,651,N'BUY',0,1,N'/manage/product/approval',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_ADM_DISPLAY',N'상품진열',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM_GOOD'),2,652,N'BUY',0,1,N'/manage/product/display',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_SAF_ADM',N'산업안전보건관리비',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),1,660,N'BUY',0,1,N'',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_SAF_MGMT',N'산업안전보건관리비',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_SAF_ADM'),2,661,N'BUY',0,1,N'/safe/safetyMgmtList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_SAF_MGMT_MTH',N'산업안전보건관리비 월별 사용내역',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_SAF_ADM'),2,662,N'BUY',0,1,N'/safe/mgmtResultList',N'13');
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'N_BUY_SAF_SKB_MTH',N'SKB 산업안전보건관리비 월별 사용내역',(select menuid from SMPMENUS where menucd = 'N_BUY_ADM'),(select menuid from SMPMENUS where menucd = 'N_BUY_SAF_ADM'),2,663,N'BUY',0,1,N'/safe/skbMgmtResultList',N'13');

-- 공급사
INSERT INTO SMPMENUS (MENUID,MENUCD,MENUNM,TOPMENUID,PARMENUID,MENULEVEL,DISORDER,SVCTYPECD,ISFIXED,ISUSE,FWDPATH,AGENT_ID) VALUES ((select max(s.menuid) + 1 from SMPMENUS s),N'VEN_PDT_QUO',N'견적',(select menuid from smpmenus where menucd= 'VEN_PDT' and agent_id = '13'),(select menuid from smpmenus where menucd= 'VEN_PDT' and agent_id = '13'),1,1441,N'VEN',0,1,N'/vendor/product/vendorBidList',N'13');


-- 마지막에 시퀸스값 수정
UPDATE SMP_SEQUENCE SET NEXT_ID = (select max(s.menuid) + 1 from SMPMENUS s) WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'

-- 메뉴별 화면권한 추가
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_ORAGN_SITE'), '1', 'ADM_ORAGN_SITE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_ORAGN_SITE'), '2', 'ADM_ORAGN_SITE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO'), '1', 'ADM_PTO', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO'), '2', 'ADM_PTO', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_SITE'), '1', 'ADM_PTO_SITE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_SITE'), '2', 'ADM_PTO_SITE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_USER'), '1', 'ADM_PTO_USER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_USER'), '2', 'ADM_PTO_USER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_PROJECT'), '1', 'ADM_PTO_PROJECT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_PROJECT'), '2', 'ADM_PTO_PROJECT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_ORDER'), '1', 'ADM_PTO_ORDER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_PTO_ORDER'), '2', 'ADM_PTO_ORDER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'AMD_PTO_RTN'), '1', 'AMD_PTO_RTN', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'AMD_PTO_RTN'), '2', 'AMD_PTO_RTN', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_MGT'), '1', 'ADM_MATERIAL_MGT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_MGT'), '2', 'ADM_MATERIAL_MGT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_BID'), '1', 'ADM_MATERIAL_BID', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_BID'), '2', 'ADM_MATERIAL_BID', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_SALE'), '1', 'ADM_MATERIAL_SALE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_SALE'), '2', 'ADM_MATERIAL_SALE', 'COMM_SAVE','13');



INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_BID'), '1', 'ADM_BID', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_BID'), '2', 'ADM_BID', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_SETTING'), '1', 'ADM_MATERIAL_SETTING', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_SETTING'), '2', 'ADM_MATERIAL_SETTING', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_VEN'), '1', 'ADM_MATERIAL_VEN', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_VEN'), '2', 'ADM_MATERIAL_VEN', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MCGOOD_BID'), '1', 'ADM_MCGOOD_BID', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MCGOOD_BID'), '2', 'ADM_MCGOOD_BID', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_COMP_BID'), '1', 'ADM_COMP_BID', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_COMP_BID'), '2', 'ADM_COMP_BID', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_PER_SUM'), '1', 'ADM_MATERIAL_PER_SUM', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_MATERIAL_PER_SUM'), '2', 'ADM_MATERIAL_PER_SUM', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_COMP_PER_SUM'), '1', 'ADM_COMP_PER_SUM', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'ADM_COMP_PER_SUM'), '2', 'ADM_COMP_PER_SUM', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER'), '1', 'N_BUY_ORDER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER'), '2', 'N_BUY_ORDER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_CART'), '1', 'N_BUY_ORDER_CART', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_CART'), '2', 'N_BUY_ORDER_CART', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_HIST'), '1', 'N_BUY_ORDER_HIST', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_HIST'), '2', 'N_BUY_ORDER_HIST', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_STEP'), '1', 'N_BUY_ORDER_STEP', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_STEP'), '2', 'N_BUY_ORDER_STEP', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_APP'), '1', 'N_BUY_ORDER_APP', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_APP'), '2', 'N_BUY_ORDER_APP', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_PREPAY_ORDER'), '1', 'N_BUY_PREPAY_ORDER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_PREPAY_ORDER'), '2', 'N_BUY_PREPAY_ORDER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_RECEIVE'), '1', 'N_BUY_RECEIVE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_RECEIVE'), '2', 'N_BUY_RECEIVE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_RECEIVE'), '1', 'N_BUY_ORDER_RECEIVE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_RECEIVE'), '2', 'N_BUY_ORDER_RECEIVE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_RETURN'), '1', 'N_BUY_ORDER_RETURN', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ORDER_RETURN'), '2', 'N_BUY_ORDER_RETURN', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_RECEIVE_HIST'), '1', 'N_BUY_RECEIVE_HIST', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_RECEIVE_HIST'), '2', 'N_BUY_RECEIVE_HIST', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAFE_RECEIVE'), '1', 'N_BUY_SAFE_RECEIVE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAFE_RECEIVE'), '2', 'N_BUY_SAFE_RECEIVE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_OFFER'), '1', 'N_BUY_OFFER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_OFFER'), '2', 'N_BUY_OFFER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_NEW_PRODUCT'), '1', 'N_BUY_NEW_PRODUCT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_NEW_PRODUCT'), '2', 'N_BUY_NEW_PRODUCT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_PRODUCT_SUG'), '1', 'N_BUY_PRODUCT_SUG', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_PRODUCT_SUG'), '2', 'N_BUY_PRODUCT_SUG', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_QUALITY'), '1', 'N_BUY_QUALITY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_QUALITY'), '2', 'N_BUY_QUALITY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_INVENTORY'), '1', 'N_BUY_INVENTORY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_INVENTORY'), '2', 'N_BUY_INVENTORY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_MANAGE'), '1', 'N_BUY_STOCK_MANAGE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_MANAGE'), '2', 'N_BUY_STOCK_MANAGE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_HISTORY'), '1', 'N_BUY_STOCK_HISTORY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_HISTORY'), '2', 'N_BUY_STOCK_HISTORY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_SURVEY'), '1', 'N_BUY_STOCK_SURVEY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_STOCK_SURVEY'), '2', 'N_BUY_STOCK_SURVEY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_BUDGET_MANAGE'), '1', 'N_BUY_BUDGET_MANAGE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_BUDGET_MANAGE'), '2', 'N_BUY_BUDGET_MANAGE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_COMM'), '1', 'N_BUY_COMM', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_COMM'), '2', 'N_BUY_COMM', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_NOTICE'), '1', 'N_BUY_NOTICE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_NOTICE'), '2', 'N_BUY_NOTICE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_QNA'), '1', 'N_BUY_QNA', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_QNA'), '2', 'N_BUY_QNA', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_FREE'), '1', 'N_BUY_FREE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_FREE'), '2', 'N_BUY_FREE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_REPAIR'), '1', 'N_BUY_REPAIR', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_REPAIR'), '2', 'N_BUY_REPAIR', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_CONTACT'), '1', 'N_BUY_CONTACT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_CONTACT'), '2', 'N_BUY_CONTACT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_FAQ'), '1', 'N_BUY_FAQ', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_FAQ'), '2', 'N_BUY_FAQ', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM'), '1', 'N_BUY_ADM', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM'), '2', 'N_BUY_ADM', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG'), '1', 'N_BUY_ADM_BORG', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG'), '2', 'N_BUY_ADM_BORG', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_BRNCH'), '1', 'N_BUY_ADM_BORG_BRNCH', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_BRNCH'), '2', 'N_BUY_ADM_BORG_BRNCH', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_USER'), '1', 'N_BUY_ADM_BORG_USER', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_USER'), '2', 'N_BUY_ADM_BORG_USER', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_HNS'), '1', 'N_BUY_ADM_BORG_HNS', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BORG_HNS'), '2', 'N_BUY_ADM_BORG_HNS', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT'), '1', 'N_BUY_ADM_RESULT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT'), '2', 'N_BUY_ADM_RESULT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_SRC'), '1', 'N_BUY_ADM_RESULT_SRC', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_SRC'), '2', 'N_BUY_ADM_RESULT_SRC', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_BIL'), '1', 'N_BUY_ADM_RESULT_BIL', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_BIL'), '2', 'N_BUY_ADM_RESULT_BIL', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_DEB'), '1', 'N_BUY_ADM_RESULT_DEB', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_RESULT_DEB'), '2', 'N_BUY_ADM_RESULT_DEB', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_INVENTORY'), '1', 'N_BUY_ADM_INVENTORY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_INVENTORY'), '2', 'N_BUY_ADM_INVENTORY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_MGE'), '1', 'N_BUY_ADM_STK_MGE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_MGE'), '2', 'N_BUY_ADM_STK_MGE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_INQ'), '1', 'N_BUY_ADM_STK_INQ', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_INQ'), '2', 'N_BUY_ADM_STK_INQ', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_TRAN'), '1', 'N_BUY_ADM_STK_TRAN', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_TRAN'), '2', 'N_BUY_ADM_STK_TRAN', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_SUR'), '1', 'N_BUY_ADM_STK_SUR', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_STK_SUR'), '2', 'N_BUY_ADM_STK_SUR', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUDJET'), '1', 'N_BUY_ADM_BUDJET', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUDJET'), '2', 'N_BUY_ADM_BUDJET', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUD_MGE'), '1', 'N_BUY_ADM_BUD_MGE', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUD_MGE'), '2', 'N_BUY_ADM_BUD_MGE', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUD_APP'), '1', 'N_BUY_ADM_BUD_APP', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_BUD_APP'), '2', 'N_BUY_ADM_BUD_APP', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_GOOD'), '1', 'N_BUY_ADM_GOOD', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_GOOD'), '2', 'N_BUY_ADM_GOOD', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_APP'), '1', 'N_BUY_ADM_APP', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_APP'), '2', 'N_BUY_ADM_APP', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_DISPLAY'), '1', 'N_BUY_ADM_DISPLAY', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_ADM_DISPLAY'), '2', 'N_BUY_ADM_DISPLAY', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_ADM'), '1', 'N_BUY_SAF_ADM', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_ADM'), '2', 'N_BUY_SAF_ADM', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_MGMT'), '1', 'N_BUY_SAF_MGMT', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_MGMT'), '2', 'N_BUY_SAF_MGMT', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_MGMT_MTH'), '1', 'N_BUY_SAF_MGMT_MTH', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_MGMT_MTH'), '2', 'N_BUY_SAF_MGMT_MTH', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_SKB_MTH'), '1', 'N_BUY_SAF_SKB_MTH', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'N_BUY_SAF_SKB_MTH'), '2', 'N_BUY_SAF_SKB_MTH', 'COMM_SAVE','13');

INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'VEN_PDT_QUO'), '1', 'VEN_PDT_QUO', 'COMM_READ','13');
INSERT INTO SMPMENUS_ACTIVITIES	(MENUID, ACTIVITYID, MENUCD, ACTIVITYCD, AGENT_ID ) VALUES ((select menuid from smpmenus where menucd = 'VEN_PDT_QUO'), '2', 'VEN_PDT_QUO', 'COMM_SAVE','13');




-- 영역 저장
--첫 저장값은 SMP_SEQUENCE > SEQMP_CORESYSTEM 의 +1 값
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select next_id +1 from SMP_SEQUENCE WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'),N'N_BUY_NHS_GRP',N'HNS 그룹 관리',N'HNS 그룹 관리자',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_SAF_SKB',N'안전몰 SKB 일반',N'',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_SAF_CLT',N'안전몰 SKB 관리',N'안전몰 SKB 관리',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_SAF_CON',N'안전몰 도급사',N'안전몰 도급사',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_SAF_GEN',N'안전몰 일반',N'안전몰 일반',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_HNS_CLT',N'HNS 본사 관리',N'HNS 본사 관리자',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_HNS_GEN',N'HNS 일반',N'HNS 일반',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_CLT',N'구매사 관리',N'구매사 관리자',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'N_BUY_GEN',N'구매사 일반',N'구매사 일반 사용자',1,N'BUY',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'ADM_PTO_SAVE',N'팬타온관리영역',N'팬타온관리영역',1,N'ADM',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'ADM_PTO_READ',N'팬타온읽기영역',N'팬타온읽기영역',1,N'ADM',N'13');
INSERT INTO smpscopes (SCOPEID,SCOPECD,SCOPENM,SCOPEDESC,ISUSE,SVCTYPECD,AGENT_ID) VALUES ((select max(SCOPEID)+ 1 from smpscopes),N'BUY_PENTAON',N'펜타온 사용자 영역',N'펜타온 사용자 영역',1,N'BUY',N'13');

UPDATE SMP_SEQUENCE SET NEXT_ID = (select max(SCOPEID)+ 1 from smpscopes) WHERE TABLE_NAME = 'SEQMP_CORESYSTEM';

-- 영역 화면권한 연결
-- ADM_PTO_READ	팬타온읽기영역
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO'),1,N'ADM_PTO',N'COMM_READ',N'ADM_PTO_READ',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_USER'),1,N'ADM_PTO_USER',N'COMM_READ',N'ADM_PTO_READ',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_SITE'),1,N'ADM_PTO_SITE',N'COMM_READ',N'ADM_PTO_READ',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_PROJECT'),1,N'ADM_PTO_PROJECT',N'COMM_READ',N'ADM_PTO_READ',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_ORDER'),1,N'ADM_PTO_ORDER',N'COMM_READ',N'ADM_PTO_READ',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'AMD_PTO_RTN'),1,N'AMD_PTO_RTN',N'COMM_READ',N'ADM_PTO_READ',N'13');

-- ADM_PTO_SAVE	팬타온관리영역
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'AMD_PTO_RTN'),2,N'AMD_PTO_RTN',N'COMM_SAVE',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'AMD_PTO_RTN'),1,N'AMD_PTO_RTN',N'COMM_READ',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_ORDER'),2,N'ADM_PTO_ORDER',N'COMM_SAVE',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_ORDER'),1,N'ADM_PTO_ORDER',N'COMM_READ',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_PROJECT'),2,N'ADM_PTO_PROJECT',N'COMM_SAVE',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_PROJECT'),1,N'ADM_PTO_PROJECT',N'COMM_READ',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_SITE'),2,N'ADM_PTO_SITE',N'COMM_SAVE',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_SITE'),1,N'ADM_PTO_SITE',N'COMM_READ',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_USER'),2,N'ADM_PTO_USER',N'COMM_SAVE',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO_USER'),1,N'ADM_PTO_USER',N'COMM_READ',N'ADM_PTO_SAVE',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'ADM_PTO'),1,N'ADM_PTO',N'COMM_READ',N'ADM_PTO_SAVE',N'13');

-- N_BUY_GEN	구매사 일반
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_GEN',N'13');


-- N_BUY_CLT	구매사 관리
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),1,N'N_BUY_ADM_BUD_MGE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),2,N'N_BUY_ADM_BUD_MGE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),1,N'N_BUY_ADM_BORG_USER',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),2,N'N_BUY_ADM_BORG_USER',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),2,N'N_BUY_NOTICE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),1,N'N_BUY_ADM_BORG_BRNCH',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),2,N'N_BUY_ADM_BORG_BRNCH',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),1,N'N_BUY_ADM_BORG',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),2,N'N_BUY_ADM_BORG',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_CLT',N'13');

-- N_BUY_HNS_GEN	HNS 일반
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),1,N'N_BUY_STOCK_SURVEY',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),2,N'N_BUY_STOCK_SURVEY',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),1,N'N_BUY_STOCK_HISTORY',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),2,N'N_BUY_STOCK_HISTORY',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),1,N'N_BUY_SAFE_RECEIVE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),2,N'N_BUY_SAFE_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_HNS_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_HNS_GEN',N'13');



-- N_BUY_HNS_CLT	HNS 본사 관리
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_DISPLAY'),1,N'N_BUY_ADM_DISPLAY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_DISPLAY'),2,N'N_BUY_ADM_DISPLAY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_APP'),1,N'N_BUY_ADM_APP',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_APP'),2,N'N_BUY_ADM_APP',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),1,N'N_BUY_ADM_BUD_MGE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),2,N'N_BUY_ADM_BUD_MGE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_SUR'),1,N'N_BUY_ADM_STK_SUR',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_SUR'),2,N'N_BUY_ADM_STK_SUR',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),1,N'N_BUY_STOCK_SURVEY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),2,N'N_BUY_STOCK_SURVEY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),1,N'N_BUY_STOCK_HISTORY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),2,N'N_BUY_STOCK_HISTORY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),1,N'N_BUY_SAFE_RECEIVE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),2,N'N_BUY_SAFE_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_HNS'),1,N'N_BUY_ADM_BORG_HNS',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_HNS'),2,N'N_BUY_ADM_BORG_HNS',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),2,N'N_BUY_NOTICE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),1,N'N_BUY_ADM_GOOD',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),2,N'N_BUY_ADM_GOOD',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_HNS_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_HNS_CLT',N'13');

-- N_BUY_SAF_GEN	안전몰 일반
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),1,N'N_BUY_ADM_BUD_MGE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),2,N'N_BUY_ADM_BUD_MGE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),1,N'N_BUY_ADM_BORG_USER',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT_MTH'),1,N'N_BUY_SAF_MGMT_MTH',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT_MTH'),2,N'N_BUY_SAF_MGMT_MTH',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT'),1,N'N_BUY_SAF_MGMT',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT'),2,N'N_BUY_SAF_MGMT',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),1,N'N_BUY_SAF_ADM',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),2,N'N_BUY_SAF_ADM',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),1,N'N_BUY_ADM_BORG_BRNCH',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),1,N'N_BUY_ADM_BORG',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_SAF_GEN',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_GEN',N'13');

-- N_BUY_SAF_CON	안전몰 도급사
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),1,N'N_BUY_ADM_BUD_MGE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),2,N'N_BUY_ADM_BUD_MGE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),1,N'N_BUY_ADM_BORG_USER',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),2,N'N_BUY_ADM_BORG_USER',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT_MTH'),1,N'N_BUY_SAF_MGMT_MTH',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT_MTH'),2,N'N_BUY_SAF_MGMT_MTH',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT'),1,N'N_BUY_SAF_MGMT',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT'),2,N'N_BUY_SAF_MGMT',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),1,N'N_BUY_SAF_ADM',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),2,N'N_BUY_SAF_ADM',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),1,N'N_BUY_ADM_BORG_BRNCH',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),2,N'N_BUY_ADM_BORG_BRNCH',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),1,N'N_BUY_ADM_BORG',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),2,N'N_BUY_ADM_BORG',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_SAF_CON',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_CON',N'13');


-- N_BUY_SAF_CLT	안전몰 SKB 관리
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_APP'),1,N'N_BUY_ADM_APP',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_APP'),2,N'N_BUY_ADM_APP',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),1,N'N_BUY_ADM_BUD_MGE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_MGE'),2,N'N_BUY_ADM_BUD_MGE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),1,N'N_BUY_ADM_BORG_USER',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_USER'),2,N'N_BUY_ADM_BORG_USER',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_SKB_MTH'),1,N'N_BUY_SAF_SKB_MTH',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_MGMT_MTH'),1,N'N_BUY_SAF_MGMT_MTH',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),1,N'N_BUY_SAF_ADM',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAF_ADM'),2,N'N_BUY_SAF_ADM',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),1,N'N_BUY_ADM_GOOD',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),2,N'N_BUY_ADM_GOOD',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),1,N'N_BUY_ADM_BORG_BRNCH',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_BRNCH'),2,N'N_BUY_ADM_BORG_BRNCH',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),1,N'N_BUY_ADM_BORG',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG'),2,N'N_BUY_ADM_BORG',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_SAF_CLT',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_CLT',N'13');


-- N_BUY_NHS_GRP	HNS 그룹 관리
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),1,N'N_BUY_ADM_RESULT_DEB',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_DEB'),2,N'N_BUY_ADM_RESULT_DEB',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),1,N'N_BUY_ADM_RESULT_BIL',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_BIL'),2,N'N_BUY_ADM_RESULT_BIL',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),1,N'N_BUY_ADM_RESULT_SRC',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT_SRC'),2,N'N_BUY_ADM_RESULT_SRC',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),1,N'N_BUY_ADM_BUD_APP',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUD_APP'),2,N'N_BUY_ADM_BUD_APP',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_TRAN'),1,N'N_BUY_ADM_STK_TRAN',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_TRAN'),2,N'N_BUY_ADM_STK_TRAN',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),1,N'N_BUY_ADM_STK_INQ',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_INQ'),2,N'N_BUY_ADM_STK_INQ',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),1,N'N_BUY_ADM_STK_MGE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_STK_MGE'),2,N'N_BUY_ADM_STK_MGE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),1,N'N_BUY_STOCK_SURVEY',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_SURVEY'),2,N'N_BUY_STOCK_SURVEY',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),1,N'N_BUY_STOCK_HISTORY',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_HISTORY'),2,N'N_BUY_STOCK_HISTORY',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),1,N'N_BUY_SAFE_RECEIVE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_SAFE_RECEIVE'),2,N'N_BUY_SAFE_RECEIVE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_HNS'),1,N'N_BUY_ADM_BORG_HNS',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BORG_HNS'),2,N'N_BUY_ADM_BORG_HNS',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_NOTICE'),2,N'N_BUY_NOTICE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),1,N'N_BUY_ADM_GOOD',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_GOOD'),2,N'N_BUY_ADM_GOOD',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),1,N'N_BUY_ADM_BUDJET',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_BUDJET'),2,N'N_BUY_ADM_BUDJET',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),1,N'N_BUY_ADM_INVENTORY',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_INVENTORY'),2,N'N_BUY_ADM_INVENTORY',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),1,N'N_BUY_ADM_RESULT',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM_RESULT'),2,N'N_BUY_ADM_RESULT',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),1,N'N_BUY_ADM',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ADM'),2,N'N_BUY_ADM',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_NHS_GRP',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD =  'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_NHS_GRP',N'13');


-- N_BUY_SAF_SKB	안전몰 SKB 일반
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_FAQ'),1,N'N_BUY_FAQ',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_FAQ'),2,N'N_BUY_FAQ',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_BUDGET_MANAGE'),1,N'N_BUY_BUDGET_MANAGE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_BUDGET_MANAGE'),2,N'N_BUY_BUDGET_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_STOCK_MANAGE'),1,N'N_BUY_STOCK_MANAGE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_STOCK_MANAGE'),2,N'N_BUY_STOCK_MANAGE',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_QUALITY'),1,N'N_BUY_QUALITY',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_QUALITY'),2,N'N_BUY_QUALITY',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_PRODUCT_SUG'),1,N'N_BUY_PRODUCT_SUG',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_PRODUCT_SUG'),2,N'N_BUY_PRODUCT_SUG',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_NEW_PRODUCT'),1,N'N_BUY_NEW_PRODUCT',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_NEW_PRODUCT'),2,N'N_BUY_NEW_PRODUCT',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_FREE'),1,N'N_BUY_FREE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_FREE'),2,N'N_BUY_FREE',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_REPAIR'),1,N'N_BUY_REPAIR',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_REPAIR'),2,N'N_BUY_REPAIR',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_RECEIVE_HIST'),1,N'N_BUY_RECEIVE_HIST',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_RECEIVE_HIST'),2,N'N_BUY_RECEIVE_HIST',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_RETURN'),1,N'N_BUY_ORDER_RETURN',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_RETURN'),2,N'N_BUY_ORDER_RETURN',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_RECEIVE'),1,N'N_BUY_ORDER_RECEIVE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_RECEIVE'),2,N'N_BUY_ORDER_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_QNA'),1,N'N_BUY_QNA',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_QNA'),2,N'N_BUY_QNA',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_PREPAY_ORDER'),1,N'N_BUY_PREPAY_ORDER',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_PREPAY_ORDER'),2,N'N_BUY_PREPAY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_APP'),1,N'N_BUY_ORDER_APP',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_APP'),2,N'N_BUY_ORDER_APP',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_STEP'),1,N'N_BUY_ORDER_STEP',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_STEP'),2,N'N_BUY_ORDER_STEP',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_HIST'),1,N'N_BUY_ORDER_HIST',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_HIST'),2,N'N_BUY_ORDER_HIST',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_CONTACT'),1,N'N_BUY_CONTACT',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_NOTICE'),1,N'N_BUY_NOTICE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_CART'),1,N'N_BUY_ORDER_CART',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER_CART'),2,N'N_BUY_ORDER_CART',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_COMM'),1,N'N_BUY_COMM',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_INVENTORY'),1,N'N_BUY_INVENTORY',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_INVENTORY'),2,N'N_BUY_INVENTORY',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_OFFER'),1,N'N_BUY_OFFER',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_OFFER'),2,N'N_BUY_OFFER',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_RECEIVE'),1,N'N_BUY_RECEIVE',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_RECEIVE'),2,N'N_BUY_RECEIVE',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER'),1,N'N_BUY_ORDER',N'COMM_READ',N'N_BUY_SAF_SKB',N'13');
INSERT INTO SMPSCOPES_ACTIVITIES (SCOPEID,MENUID,ACTIVITYID,MENUCD,ACTIVITYCD,SCOPECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(SELECT MENUID FROM SMPMENUS WITH(NOLOCK) WHERE MENUCD = 'N_BUY_ORDER'),2,N'N_BUY_ORDER',N'COMM_SAVE',N'N_BUY_SAF_SKB',N'13');

-- 권한 추가
INSERT INTO SMPROLES (ROLEID,ROLECD,ROLENM,ROLEDESC,BORGSCOPECD,SVCTYPECD,ISUSE,INITISROLE,INITBORGSCOPECD,AGENT_ID) VALUES ((select next_id +1 from SMP_SEQUENCE WHERE TABLE_NAME = 'SEQMP_CORESYSTEM'),N'BUY_PENTAON',N'펜타온 사용자권한',N'펜타온 사용자 권한',N'BUY',N'BUY',1,0,N'1000',N'13');

UPDATE SMP_SEQUENCE SET NEXT_ID = (select max(ROLEID)+ 1 from SMPROLES) WHERE TABLE_NAME = 'SEQMP_CORESYSTEM';

-- 권한 수정
UPDATE smproles set isuse = 0 where svctypecd = 'BUY' and isuse = 1 and agent_id = '13' and ROLECD not in ('BUY_CLT', 'BUY_GEN', 'BUY_HNS_GEN', 'BUY_HNS_MST', 'BUY_HNS_MST2', 'SAF_USER', 'SAF_CON', 'SAF_SKB_GEN', 'SAF_SKB', 'BUY_PENTAON');

-- 권한-영역 추가
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'BUY_PENTAON'),(select roleid from SMPROLES where rolecd = 'BUY_PENTAON'),N'21538',N'BUY_PENTAON',N'13');

-- 기존 권한-영역 수정
delete SMPROLES_SCOPES where ROLECD = 'BUY_CLT' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),(select roleid from smproles where rolecd = 'BUY_CLT' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_CLT'),N'BUY_CLT',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'BUY_GEN' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),(select roleid from smproles where rolecd = 'BUY_GEN' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_GEN'),N'BUY_GEN',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'BUY_HNS_GEN' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),(select roleid from smproles where rolecd = 'BUY_HNS_GEN' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_HNS_GEN'),N'BUY_HNS_GEN',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'BUY_HNS_MST' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),(select roleid from smproles where rolecd = 'BUY_HNS_MST' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_HNS_CLT'),N'BUY_HNS_MST',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'BUY_HNS_MST2' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),(select roleid from smproles where rolecd = 'BUY_HNS_MST2' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_NHS_GRP'),N'BUY_HNS_MST2',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'SAF_USER' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),(select roleid from smproles where rolecd = 'SAF_USER' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_SAF_GEN'),N'SAF_USER',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'SAF_CON' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),(select roleid from smproles where rolecd = 'SAF_CON' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CON'),N'SAF_CON',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'SAF_SKB_GEN' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),(select roleid from smproles where rolecd = 'SAF_SKB_GEN' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_SAF_SKB'),N'SAF_SKB_GEN',N'13'); 

delete SMPROLES_SCOPES where ROLECD = 'SAF_SKB' and agent_id = '13' ;
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),(select roleid from smproles where rolecd = 'SAF_SKB' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'N_BUY_SAF_CLT'),N'SAF_SKB',N'13'); 

-- 운영사 > 파워운영자에 팬타온관리, 읽기영역 추가
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),(select roleid from smproles where rolecd = 'MRO_ADMIN002' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'ADM_PTO_SAVE'),N'MRO_ADMIN002',N'13');
INSERT INTO SMPROLES_SCOPES (SCOPEID,ROLEID,SCOPECD,ROLECD,AGENT_ID) VALUES ((select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),(select roleid from smproles where rolecd = 'MRO_ADMIN002' and agent_id = '13'),(select scopeid from smpscopes where scopecd = 'ADM_PTO_READ'),N'MRO_ADMIN002',N'13');
---------------------------------------------------------------------------------------------------
CREATE TABLE SMP_TEMPLATE_MNG (
	TEMPLATE_CD varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SEND_TYPE varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	SEND_SVC varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	TITLE varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	CONTENTS varchar(4000) COLLATE Korean_Wansung_CI_AS NULL,
	DESCRIPTION varchar(4000) COLLATE Korean_Wansung_CI_AS NULL,
	INSERT_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	INSERT_DATE datetime NULL,
	UPDATE_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	UPDATE_DATE datetime NULL,
	CONSTRAINT SMP_TEMPLATE_MNG_PK PRIMARY KEY (TEMPLATE_CD)
);

INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza001',N'KKO',N'OKP',N'물량배분 주문요청 시',N'[#{svcName}] [#{branchNm}]의 [#{goodName}] 물량배분주문 요청이 왔습니다.',N'주문사업장 공사유형 담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza005',N'KKO',N'OKP',N'주문취소 요청',N'[#{svcName}] 주문번호 [#{ordeIdenNumb}-#{ordeSequNumb}] 의 주문취소 요청이 있습니다. 미 확인 처리시에는 10일이후 자동취소처리됩니다.',N'주문 공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza009',N'KKO',N'OKP',N'인수처리 시',N'[#{svcName}] [#{branchNm}]에서 인수확인 하였습니다.',N'주문 공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza014',N'KKO',N'OKP',N'주문변경 시',N'[#{svcName}] 주문번호 #{ordeIdenNumb}-#{ordeSequNumb}의 #{orderInfo}가 변경 되었으니 OK plaza에서 반드시 확인 바랍니다.',N'주문 공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza018',N'KKO',N'OKP',N'공급사 주문접수 거부',N'[#{svcName}] 공급사 [#{vendorNm}] 에서 [#{ordeIdenNumb}-#{ordeSequNumb}]를 주문 접수 거부 하였습니다.',N'주문사업장 공사유형 담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza019',N'KKO',N'OKP',N'반품요청 시',N'[#{svcName}] 주문번호 #{ordeIdenNumb}-#{ordeSequNumb}의 반품요청이 왔습니다.',N'주문 공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza022',N'KKO',N'OKP',N'반품철회 시',N'[#{svcName}] 주문번호 [#{ordeIdenNumb}-#{ordeSequNumb}]의 반품요청이 철회되었습니다.',N'주문 공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza029',N'KKO',N'OKP',N'여신초과 주문 시',N'[#{svcName}] 주문번호 [#{ordeIdenNumb}] 여신초과 주문처리 요청이 왔습니다.',N'운영사 코드관리(BONDS_MANAGER)에 회계담당자로 지정된 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza030',N'KKO',N'OKP',N'공급사 상품등록요청 시',N'[#{svcName}] [#{borgNm}] 공급사 상품등록 요청이 도착하였습니다.',N'운영사 상품담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza036',N'KKO',N'OKP',N'출고접수 > 재고 부족 시 (배송가능수량+입고대기-주문수량) 이 마이너스일 경우(매일 오전 10시 15분)',N'[#{svcName}] WMS(#{borgNm})에 출고 재고 부족한 품목이 #{orderCnt}건 있습니다. 확인 조치해주시길 바랍니다.',N'운영사 상품당당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza037',N'SMS',N'OKP',N'아이디찾기',N'[#{svcName}] 해당 사업자번호로 가입된 아이디는 #{loginId}입니다.',N'제안자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza038',N'SMS',N'OKP',N'비밀번호 초기화',N'[#{svcName}] 초기화된 비밀번호는 #{newPwd}입니다.',N'제안자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza045',N'KKO',N'OKP',N'구매사 상품 주문시',N'[#{svcName}] 자재 재고관리 대상 주문 건이 있습니다. 주문번호: [#{ordeIdenNumb}-#{ordeSequNumb}] 구매사 : [#{borgNm}] 상품명: [#{goodName}] 규격: [#{goodSpec}] 주문자성명: [#{ordeUserName}] 주문자연락처: [#{ordeTeleNumb}]',N'운영사 상품담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza047',N'KKO',N'OKP',N'고객사 질의응답 등록 시',N'[#{svcName}] 질의응답 게시판에 글이 등록 되었습니다.',N'코드 질의유형(REQU_STAT_FLAG) 담당자에게 발송',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza048',N'KKO',N'OKP',N'질의응답 답변 등록',N'[#{svcName}] 등록하신 질의응답 게시판에 답변 글이 등록 되었습니다.',N'질의자에게 발송',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza049',N'KKO',N'OKP',N'법인 등록 요청 시',N'[#{svcName}] [#{clientNm}]에서 구매사 등록을 요청하였습니다',N'코드 (ORGAN_REQ_SMS) 담당자에게 발송',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza050',N'KKO',N'OKP',N'홈앤서비스 재고조사 등록 or 수정 시',N'#{svcName}] 재고조사 승인 요청 건이 있습니다. "HOMS>재고/예산>재고조사"화면에서 확인해 주시길 바랍니다.',N'(As-Is)사업장의 지점장 권한을 가진 사용자에게 발송 => (To-Be) 사업장의 감독관에게 발송',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza053',N'KKO',N'OKP',N'공급사 등록요청 시',N'[#{svcName}] [#{vendorNm}]에서 공급사등록을 요청하였습니다',N'B2B운영자권한(ADM_B2B_MAN)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza054',N'KKO',N'OKP',N'사업장 생성',N'[#{svcName}] 구매사 [#{clientNm}]에서 사업장 [#{borgNm}] 가(이) 생성 되었습니다',N'사업장 공사유형 담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza055',N'SMS',N'OKP',N'잠금 상태 해제',N'[#{svcName}] 사용 계정의 잠금 해제 처리가 완료되었습니다. 새로운 비밀번호는 [#{randPassword}] 입니다',N'잠김해제 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza056',N'KKO',N'OKP',N'신규상품등록 반려',N'[#{svcName}] 신규 등록 요청하신 상품이 반려 처리 되었습니다. 자세한 내용은 상품제안>상품소싱요청>신규상품요청 이력에서 확인해 주시길 바랍니다. (발신자 : #{userNm})',N'신규상품 등록자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza057',N'KKO',N'OKP',N'고객사상품등록요청 시',N'[#{svcName}] [#{borgNm}] 고객사 상품등록요청을 하였습니다.',N'사업장 공사유형 담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza058',N'KKO',N'OKP',N'고객사상품등록요청 기상품 처리',N'[#{svcName}] 신규 등록 요청하신 상품이 등록 처리 되었습니다. 자세한 내용은 상품관리>신규상품요청 에서 확인해 주시길 바랍니다. (발신자 : #{userNm})',N'신규상품 등록자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza059',N'KKO',N'OKP',N'상품 승인 반려 시',N'[#{svcName}] 상품가격변동 요청 건이 반려 되었습니다. #{goodName} (#{good_iden_numb})',N'상품담당자(MCGOOD)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza060',N'KKO',N'OKP',N'홈앤서비스 1단계 상품승인 시',N'[#{svcName}] 상품등록/단가변경 승인요청이 있습니다.',N'HNS_경영지원팀(BRANCHID : 306164)에 속해있고, HNS본사관리자 권한을 가진 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza061',N'KKO',N'OKP',N'홈앤서비스 상품승인 반려 시',N'[#{svcName}] #{appType} 요청 건이 반려 되었습니다. #{goodName} (#{goodIdenNumb})',N'상품담당자(MCGOOD)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza063',N'KKO',N'OKP',N'HOMS 미승인 주문 스케줄',N'[#{svcName}] 승인처리 대상이 있습니다.',N'HNS 주문 미승인자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza064',N'KKO',N'OKP',N'홈앤서비스 미 인수 주문건 스케줄',N'[#{svcName}] #{branchNm}에 미 인수 주문 #{noReceiveCnt}건이 있습니다.',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza069',N'KKO',N'OKP',N'예산 증액 요청 시',N'[#{svcName}] #{branchNm} 센터에서 예산 증액이 신청되었습니다.',N'해당 사업장(지점) 또는 상위 사업장(센터)의 본사관리자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza070',N'SMS',N'OKP',N'로그인 인증번호',N'[#{svcName}] 로그인 인증번호는 [#{authNumber}] 입니다',N'로그인 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza071',N'SMS',N'OKP',N'비번 오류 10회이상 계정 잠금 시',N'[#{svcName}] #{loginId} 계정이 잠금처리 되었습니다.',N'로그인 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza072-1',N'SMS',N'OKP',N'아이디 분실 시',N'[#{svcName}] 요청하신 로그인 아이디는 [#{loginid}] 입니다',N'로그인 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza072-2',N'SMS',N'OKP',N'비밀번호 분실 시',N'[#{svcName}] 요청하신 로그인 비밀번호는 [#{randPassword}] 입니다',N'로그인 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza073',N'KKO',N'OKP',N'선입금시 주문자에게 SMS 발송',N'[#{svcName}] 주문하신 건 ...에 대한 ...원을 선입금하여 주시길 바랍니다.',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza074',N'KKO',N'OKP',N'승인 요청 상태인 경우 감독관에게 SMS 발송',N'[#{svcName}] 주문번호 [#{ordeIdenNumb}] 건에 대한 주문 승인 요청이 왔습니다. 고객사명 : [#{branchNm}] 상품명 : [#{goodName}]',N'감독관',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza076',N'KKO',N'OKP',N'출하 시 (일반)',N'[#{svcName}] [#{vendorNm}]에서 [#{orde_iden_numb}-#{orde_sequ_numb}], [#{good_name} 상품]에 대하여 배송처리 하였습니다. * #{vendorNm} 배송 문의: #{phonenum}, 송장번호: #{deli_invo_iden}',N'인수자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza081',N'KKO',N'OKP',N'발주거부 시',N'[#{svcName}] 공급사 [#{vendorNm}] 에서 [#{orde_iden_numb}-#{orde_sequ_numb}]를 주문 접수 거부 하였습니다.',N'인수자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza082',N'KKO',N'OKP',N'주문접수 시',N'[#{svcName}] [#{vendorNm}]에서 [#{orde_iden_numb}-#{orde_sequ_numb}], [#{goodName}]에 대하여 #{deliDate}에 납품 예정입니다. * #{vendorNm} 배송 문의 : #{vendorPhone}',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza083',N'KKO',N'OKP',N'반품승인 시',N'[#{svcName}] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 반품요청이 승인 되었습니다.',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza084',N'KKO',N'OKP',N'반품거부 시',N'[#{svcName}] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 반품요청이 거부 되었습니다.',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza085',N'KKO',N'OKP',N'출하후 4일이 지난 줄하주문',N'[#{svcName}] 인수대상 주문이 존재합니다. 해당 주문은 3일후 자동인수처리됩니다',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza092',N'KKO',N'OKP',N'공급사 상품 등록 요청 미응답',N'[#{svcName}] 처리하지 못한 공급사 상품등록 목록이 있습니다.',N'요청상품 운영사담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza093',N'KKO',N'OKP',N'구매사 상품 등록 요청 미응답',N'[#{svcName}] 처리하지 못한 고객사 상품등록 목록이 있습니다.',N'구매사 공사유형 운영사담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza094',N'KKO',N'OKP',N'질의응답 요청 미응답',N'[#{svcName}] 처리하지 못한 질의 응답 목록이 있습니다.',N'구매사 공사유형 운영사담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza095',N'KKO',N'OKP',N'사용자 휴면안내',N'[#{svcName}] 고객님은 OK플라자를 11개월 동안 로그인 하지 않아 휴면처리 대상 입니다. 고객님의 개인정보 보호를 위하여 정보통신망법 제29조에 따라 1년 이상(약 한달 후) OK플라자를 이용하지 않으시면 고객님은 휴면으로 전환되며, 개인정보는 별도로 분리보관 되거나 삭제될 예정입니다.',N'마지막 로그인이 11개월이 되는 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza097',N'KKO',N'WMS',N'물류인 경우 주문자, 인수자 발송',N'[#{svcName}] 통합물류센터에서 [#{orde_iden_numb}-#{orde_sequ_numb}], [#{good_name}]을(를) 출하하였습니다. * 배송 문의 : " + #{admWorkInfo}',N'주문자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza098',N'KKO',N'WMS',N'매입주문 승인요청 SMS',N'[#{svcName}] 매입주문 승인 요청건이 있습니다.',N'코드유형(WMS_ORDER_APP_SMS) 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza099',N'KKO',N'OKP',N'공급사 SMS 발송',N'[#{svcName}] 주문의뢰 정보가 있습니다. 주문접수 처리 요청 드립니다.',N'공급사 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza100',N'KKO',N'OKP',N'주문의뢰시 물류센터 사용자에게 SMS 전송',N'[#{svcName}] 배송준비 처리 할 주문이 있습니다. 확인 부탁드립니다.',N'물류센타 담당자, 권한코드(CEN_MNG)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza101-1',N'KKO',N'OKP',N'공급사 단가변경',N'[#{svcName}] 공급사 [#{vendorNm}]에서 상품 [#{goodName}]의 단가변경요청 하였습니다',N'운영사 상품담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza101-2',N'KKO',N'OKP',N'공급사 단종요청',N'[#{svcName}] 공급사 [#{vendorNm}]에서 상품 [#{goodName}]의 단종요청 하였습니다',N'운영사 상품담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza101-3',N'KKO',N'OKP',N'공급사 재등록요청',N'[#{svcName}] 공급사 [#{vendorNm}]에서 상품 [#{goodName}]의 재등록요청 하였습니다',N'운영사 상품담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza102',N'KKO',N'OKP',N'재고조사 등록 시',N'[#{svcName}] #{month}월 재고조사 등록 대기/승인 건이 있습니다. HOMS > 재고/예산관리 > 재고조사 화면에서 확인해주시길 바랍니다.',N'해당 사업장 감독관(기존엔 재고조사 담당자였음)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza109',N'KKO',N'OKP',N'SKB 상품 승인 대기 건 알림 전송',N'[#{svcName}] SKB 상품 승인 대기 #{appCnt}건이 승인 대기 중입니다. 확인 부탁드립니다.',N'안전보건 담당자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'OKPlaza111',N'SMS',N'PTO',N'펜타온 사용자등록',N'[#{svcName}] [#{userName}]님 펜타온 사용자등록이 완료되었습니다. 로그인ID: #{loginId} 암호: #{randPassword}',N'운영사 에서 사용자등록 시 사용자에게 로그인ID와 함호를 전달',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon001',N'KKO',N'PTO',N'회원가입 완료시',N'[팬타온] #{userNm}님의 회원가입을 축하드립니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon002',N'KKO',N'PTO',N'회원탈퇴 완료 시',N'[팬타온] #{userNm}님의 회원탈퇴 처리가 완료되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon003',N'KKO',N'PTO',N'회원정보 변경완료 시',N'[팬타온] #{userNm}님의 회원정보가 변경되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon004',N'KKO',N'PTO',N'주문 결제완료 시',N'[팬타온] 주문번호 [#{orderNum}] 건에 대한 주문이 결제완료되었습니다. 고객명 : [#{userNm}] 상품명 : [#{goodName}]',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon005',N'KKO',N'PTO',N'주문취소 완료 시',N'[팬타온] 주문번호 [#{orderNum}] 건에 대한 주문이 결제취소되었습니다. 고객명 : [#{userNm}] 상품명 : [#{goodName}]',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon006',N'KKO',N'PTO',N'택배사에서 배송 시작 시',N'[팬타온] [#{vendorNm}]에서 [#{orde_iden_numb}-#{orde_sequ_numb}], [#{good_name} 상품]에 대하여 배송처리 하였습니다. * #{vendorNm} + 배송 문의: #{phonenum}, 송장번호: #{deli_invo_iden}',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon007',N'KKO',N'PTO',N'구매자가 교환요청 신청시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 교환요청이 왔습니다.',N'공급사(담당자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon008',N'KKO',N'PTO',N'공급사가 교환요청 거부 시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 교환요청이 거부 되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon009',N'KKO',N'PTO',N'공급사가 교환요청 승인 시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 교환요청이 승인 되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon010',N'KKO',N'PTO',N'구매자가 반품요청 신청시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 반품요청이 왔습니다.',N'공급사(담당자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon011',N'KKO',N'PTO',N'공급사가 반품요청 거부 시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 반품요청이 거부 되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon012',N'KKO',N'PTO',N'공급사가 반품요청 승인 시',N'[팬타온] 주문번호 [#{orde_iden_numb}-#{orde_sequ_numb}] 의 반품요청이 승인 되었습니다.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon013',N'KKO',N'PTO',N'상품문의 답글 생성 시',N'[팬타온] #{userNm} 님의 상품문의에 대한 답글이 등록되었습니다. 확인해주세요.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon014',N'KKO',N'PTO',N'1:1문의 답변 생성 시',N'[팬타온] #{userNm} 님의 1:1문의에 대한 답변이 등록되었습니다. 확인해주세요.',N'고객(구매자)',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon101',N'SMS',N'PTO',N'로그인페이지 > 아이디 찾기',N'[팬타온] 고객님의 아이디는 #{userId} 입니다.',N'아이디 찾는 사용자',NULL,NULL,NULL,NULL);
INSERT INTO SMP_TEMPLATE_MNG (TEMPLATE_CD,SEND_TYPE,SEND_SVC,TITLE,CONTENTS,DESCRIPTION,INSERT_USER_ID,INSERT_DATE,UPDATE_USER_ID,UPDATE_DATE) VALUES (N'Pantaon102',N'SMS',N'PTO',N'로그인페이지 > 비밀번호 찾기',N'[팬타온] 초기화 된 비밀번호는 #{userPwd} 입니다.',N'비밀번호 찾는 사용자',NULL,NULL,NULL,NULL);


---------------------------------------------------------------------------------------------
-- 검색엔진

-- SRC_PRODUCT_NAME (OK플라자, 펜타온 자동완성용 상품명)
CREATE   VIEW dbo.SRC_PRODUCT_NAME
WITH SCHEMABINDING
AS
SELECT	AA.GOOD_NAME
,		SUM(ISNULL(BB.ORDER_CNT,0)) AS ORDER_CNT
,		STUFF((
					SELECT	',' + A.BRANCHID
					FROM	(
							SELECT	DISTINCT B.GOOD_NAME
							,		A.BRANCHID
							FROM	(
									
									SELECT	A.GOOD_IDEN_NUMB
									,		C.BRANCHID
									FROM	dbo.MCGOODDISPLAY A WITH(NOLOCK)
									INNER JOIN	dbo.MCGOODDISPLAY B WITH(NOLOCK)
										ON	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
										AND	A.VENDORID = B.VENDORID
									INNER JOIN	dbo.SMPBRANCHS C WITH(NOLOCK)
										ON	A.DISPLAY_TYPE_CD = C.AREATYPE
										AND CASE B.DISPLAY_TYPE_CD WHEN '0' THEN C.WORKID ELSE B.DISPLAY_TYPE_CD END = C.WORKID
									INNER JOIN dbo.MCGOODVENDOR D WITH(NOLOCK)
										ON	A.GOOD_IDEN_NUMB = D.GOOD_IDEN_NUMB
										AND	A.VENDORID = D.VENDORID
									WHERE	A.DISPLAY_TYPE = '10'
									AND		B.DISPLAY_TYPE = '20'
									AND		A.DISPLAY_TYPE_CD != '99'
									AND		D.ISUSE = '1'

									UNION

									SELECT	A.GOOD_IDEN_NUMB
									,		C.BRANCHID
									FROM	dbo.MCGOODDISPLAY A WITH(NOLOCK)
									INNER JOIN	dbo.MCGOODDISPLAY B WITH(NOLOCK)
										ON	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
										AND	A.VENDORID = B.VENDORID
									INNER JOIN	dbo.SMPBRANCHS C WITH(NOLOCK)
										ON	CASE B.DISPLAY_TYPE_CD WHEN '0' THEN C.WORKID ELSE B.DISPLAY_TYPE_CD END = C.WORKID 
									INNER JOIN dbo.MCGOODVENDOR D WITH(NOLOCK)
										ON	A.GOOD_IDEN_NUMB = D.GOOD_IDEN_NUMB
										AND	A.VENDORID = D.VENDORID
									WHERE	A.DISPLAY_TYPE = '10'
									AND		B.DISPLAY_TYPE = '20'
									AND		A.DISPLAY_TYPE_CD = '99'
									AND		D.ISUSE = '1'

									UNION
						
									SELECT	A.GOOD_IDEN_NUMB
									,		A.BRANCHID
									FROM	dbo.MCGOODDISPLAYBRANCH A WITH(NOLOCK)
									INNER JOIN	dbo.SMPBORGS B WITH(NOLOCK)
										ON A.BRANCHID = B.BORGID
									INNER JOIN dbo.MCGOODVENDOR D WITH(NOLOCK)
										ON	A.GOOD_IDEN_NUMB = D.GOOD_IDEN_NUMB
										AND	A.VENDORID = D.VENDORID
									WHERE	B.ISUSE = '1'
									AND		D.ISUSE = '1'
							) A
							INNER JOIN dbo.MCGOOD B
								ON	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
					) A
					WHERE	A.GOOD_NAME = AA.GOOD_NAME
		FOR XML PATH('')),1,1,'')	AS BRANCHIDS
FROM	dbo.MCGOOD AA WITH(NOLOCK)
INNER JOIN dbo.MCGOODVENDOR BB WITH(NOLOCK)
	ON	AA.GOOD_IDEN_NUMB = BB.GOOD_IDEN_NUMB
WHERE	BB.ISUSE = '1'
AND		AA.REPRE_GOOD != 'P'
GROUP BY AA.GOOD_NAME
;

-- SRC_CATEGORY (OK플라자 상품검색용 구매사카테고리)
CREATE VIEW dbo.SRC_CATEGORY
WITH SCHEMABINDING
AS 
SELECT A.CUST_CATE_CD         AS CUST_CATE_CD
     , B.CATE_ID              AS CATE_ID
  FROM dbo.MCCUST_CATE_NEW A      WITH(NOLOCK)
  LEFT JOIN dbo.MCCUST_CATE_NEW_CONN B WITH(NOLOCK)
    ON A.CUST_CATE_CD = SUBSTRING(B.CUST_CATE_CD, 1, 5)
 WHERE A.CATE_LEVEL   = 0
 UNION ALL
SELECT A.CUST_CATE_CD
     , B.CATE_ID
  FROM dbo.MCCUST_CATE_NEW A      WITH(NOLOCK)
  LEFT JOIN dbo.MCCUST_CATE_NEW_CONN B WITH(NOLOCK)
    ON A.CUST_CATE_CD = SUBSTRING(B.CUST_CATE_CD, 1, 7)
 WHERE A.CATE_LEVEL   = 1
 UNION ALL
SELECT A.CUST_CATE_CD
     , B.CATE_ID
  FROM dbo.MCCUST_CATE_NEW A      WITH(NOLOCK)
  LEFT JOIN dbo.MCCUST_CATE_NEW_CONN B WITH(NOLOCK)
    ON A.CUST_CATE_CD = SUBSTRING(B.CUST_CATE_CD, 1, 9)
 WHERE A.CATE_LEVEL   = 2
; 

-- SRC_BRANCH (OK플라자 상품검색용 조직)
CREATE VIEW dbo.SRC_BRANCH
WITH SCHEMABINDING
AS 
SELECT	A.GOOD_IDEN_NUMB
,		A.VENDORID
,		C.BRANCHID
FROM		dbo.MCGOODDISPLAY A WITH(NOLOCK)
INNER JOIN	dbo.MCGOODDISPLAY B WITH(NOLOCK)
	ON	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
	AND	A.VENDORID = B.VENDORID
	AND B.USE_YN = 'Y'
INNER JOIN	dbo.SMPBRANCHS C WITH(NOLOCK)
	ON	CASE A.DISPLAY_TYPE_CD WHEN '99' THEN C.AREATYPE ELSE A.DISPLAY_TYPE_CD END = C.AREATYPE
	AND CASE B.DISPLAY_TYPE_CD WHEN '0' THEN C.WORKID ELSE B.DISPLAY_TYPE_CD END = C.WORKID 
INNER JOIN	dbo.SMPBORGS D WITH(NOLOCK)
	ON	C.BRANCHID = D.BORGID
WHERE	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
AND		A.VENDORID = B.VENDORID
AND		A.DISPLAY_TYPE = '10'
AND		B.DISPLAY_TYPE = '20'
AND		CASE WHEN D.CLIENTID = '305952' 
			 THEN (CASE WHEN
						NOT EXISTS(
						SELECT	1
						FROM	dbo.MCGOODDISPLAY ZZ WITH(NOLOCK)
						WHERE	ZZ.GOOD_IDEN_NUMB = A.GOOD_IDEN_NUMB
						AND		ZZ.VENDORID = B.VENDORID
						AND		ZZ.USE_YN =  'N'
						AND		ZZ.DISPLAY_TYPE_CD IN (
													SELECT	B.WORKID
													FROM	dbo.SMPWORKINFO B WITH(NOLOCK)
													INNER JOIN dbo.SMPCODES C WITH(NOLOCK)
														ON CONVERT(VARCHAR(10),B.WORKID,120) = C.CODEVAL1
													WHERE	B.IS_SKTS_MANAGE = '1'
													AND		B.ISUSE = '1'
													AND		C.CODETYPECD = 'HNS_PROD_DISPLAY'
													) 
									) THEN 1 ELSE 0 END
					) ELSE 1 END = 1
UNION
SELECT	A.GOOD_IDEN_NUMB
,		A.VENDORID
,		B.BRANCHID
FROM		dbo.MCGOODVENDOR A WITH(NOLOCK)
INNER JOIN	dbo.MCGOODDISPLAYBRANCH B WITH(NOLOCK)
	ON	A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
	AND	A.VENDORID = B.VENDORID
	AND B.USE_YN = 'Y'
INNER JOIN	dbo.SMPBORGS C WITH(NOLOCK)
	ON B.BRANCHID = C.BORGID
INNER JOIN	dbo.SMPBRANCHS D WITH(NOLOCK)
	ON C.BORGID = D.BRANCHID
WHERE	C.ISUSE = '1'
;

-- SRC_GOODS (OK플라자 상품검색)
CREATE VIEW dbo.SRC_GOODS 
WITH SCHEMABINDING
AS 
SELECT A.GOOD_IDEN_NUMB
     , B.VENDORID 
     , A.CATE_ID
     , A.GOOD_NAME
     , A.GOOD_SPEC
     
     , ISNULL(A.ADD_GOOD,'N')       AS ADD_GOOD
     , A.REPRE_GOOD
     , ISNULL(A.VENDOR_EXPOSE,'Y')  AS VENDOR_EXPOSE
     , A.GOOD_TYPE 
     , ISNULL(E.CODENM1, '')        AS GOOD_TYPE_NM
     
     , ISNULL(E.CODEVAL2, '')       AS GOOD_TYPE_CLASS
     , ISNULL(B.ORDER_CNT,0)        AS ORDER_CNT
     , A.INSERT_DATE 
	 , CASE WHEN A.STOCK_YN = 'Y'
			THEN (
				SELECT	ISNULL(SUM(GOOD_QUAN), 0)
				FROM	dbo.LOGI_INFO WITH(NOLOCK)
				WHERE	GOOD_IDEN_NUMB	= B.GOOD_IDEN_NUMB
				AND		ENTER_STATE		= '9'
			)
			WHEN ISNULL(B.VENDOR_STOCK_YN,'N')='Y' AND B.GOOD_INVENTORY_CNT>0
			THEN ISNULL(B.GOOD_INVENTORY_CNT, 0)
			ELSE 0 END AS GOOD_INVENTORY_CNT
     , CONVERT(TINYINT, ROW_NUMBER() OVER(PARTITION BY B.GOOD_IDEN_NUMB ORDER BY B.SELL_PRICE ASC)) AS RANK
     
     , COUNT(1) OVER(PARTITION BY B.GOOD_IDEN_NUMB) AS VENDOR_CNT
     , IIF(A.SKTS_IMG = 'Y', A.SKTS_ORIGNAL_IMG_PATH, B.ORIGINAL_IMG_PATH) AS IMG_PATH
     , IIF(A.VENDOR_EXPOSE = 'N', '오케이플라자', C.VENDORNM) AS VENDORNM
     , B.DELI_MINI_DAY
     , B.DELI_MINI_QUAN
     
     , B.MAKE_COMP_NAME
     , B.SELL_PRICE
     , A.ORDER_UNIT
     , A.ISDISTRIBUTE
     , IIF(ASCII(SUBSTRING(A.GOOD_NAME, 1,1)) < 128, 2, 1) AS ASCII_ORDER
     
     , B.GOOD_SAME_WORD
     , ISNULL(A.STOCK_YN, 'N')      AS STOCK_YN
     , ISNULL(A.JOJANG_YN, 'N')     AS JOJANG_YN
     , B.VENDOR_STOCK_YN
     , B.GOOD_DESC
     , (SELECT STRING_AGG(CUST_CATE_CD, ',') FROM dbo.SRC_CATEGORY X WITH(NOLOCK) WHERE X.CATE_ID = A.CATE_ID) AS CUST_CATE_CDS
     , (SELECT STRING_AGG(CAST(BRANCHID AS VARCHAR(MAX)), ',') FROM dbo.SRC_BRANCH X WITH(NOLOCK) WHERE X.GOOD_IDEN_NUMB = A.GOOD_IDEN_NUMB AND X.VENDORID = B.VENDORID) AS BRANCHIDS
     
  FROM dbo.MCGOOD          A WITH(NOLOCK)
     , dbo.MCGOODVENDOR    B WITH(NOLOCK)
     , dbo.SMPVENDORS      C WITH(NOLOCK)
     , dbo.SMPBORGS        D WITH(NOLOCK)
     , dbo.SMPCODES        E WITH(NOLOCK)
 WHERE A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
   AND B.ISUSE      = 1
   AND B.VENDORID   = C.VENDORID
   AND C.VENDORID   = D.BORGID
   AND D.ISUSE      = '1'
   AND A.AGENT_ID   = 13
   AND E.CODETYPECD = 'ORDERGOODSTYPE'
   AND A.GOOD_TYPE  = E.CODEVAL1
   AND A.AGENT_ID   = E.AGENT_ID
;

-- SRC_GOODS_PANTA (펜타온 상품검색)
CREATE VIEW dbo.SRC_GOODS_PANTA
WITH SCHEMABINDING
AS 
SELECT GOOD_IDEN_NUMB
     , VENDORID 
     , CATE_ID
     , GOOD_NAME
     , GOOD_SPEC
     
     , ADD_GOOD
     , REPRE_GOOD
     , ORDER_CNT
     , INSERT_DATE
     , IMG_PATH
     
     , VENDORNM
     , DELI_MINI_QUAN
     , MAKE_COMP_NAME
     , ORI_SELL_PRICE
     , SELL_PRICE
	 
	 , SALE_RATE
	 , FREE_DELI_YN
     , ORDER_UNIT
     , GOOD_DESC
     , ASCII_ORDER
     
     , GOOD_SAME_WORD
     , STOCK_YN
     , JOJANG_YN
     , CUST_CATE_CDS
  FROM (
	SELECT A.GOOD_IDEN_NUMB
	     , B.VENDORID 
	     , A.CATE_ID
	     , A.GOOD_NAME
	     , A.GOOD_SPEC
	     
	     , ISNULL(A.ADD_GOOD,'N')       AS ADD_GOOD
	     , A.REPRE_GOOD
	     , ISNULL(B.ORDER_CNT,0)        AS ORDER_CNT
	     , A.INSERT_DATE
	     , IIF(A.SKTS_IMG = 'Y', A.SKTS_ORIGNAL_IMG_PATH, B.ORIGINAL_IMG_PATH) AS IMG_PATH
	     
	     , IIF(A.VENDOR_EXPOSE = 'N', '오케이플라자', C.VENDORNM) AS VENDORNM
	     , B.DELI_MINI_QUAN
	     , B.MAKE_COMP_NAME
	     , D.ORI_SELL_PRICE
	     , D.SELL_PRICE
		 
		 , ROUND((1 - (D.SELL_PRICE/D.ORI_SELL_PRICE)) * 100, 2, 1)	AS SALE_RATE
		 , (CASE WHEN ISNULL(F.BASE_DELI_AMOUNT, 0 ) = 0 THEN 'Y' WHEN F.FREE_DELI_YN = 'Y' AND ISNULL(F.FREE_DELI_AMOUNT, 0) = 0 THEN 'Y' ELSE 'N' END) AS FREE_DELI_YN
	     , A.ORDER_UNIT
	     , B.GOOD_DESC
	     , IIF(ASCII(SUBSTRING(A.GOOD_NAME, 1,1)) < 128, 2, 1) AS ASCII_ORDER
	     
	     , B.GOOD_SAME_WORD
	     , ISNULL(A.STOCK_YN, 'N')      AS STOCK_YN
	     , ISNULL(A.JOJANG_YN, 'N')     AS JOJANG_YN
	     , (SELECT STRING_AGG(CUST_CATE_CD, ',') FROM dbo.SRC_CATEGORY X WITH(NOLOCK) WHERE X.CATE_ID = A.CATE_ID) AS CUST_CATE_CDS
	     , ROW_NUMBER() OVER (PARTITION BY A.GOOD_IDEN_NUMB, IIF(A.STOCK_YN = 'Y', '0', B.VENDORID) ORDER BY D.SELL_PRICE ASC)	AS RANK
	  FROM dbo.MCGOOD                  A WITH(NOLOCK)
	     , dbo.MCGOODVENDOR            B WITH(NOLOCK)
         , dbo.SMPVENDORS              C WITH(NOLOCK)
	     , dbo.MCGOODVENDOR_PANTA      D WITH(NOLOCK)
	     , dbo.MCGOODVENDOR_PANTA_NOTI E WITH(NOLOCK)
	     , dbo.SMPVENDORS_PANTA        F WITH(NOLOCK)
	 WHERE A.GOOD_IDEN_NUMB = B.GOOD_IDEN_NUMB
	   AND B.VENDORID       = C.VENDORID
       AND B.VENDORID       = D.VENDORID
	   AND A.GOOD_IDEN_NUMB = D.GOOD_IDEN_NUMB
	   AND B.VENDORID       = E.VENDORID
	   AND (A.ADD_GOOD = 'N'  OR A.ADD_GOOD IS NULL)
	   AND (A.JOJANG_YN = 'N' OR A.JOJANG_YN IS NULL)
	   AND A.REPRE_GOOD    != 'P'
	   AND D.SELL_PRICE    >= 0
	   AND A.AGENT_ID       = '13'
	   AND A.GOOD_IDEN_NUMB = E.GOOD_IDEN_NUMB
	   AND B.VENDORID       = E.VENDORID
       AND B.VENDORID       = F.VENDORID
	   AND NOT EXISTS (
			SELECT 1
			  FROM dbo.MCADDGOOD Z WITH(NOLOCK)
			 WHERE Z.ADD_GOOD_IDEN_NUMB = A.GOOD_IDEN_NUMB
		   )
	   AND EXISTS (
			SELECT 1
			  FROM dbo.MCGOODDISPLAY X WITH(NOLOCK)
			 WHERE X.GOOD_IDEN_NUMB = A.GOOD_IDEN_NUMB
			   AND X.VENDORID = B.VENDORID
			   AND X.DISPLAY_TYPE = '20'

			UNION ALL
			SELECT 1
			  FROM dbo.MCGOODDISPLAYBRANCH X WITH(NOLOCK)
			 WHERE	X.GOOD_IDEN_NUMB = A.GOOD_IDEN_NUMB
			   AND X.VENDORID = B.VENDORID
			   AND X.BRANCHID = 'PTO000002'
				)
	   )  A
 WHERE RANK = 1
;

-- SRC_GOODS_TRIG (검색엔진용 트리거)
CREATE TABLE dbo.SRC_GOODS_TRIG (
	SEQ int IDENTITY(1,1) NOT NULL,
	GOOD_IDEN_NUMB bigint NOT NULL,
	TABLE_NAME varchar(30) COLLATE Korean_Wansung_CI_AS NULL,
	[ACTION] varchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	INSERTDATE datetime NULL,
	STATUS varchar(100) COLLATE Korean_Wansung_CI_AS DEFAULT 'N' NULL,
	CONSTRAINT PK__SRC_GOODS_TRIG PRIMARY KEY (SEQ)
);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 트리거
SELECT * FROM SRC_GOODS_TRIG;
--INSERT SRC_GOODS_TRIG VALUES (1, 1, 'MCADDGOOD', 'I', GET  )

/*
실서버 트리거
1. MCADDGOOD > 추가구성상품 추가
2. MCGOOD > 상품마스터
3. MCGOOD_HNS_APP > HNS 상품 승인 테이블 
4. MCGOODAPP > 상품가격변경승인
5. MCGOODDISPLAY > 상품진열
6. MCGOODDISPLAYBRANCH > 상품진열사업장
7. MCGOODVENDOR > 상품공급사

추가 트리거 대상 테이블
1. MCGOODVENDOR_PANTA > 상품공급사_팬타온
   ㄴ 판매가 변경 시 필요
2. SMPVENDORS_PANTA > 공급사_팬타온
   ㄴ 배송비 정책관련 변경 시 필요
3. SMPVENDORS > 공급사
   ㄴ 팬타온 판매여부 YN 변경 시 필요
   ㄴㄴ 운영사 수정 후 확인
*/

-- MCGOODVENDOR_PANTA > 상품공급사_팬타온
CREATE TRIGGER TRG_MCGOODVENDOR_PANTA
ON dbo.MCGOODVENDOR_PANTA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT 처리 (INSERTED 테이블에만 값이 있는 경우)
    INSERT INTO dbo.SRC_GOODS_TRIG (GOOD_IDEN_NUMB, TABLE_NAME, [ACTION], INSERTDATE, STATUS)
    SELECT 
        i.GOOD_IDEN_NUMB,  
        'SRC_GOODS_PANTA',
        'I',
        GETDATE(),
        'N'
    FROM inserted i
    LEFT JOIN deleted d ON i.GOOD_IDEN_NUMB = d.GOOD_IDEN_NUMB
    WHERE d.GOOD_IDEN_NUMB IS NULL;  -- 기존 데이터가 없으면 INSERT

    -- UPDATE 처리 (INSERTED와 DELETED 테이블에 값이 모두 있는 경우)
    INSERT INTO dbo.SRC_GOODS_TRIG (GOOD_IDEN_NUMB, TABLE_NAME, [ACTION], INSERTDATE, STATUS)
    SELECT 
        i.GOOD_IDEN_NUMB,  
        'SRC_GOODS_PANTA',
        'U',
        GETDATE(),
        'N'
    FROM inserted i
    INNER JOIN deleted d ON i.GOOD_IDEN_NUMB = d.GOOD_IDEN_NUMB;  -- 기존 데이터가 있으면 UPDATE

    -- DELETE 처리 (DELETED 테이블에만 값이 있는 경우)
    INSERT INTO dbo.SRC_GOODS_TRIG (GOOD_IDEN_NUMB, TABLE_NAME, [ACTION], INSERTDATE, STATUS)
    SELECT 
        d.GOOD_IDEN_NUMB,  
        'SRC_GOODS_PANTA',
        'D',
        GETDATE(),
        'N'
    FROM deleted d
    LEFT JOIN inserted i ON d.GOOD_IDEN_NUMB = i.GOOD_IDEN_NUMB
    WHERE i.GOOD_IDEN_NUMB IS NULL;  -- 새로운 데이터가 없으면 DELETE
END;

-- SMPVENDORS_PANTA > 공급사_팬타온
CREATE TRIGGER TRG_SMPVENDORS_PANTA
ON dbo.SMPVENDORS_PANTA
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	-- 팬타온 전시여부 상품만 업데이트처리
    INSERT INTO dbo.SRC_GOODS_TRIG (GOOD_IDEN_NUMB, TABLE_NAME, [ACTION], INSERTDATE, STATUS)
    SELECT 
        mg.GOOD_IDEN_NUMB,  
        'SRC_GOODS_PANTA',
        'U',
        GETDATE(),
        'N'
    FROM inserted i
    INNER JOIN dbo.MCGOODVENDOR mg ON i.VENDORID = mg.VENDORID AND mg.PANTA_DISP_YN = 'Y';
END;

-- SMPVENDORS > 공급사
CREATE TRIGGER TRG_SMPVENDORS
ON dbo.SMPVENDORS
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- PANTA_YN이 'N'으로 변경된 경우만 처리
    INSERT INTO dbo.SRC_GOODS_TRIG (GOOD_IDEN_NUMB, TABLE_NAME, [ACTION], INSERTDATE, STATUS)
    SELECT 
        mg.GOOD_IDEN_NUMB,  
        'SMPVENDORS',
        'U',
        GETDATE(),
        'Y'
    FROM inserted i
    INNER JOIN deleted d ON i.VENDORID = d.VENDORID  -- 업데이트된 데이터만 확인
    INNER JOIN dbo.MCGOODVENDOR mg ON i.VENDORID = mg.VENDORID
    WHERE d.PANTA_YN <> 'N'		-- 기존값이 'N'이 아니었고
    AND i.PANTA_YN = 'N'		-- 새 값이 'N'으로 변경된 경우
    AND mg.PANTA_DISP_YN = 'Y';	-- 팬타온 진열 상품만
END;


--------------------------------------------------------------------------------------
-- 전자입찰 DDL
CREATE TABLE Bidding.dbo.T_ATTACHINFO (
   ATTACH_SEQ varchar(10) NOT NULL,
   ATTACH_FILE_NAME varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   ATTACH_FILE_PATH varchar(400) COLLATE Korean_Wansung_CI_AS NULL,
   INSERT_DATE datetime NULL,
   CONSTRAINT PK_ATTACHINFO PRIMARY KEY (ATTACH_SEQ)
);

CREATE TABLE Bidding.dbo.T_BI_DETAIL_MAT_CUST (
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   SEQ int NOT NULL,
   CUST_CODE int NOT NULL,
   ESMT_UC decimal(13,1) NULL,
   CONSTRAINT PK__T_BI_DET__FCE2959DF87F7F30 PRIMARY KEY (BI_NO,SEQ,CUST_CODE)
);
 CREATE NONCLUSTERED INDEX T_BI_DETAIL_MAT_CUST_BI_NO_IDX ON dbo.T_BI_DETAIL_MAT_CUST (  BI_NO ASC  , SEQ ASC  , CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;


CREATE TABLE Bidding.dbo.T_BI_DETAIL_MAT_CUST_TEMP (
   BI_NO varchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   BI_ORDER smallint NOT NULL,
   CUST_CODE int NOT NULL,
   SEQ int NOT NULL,
   ESMT_UC decimal(13,1) NULL,
   CONSTRAINT PK__T_BI_DET__DD37237C6774F5CE PRIMARY KEY (BI_NO,BI_ORDER,CUST_CODE,SEQ)
);

CREATE TABLE Bidding.dbo.T_BI_INFO_MAT (
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   BI_NAME varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   BI_MODE char(1) COLLATE Korean_Wansung_CI_AS NULL,
   INS_MODE char(1) COLLATE Korean_Wansung_CI_AS NULL,
   BID_JOIN_SPEC varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   SPECIAL_COND varchar(400) COLLATE Korean_Wansung_CI_AS NULL,
   SUPPLY_COND varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   SPOT_DATE datetime NULL,
   SPOT_AREA varchar(80) COLLATE Korean_Wansung_CI_AS NULL,
   SUCC_DECI_METH char(1) COLLATE Korean_Wansung_CI_AS NULL,
   BID_OPEN_DATE datetime NULL,
   AMT_BASIS varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   BD_AMT decimal(15,0) NULL,
   SUCC_AMT decimal(15,0) NULL,
   EST_START_DATE datetime NULL,
   EST_CLOSE_DATE datetime NULL,
   EST_OPENER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   EST_BIDDER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   EST_OPEN_DATE datetime NULL,
   OPEN_ATT1 varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT1_SIGN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT2 varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT2_SIGN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   ING_TAG char(2) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   GONGO_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   PAY_COND varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   WHY_A3 varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   WHY_A7 varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   BI_OPEN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_BI_INF__40C095D5EEF6C5CC PRIMARY KEY (BI_NO)
);

CREATE TABLE Bidding.dbo.T_BI_INFO_MAT_CUST (
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CUST_CODE int NOT NULL,
   REBID_ATT char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ESMT_YN char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ESMT_AMT decimal(15,1) NULL,
   SUCC_YN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   FILE_ID int NULL,
   SUBMIT_DATE datetime NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   BI_ORDER smallint NULL,
   ENC_QUTN varchar(8000) COLLATE Korean_Wansung_CI_AS NULL,
   ENC_ESMT_SPEC text COLLATE Korean_Wansung_CI_AS NULL,
   ESMT_CURR varchar(10) COLLATE Korean_Wansung_CI_AS NULL,
   ETC_B_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   ETC_B_FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   REAL_AMT decimal(15,0) NULL,
   ADD_ACCEPT varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_BI_INF__48F9A99F69AEC53B PRIMARY KEY (BI_NO,CUST_CODE)
);
 CREATE NONCLUSTERED INDEX T_BI_INFO_MAT_CUST_BI_NO_IDX ON dbo.T_BI_INFO_MAT_CUST (  BI_NO ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_BI_INFO_MAT_CUST_TEMP (
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CUST_CODE int NOT NULL,
   BI_ORDER smallint NOT NULL,
   REBID_ATT char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ESMT_YN char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ESMT_AMT decimal(15,1) NULL,
   SUCC_YN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   ENC_QUTN varchar(8000) COLLATE Korean_Wansung_CI_AS NULL,
   ENC_ESMT_SPEC text COLLATE Korean_Wansung_CI_AS NULL,
   FILE_ID int NULL,
   SUBMIT_DATE datetime NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   ESMT_CURR varchar(10) COLLATE Korean_Wansung_CI_AS NULL,
   ETC_B_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   ETC_B_FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   REAL_AMT decimal(15,0) NULL,
   ADD_ACCEPT varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_BI_INF__A3EF21D05B1D619F PRIMARY KEY (BI_NO,CUST_CODE,BI_ORDER)
);
 CREATE NONCLUSTERED INDEX T_BI_INFO_MAT_CUST_TEMP_BI_NO_IDX ON dbo.T_BI_INFO_MAT_CUST_TEMP (  BI_NO ASC  , CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_BI_INFO_MAT_HIST (
   HIST_ID int NOT NULL,
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NULL,
   BI_NAME varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   BI_MODE char(1) COLLATE Korean_Wansung_CI_AS NULL,
   INS_MODE char(1) COLLATE Korean_Wansung_CI_AS NULL,
   BID_JOIN_SPEC varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   SPECIAL_COND varchar(400) COLLATE Korean_Wansung_CI_AS NULL,
   SUPPLY_COND varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   SPOT_DATE datetime NULL,
   SPOT_AREA varchar(80) COLLATE Korean_Wansung_CI_AS NULL,
   SUCC_DECI_METH char(1) COLLATE Korean_Wansung_CI_AS NULL,
   BID_OPEN_DATE datetime NULL,
   AMT_BASIS varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   BD_AMT decimal(15,0) NULL,
   SUCC_AMT decimal(15,0) NULL,
   EST_START_DATE datetime NULL,
   EST_CLOSE_DATE datetime NULL,
   EST_OPENER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   EST_BIDDER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   EST_OPEN_DATE datetime NULL,
   OPEN_ATT1 varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT1_SIGN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT2 varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   OPEN_ATT2_SIGN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   ING_TAG char(2) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   GONGO_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   PAY_COND varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   WHY_A3 varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   WHY_A7 varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   BI_OPEN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_BI_INF__32BED210C10D0C2E PRIMARY KEY (HIST_ID)
);

CREATE TABLE Bidding.dbo.T_BI_LOG (
   LOG_SEQ int NOT NULL,
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   LOG_TEXT varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   CONSTRAINT PK__T_BI_LOG__F49E45A994E7D410 PRIMARY KEY (LOG_SEQ)
);
 CREATE NONCLUSTERED INDEX T_BI_LOG_BI_NO_IDX ON dbo.T_BI_LOG (  BI_NO ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_BI_SPEC_MAT (
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   SEQ int NOT NULL,
   NAME varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   SSIZE varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   UNITCODE varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   ORDER_UC numeric(12,0) NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   ORDER_QTY numeric(12,3) NULL,
   METERAIL varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   GOOD_IDEN_NUMB bigint NULL,
   COMP_ID int NULL,
   CONSTRAINT PK__T_BI_SPE__5C61065940B565EC PRIMARY KEY (BI_NO,SEQ)
);

CREATE TABLE Bidding.dbo.T_BI_UPLOAD (
   FILE_ID int NOT NULL,
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   FILE_FLAG char(1) COLLATE Korean_Wansung_CI_AS NULL,
   F_CUST_CODE int NULL,
   FILE_NM varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   USE_YN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK_T_BI_UPLOAD PRIMARY KEY (FILE_ID,BI_NO)
);

CREATE TABLE Bidding.dbo.T_CO_BOARD_CUST (
   B_NO int NOT NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CONSTRAINT PK__T_CO_BOA__38B7E1CC4C782E7D PRIMARY KEY (B_NO,INTERRELATED_CUST_CODE)
);

CREATE TABLE Bidding.dbo.T_CO_BOARD_NOTICE (
   B_NO int NOT NULL,
   B_USERID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   B_TITLE varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   B_DATE datetime NULL,
   B_COUNT int NULL,
   B_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   B_CONTENT text COLLATE Korean_Wansung_CI_AS NULL,
   B_FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   B_CO varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   NOTI_DIV varchar(1) COLLATE Korean_Wansung_CI_AS NULL,
   IMPORT_YN varchar(1) COLLATE Korean_Wansung_CI_AS DEFAULT 'N' NULL,
   EMERG_YN varchar(1) COLLATE Korean_Wansung_CI_AS DEFAULT 'N' NULL,
   TOP_YN varchar(1) COLLATE Korean_Wansung_CI_AS DEFAULT 'N' NULL,
   NOTI_START_DATE DATE NULL,
   NOTI_END_DATE DATE NULL,
   CONSTRAINT PK__T_CO_BOA__4B26D74953F178A0 PRIMARY KEY (B_NO)
);

CREATE TABLE Bidding.dbo.T_CO_CODE (
   COL_CODE varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CODE_VAL varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CODE_NAME varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   SORT_NO int NULL,
   USEYN char(1) COLLATE Korean_Wansung_CI_AS DEFAULT 'Y' NOT NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   CONSTRAINT PK__T_CO_COD__01D0DD42C91F44C0 PRIMARY KEY (COL_CODE,CODE_VAL)
);

CREATE TABLE Bidding.dbo.T_CO_CUST_IR (
   CUST_CODE int NOT NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CUST_LEVEL char(1) COLLATE Korean_Wansung_CI_AS NULL,
   CUST_VALUATION varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   CERT_DATE datetime NULL,
   CARE_CONTENT varchar(2000) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_CO_CUS__F002F224E4ECCD2A PRIMARY KEY (CUST_CODE,INTERRELATED_CUST_CODE)
);

CREATE TABLE Bidding.dbo.T_CO_CUST_MASTER (
   CUST_CODE int NOT NULL,
   CUST_NAME varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   REGNUM char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   PRES_NAME varchar(50) COLLATE Korean_Wansung_CI_AS NOT NULL,
   PRES_JUMIN_NO varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   TEL varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   FAX varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   ZIPCODE varchar(6) COLLATE Korean_Wansung_CI_AS NULL,
   ADDR varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ADDR_DETAIL varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   CAPITAL bigint NULL,
   FOUND_YEAR varchar(4) COLLATE Korean_Wansung_CI_AS NULL,
   CERT_YN char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ETC varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CREATE_DATE datetime NOT NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   UPDATE_DATE datetime NOT NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NULL,
   B_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   B_FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   REGNUM_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   REGNUM_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   SSO_VENDOR_CD varchar(10) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_CO_CUS__8393C4A161C260B2 PRIMARY KEY (CUST_CODE)
);

 CREATE NONCLUSTERED INDEX T_CO_CUST_MASTER_CUST_CODE_IDX ON dbo.T_CO_CUST_MASTER (  CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX T_CO_CUST_MASTER_INTERRELATED_CUST_CODE_IDX ON dbo.T_CO_CUST_MASTER (  INTERRELATED_CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_CO_CUST_MASTER_HIST (
   HIST_ID int NOT NULL,
   CUST_CODE int NULL,
   CUST_NAME varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   REGNUM char(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
   PRES_NAME varchar(50) COLLATE Korean_Wansung_CI_AS NOT NULL,
   PRES_JUMIN_NO varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   TEL varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   FAX varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   ZIPCODE varchar(6) COLLATE Korean_Wansung_CI_AS NULL,
   ADDR varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   ADDR_DETAIL varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   CAPITAL bigint NULL,
   FOUND_YEAR varchar(4) COLLATE Korean_Wansung_CI_AS NULL,
   CERT_YN char(1) COLLATE Korean_Wansung_CI_AS DEFAULT 'Y' NOT NULL,
   ETC varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CREATE_DATE datetime NOT NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   UPDATE_DATE datetime NOT NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NULL,
   B_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   B_FILE_PATH varchar(300) COLLATE Korean_Wansung_CI_AS NULL,
   REGNUM_FILE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   REGNUM_PATH varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_CO_CUS__32BED21043632999 PRIMARY KEY (HIST_ID)
);

CREATE TABLE Bidding.dbo.T_CO_CUST_USER (
   USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CUST_CODE int NOT NULL,
   USER_PWD varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   USER_NAME varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   USER_TEL varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   USER_HP varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   USER_EMAIL varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   USER_TYPE char(1) COLLATE Korean_Wansung_CI_AS NULL,
   USER_BUSEO varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   USER_POSITION varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   PWD_CHG_DATE datetime NULL,
   USE_YN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   SSO_LOGIN_ID varchar(30) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_CO_CUS__F3BEEBFFABABA062 PRIMARY KEY (USER_ID)
);
 CREATE NONCLUSTERED INDEX T_CO_CUST_USER_CUST_CODE_IDX ON dbo.T_CO_CUST_USER (  CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_CO_INTERRELATED (
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
   INTERRELATED_NM varchar(100) COLLATE Korean_Wansung_CI_AS NOT NULL,
   LOGO_PATH varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   IMG_PATH2 varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   USE_YN char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CONSTRAINT PK__T_CO_INT__39136856EA10767B PRIMARY KEY (INTERRELATED_CUST_CODE)
);

CREATE TABLE Bidding.dbo.T_CO_USER (
   USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   USER_PWD varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   USER_NAME varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   USER_AUTH char(1) COLLATE Korean_Wansung_CI_AS NULL,
   USER_EMAIL varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   USER_HP varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   USER_POSITION varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   USER_TEL varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   UPDATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   PWD_EDIT_YN char(1) COLLATE Korean_Wansung_CI_AS NULL,
   PWD_EDIT_DATE datetime NULL,
   DEPT_NAME varchar(50) COLLATE Korean_Wansung_CI_AS NULL,
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NULL,
   OPENAUTH char(1) COLLATE Korean_Wansung_CI_AS NULL,
   USE_YN char(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
   BIDAUTH char(1) COLLATE Korean_Wansung_CI_AS NULL,
   SSO_LOGIN_ID varchar(30) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_CO_USE__F3BEEBFF6D7A974D PRIMARY KEY (USER_ID)
);

 CREATE NONCLUSTERED INDEX T_CO_USER_INTERRELATED_CUST_CODE_IDX ON dbo.T_CO_USER (  INTERRELATED_CUST_CODE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_CO_USER_INTERRELATED (
   INTERRELATED_CUST_CODE char(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
   USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   CONSTRAINT PK__T_CO_USE__D62886E9D35C3723 PRIMARY KEY (INTERRELATED_CUST_CODE,USER_ID)
);

CREATE TABLE Bidding.dbo.T_EMAIL (
   MAIL_ID int NOT NULL,
   TITLE varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   CONTS varchar(2000) COLLATE Korean_Wansung_CI_AS NULL,
   RECEIVES varchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
   SEND_FLAG char(1) COLLATE Korean_Wansung_CI_AS NULL,
   ERROR_MSG varchar(200) COLLATE Korean_Wansung_CI_AS NULL,
   SEND_DATE datetime NULL,
   CREATE_DATE datetime NULL,
   BI_NO char(10) COLLATE Korean_Wansung_CI_AS NULL,
   CONSTRAINT PK__T_EMAIL__563A839FD10DD30F PRIMARY KEY (MAIL_ID)
);
 CREATE NONCLUSTERED INDEX T_EMAIL_CREATE_DATE_IDX ON dbo.T_EMAIL (  CREATE_DATE ASC  )  
    WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
    ON [PRIMARY ] ;

CREATE TABLE Bidding.dbo.T_FAQ (
   FAQ_ID int NOT NULL,
   FAQ_TYPE char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
   TITLE varchar(2000) COLLATE Korean_Wansung_CI_AS NULL,
   ANSWER varchar(2000) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_USER varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   CREATE_DATE datetime NULL,
   CONSTRAINT PK__t_faq__838154B4EB4286BD PRIMARY KEY (FAQ_ID)
);

CREATE TABLE Bidding.dbo.T_SEQUENCE (
   TABLE_NAME varchar(30) COLLATE Korean_Wansung_CI_AS NOT NULL,
   NEXT_ID decimal(30,0) NOT NULL,
   CONSTRAINT PK_SMP_SEQUENCE PRIMARY KEY (TABLE_NAME)
);

CREATE TABLE Bidding.dbo.T_TEMPLATE_MNG (
   TEMPLATE_CD varchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
   SEND_TYPE varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   SEND_SVC varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   TITLE varchar(100) COLLATE Korean_Wansung_CI_AS NULL,
   CONTENTS varchar(4000) COLLATE Korean_Wansung_CI_AS NULL,
   DESCRIPTION varchar(4000) COLLATE Korean_Wansung_CI_AS NULL,
   INSERT_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   INSERT_DATE datetime NULL,
   UPDATE_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS NULL,
   UPDATE_DATE datetime NULL,
   CONSTRAINT T_TEMPLATE_MNG_PK PRIMARY KEY (TEMPLATE_CD)
);

CREATE TABLE Bidding.dbo.T_ASK (
   ASK_ID INT NOT NULL,
   ASK_TYPE CHAR(1),
   ASK_STATE CHAR(1),
   INTERRELATED_CUST_CODE CHAR(2),
   CUST_CODE INT,
   ASK_TITLE varchar(500) COLLATE Korean_Wansung_CI_AS ,
   ASK_CONTENTS varchar(2000) COLLATE Korean_Wansung_CI_AS ,
   ASK_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS ,
   ASK_DATE DATETIME,
   ASK_FILE1 INT,
   ASK_FILE2 INT,
   ASK_FILE3 INT,
   ASK_FILE4 INT,
   REPLY_CONTENTS varchar(2000) COLLATE Korean_Wansung_CI_AS ,
   REPLY_USER_ID varchar(20) COLLATE Korean_Wansung_CI_AS,
   REPLY_DATE datetime,
   REPLY_FILE1 INT,
   CONSTRAINT T_ASK_PK PRIMARY KEY (ASK_ID)
);


------------------------------------------------------

