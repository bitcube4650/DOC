var netModule = (function($, window) {
	getContextPath = function () {
		  var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		  return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	},
	comAjax = function(_name, _url, _param, fn_callback){
		$.ajax({
			url : _url,
			dataType : 'json',
			contentType:"application/json; charset=UTF-8",
			data : JSON.stringify(_param),
			type : 'POST',
			async : true,
			beforeSend : function() {
				//show_loading();
				//$(".loadingBar").fadeIn();
			},
			success : function(result) {
				if(result.ResultCode == "Validation"){
					alert(result.ResultMsg);
				}else{
					if(fn_callback != undefined){
						fn_callback.call(this, _name, "success", result);
					}
				}
				
			},
			error : function(result, status, err, request) {
				alert('오류가 발생하였습니다.\n' + err);
				
				if(fn_callback != undefined){
					fn_callback.call(this, _name, "error", result);
				}
			},
			complete : function() {
				//hide_loading();
				//$(".loadingBar").fadeOut();
			}
		});
	}
	
	/*
	comAjax = function(_url, _param, fn_successCallback, fn_failCallback, fn_complateCallback){
		$.ajax({
			url : _url,
			//dataType : 'json',
			contentType:"application/json; charset=UTF-8",
			data : JSON.stringify(_param),
			type : 'POST',
			async : true,
			beforeSend : function() {
				show_loading();
			},
			success : function(result) { 
				if (result.result == "EXCEPTION") {
					var err_msg = result.message
					if (err_msg == null || err_msg == "") {
						errorBox('<spring:message code="MSG_005" javaScriptEscape="true"/>');//err_msg='오류가 발생하였습니다.\n잠시후에 다시 시도하십시오.';
					}
					fn_failCallback.call(this, result);
					return;
				}
				if(fn_successCallback != undefined){
					fn_successCallback.call(this, result);
				}

			},
			error : function(result, status, err, request) {
				if(fn_failCallback != undefined){
					fn_failCallback.call(this, result, err);
				}else alert('오류가 발생하였습니다.\n' + err);
			},
			complete : function() {
				if(fn_complateCallback != undefined){
					fn_complateCallback.call();
				}
				hide_loading();
			}
		});
	}
	*/
	openIframe = function(urlType, _params, _iframeId, _iframeName){
		url = getURL(urlType);
		_params.iframeId = _iframeId;
		_params.iframeName = _iframeName;
		_params.url = url;
		comAjax(_params.preServiceURL, _params, comIframeSuccessCallback, comIframeFailCallback);
	}
	
	openIframeProc = function(_url, _params, _iframeId, _iframeName){
		//var aesUtil = new AesUtil(128);
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", _url);
        for (var i in _params)
        {
            if (_params.hasOwnProperty(i))
            {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = i;
                input.value = _params[i];

                //EFORMDOC는  전체를 URLEncode 하여 Application쪽으로 전달 하기 때문에 다시  encode하지 않는다.
                if (i == "EP_EFORMDOC") {
                    input.value = _params[i];                    //암호화 안할 경우  [(EFORMDOC는   이미 URLEncode되어 있기 때문에 다시  encode하지 않는다.)]
                    //param.value = aesUtil.encode(_params[i]);  //암호화 할 경우     [유비스톰 암호화 모듈 사용(EFORMDOC는   이미 URLEncode되어 있기 때문에 다시  encode하지 않는다.)]
                } else if (i == "EP_CRYPTO") {
                    input.value = encodeURIComponent(_params[i]);                    //EP_CRYPTO는 암호화 하지않고  URI Encoding만 한다.
                } else if (i == "EP_BTN_COMPLETE"){
                	input.value = _params[i];                    //암호화 안할 경우  [(EFORMDOC는   이미 URLEncode되어 있기 때문에 다시  encode하지 않는다.)]
            	}else {
                	input.value = encodeURIComponent(_params[i]);                    //암호화 안할 경우 : URI Encoding 
                    //param.value = aesUtil.encode( encodeURIComponent(_params[i])); //암호화 할 경우 :  URI Encoding 후 유비스톰 암호화 모듈 사용
                }
                form.appendChild(input);
            }
        }
        
        form.appendChild(input);
        
        form.setAttribute("target", _iframeName);					
        var iframe = document.getElementById(_iframeId);
        document.body.appendChild(form);
        iframe.focus();
        form.submit(); 
	}
	
	getURL = function(urlType){
		var url = "";
		if(urlType == "viewer"){
			url = window.origin + contextPath + "/eformPlus/viewer/viewer.jsp";
		}else if(urlType == "editor"){
			url = window.origin + contextPath + "/eformPlus/editor/editor.jsp";
		}
		return url;
	}
	
	comIframeSuccessCallback = function(_res){
		openIframeProc(_res.url, _res, _res.iframeId, _res.iframeName);
	}
	comIframeFailCallback = function(_res){
		errorBox('<spring:message code="MSG_005" javaScriptEscape="true"/>');//err_msg='오류가 발생하였습니다.\n잠시후에 다시 시도하십시오.';
	}
	
	isJSONString = function(str){
		try {
			var json = JSON.parse(str);
		    return (typeof json === 'object');
		} catch (e) {
			return false;
		}
	}
	
	var contextPath = getContextPath();
	return{
		comAjax:comAjax,
		openIframe:openIframe,
		getURL:getURL,
		isJSONString:isJSONString
	};
	
})(jQuery, window);  
