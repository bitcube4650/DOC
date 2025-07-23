-- To-Be 실DB에서 수행
DELETE FROM t_co_user_interrelated;

insert into t_co_user_interrelated 
select	B.INTERRELATED_CUST_CODE 
,		A.USER_ID 
from 	t_co_user A
cross join t_co_interrelated b
where 	A.USER_AUTH = '4';

