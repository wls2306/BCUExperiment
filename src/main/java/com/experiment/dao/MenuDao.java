package com.experiment.dao;

import com.experiment.entity.Menu;
import com.experiment.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MenuDao {
    DBUtil util=new DBUtil();
    public ArrayList<Menu> getMenuByAccess(String userType)
    {
        ArrayList<Menu> list=new ArrayList<Menu>();

        String sql="select * from bcu_experiment.menu where menu_access<=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,userType);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Menu m=new Menu();
                m.setMenuId(rs.getString(1));
                m.setMenuName(rs.getString(2));
                m.setMenuAccess(rs.getString(3));
                m.setMenuType(rs.getString(4));
                m.setMenuStatus(rs.getString(5));
                m.setMenuUrl(rs.getString(6));
                list.add(m);
            }
            conn.close();
            return list;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }
}
