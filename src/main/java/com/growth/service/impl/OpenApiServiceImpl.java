package com.growth.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.springframework.stereotype.Service;
import static com.growth.util.DateUtil.*;
import com.growth.service.OpenApiService;

@Service
public class OpenApiServiceImpl implements OpenApiService{

	private final String serviceKey = "XawnbvIIZkYXZb4T9DQURVkgC3HnKnjSuJgj%2BzTqB6JYpuA9SdN16vnDDSmq0vs%2FWFD8Txu9Y%2BbGkhmU9hJl1Q%3D%3D";
	
	@Override
	public List<HashMap<String, Object>> getEList() throws Exception {
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		HashMap<String,Object> temp = null;
		
		SAXBuilder builder = new SAXBuilder(); 

		//url에 xml이 있는경우

		Document doc = builder.build(new java.net.URL("http://openapi.q-net.or.kr/api/service/rest/InquiryTestInformationNTQSVC/getEList?serviceKey=" + serviceKey));
		
		Element root = doc.getRootElement();
		
		List<Element> items = root.getChild("body").getChild("items").getChildren("item");
		final String SOURCE_PATTERN = "yyyyMMdd";
		final String DEST_PATTERN = "yyyy.MM.dd";
		for( Element item : items ){
			temp = new HashMap<String,Object>();
			//차수 
			temp.put("description", item.getChild("description").getTextTrim());
			temp.put("docExamDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docExamDt").getTextTrim()));
			temp.put("docPassDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docPassDt").getTextTrim()));
			temp.put("docRegStartDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docRegStartDt").getTextTrim()));
			temp.put("docRegEndDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docRegEndDt").getTextTrim()));
			temp.put("docSubmitStartDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docSubmitStartDt").getTextTrim()));
			temp.put("docSubmitEntDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("docSubmitEntDt").getTextTrim()));
			temp.put("pracExamStartDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("pracExamStartDt").getTextTrim()));
			temp.put("pracExamEndDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("pracExamEndDt").getTextTrim()));
			temp.put("pracPassDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("pracPassDt").getTextTrim()));
			temp.put("pracRegEndDt" , convertDateFormat(SOURCE_PATTERN, DEST_PATTERN, item.getChild("pracRegEndDt").getTextTrim()));
			
			
			resultList.add(temp);
		}
		
		

		return resultList;
	}
	
}
