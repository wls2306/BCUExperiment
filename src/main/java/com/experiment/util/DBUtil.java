package com.experiment.util;


/***
 * 数据库连接工具类
 * 功能：连接数据库并返回对象
 */



import java.sql.Connection;
import java.sql.DriverManager;
public class DBUtil {
    public Connection getConnection() {//得到数据库连接
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bcu_experiment?useUnicode=true&characterEncoding=utf8", "root", "root");
            return conn;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
