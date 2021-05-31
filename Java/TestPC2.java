package com.jiansong.senior;

/**
 * 测试生产者-消费者问题： 信号灯法，标志位解决
 */
public class TestPC2 {
    public static void main(String[] args) {
        TV tv = new TV();
        new Player(tv).start();
        new Viewer(tv).start();
    }
}

// 生产者->演员
class Player extends Thread {
    TV tv;
    public Player(TV tv) {
        this.tv = tv;
    }

    @Override
    public void run() {
        for (int i = 0; i < 20; i++) {
            if (i % 2 == 0) {
                try {
                    this.tv.play("天龙八部");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    this.tv.play("广告：脑白金");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

// 消费者->观众
class Viewer extends Thread {
    TV tv;
    public Viewer(TV tv) {
        this.tv = tv;
    }

    @Override
    public void run() {
        for (int i = 0; i < 20; i++) {
            try {
                tv.view();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

// 产品->节目
class TV {
    // 演员表演，观众等待
    // 观众观看，演员等待
    String voice; // 表演的节目
    boolean flag = true;

    // 表演
    public synchronized void play(String voice) throws InterruptedException {
        if (!flag) {
            this.wait();
        }
        System.out.println("演员表演了：" + voice);
        // 通知观众观看
        this.notifyAll();
        this.voice = voice;
        this.flag = !this.flag;
    }

    // 观看
    public synchronized void view() throws InterruptedException {
        if (flag) {
            this.wait();
        }
        System.out.println("观众观看了：" + voice);
        // 通知演员表演
        this.notifyAll();
        this.flag = !this.flag;
    }
}
