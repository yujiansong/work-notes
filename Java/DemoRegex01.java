package test05;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 正则表达式练习
 *
 * @author W9010597 2021/07/26 14:52
 */
public class DemoRegex01 {
    public static void main(String[] args) {
//        demo01();
//        demo02();
        demo03();
    }

    private static void demo03() {
        System.out.println("\\");
        System.out.println("\\\\");
    }

    private static void demo02() {
        String line = "This order was placed for QT3000! OK?";
        String pattern = "(\\D*)(\\d+)(.*)";
        // 创建pattern对象
        Pattern r = Pattern.compile(pattern);
        // 创建matcher对象
        Matcher m = r.matcher(line);
        if (m.find()) {
            System.out.println("Found value: " + m.group(0));
            System.out.println("Found value: " + m.group(1));
            System.out.println("Found value: " + m.group(2));
            System.out.println("Found value: " + m.group(3));
        } else {
            System.out.println("NO MATCH");
        }

    }

    private static void demo01() {
        // 用于查找字符串中是否包了 yujiansong 子串：
        String content = "I am yujiansong " +
                "from jiansong.com.";
        String pattern = ".*yujiansong.*";
        boolean isMatch = Pattern.matches(pattern, content);
        System.out.println("字符串是否包含了 'yujiansong' ？" + isMatch);
    }

}
