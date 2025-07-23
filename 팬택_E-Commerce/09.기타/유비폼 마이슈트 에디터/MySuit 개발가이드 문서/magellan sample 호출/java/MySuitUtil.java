package appSample.cmmn;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


public class MySuitUtil {

	@SuppressWarnings("unchecked")
	public static HashMap<String, Object> ubExportServerSide(HashMap<String, String> _param ,String _url) throws UnsupportedEncodingException
	{
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
        HttpPost postRequest = new HttpPost(_url);
        List<NameValuePair> nameValuePairs = new ArrayList<>();

        if( _param != null ) {
        	for(String _keySet : _param.keySet()) {
        		String _value = _param.get(_keySet);
        		nameValuePairs.add(new BasicNameValuePair(_keySet,_value));
        	}
        }
        
        postRequest.setEntity(new UrlEncodedFormEntity(nameValuePairs));
        
		HttpClient httpclient = null;
		HttpClientBuilder httpBuilder = HttpClientBuilder.create();
		
		try {
			
			httpBuilder.setUserAgent("UBIFORM");
			httpclient = httpBuilder.build();
			
		    HttpResponse response = httpclient.execute(postRequest); 
	        HttpEntity entity = response.getEntity();
		    
	        if (entity != null) {
	            InputStream inputStream = entity.getContent();
	            
	            InputStreamReader inputR = new InputStreamReader(inputStream , "UTF-8");
	            BufferedReader resultBuf = new BufferedReader(inputR);
	            
	            String sUbRtn = "";
	            String sRtn   = "";
	            
	            while(true)
				{
	            	sUbRtn = resultBuf.readLine();
					if( sUbRtn == null) break;
					
					sRtn = URLDecoder.decode(sUbRtn, "UTF-8");
				}
	            
	            //Gson lib 사용
	            //Gson gson = new Gson();
	            //returnMap = gson.fromJson(sRtn, new TypeToken<HashMap<String, Object>>() {}.getType());
	            
	            //jackson lib 사용
	            ObjectMapper objectMapper = new ObjectMapper();
	            returnMap = objectMapper.readValue(sRtn, HashMap.class);
	            
	            System.out.println("");
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			postRequest.abort();
			httpclient  = null;
			httpBuilder = null;
		}
        
        return returnMap;
	}

	
	public static List<HashMap<String, String>> listData() throws Exception {
		List<HashMap<String, String>> returnList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("col_0", "테스트 1");
		paramMap.put("col_1", "테스트 DATA 1");
		returnList.add(paramMap);
		paramMap.put("col_0", "테스트 2");
		paramMap.put("col_1", "테스트 DATA 2");
		returnList.add(paramMap);
		paramMap.put("col_0", "테스트 3");
		paramMap.put("col_1", "테스트 DATA 3");
		returnList.add(paramMap);
		
		return returnList;
	}
	
	
}
