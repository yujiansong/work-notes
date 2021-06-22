package test01;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * java8中的Collectors.groupingBy用法
 *
 * @author W9010597 2021/06/22 11:15
 */
public class CollectorsTest {
    public static void main(String[] args) {
        Product prod1 = new Product(1L, 1, new BigDecimal("15.5"), "面包", "零食");
        Product prod2 = new Product(2L, 2, new BigDecimal("20"), "饼干", "零食");
        Product prod3 = new Product(3L, 3, new BigDecimal("30"), "月饼", "零食");
        Product prod4 = new Product(4L, 3, new BigDecimal("10"), "青岛啤酒", "啤酒");
        Product prod5 = new Product(5L, 10, new BigDecimal("15"), "百威啤酒", "啤酒");
        List<Product> productList = new ArrayList<>();
        Collections.addAll(productList, prod1, prod2, prod3, prod4, prod5);
        // 按照几个属性拼接分组
//        Map<String, List<Product>> prodMap = productList.stream().collect(Collectors.groupingBy(item -> item.getCategory() + "_" + item.getName()));
        Map<Boolean, List<Product>> prodMap = productList.stream().collect(Collectors.groupingBy(item -> "零食".equals(item.getCategory())));
        System.out.println(prodMap);

    }

}

class Product {
    private long id;
    private Integer num;
    private BigDecimal price;
    private String name;
    private String category;

    public Product(Long id, Integer num, BigDecimal price, String name, String category) {
        this.id = id;
        this.num = num;
        this.price = price;
        this.name = name;
        this.category = category;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", num=" + num +
                ", price=" + price +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}
