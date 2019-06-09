package com.experiment.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil2 {
    public Connection getConnection() {//得到数据库连接
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://39.105.208.84:3306/grade?useUnicode=true&characterEncoding=utf8", "root", "root");
            return conn;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
