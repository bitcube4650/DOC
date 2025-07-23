SELECT 	A.CUST_CODE 
,		A.INTERRELATED_CUST_CODE
,		A.CUST_LEVEL 
,		A.CUST_VALUATION 
,		A.CERT_DATE 
,		A.CARE_CONTENT 
FROM 	T_CO_CUST_IR A


-- 이관 후 TO_BE 서버에서 수행(2021-01-01 이후 매핑이 등록안된 승인요청업체만 해당)
insert into t_co_cust_ir (CUST_CODE, INTERRELATED_CUST_CODE)
select	a.CUST_CODE 
,		A.INTERRELATED_CUST_CODE 
from 	t_co_cust_master a
where 	not exists(select 1 from t_co_cust_ir b where b.CUST_CODE=a.CUST_CODE)
and 	A.CERT_YN !='D'
and 	A.CREATE_DATE > '2021-01-01'