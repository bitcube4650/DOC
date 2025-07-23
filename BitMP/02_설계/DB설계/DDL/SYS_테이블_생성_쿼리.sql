CREATE TABLE SYS_BORGS (
	BORG_ID varchar(10) not null primary key COMMENT '조직ID',
	BORG_CD varchar(10) COMMENT '조직코드',
	BORG_NM varchar(100) COMMENT '조직명',
	TOP_BORG_ID varchar(10) COMMENT '최상위조직ID',
	PAR_BORG_ID varchar(10) COMMENT '상위조직ID',
	BORG_LEVEL INT COMMENT '조직레벨',
	BORG_TYPE_CD varchar(10) COMMENT '조직유형코드 (BORGTYPECD)',
	SVC_TYPE_CD varchar(10) COMMENT '서비스유형코드 (SVCTYPECD)',
	GROUP_ID varchar(10) COMMENT '그룹ID',
	CLIENT_ID varchar(10) COMMENT '법인ID',
	BRANCH_ID varchar(10) COMMENT '사업장ID',
	INSERT_DT datetime null COMMENT '생성일시',
	INSERT_USER_ID varchar(10) COMMENT '생성자ID',
	UPDATE_DT datetime null COMMENT '수정일시',
	UPDATE_USER_ID varchar(10) COMMENT '수정자ID',
	IS_USE varchar(1) not null default '1' COMMENT '사용여부',
	IS_REPRE varchar(1) not null default '0' COMMENT '대표사업장여부',
	IS_ORD_LIMIT varchar(1) not null default '0' COMMENT '법인주문제한여부',
	CLOSE_REASON varchar(200) COMMENT '종료사유',
	LOAN_AMT decimal(13,2) null COMMENT '여신금액',
	IS_PRE_PAY varchar(1) not null default '0' COMMENT '법인선입금여부',
	IS_LOAN varchar(1) not null default '0' COMMENT '법인여신사용여부',
	TRUST_GRADE varchar(10) COMMENT '신용등급',
	TRUST_DT datetime null COMMENT '기업신용등급평가일',
	TRUST_LIMIT_DT datetime null COMMENT '기업신용등급유효기간',
	ADJUST_DAY varchar(10) COMMENT '마감일'
)
COMMENT='조직마스터';

CREATE TABLE SYS_MENUS (
	MENU_ID int NOT null primary key COMMENT '메뉴ID',
	MENU_CD varchar(20) NULL COMMENT '메뉴코드',
	MENU_NM varchar(100) NULL COMMENT '메뉴명',
	TOP_MENU_ID int NULL COMMENT '최상위메뉴ID',
	PAR_MENU_ID int NULL COMMENT '상위메뉴ID',
	MENU_LEVEL int NULL COMMENT '메뉴레벨',
	DISP_NO int NULL COMMENT '출력순서',
	SVC_TYPE_CD varchar(20) NULL COMMENT '서비스유형코드 (SVCTYPECD)',
	IS_USE varchar(1) not null default '1' COMMENT '사용여부',
	FWD_PATH varchar(200) NULL COMMENT '경로URL',
	ICON VARCHAR(100) null COMMENT 'fontawesome'
)
COMMENT='메뉴';

CREATE TABLE SYS_MENUS_HIST (
	MENU_ID int NOT null COMMENT '메뉴ID',
	MENU_CD varchar(20) NULL COMMENT '메뉴코드',
	MENU_NM varchar(100) NULL COMMENT '메뉴명',
	TOP_MENU_ID int NULL COMMENT '최상위메뉴ID',
	PAR_MENU_ID int NULL COMMENT '상위메뉴ID',
	MENU_LEVEL int NULL COMMENT '메뉴레벨',
	DISP_NO int NULL COMMENT '출력순서',
	SVC_TYPE_CD varchar(20) NULL COMMENT '서비스유형코드 (SVCTYPECD)',
	IS_USE varchar(1) NULL COMMENT '사용여부',
	FWD_PATH varchar(200) NULL COMMENT '경로URL',
	ICON VARCHAR(100) null COMMENT 'fontawesome',
	HIST_USER_ID varchar(10) NULL COMMENT '이력등록자ID',
	HIST_DT DATETIME NULL COMMENT '이력등록일'
)
COMMENT='메뉴 이력';

CREATE TABLE SYS_ACTIVITIES (
	ACTIVITY_ID int NOT null primary key COMMENT '화면권한ID',
	ACTIVITY_CD varchar(20) null COMMENT '화면권한코드',
	ACTIVITY_NM varchar(100) null COMMENT '화면권한명',
	IS_USE VARCHAR(1) not null default '1' COMMENT '사용여부'
)
COMMENT='화면권한';

CREATE TABLE SYS_MENUS_ACTIVITIES (
	MENU_ID int NOT null COMMENT '메뉴ID',
	ACTIVITY_ID int NOT null COMMENT '화면권한ID',
	MENU_CD varchar(20) null COMMENT '메뉴코드',
	ACTIVITY_CD varchar(20) null COMMENT '화면권한코드',
	PRIMARY KEY (MENU_ID, ACTIVITY_ID)
)
COMMENT='메뉴화면권한';

CREATE TABLE SYS_MENUS_ACTIVITIES_HIST (
	MENU_ID int NOT null COMMENT '메뉴ID',
	ACTIVITY_ID int NOT null COMMENT '화면권한ID',
	MENU_CD varchar(20) null COMMENT '메뉴코드',
	ACTIVITY_CD varchar(20) null COMMENT '화면권한코드',
	HIST_USER_ID varchar(10) null COMMENT '이력등록자ID',
	HIST_DT datetime null COMMENT '이력등록일'
)
COMMENT='메뉴화면권한 이력';

CREATE TABLE SYS_SCOPES (
	SCOPE_ID int NOT null primary key COMMENT '영역ID',
	SCOPE_CD varchar(20) null COMMENT '영역코드',
	SCOPE_NM varchar(100) null COMMENT '영역 명',
	SCOPE_DESC varchar(300) null COMMENT '영역 설명',
	IS_USE VARCHAR(1) not null default '1' COMMENT '사용여부',
	SVC_TYPE_CD varchar(20) null COMMENT '서비스유형코드 (SVCTYPECD)'
)
COMMENT='영역';

CREATE TABLE SYS_SCOPES_HIST (
	SCOPE_ID int NOT null COMMENT '영역ID',
	SCOPE_CD varchar(20) null COMMENT '영역코드',
	SCOPE_NM varchar(100) null COMMENT '영역 명',
	SCOPE_DESC varchar(300) null COMMENT '영역 설명',
	IS_USE VARCHAR(1) not null default '1' COMMENT '사용여부',
	SVC_TYPE_CD varchar(20) null COMMENT '서비스유형코드 (SVCTYPECD)',
	HIST_USER_ID varchar(10) null COMMENT '등록자ID',
	HIST_DT DATETIME null COMMENT '등록일'
)
COMMENT='영역 이력';

CREATE TABLE SYS_SCOPES_ACTIVITIES (
	SCOPE_ID int NOT null COMMENT '영역ID',
	MENU_ID int NOT null COMMENT '메뉴ID',
	ACTIVITY_ID int NOT null COMMENT '화면권한ID',
	MENU_CD varchar(20) null COMMENT '메뉴코드',
	ACTIVITY_CD varchar(20) null COMMENT '화면권한코드',
	SCOPE_CD varchar(20) null COMMENT '영역코드',
	PRIMARY KEY (SCOPE_ID, MENU_ID, ACTIVITY_ID)
)
COMMENT='영역메뉴권한';

CREATE TABLE SYS_SCOPES_ACTIVITIES_HIST (
	SCOPE_ID int NOT null COMMENT '영역ID',
	MENU_ID int NOT null COMMENT '메뉴ID',
	ACTIVITY_ID int NOT null COMMENT '화면권한ID',
	MENU_CD varchar(20) null COMMENT '메뉴코드',
	ACTIVITY_CD varchar(20) null COMMENT '화면권한코드',
	SCOPE_CD varchar(20) null COMMENT '영역코드',
	HIST_USER_ID varchar(10) null COMMENT '등록자ID',
	HIST_DT DATETIME null COMMENT '등록일'
)
COMMENT='영역메뉴권한 이력';

CREATE TABLE SYS_ROLES (
	ROLE_ID int NOT null primary key COMMENT '권한ID',
	ROLE_CD varchar(20) null COMMENT '권한코드',
	ROLE_NM varchar(100) null COMMENT '권한명',
	ROLE_DESC varchar(300) null COMMENT '권한개요',
	SVC_TYPE_CD varchar(20) null COMMENT '서비스유형코드 (SVCTYPECD)',
	IS_USE varchar(1) not null default '1' COMMENT '사용여부',
	IS_INIT_ROLE varchar(1) not null default '0' COMMENT '사용자초기권한여부'
)
COMMENT='권한';

CREATE TABLE SYS_ROLES_HIST (
	ROLE_ID int NOT null COMMENT '권한ID',
	ROLE_CD varchar(20) null COMMENT '권한코드',
	ROLE_NM varchar(100) null COMMENT '권한명',
	ROLE_DESC varchar(300) null COMMENT '권한개요',
	SVC_TYPE_CD varchar(20) null COMMENT '서비스유형코드',
	IS_USE varchar(1) null COMMENT '사용여부',
	IS_INIT_ROLE varchar(1) null COMMENT '사용자초기권한여부',
	HIST_USER_ID varchar(10) null COMMENT '등록자ID',
	HIST_DT DATETIME null COMMENT '등록일'
)
COMMENT='권한 이력';

CREATE TABLE SYS_ROLES_SCOPES (
	SCOPE_ID int NOT null COMMENT '영역ID',
	ROLE_ID int NOT null COMMENT '권한ID',
	SCOPE_CD varchar(20) null COMMENT '영역 코드',
	ROLE_CD varchar(20) null COMMENT '권한코드',
	PRIMARY KEY (SCOPE_ID, ROLE_ID)
)
COMMENT='권한영역';

CREATE TABLE SYS_ROLES_SCOPES_HIST (
	SCOPE_ID int NOT null COMMENT '영역ID',
	ROLE_ID int NOT null COMMENT '권한ID',
	SCOPE_CD varchar(20) null COMMENT '영역 코드',
	ROLE_CD varchar(20) null COMMENT '권한코드',
	HIST_USER_ID varchar(10) null COMMENT '등록자ID',
	HIST_DT DATETIME null COMMENT '등록일'
)
COMMENT='권한영역 이력';

CREATE TABLE SYS_SEQUENCE (
	TABLE_NM varchar(30) NOT null primary key COMMENT '시퀀스명',
	NEXT_ID decimal(30,0) NOT null COMMENT '시퀀스번호'
)
COMMENT='시퀀스테이블';

CREATE TABLE SYS_CODE_TYPES (
	CODE_TYPE_ID INT NOT null primary key COMMENT '코드타입ID',
	CODE_TYPE_CD varchar(20) null COMMENT '코드타입CD',
	CODE_TYPE_NM varchar(100) null COMMENT '코드타입명',
	CODE_TYPE_DESC varchar(1000) null COMMENT '코드타입 설명',
	CODE_FL VARCHAR(10) null COMMENT '유형구분',
	INSERT_DT DATETIME null COMMENT '생성일시',
	INSERT_USER_ID varchar(10) null COMMENT '생성자ID',
	UPDATE_DT DATETIME null COMMENT '수정일시',
	UPDATE_USER_ID varchar(10) null COMMENT '수정자ID',
	IS_USE VARCHAR(1) not null default '1' COMMENT '사용여부'
)
COMMENT='코드타입';

CREATE TABLE SYS_CODES (
	CODE_ID INT NOT null primary key COMMENT '코드ID',
	CODE_TYPE_ID INT null COMMENT '코드타입ID',
	CODE_TYPE_CD varchar(20) null COMMENT '코드타입CD',
	CODE_VAL1 varchar(100) null COMMENT '코드값1',
	CODE_VAL2 varchar(200) null COMMENT '코드값2',
	CODE_VAL3 varchar(100) null COMMENT '코드값3',
	CODE_NM1 varchar(100) null COMMENT '코드명1',
	CODE_NM2 varchar(100) null COMMENT '코드명2',
	CODE_NM3 varchar(100) null COMMENT '코드명3',
	DISP_NO INT null COMMENT '순서',
	IS_USE VARCHAR(1) not null default '1' COMMENT '사용여부',
	INSERT_USER_ID varchar(10) null COMMENT '등록자ID',
	INSERT_DT DATETIME null COMMENT '등록일시',
	UPDATE_USER_ID varchar(10) null COMMENT '수정자ID',
	UPDATE_DT DATETIME null COMMENT '수정일시'
)
COMMENT='코드정보';
