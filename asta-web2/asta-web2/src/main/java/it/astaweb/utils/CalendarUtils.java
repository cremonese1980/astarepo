package it.astaweb.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

public class CalendarUtils {
	
	private static final TimeZone timeZoneRome = TimeZone.getTimeZone("Europe/Copenhagen");
	
	public static Date currentTimeInItaly(){
		
		
		Calendar calendarItalian = new GregorianCalendar();
		calendarItalian.setTimeZone(timeZoneRome);
		
		Calendar calendar = new GregorianCalendar(
				calendarItalian.get(Calendar.YEAR),
				calendarItalian.get(Calendar.MONTH),
				calendarItalian.get(Calendar.DATE),
				calendarItalian.get(Calendar.HOUR_OF_DAY),
				calendarItalian.get(Calendar.MINUTE),
				calendarItalian.get(Calendar.SECOND));
		
		return calendar.getTime();
		
		
	}
	
	public static void main(String[] args) {
		System.out.println(CalendarUtils.currentTimeInItaly());
	}

}
