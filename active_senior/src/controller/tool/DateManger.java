package controller.tool;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateManger {
    public static String getSimpleDate(String d) throws ParseException {
        if (d == null) return "";
        Date date =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(d);
        DateFormat dateFormat  = new SimpleDateFormat("MM-dd HH");
        String sd = dateFormat.format(date);
        return sd;
    }

    public static String getSimpleDate(Date d) throws ParseException {
        if(d == null) return "";
        DateFormat dateFormat  = new SimpleDateFormat("MM-dd HH");
        String sd = dateFormat.format(d);
        return sd;
    }

    public static String getDate(String d) throws ParseException {
        if (d == null) return "";
        Date date =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(d);
        DateFormat dateFormat  = new SimpleDateFormat("yyyy-MM-dd");
        String sd = dateFormat.format(date);
        return sd;
    }

    public static Date stringToDate(String d) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date to = sdf.parse(d);
        return to;
    }

    public static int compareDate(String d1, String d2) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date day1 = sdf.parse(d1);
        Date day2 = sdf.parse(d2);
        return day1.compareTo(day2);
    }
}
