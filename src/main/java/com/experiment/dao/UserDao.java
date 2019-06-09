package com.experiment.dao;

import com.experiment.entity.User;
import com.experiment.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDao {
    DBUtil util=new DBUtil();
    public boolean checkUser(String userId,String password)
    {
        String sql="select * from bcu_experiment.user where user_id=? and user_password=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,userId);
            pstmt.setString(2,password);
            ResultSet rs=pstmt.executeQuery();
            if (rs.next())
            {
                conn.close();
                return true;
            }
            conn.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }


    public User getUser(String userId, String password)
    {
        User u=new User();
        String sql="select * from bcu_experiment.user where user_id=? and user_password=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,userId);
            pstmt.setString(2,password);
            ResultSet rs=pstmt.executeQuery();
           while (rs.next())
           {
               u.setUserId(rs.getString(1));
               u.setUserName(rs.getString(2));
               u.setUserPwd(rs.getString(3));
               u.setUserClass(rs.getString(4));
               u.setUserType(rs.getString(5));
               u.setUserStatus(rs.getString(6));
           }
            conn.close();
            return u;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }


    public boolean changePwd(String userId,String pwd)
    {
        String sql="update bcu_experiment.user set user_password=? where user_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,pwd);
            pstmt.setString(2,userId);
            if(pstmt.executeUpdate()>0)
            {
                conn.close();
                return true;
            }
            conn.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<User> getUserByGroup(String groupId)
    {
        ArrayList<User> list=new ArrayList<User>();
        String sql="select * from bcu_experiment.user where user_class=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,groupId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                User u=new User();
                u.setUserId(rs.getString(1));
                u.setUserName(rs.getString(2));
                u.setUserPwd(rs.getString(3));
                u.setUserClass(rs.getString(4));
                u.setUserType(rs.getString(5));
                u.setUserStatus(rs.getString(6));
                list.add(u);
            }
            conn.close();
            return list;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }


    public String getUsernameByUserId(String userId)
    {
        String username="";
        String sql="select * from bcu_experiment.user where user_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,userId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                username=rs.getString(2);
            }
            conn.close();
            return username;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

}
