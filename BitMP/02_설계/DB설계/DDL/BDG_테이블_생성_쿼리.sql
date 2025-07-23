CREATE TABLE BDG_ITEM (
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_ITEM_NM varchar(20) NULL COMMENT '예산항목명',
	ITEM_TP VARchar(1) DEFAULT 0 NOT NULL COMMENT '항목유형',
	ITEM_TP_VALUE varchar(100) NULL COMMENT '항목유형값',
	DISP_NO int DEFAULT 0 NOT NULL COMMENT '순서',
	USE_YN char(1) DEFAULT 'Y' NOT NULL COMMENT '사용_YN',
	INSERT_USER_ID varchar(10) NULL COMMENT '등록자ID',
	INSERT_DT datetime NULL COMMENT '등록일시',
	UPDATE_USER_ID varchar(10) NULL COMMENT '수정자ID',
	UPDATE_DT datetime NULL COMMENT '수정일시',
	PRIMARY KEY (BDG_ITEM_CD)                                  
)
COMMENT = '예산항목';

CREATE TABLE BDG_BRANCH (
	BRANCH_ID varchar(10) NOT NULL COMMENT '사업장ID',
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_AMT decimal(15,0) NULL COMMENT '예산금액',
	IS_USE int NOT NULL DEFAULT '1' COMMENT '사용여부',
	INSERT_USER_ID varchar(10) NULL COMMENT '등록자ID',
	INSERT_DT datetime NULL COMMENT '등록일시',
	UPDATE_USER_ID varchar(10) NULL COMMENT '수정자ID',
	UPDATE_DT datetime NULL COMMENT '수정일시',
	PRIMARY KEY (BRANCH_ID, BDG_ITEM_CD)
)
COMMENT = '예산사업장';

CREATE TABLE BDG_PRE_YM (
	BRANCH_ID varchar(10) NOT NULL COMMENT '사업장ID',
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_YM varchar(10) NOT NULL COMMENT '예산년월',
	BASIC_BDG_AMT decimal(15,0) NULL COMMENT '기초예산',
	INSERT_DT datetime NULL COMMENT '생성일',
	INSERT_USER_ID varchar(10) NULL COMMENT '등록자',
	UPDATE_DT datetime NULL COMMENT '수정자ID',
	UPDATE_USER_ID varchar(10) NULL COMMENT '수정일시'
)
COMMENT = '기초예산';

CREATE TABLE BDG_YM (
	BRANCH_ID varchar(10) NOT NULL COMMENT '사업장ID',
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_YM varchar(10) NOT NULL COMMENT '예산년월',
	ASSIGN_BDG_AMT decimal(15,0) NULL COMMENT '배정예산',
	USED_BDG_AMT decimal(15,0) NULL COMMENT '사용예산',
	PRIMARY KEY (BRANCH_ID, BDG_ITEM_CD, BDG_YM)                                    
)
COMMENT = '예산연월';

CREATE TABLE BDG_REQUEST (
	BDG_REQ_ID varchar(18) NOT NULL COMMENT '예산요청ID',
	BRANCH_ID varchar(10) NOT NULL COMMENT '사업장ID',
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_YM varchar(10) NOT NULL COMMENT '예산년월',
	APP_ST varchar(10) NOT NULL DEFAULT '10' COMMENT '승인상태',
	REQ_BDG_AMT decimal(15,0) NULL COMMENT '예산요청금액',
	REQ_USER_ID varchar(10) NULL COMMENT '요청자',
	REQ_DT datetime NULL COMMENT '요청일',
	APP_USER_ID varchar(10) NULL COMMENT '승인자',
	APP_DT datetime NULL COMMENT '승인일',
	REQ_REASON varchar(1000) NULL COMMENT '요청사유',
	INSERT_DT datetime NULL COMMENT '등록일',
	APP_COMMENT varchar(1000) NULL COMMENT '승인자 의견',
	ATTACH_SEQ1 varchar(50) NULL COMMENT '첨부파일1',
	ATTACH_SEQ2 varchar(50) NULL COMMENT '첨부파일2',
	PRIMARY KEY (BDG_REQ_ID, BRANCH_ID, BDG_ITEM_CD, BDG_YM)                                          
)
COMMENT = '예산증액요청';

CREATE TABLE BDG_USE_HIST (
	BDG_HIST_ID varchar(10) NOT NULL COMMENT '예산내역ID',
	BRANCH_ID varchar(10) NOT NULL COMMENT '사업장ID',
	BDG_ITEM_CD varchar(10) NOT NULL COMMENT '예산항목코드',
	BDG_YM varchar(10) NOT NULL COMMENT '예산년월',
	BDG_USE_INFO varchar(1000) NULL COMMENT '사용내역',
	REQ_BDG_AMT decimal(15,0) NULL COMMENT '예산신청금액',
	ASSIGN_BDG_AMT decimal(15,0) NULL COMMENT '배정예산',
	USED_BDG_AMT decimal(15,0) NULL COMMENT '사용예산',
	REMAIN_BDG_AMT decimal(15,0) NULL COMMENT '남은예산',
	BDG_USE_DT datetime NULL COMMENT '예산사용일시',
	PRIMARY KEY (BDG_HIST_ID)                                        
)
COMMENT = '예산사용내역';

