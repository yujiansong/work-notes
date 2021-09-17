package test07;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * description
 *
 * @author W9010597 2021/09/17 14:31
 */
public class Room {
    private Integer id;
    private String name;
    private Short type;
    private Integer fid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }

    public static void main(String[] args) {
//       show01();
        show02();
    }

    private static void show02() {
        List<Room> rooms1=new ArrayList<>();
        Room roomA=new Room();
        roomA.setId(1);
        roomA.setName("1-A");
        roomA.setType((short)1);
        roomA.setFid(5);

        Room roomB=new Room();
        roomB.setId(2);
        roomB.setName("2-A");
        roomB.setType((short)1);
        roomB.setFid(10);
        rooms1.add(roomA);
        rooms1.add(roomB);
        // 如果来自一个List的两个值，也想抽出来放到一个list里面去
        List<Integer> idList = Stream.concat(rooms1.stream().map(Room::getId), rooms1.stream().map(Room::getFid)).collect(Collectors.toList());
        System.out.println(idList);
    }

    private static void show01() {
        List<Room> rooms1 = new ArrayList<>();
        Room roomA = new Room();
        roomA.setId(1);
        roomA.setName("1-A");
        roomA.setType((short)1);

        Room roomB = new Room();
        roomB.setId(2);
        roomB.setName("2-A");
        roomB.setType((short)1);
        rooms1.add(roomA);
        rooms1.add(roomB);

        List<Room> rooms2=new ArrayList<>();
        Room roomC=new Room();
        roomC.setId(3);
        roomC.setName("3-C");
        roomC.setType((short)2);
        Room roomD=new Room();
        roomD.setId(4);
        roomD.setName("4-D");
        roomD.setType((short)2);
        rooms2.add(roomC);
        rooms2.add(roomD);

        //去重set (注意真正操作时需要对俩list做判空校验)
        List<Integer> idList = new ArrayList<>(Stream.concat(rooms1.stream().map(Room::getId), rooms2.stream().map(Room::getId)).collect(Collectors.toSet()));

        //去重set (注意真正操作时需要对俩list做判空校验)
        List<Integer> idList2 = new ArrayList<>(Stream.of(rooms1, rooms2).flatMap(List::stream).map(Room::getId).collect(Collectors.toSet()));
        System.out.println(idList2);

        //不去重list
        List<Integer> idList3 = Stream.concat(rooms1.stream().map(Room::getId), rooms2.stream().map(Room::getId)).collect(Collectors.toList());
        System.out.println(idList3);
    }

}
