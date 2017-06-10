package com.growth.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	public static String convertDateFormat(String sourceFormat, String destFormat, String date ) throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat(sourceFormat);
		Date sourceDate = sdf.parse(date);
		sdf.applyPattern(destFormat);
		
		return sdf.format(sourceDate);
	}
}
