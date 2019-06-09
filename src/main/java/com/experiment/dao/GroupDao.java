package com.experiment.dao;

import com.experiment.entity.Group;
import com.experiment.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GroupDao {
    DBUtil utli=new DBUtil();
    public boolean insertGroup(String id,String name){
        String sql="insert into bcu_experiment.group(group_id,group_name) values(?,?)";
        Connection conn= utli.getConnection();
        try {
            PreparedStatement pstmt =conn.prepareStatement(sql);
            pstmt.setString(1,id);
            pstmt.setString(2,name);


            if (pstmt.executeUpdate()>0) {
                conn.close();
                return true;
            }
            conn.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return  false;
    }



    public boolean changeGroupName(String id,String name){
        String sql = "update bcu_experiment.group  set group_id=?,group_name=? where group_id=?";
        Connection conn= utli.getConnection();
        try{
            PreparedStatement pstmt =conn.prepareStatement(sql);
            pstmt.setString(1,id);
            pstmt.setString(2,name);
            pstmt.setString(3,id);
            if (pstmt.executeUpdate()>0){
                conn.close();
                return true;
            }
            conn.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }




    public boolean deleteGroupById(String id){

        String sql = "delete from  bcu_experiment.group where group_id=?";
        Connection conn =utli.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,id);
            if (pstmt.executeUpdate()>0){
                conn.close();
                return  true;
            }
            conn.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return  false;
    }



    public String GetGroupNameById(String Groupid){

        String sql = "select * from bcu_experiment.group where group_id=?";
        Connection conn = utli.getConnection();
        String groupName="";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Groupid);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                groupName=rs.getString(2);
            }
            conn.close();
            return groupName;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return "Err";
    }

    public ArrayList<Group> getAllGroup() {
        ArrayList<Group> list = new ArrayList<Group>();
        String sql = "select * from bcu_experiment.group ";
        Connection conn = utli.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Group part = new Group();
                part.setGroupId(rs.getString(1));
                part.setGroupName(rs.getString(2));
                list.add(part);

            }
            conn.close();
            return list ;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getGroupPeopleCount(String groupId)
    {
        int sum=0;
        String sql="select * from bcu_experiment.user where user_class=?";
        Connection conn=utli.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,groupId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                sum+=1;
            }
            conn.close();
            return sum+"";
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return -1+"";
    }
}
