package appSample.main.web;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import appSample.cmmn.MySuitUtil;
import appSample.cmmn.util.CommonMessageSource;
import appSample.main.service.MainService;

/**
 * @Class Name : MainController.java
 * @Description : Main Controller Class
 * @Modification Information
 * @
 * @  수정일        수정자              수정내용
 * @ ---------    ---------   -------------------------------
 * @ 2022.04.12           최초생성
 *
 * @author 지원팀
 * @since 
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class MainController {
	private Logger log = LogManager.getLogger(this.getClass());
	
	/** EgovSampleService */
	@Resource(name = "mainService")
	private MainService mainService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Resource(name="commonMessageSource")
    CommonMessageSource commonMessageSource;
	
	
	/**
	 * MySuit File Export
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@ResponseBody	
	@RequestMapping(value = "/javaMysuitExport.do")
	public ModelAndView javaMysuitExport(@RequestBody HashMap<String, Object> requestMap) throws Exception {
		log.debug("*************** /javaMysuitExport.do START ***************");
		
		ModelAndView mnv = new ModelAndView("jsonView");

		
		ObjectMapper jsonSring = new ObjectMapper();
		String sUrl = "http://localhost:9080/UBIFORM/ubiform.do";
		
		List<HashMap<String, Object>> arrParamList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> objFormInfo = new HashMap<String, Object>();
		objFormInfo.put("projectName" ,"project");
		objFormInfo.put("formName"    ,"report1");
		HashMap<String, String> objParam = new HashMap<String, String>();
		objParam.put("Key_101"   ,"Test parameter data");
		
		objParam.put("dataset_0" ,jsonSring.writeValueAsString(MySuitUtil.listData()) );
		objFormInfo.put("parameter" ,objParam);
		arrParamList.add(0, objFormInfo);

		
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("METHOD_NAME"         ,"exportServerSide");
		paramList.put("CALL"                ,"VIEWER5");
		paramList.put("FILE_TYPE"           ,"exec");
		paramList.put("MULTI_FORM_TYPE"     ,"M");
		paramList.put("UB_EXPORT_FILE_TYPE" ,"PDF");
		paramList.put("UB_FORMLIST_INFO"    ,URLEncoder.encode(jsonSring.writeValueAsString(arrParamList), "UTF-8") );
		paramList.put("accessKey" ,""); 		// (필수) 리포트 접속 키값
		paramList.put("saasDivision" ,""); 		// T: Test(개발) O: Operation(운영)
		paramList.put("magellanCommonDoc" ,""); // Y: 공통서식여부
		
		// return type : BASE 64 (파일생성과 같이 사용가능)
		paramList.put("RTN_INCLUDE_B64"     ,"true");
		
		// return type : 파일생성 
		paramList.put("UB_EXPORT_FILE_PATH" ,"D:/SIProject/UBIFORM/workspace/appSample/src/main/webapp/download/");
		//paramList.put("UB_EXPORT_FILE_NAME" ,"pdfFile"); // 주석인 경우 파일명:time
		
		//paramList.put("EXPORT_RESULT_TYPE"  ,"FILE"); // binary return
		
		//UB_DOCUMENT_DATA = base64 ubjf data
		//paramList.put("UB_DOCUMENT_DATA"    ,"Z3xSqRpnwdEYPYmEjqzqACqaCKvydsl8TmjvxaavUPTe3KUFOlxo2v8TEbgIHPMaR8sixAY1QDuxAZ8H3f3ihVxBHoYqcQXlJhZPgaKnXhVzNxIwzOxzLUZOMKGgoVTnOh57su02IEKPVJHRcqSRm%2F7J2dRXWQs3V3bnj%2BNoAndyo8bex5sY0TQyoOV861tHNzmMpm43Q74mG%2BCjYf8A6eaHxnrVW8Ke%2B4SymHveoaR5roZLDEBEENrA4QL9CfLBvuQ51%2FmHJAXH31HTkOatmG6MY9Brwxs4p0lo%2FRmCLPk%2FEB5FqiGXWAGaVYoVqII0imoSMw8xrqNz7XPppP%2B4ne97JF4uZvWeOi21szDcD2BKIpzG3%2FmodJjWQ0vC7CuOTiwHXZMfYDfyMGMo909MFP0qgV0Vob8Nqzg7LfLsTNvUvh8G2NHcBt%2FyaCokDauoTLqZpIgfVJeMxnWefHMEk1EsmGIs5nj54MDhAJ82r7sMFtBj%2FO5XRnmHeUAEndtPB1fHwf0w4yLkzyV9pq7cBylow%2FC0E4z0UfZfvqi2oLIbvgA2Xuc3fRm23Hi%2B68JDRG9n9f%2F2D9YkhdDoBq4ratCDbypOblp7bq1ZZVmtAzWEfdsQ7p%2FSWKkqNVL3sJG4hCEO94I%2FX8nFSYNuKrcnR%2B4gPfT7etTlS8oxIFG%2B3d5kryGAqr%2Fjm0GaVoBT2C%2FSMZ1fPkWs9quX3fFDQ0CXx8nQLZguk75a5IQPYYFfmxF4fQTYH2gRuwVeDm%2BrzRl%2BBh2PSE0RdPc1m%2FHgTbsF3F8Y4sn2z0SX9jLujnwqXyQt1RRylElbNvbz0rtNwlJtiEjwW7CRHPwjIx3QD4q3PNVozv5z3ZVmvwKEUAt5lTQqZc3BwRruGOtjvTxXCFyEfAu%2BBwZOGwcMG0KaACIdORVuMmVJOm89dgtkeHqo3K8umX4dMvOERKpOwXlA0iULH9BFAS4WHkaLQAvRdT2HowJPq1fPsvGjngYztDV4wOXiP67W0LqFE5NZOeGpKivuL8WBKAEV%2FMBbqOAizC1%2B1I63Ek8HHwTFcwi8jfZbjuEgybcZDZNvJHJr3Is4wqw4Co8nUM3Dd4prwpjYtD%2BYBGEtWTTOvl1jjWDUGJd7ywnpLW2T%2FICxOkAY6fBameA6GGV4jaW9Dv68BQ6e7ycZjqTB%2F2oE0p%2B35xkD%2B3ogxwo%2FBseZSuewippQe%2BEFShWdn0M7db962sAUK81ttNVz3TgHVnGIt4VjTgy1K5D%2FRGskkOlvZpUSejxJ1TjOgaN90jDPU6W9Gcbj274e7gUFLokO02vVqGjr%2BpUpHCUFArUUX990gNS3%2FUswiew8dnWWuFgpN%2BSt6a%2FLPdMWDcfhyhrPMYjRHcdyv%2BWQCL1Y%2Bwsajzhgo6kF5QidVUGlIDLIjdaYMuLHKr6MFArxFhPTO12t4UZD1KvUemtNIsEnrwVYE87QQPzf47o2k915zHCbTTRbl537iwqjN3XQL12Y%2FSx7%2F1IVkHGyo6cZrcNHHGssSfzjC0EJVTNJhXLBMAyvRnhyoJZlhxhva1oa6HGyF6qVg4YcZ28R4ELbsxWEnEnpwfVGK5aDjCoZwVYFFyNnADBUyM%2FtkRuwLWKp17tTbZBmH0biyli6%2FvTTHahte8aQGolTSCH8UPo53dbHzfvwHeqRTicGIb7lCj6kGvxBlXnQJsyYp7feGn12fMP4mkn6iUWdxIDLPBd%2B78v4IZnwExbxsIyHxlouKRtJ%2FCSjBcfvuzENZ6%2BanFbbP0A3%2BhkNKJLU9Z6m2gCDqTlKvCwCnwOywGWGcdDyntqbofxg9Hjjx1VimkivK8vZiq41R9ByVkufgX2Vd5gH0HV4Mir0SMLoQOqJ%2FqWZIHRgl8ZdTWjQ3qrV10GMwe0OML1C5%2BFR%2B%2FXgmyxWeUZNKTxHrp6fVmVM3aCL8Afb3uj6s24S9Do8Ru1rn1ecFPJweOqqy0FJlOCSY8gmmFkPEKyhkD3Ol8e6AcGf2Y1gvizB19hQ9MYKhd7%2FH%2BPUZM9Hlqx2TmS8yCj9kElRnQg2usRBfg9hutMaVhBqxx%2Bu%2FFcYY0VllGeA1hNHCKXLgd3WTNMoc6wOIOdH8WwD1siZtgCiesIJo39GMEXX5GdthgiV3X2rjTxWsN5WI8z2iOSong715yd0YzB1yCNZOMryxuNxvz5%2Fz2v1EKhzN%2F4kaRnAeHQLjloXlJsgXTPR0aIQ2iZ%2FtbpYv%2BaIhJQcnTBanPxUxNiiNtpD67mjZcolhoPmygPgEM%2FP2NXxkVVO0GAnZxuIJbO%2BTbbO4ATbIBpltlkevkyuvyO%2FuBlWImgIgNhVG%2BPwnfq%2FC2yR5ut7tdA99BdDOeVKjtXji5iCpsPRQJG45KGR");   
		
		HashMap<String, Object> ubRtnMap = MySuitUtil.ubExportServerSide(paramList ,sUrl);
		
		
		HashMap<String, Object> ubRtnMapResult = (HashMap<String, Object>) ubRtnMap.get("Result");
		HashMap<String, Object> ubRtnMapData   = (HashMap<String, Object>) ubRtnMap.get("Data");
		
		return mnv;
	}
	

	
	}
