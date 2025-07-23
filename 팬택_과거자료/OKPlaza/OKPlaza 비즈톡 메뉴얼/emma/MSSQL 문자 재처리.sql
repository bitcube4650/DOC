
/**************************************************************************/
/* NAME : sp_custom_failback_insert										  */
/* DESC : 알림톡 실패 건 문자 메시지 재 전송							  */
/* PARAMETERS															  */
/*   IN p_client_msg_key        : 전송키(mt_pr) 						  */
/*   IN p_mt_report_code_ib     : 결과코드								  */
/* REMARK																  */
/*   N/A																  */	
/**************************************************************************/
IF EXISTS (
    SELECT name
    FROM   sysobjects 
    WHERE  name = 'sp_custom_failback_insert' 
    AND    type = 'P' )
    DROP PROCEDURE sp_custom_failback_insert
GO

CREATE PROCEDURE sp_custom_failback_insert
    @p_client_msg_key int
  , @p_mt_report_code_ib char(4)
AS
      DECLARE
      @v_len int
    , @v_subject nvarchar(40)
	, @v_content nvarchar(4000)
	, @v_callback nvarchar(25)
	, @v_recipient_num nvarchar(25)

    -- 결과코드 성공 이외의 건만 재 전송
    IF @p_mt_report_code_ib = '1000'
    BEGIN
        RETURN;
    END
	
		SELECT 
		@v_len = DATALENGTH(content)
		 , @v_subject = subject
		 , @v_content = content
		 , @v_callback = callback
		 , @v_recipient_num = recipient_num
				 
	FROM   ata_mmt_tran 
	WHERE  mt_pr = @p_client_msg_key;
	
	IF @@ROWCOUNT = 0
	BEGIN 
    RETURN
	END
    	 -- LMS     
	IF @v_len > 90 
	BEGIN
		INSERT INTO em_mmt_tran 
		(
		   date_client_req, 
		   subject, 
		   content,  
		   callback, 
		   service_type, 
		   broadcast_yn, 
		   msg_status, 
		   recipient_num, 
		   crypto_yn
		) 
		VALUES
		(
			getdate(), 
			@v_subject, 
			@v_content,  
			@v_callback, 
			'3', 
			'N', 
			'1', 
			@v_recipient_num, 
			'Y'
		); 
	END
	
				 -- SMS    
	IF @v_len <= 90 
	BEGIN
		INSERT INTO em_smt_tran
		(
		  date_client_req, 
		  content,  
		  callback, 
		  service_type, 
		  broadcast_yn, 
		  msg_status, 
		  recipient_num, 
		  crypto_yn
		) 
		VALUES
		(
			getdate(), 
			@v_content, 
			@v_callback, 
			'0', 
			'N', 
			'1', 
			@v_recipient_num, 
			'Y'
		);
		
		END

          
RETURN
GO