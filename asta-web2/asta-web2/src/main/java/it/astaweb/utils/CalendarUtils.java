package it.astaweb.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

public class CalendarUtils {
	
	private static final TimeZone timeZoneRome = TimeZone.getTimeZone("Europe/Copenhagen");
	
	private static final ThreadLocal<Calendar> calendarItalianThreadLocal = new ThreadLocal<Calendar>(){
		
		@Override
	    protected Calendar initialValue() {
			
			Calendar calendarItalian = new GregorianCalendar();
			calendarItalian.setTimeZone(timeZoneRome);
			return calendarItalian;
		}
	};
	
	private static final ThreadLocal<Calendar> calendarThreadLocal = new ThreadLocal<Calendar>(){
	    @Override
	    protected Calendar initialValue() {
	    	Calendar calendarItalian = calendarItalianThreadLocal.get();
			
			Calendar calendar = new GregorianCalendar(
					calendarItalian.get(Calendar.YEAR),
					calendarItalian.get(Calendar.MONTH),
					calendarItalian.get(Calendar.DATE),
					calendarItalian.get(Calendar.HOUR_OF_DAY),
					calendarItalian.get(Calendar.MINUTE),
					calendarItalian.get(Calendar.SECOND));
	        return calendar;
	    }
	  };
	
	public static Date currentTimeInItaly(){
		
		return currentCalendarInItaly().getTime();
		
	}
	
	public static Calendar currentCalendarInItaly(){
		
		return calendarThreadLocal.get();
	}

	public static Date currentTimeInItalyAddHour(int minSellTime) {
		Calendar calendar = currentCalendarInItaly();
		calendar.add(Calendar.HOUR, minSellTime);
		return calendar.getTime();
	}

}
