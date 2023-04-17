/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tools;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author IT-Programmer
 */
public class DateTimeGenerator {
    
       public static String GetMyDateTime() {
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String nowAsISO = df.format(new Date());
        return nowAsISO;
    }
}
