package controller.tool;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateManger {
    public String getSimpleDate(String d) throws ParseException {
        Date date =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(d);
        DateFormat dateFormat  = new SimpleDateFormat("MM-dd HH");
        String sd = dateFormat.format(date);
        return sd;
    }
}
