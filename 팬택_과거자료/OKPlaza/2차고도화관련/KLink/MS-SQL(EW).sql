DROP TABLE EW0010 ;
DROP TABLE EW0030 ;


/* 1. EW0010 */
CREATE TABLE EW0010 
(
	EWCD             VARCHAR (15) NOT NULL,
	REG_ENP_NM       VARCHAR (150),
	REG_ENP_REPER_NM VARCHAR (150),
	REG_DT           VARCHAR (8),
	CHG_DT           VARCHAR (8),
	BZNO             VARCHAR (10),
	CONO             VARCHAR (13),
	PID              VARCHAR (13),
	TXPL_CLS         VARCHAR (3),
	EW_MODL_SGMT_CLS VARCHAR (2),
	DEL_YN           CHAR (1),
	CHG_CD           CHAR(1),
	UPD_DT           DATETIME NOT NULL DEFAULT (GETDATE())
);



ALTER TABLE "EW0010"  ADD CONSTRAINT "EW0010_PK" PRIMARY KEY ( EWCD);




/*  2.EW0030 */
CREATE TABLE EW0030 
(
	EWCD             VARCHAR (15) NOT NULL,
	BASE_DT          VARCHAR (8) NOT NULL,
	EWRT             VARCHAR (2),
	RT_CLS           VARCHAR (2),
	CR               CHAR (1),
	CR_CARD          CHAR (1),
	DB_NEXE_ENP      CHAR (1),
	DB_NEXE_REPER    CHAR (1),
	CR_GRD           CHAR (1),
	FIN              CHAR (1),
	LWST             CHAR (1),
	DBTR_MR          CHAR (1),
	IQ_HIS           CHAR (1),
	CTX_OV           CHAR (1),
	OVD_HOLD         CHAR (1),
	LQDT             CHAR (1),
	CR_KFB           CHAR (1),
	ADMIN            CHAR (1),
	WORKOUT          CHAR (1),
	NEXE_PURC_ENP    CHAR (1),
	NEXE_PURC_REPER  CHAR (1),
	CR_CURRENT       CHAR (1),
	CR_CARD_CURRENT  CHAR (1),
	CR_HIS           CHAR (1),
	CR_CARD_HIS      CHAR (1),
	UPD_DT           DATETIME NOT NULL DEFAULT (GETDATE())
);

ALTER TABLE "EW0030"  ADD CONSTRAINT "EW0030_PK" PRIMARY KEY (EWCD, BASE_DT);

