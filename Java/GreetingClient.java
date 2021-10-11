import java.io.*;
import java.net.Socket;

/**
 * Socket 客户端
 *
 * @author W9010597 2021/10/11 11:46
 * 启动命令：
 * javac -encoding UTF-8 GreetingClient.java
 * java GreetingClient
 */
public class GreetingClient {
    public static void main(String[] args) {
        String serverName = args[0];
        int port = Integer.parseInt(args[1]);
        try {
            System.out.println("连接到主机：" + serverName + " ，端口号：" + port);
            Socket client = new Socket(serverName, port);
            System.out.println("远程主机地址：" + client.getRemoteSocketAddress());
            System.out.println("时间：" + client.getSoTimeout());
            OutputStream outToServer = client.getOutputStream();
            DataOutputStream out = new DataOutputStream(outToServer);

            out.writeUTF("Hello from " + client.getLocalSocketAddress());
            InputStream inFromServer = client.getInputStream();
            DataInputStream in = new DataInputStream(inFromServer);
            System.out.println("服务器响应： " + in.readUTF());
            client.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
