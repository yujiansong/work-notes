package com.jiansong.list;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author W9010597
 * Java 两个list 取出交集
 */
public class Main {
    public static void main(String[] args) {
        show01();
    }

    private static void show01() {
        List<String> studentsNameList = new ArrayList<String>();
        studentsNameList.add("apple");
        studentsNameList.add("orange");
        studentsNameList.add("banana");
        studentsNameList.add("pear");

        List<String> studentNameList2 = new ArrayList<String>();
        studentNameList2.add("apple");
        studentNameList2.add("orange");
        studentNameList2.add("watermellon");


        List<String> collect = studentsNameList.stream().filter(studentNameList2::contains).collect(Collectors.<String>toList());

        System.out.println(collect.toString());
    }
}
