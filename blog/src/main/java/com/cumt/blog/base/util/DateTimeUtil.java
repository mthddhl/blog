package com.cumt.blog.base.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {

    //返回年月日 时分秒
	public static String getSysTime(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date = new Date();
		String dateStr = sdf.format(date);
		
		return dateStr;
		
	}

    //返回年月日
    public static String getDate(){

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();
        String dateStr = sdf.format(date);

        return dateStr;

    }
	
}
