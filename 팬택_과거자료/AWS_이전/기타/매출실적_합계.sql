
SELECT	COUNT(1)
,		SUM(CASE	WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan>=0) THEN D.SHIPPING_QUAN 
					WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan<0) THEN E.SUPPLY_QUAN
					ELSE B.sale_prod_quan 
		END) AS sale_prod_quan_SUM
,		SUM(CASE	WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan>=0) THEN B.sale_prod_pris*D.SHIPPING_QUAN 
					WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan<0) THEN B.sale_prod_pris*E.SUPPLY_QUAN
					ELSE B.sale_prod_amou 
		END) AS sale_prod_amou_SUM
,		SUM(CASE	WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan>=0) THEN D.PURC_PROD_PRIS*D.SHIPPING_QUAN 
					WHEN (B.LOGI_YN='Y' AND B.sale_prod_quan<0) THEN E.PURC_PROD_PRIS*E.SUPPLY_QUAN
					ELSE B.purc_prod_amou
		END) AS purc_prod_amou_SUM
FROM	MSSALM A WITH(NOLOCK)
INNER JOIN MRORDTLIST B WITH(NOLOCK)
	ON	B.sale_sequ_numb = A.sale_sequ_numb
	AND	B.AGENT_ID = '13'
INNER JOIN SMPBRANCHS C WITH(NOLOCK)
	ON	C.BRANCHID = B.branchid
	AND	C.AGENT_ID = '13'
LEFT OUTER JOIN (	--�����ֹ�
				SELECT	X1.ORDE_IDEN_NUMB
				,		X1.ORDE_SEQU_NUMB
				,		X1.PURC_IDEN_NUMB
				,		X1.SHIPPING_QUAN
				,		X2.PURC_PROD_PRIS
				FROM	LOGI_SHIPPING X1 WITH(NOLOCK)
				INNER JOIN LOGI_INFO X2 WITH(NOLOCK)
					ON	X2.BARCODE = X1.BARCODE
					AND	X2.BARCODE_SEQ = '1'
		) D
	ON	D.ORDE_IDEN_NUMB = B.orde_iden_numb
	AND	D.ORDE_SEQU_NUMB = B.orde_sequ_numb
	AND	D.PURC_IDEN_NUMB = B.purc_iden_numb
	AND	B.sale_prod_quan > 0
LEFT OUTER JOIN (	--������ǰ
				SELECT	X1.ORDE_IDEN_NUMB
				,		X1.ORDE_SEQU_NUMB
				,		X1.PURC_IDEN_NUMB
				,		X2.SUPPLY_QUAN*(-1) AS SUPPLY_QUAN
				,		X3.PURC_PROD_PRIS
				FROM	MRAREM X1 WITH(NOLOCK)
				INNER JOIN LOGI_INFO X2 WITH(NOLOCK)
					ON	X2.RETU_IDEN_NUMB = X1.RETU_IDEN_NUM
				INNER JOIN LOGI_INFO X3 WITH(NOLOCK)
					ON	X3.BARCODE = X2.BARCODE
					AND	X3.BARCODE_SEQ = '1'
		) E
	ON	E.ORDE_IDEN_NUMB = B.orde_iden_numb
	AND	E.ORDE_SEQU_NUMB = B.orde_sequ_numb
	AND	E.PURC_IDEN_NUMB = B.purc_iden_numb
	AND	B.sale_prod_quan < 0
WHERE	A.clos_sale_date BETWEEN '2023-01-01' AND '2023-09-30'
AND		A.AGENT_ID = '13'
--AND		B.orde_iden_numb = 'BUY2309080004'	--�ֹ���ȣ
--AND		A.branchid = '305140'	-- ���Ż�
--AND		B.vendorid = '307564'	--���޻�
/*
AND		C.WORKID IN (	--�������
				SELECT	X1.WORKID
				FROM	SMPWORKINFO X1 WITH(NOLOCK)
				INNER JOIN SMPCODES X2 WITH(NOLOCK)
					ON	X2.CODEVAL1 = X1.MAT_KIND
					AND	X2.AGENT_ID = '13'
				WHERE	X1.AGENT_ID = '13'
				AND		X2.CODEVAL2 = '7'	--��������ڵ�
		)
*/