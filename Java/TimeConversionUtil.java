package com.jiansong.practise.controller;

import org.springframework.util.Assert;

import java.time.Clock;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * JAVA JDK1.8 时间戳与时间格式化 实用工具类
 *
 * @author W9010597 2021/07/06 9:08
 */
public class TimeConversionUtil {
    /*
     * 传入long时间戳，转换成格式化的String类型
     */
    public String TimeOfLongToStr(long time) {
        Assert.notNull(time, "time is null");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return dtf.format(LocalDateTime.ofInstant(Instant.ofEpochMilli(time), ZoneId.systemDefault()));
    }

    /**
     * 传入String类型格式化时间，转换成Long类型的时间戳
     */
    public long TimeOfStrToLong(String strTime) {
        Assert.notNull(strTime, "time is null");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime parse = LocalDateTime.parse(strTime, dtf);
        return LocalDateTime.from(parse).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
    }

    /**
     * 通过LocalDateTime获取当前格式化时间
     */
    public String getTimeStrNow() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    /**
     * 通过LocalDateTime获取当前格式化时间
     */
    public String getTimeStrNow1() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    /**
     *  获取当前时间戳方法一
     */
    public long getTimeLongOfClock() {
        return Clock.systemDefaultZone().millis();
    }

    /**
     * 获取当前时间戳方法2
     */
    public long getTimeLongOfCalendar() {
        Calendar calendar = Calendar.getInstance();
        return calendar.getTimeInMillis();
    }

    /**
     * 获取当前时间戳方法3
     */
    public long getTimeLongOfSystem() {
        return System.currentTimeMillis();
    }

    /**
     * 获取当前时间戳方法4
     */
    public long getTimeLongOfDate() {
        Date date = new Date();
        return date.getTime();
    }

    /**
     * 获取当前时间戳方法5
     */
    public long getTimeLongOfInstant() {
        Instant now = Instant.now().plusMillis(TimeUnit.HOURS.toMillis(8));
//        System.out.println("秒数:" + now.getEpochSecond());
//        System.out.println("毫秒数:" + now.toEpochMilli());
        return now.toEpochMilli();
    }

    /**
     * 获取两天之间相差多少天
     */
    public String getTransTime(String timeStr) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime date = LocalDateTime.parse(timeStr, dtf);

        DateTimeFormatter f2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String transTime = f2.format(date);
        return transTime;
    }




    public static void main(String[] args) {
        TimeConversionUtil timeConversionUtil = new TimeConversionUtil();
        System.out.println(timeConversionUtil.getTimeLongOfCalendar());
        System.out.println(timeConversionUtil.getTimeLongOfDate());
        System.out.println(timeConversionUtil.getTimeLongOfInstant());
        System.out.println(timeConversionUtil.TimeOfLongToStr(timeConversionUtil.getTimeLongOfDate()));
        System.out.println(timeConversionUtil.getTimeStrNow());
        System.out.println(timeConversionUtil.getTransTime("2021-03-17 00:00:00"));
    }
}
