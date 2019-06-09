package com.experiment.dao;

import com.experiment.entity.Subject;
import com.experiment.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SubjectDao {
    DBUtil util=new DBUtil();
    public boolean insertSubject(String subId,String subName,String subLeader,String subStatus)
    {
        String sql="insert into subject (sub_id,sub_name,sub_leader,sub_status) values (?,?,?,?)";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,subId);
            pstmt.setString(2,subName);
            pstmt.setString(3,subLeader);
            pstmt.setString(4,subStatus);
            if (pstmt.executeUpdate()>0)
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

    public ArrayList<Subject> selectAllSubject()
    {
        ArrayList<Subject> subjectArrayList=new ArrayList<>();
        String sql="select * from subject";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Subject subject=new Subject();
                subject.setSubId(rs.getString(1));
                subject.setSubName(rs.getString(2));
                subject.setSubLeader(rs.getString(3));
                subject.setSubStatus(rs.getString(4));
                subjectArrayList.add(subject);
            }
            conn.close();
            return subjectArrayList;

        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteSubject(String subId)
    {
        String sql="delete from subject where sub_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,subId);
            if (pstmt.executeUpdate()>0)
            {
                conn.close();
                return true;
            }
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }
}
