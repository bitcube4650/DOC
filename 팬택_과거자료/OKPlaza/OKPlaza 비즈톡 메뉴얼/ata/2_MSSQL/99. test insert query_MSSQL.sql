-- Format String : DS
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','1','버튼명^DS');


-- Format String : WL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','1','버튼명^WL^http://www.abiztalk.co.kr^http://www.abiztalk.co.kr');


-- Format String : AL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','1','버튼명^AL^bizapps://open^bizapps://open');


-- Format String : BK
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','1','버튼명^BK');


-- Format String : MD
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','1','버튼명^MD');


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JSON : DS
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','2','{"button":[{"name":"버튼명","type":"DS"}]}');


-- JSON : WL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','2','{"button":[{"name":"버튼명","type":"WL","url_pc":"http://abiztalk.co.kr","url_mobile":"http://abiztalk.co.kr"}]}');


-- JSON : AL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','2','{"button":[{"name":"버튼명","type":"AL","scheme_ios":"bizapps://open","scheme_android":"bizapps://open"}]}');


-- JSON : BK
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','2','{"button":[{"name":"버튼명","type":"BK"}]}');


-- JSON : MD
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','2','{"button":[{"name":"버튼명","type":"MD"}]}');


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- XML : DS
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','3','<?xml version="1.0"?><button_info><button><name>버튼명</name><type>DS</type></button></button_info>');


-- XML : WL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','3','<?xml version="1.0"?><button_info><button><name>버튼명</name><type>WL</type><mobile_url>http://abiztalk.co.kr</mobile_url><pc_url>http://abiztalk.co.kr</pc_url></button></button_info>');


-- XML : AL
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','3','<?xml version="1.0"?><button_info><button><name>버튼명</name><type>AL</type><scheme_android>bizapps://open</scheme_android><scheme_ios>bizapps://open</scheme_ios></button></button_info>');


-- XML : BK
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','3','<?xml version="1.0"?><button_info><button><name>버튼명</name><type>BK</type></button></button_info>');


-- XML : MD
-- 발송 INSERT (Senderkey, TemplateCode: 비즈톡 테스트용)
INSERT INTO ata_mmt_tran
(date_client_req, template_code, content, recipient_num, msg_status, subject, callback, sender_key, msg_type,kko_btn_type,kko_btn_info)
VALUES
-- (#{발송시간}, #{템플릿코드}, #{내용}, #{수신번호}, #{메시지상태}, ' ', #{보내는번호}, #{센더키}, '3', '1008')
(GETDATE(), 'TEST001', 'TEST MESSAGE. 등록된 템플릿이 아니므로 발송이 되지 않습니다.', '01000000000', '1', ' ', '010', 'AAAAAAAAAA',  '1008','3','<?xml version="1.0"?><button_info><button><name>버튼명</name><type>MD</type></button></button_info>');

