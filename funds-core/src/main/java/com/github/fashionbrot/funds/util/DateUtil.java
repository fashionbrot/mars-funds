package com.github.fashionbrot.funds.util;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {


    /**
     * 日期格式 年 月 日 如2009-02-26
     */
    public static final String DATE_FORMAT_DAY = "yyyy-MM-dd";
    /**
     * 日期格式年 月 日 时 分 秒 如 2009-02-26 15:40:00
     */
    public static final String DATE_FORMAT_SECOND = "yyyy-MM-dd HH:mm:ss";

    public static final DateTimeFormatter defaultFormatter = DateTimeFormatter.ofPattern(DATE_FORMAT_SECOND);

    public static final DateTimeFormatter DATE_FORMAT_DAY_FORMATTER = DateTimeFormatter.ofPattern(DATE_FORMAT_DAY);


    /**
     * 格式化 字符串 转 Date(yyyy-MM-dd HH:mm:ss)
     * @param dataStr
     * @return Date
     */
    public static Date parseDate(String dataStr){
        return parseDate(defaultFormatter,dataStr);
    }

    /**
     * 格式化 字符串 转 Date
     * @param formatter
     * @param dateStr
     * @return Date
     */
    public static Date parseDate(DateTimeFormatter formatter,String dateStr){
        if (StringUtil.isEmpty(dateStr)){
            return null;
        }
        LocalDateTime parse = LocalDateTime.parse(dateStr, formatter);
        ZoneId zone = ZoneId.systemDefault();
        Instant instant = parse.atZone(zone).toInstant();
        return Date.from(instant);
    }

    public static String formatDate(DateTimeFormatter formatter, Date date){
        return LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault()).format(formatter);
    }

    public static int getYear(Date date){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.YEAR);
    }

}
