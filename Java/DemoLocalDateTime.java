package test03;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;

/**
 * Java 8 日期时间 API
 *
 * @author W9010597 2021/07/21 8:36
 */
public class DemoLocalDateTime {
    public static void main(String[] args) {
        // 获取当前的日期时间
        LocalDateTime currentTime = LocalDateTime.now();
        System.out.println("当前时间：" + currentTime);

        LocalDate date1 = currentTime.toLocalDate();
        System.out.println("date1:" + date1);

        Month month = currentTime.getMonth();
        int day = currentTime.getDayOfMonth();
        int second = currentTime.getSecond();
        System.out.println("月：" + month + ",日:" + day + ",秒:" + second);

        LocalDateTime dateTime2 = currentTime.withDayOfMonth(15).withYear(2017);
        System.out.println(dateTime2);

        LocalDate date3 = LocalDate.of(2012, Month.SEPTEMBER, 6);
        System.out.println(date3);

        LocalTime time1 = LocalTime.of(14, 15);
        System.out.println(time1);

        // 解析字符串
        LocalTime date4 = LocalTime.parse("08:44:30");
        System.out.println(date4);


    }
}
