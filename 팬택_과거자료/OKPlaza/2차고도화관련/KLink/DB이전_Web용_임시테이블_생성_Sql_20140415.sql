/**********************  0002	(표준)기업개요
TKE001_INTR             **************************/
create table TMP0002
(
	KEDCD          VARCHAR(10) not null,
	ENP_NM         VARCHAR(150),
	ENP_NM_TRD     VARCHAR(150),
	ENP_NM_ENG     VARCHAR(300),
	ENP_TYP        char(1),
	ENP_SZE        VARCHAR(2),
	GRDT_PLN_DT    VARCHAR(8),
	ENP_FCD        VARCHAR(2),
	ESTB_FCD       VARCHAR(2),
	ENP_SCD        VARCHAR(2),
	ENP_SCD_CHG_DT VARCHAR(8),
	PUBI_FCD       VARCHAR(2),
	VENP_YN        char(1),
	ENP_FORM_FR    VARCHAR(1),
	BZC_CD         VARCHAR(6),
	FS_BZC_CD      VARCHAR(2),
	GRP_CD         VARCHAR(4),
	GRP_NM         VARCHAR(75),
	CONO_PID       VARCHAR(13),
	ESTB_DT        VARCHAR(8),
	IPO_CD         char(1),
	TRDBZ_RPT_NO   VARCHAR(10),
	LIST_DT        VARCHAR(8),
	DLIST_DT       VARCHAR(8),
	MTX_BNK_CD     VARCHAR(7),
	MTX_BNK_NM     VARCHAR(181),
	OVD_TX_BNK_CD  VARCHAR(7),
	OVD_TX_BNK_NM  VARCHAR(181),
	ACCT_EDDT      VARCHAR(4),
	HPAGE_URL      VARCHAR(75),
	EMAIL          VARCHAR(90),
	STD_DT         VARCHAR(8),
	BZNO           VARCHAR(10),
	LOC_ZIP        VARCHAR(6),
	LOC_ADDRA      VARCHAR(300),
	LOC_ADDRB      VARCHAR(300),
	TEL_NO         VARCHAR(20),
	FAX_NO         VARCHAR(20),
	LABORER_SUM    numeric(13),
	PD_NM          VARCHAR(150),
	KSIC9_BZC_CD   VARCHAR(6),
	REL_KEDCD              VARCHAR(10),
	REL_ESTB_DT            VARCHAR(8),
	LOC_RDNM_ZIP           VARCHAR(6),
	LOC_RDNM_ADDRA         VARCHAR(150),
	LOC_RDNM_ADDRB         VARCHAR(300),
	LOC_RDNM_ADDRB_CONF_YN VARCHAR(1),
	LOC_ADDRB_CONF_YN      VARCHAR(1),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0002  ADD CONSTRAINT IX_TMP0002_PK PRIMARY KEY (KEDCD);

/**********************  0004	(표준)대표자정보
TKE010_REPER            **************************/
create table TMP0004
(
	KEDCD             VARCHAR(10) not null,
	PCD               VARCHAR(10) not null,
	STD_DT            VARCHAR(8),
	NAME              VARCHAR(90),
	PID               VARCHAR(13),
	REPER_CCD         VARCHAR(2),
	MRK_REPER_YN      VARCHAR(1),
	ASMP_DT           VARCHAR(8),
	RTIR_DT           VARCHAR(8),
	PO_YN             VARCHAR(1),
	TTL               VARCHAR(45),
	MNG_FCD           VARCHAR(2),
	SBZC_EG_YCN_REPER numeric(2),
	SBZC_EG_MCN_REPER numeric(2),
	SIND_EG_PRD_YY    numeric(2),
	SIND_EG_PRD_MM    numeric(2),
	SBZC_EVL_CD       VARCHAR(2),
	MDM_REL_CD        VARCHAR(2),
	REPER_MABL_CD     VARCHAR(2),
	CSTK_OWN          numeric(13),
	PSTK_OWN          numeric(13),
	SO_REG_CN         numeric(13),
	RMK               VARCHAR(300),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0004  ADD CONSTRAINT IX_TMP0004_PK PRIMARY KEY (KEDCD, PCD);


/**********************  0011	(표준)관계회사
TKE004_RENP             **************************/
create table TMP0011
(
	KEDCD          VARCHAR(10) not null,
	STD_DT         VARCHAR(8) not null,
	RENP_SEQ       VARCHAR(4) not null,
	RENP_NM        VARCHAR(150),
	CONO_PID       VARCHAR(13),
	RENP_KEDCD     VARCHAR(10),
	RENP_REPER_NM  VARCHAR(90),
	RENP_ZIP       VARCHAR(6),
	RENP_ADDRA     VARCHAR(90),
	RENP_ADDRB     VARCHAR(90),
	RENP_BZCD_NM   VARCHAR(45),
	RENP_MPD_NM    VARCHAR(75),
	RENP_ACCT_DT   VARCHAR(8),
	RENP_CAP       numeric(13),
	RENP_TASET     numeric(13),
	RENP_SALE_AM   numeric(13),
	RENP_CT_NPF    numeric(13),
	EQRT           numeric(5,2),
	BUY_AM         numeric(15),
	RENP_BUY_RIPT  numeric(5,2),
	SAM            numeric(15),
	RENP_SALE_RIPT numeric(5,2),
	PGRN_AM        numeric(15),
	RENP_BON_T_AMT numeric(15),
	RENP_DB_T_AMT  numeric(15),
	REL_CTT        VARCHAR(150),

	RENP_RDNM_ZIP           VARCHAR(6),
	RENP_RDNM_ADDRA         VARCHAR(150),
	RENP_RDNM_ADDRB         VARCHAR(300),
	RENP_RDNM_ADDRB_CONF_YN VARCHAR(1),
	RENP_ADDRB_CONF_YN      VARCHAR(1),

	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0011  ADD CONSTRAINT IX_TMP0011_PK PRIMARY KEY (KEDCD, STD_DT, RENP_SEQ);


/**********************  0013	(표준)주주현황
TKE028_STH              **************************/
create table TMP0013
(
	KEDCD       VARCHAR(10) not null,
	STD_DT      VARCHAR(8) not null,
	STH_STT_SEQ VARCHAR(4) not null,
	STH_CCD     VARCHAR(2),
	STH_NM      VARCHAR(150),
	KEDCD_PCD   VARCHAR(10),
	CONO_PID    VARCHAR(13),
	MDM_REL_CD  VARCHAR(2),
	ENP_REL_CD  VARCHAR(2),
	OWN_STK_CN  numeric(13),
	CSTK_CN     numeric(13),
	PSTK_CN     numeric(13),
	EQRT        numeric(5,2),
	CSTK_RT     numeric(5,2),
	PSTK_RT     numeric(5,2),
	OWN_STK_AM  numeric(13),
	RMK         VARCHAR(300),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0013  ADD CONSTRAINT IX_TMP0013_PK PRIMARY KEY (KEDCD, STD_DT, STH_STT_SEQ);


/**********************  0014	(표준)사업장
TKE016_BZPL             **************************/
create table TMP0014
(
	KEDCD          VARCHAR(10) not null,
	BZPL_CD        VARCHAR(2) not null,
	BZPL_SEQ       VARCHAR(4) not null,
	BZNO           VARCHAR(10),
	BZPL_NM        VARCHAR(150),
	MBZPL_YN       char(1),
	ACTL_WK_YN     char(1),
	OFBK_ACTL_CCD  char(1),
	LOC_ZIP        VARCHAR(6),
	LOC_ADDRA      VARCHAR(300),
	LOC_ADDRB      VARCHAR(300),
	TEL_NO         VARCHAR(20),
	FAX_NO         VARCHAR(20),
	TAXO_NM        VARCHAR(45),
	MPD            VARCHAR(150),
	LOC_CND_CCD    VARCHAR(2),
	EP_PREV_YN     char(1),
	INDCP_NM       VARCHAR(75),
	LOC_CND_ETC    VARCHAR(300),
	LSZE_METR      numeric(13),
	LSZE_UAR       numeric(13),
	BSZE_METR      numeric(13),
	BSZE_UAR       numeric(13),
	OWNER          VARCHAR(90),
	OWNER_CONO_PID VARCHAR(13),
	OWNER_REL_CD   VARCHAR(2),
	OWN_YN         char(1),
	LES_GAM        numeric(13),
	LES_GAM_AM_CD  numeric(2),
	MMR            numeric(13),
	MMR_AM_CD      VARCHAR(2),
	RVIOL_YN       char(1),
	MOG_OFR_YN     char(1),
	T_SUP_AM       numeric(13),
	MOG_CTT        VARCHAR(1500),
	RMK            VARCHAR(300),
	STD_DT         VARCHAR(8),

	LOC_RDNM_ZIP           VARCHAR(6),
	LOC_RDNM_ADDRA         VARCHAR(150),
	LOC_RDNM_ADDRB         VARCHAR(300),
	LOC_RDNM_ADDRB_CONF_YN VARCHAR(1),
	LOC_ADDRB_CONF_YN      VARCHAR(1),

	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0014  ADD CONSTRAINT IX_TMP0014_PK PRIMARY KEY (KEDCD, BZPL_CD, BZPL_SEQ);

                         

/**********************  0016	(표준)인원현황
TKE022_EM               **************************/
create table TMP0016
(
	KEDCD           VARCHAR(10) not null,
	STD_DT          VARCHAR(8) not null,
	TTL_CD          VARCHAR(2) not null,
	ORDN_MEM        numeric(13),
	ORDN_FEM        numeric(13),
	ORDN_EM         numeric(13),
	T_YSLRY_MEM     numeric(12),
	T_YSLRY_FM      numeric(12),
	T_YSLRY         numeric(12),
	AVG_SLRY_PE_MEM numeric(12),
	AVG_SLRY_PE_FE  numeric(12),
	AVG_SLRY_PE     numeric(12),
	AVG_WK_PRD_MEM  numeric(5,2),
	AVG_WK_PRD_FM   numeric(5,2),
	AVG_WK_PRD      numeric(5,2),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0016  ADD CONSTRAINT IX_TMP0016_PK PRIMARY KEY (KEDCD, STD_DT, TTL_CD);



/**********************  0025	(표준)공인규격
TKE024_PSTD             **************************/
create table TMP0025
(
	KEDCD    VARCHAR(10) not null,
	PSTD_SEQ VARCHAR(4) not null,
	PSTD_KCD VARCHAR(150),
	PSTD_NM  VARCHAR(150),
	PSTD_CTT VARCHAR(300),
	PMSS_NO  VARCHAR(150),
	APR_INST VARCHAR(150),
	ACQ_DT   VARCHAR(8),
	VLD_DT   VARCHAR(8),
	REL_PD   VARCHAR(300),
	RMK      VARCHAR(300),
	STD_DT   VARCHAR(8),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0025  ADD CONSTRAINT IX_TMP0025_PK PRIMARY KEY (KEDCD, PSTD_SEQ);


/**********************  0026	(표준)주요거래처
TKE041_MTXPL            **************************/
create table TMP0026
(
	KEDCD           VARCHAR(10) not null,
	STD_DT          VARCHAR(8) not null,
	TXPL_CCD        VARCHAR(1) not null,
	TXPL_SEQ        VARCHAR(4) not null,
	TX_AM_BASE_STDT VARCHAR(8),
	TX_AM_BASE_EDDT VARCHAR(8),
	TXPL_NM         VARCHAR(150),
	TEL_NO          VARCHAR(20),
	BZNO            VARCHAR(10),
	TXPL_KEDCD      VARCHAR(10),
	DO_CCD          VARCHAR(1),
	TX_FCD          VARCHAR(75),
	PD_NM           VARCHAR(150),
	PD_CD           VARCHAR(9),
	TX_AM           numeric(13),
	TX_RT           numeric(5,2),
	TX_PRD          numeric(2),
	CSH_STL_RT      numeric(5,2),
	CR_STL_RT       numeric(5,2),
	CR_STL_DCN      numeric(4),
	CND_ETC         VARCHAR(300),
	RMK             VARCHAR(300),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0026  ADD CONSTRAINT IX_TMP0026_PK PRIMARY KEY (KEDCD, STD_DT, TXPL_CCD, TXPL_SEQ);
                          

/**********************  0041	(표준)종합신용등급
TNC119_SV_GRD           **************************/
CREATE TABLE TMP0041 
(
	KEDCD            VARCHAR (10) NOT NULL,
	REG_DT           VARCHAR (8) NOT NULL,
	EVL_DT           VARCHAR (8) NOT NULL,
	STTL_BASE_DD     VARCHAR (8),
	GRD_CLS          VARCHAR (2),
	CR_GRD           VARCHAR (8),
	MODL_EVL_DT      VARCHAR (8),
	IVG_MTD_CLS      VARCHAR (2),
	GRD_SV_ST_DD     VARCHAR (8),
	GRD_SV_EDDT      VARCHAR (8),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0041  ADD CONSTRAINT IX_TMP0041_PK PRIMARY KEY (KEDCD, REG_DT);


/**********************  0050	(표준) 현금흐름등급	
TKE081_FANAL_DATA        **************************/
CREATE TABLE TMP0050 
(
	KEDCD            VARCHAR (10) NOT NULL,
	STTL_BASE_YM_DD  VARCHAR (8) NOT NULL,
	FS_INFO_CD       VARCHAR (2) NOT NULL,
	ACCT_CCD         CHAR (1) NOT NULL,
	ACC_CD_FULL      VARCHAR (10) NOT NULL,
	VAL              numeric (22,7),
	ITM_STL          VARCHAR (20),
	UPD_DT         DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE TMP0050  ADD CONSTRAINT IX_TMP0050_PK PRIMARY KEY (KEDCD, STTL_BASE_YM_DD, FS_INFO_CD, ACCT_CCD, ACC_CD_FULL);

