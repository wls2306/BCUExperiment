package com.experiment.dao;

import com.experiment.entity.Work;
import com.experiment.util.DBUtil;
import com.experiment.util.DBUtil2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class WorkDao {

    DBUtil util = new DBUtil();
    DBUtil2 util2=new DBUtil2();

    public boolean insertWork( String name, String lesson, String requirement, String outline, String guide, String design, String initiator, String creattime, String endtime, String status, String type,String target,String detailPart,String detailContent,String detailScore) {
        String sql = "insert into bcu_experiment.work(work_name,work_lesson,work_requirement,work_outline,work_guide,work_design,work_initiator,work_creat_time,work_end_time,work_status,work_type,work_target,work_detail_part,work_detail_content,work_detail_score) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection coon = util.getConnection();
        try {
            PreparedStatement pstmt = coon.prepareStatement(sql);
            //pstmt.setString(1, id);    txt上都说了id自动递增生成  还写？？？  @ 李炎昊
            pstmt.setString(2-1, name);
            pstmt.setString(3-1, lesson);
            pstmt.setString(4-1, requirement);
            pstmt.setString(5-1, outline);
            pstmt.setString(6-1, guide);
            pstmt.setString(7-1, design);
            pstmt.setString(8-1, initiator);
            pstmt.setString(9-1, creattime);
            pstmt.setString(10-1, endtime);
            pstmt.setString(11-1, status);
            pstmt.setString(12-1, type);
            pstmt.setString(12, target);
            pstmt.setString(13,detailPart);
            pstmt.setString(14,detailContent);
            pstmt.setString(15,detailScore);
            if (pstmt.executeUpdate() > 0) {
                coon.close();
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;

    }

    /**
     * 闫润宁库中的项目均为project
     */
    public boolean createProject(String name,String num,String type,String clazz,String teacher)
    {
        String sql="insert into project (project_name,project_num,project_type,project_class,project_teacher) values(?,?,?,?,?)";
        Connection conn=util2.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,name);
            pstmt.setString(2,num);
            pstmt.setString(3,type);
            pstmt.setString(4,clazz);
            pstmt.setString(5,teacher);
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













    public boolean deleteWork(String id) {
        String sql = "delete from  bcu_experiment.work where work_id=?";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            if (pstmt.executeUpdate() > 0) {
                conn.close();
                return true;
            }
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeWorkRequirement(String id, String requirement) {
        String sql = "update bcu_experiment.work  set work_id=?,work_requirement=? where group_id=?";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, requirement);
            if (pstmt.executeUpdate() > 0) {
                conn.close();
                return true;
            }
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();

        }
        return false;
    }


    public boolean changeWorkStatus(String id, String status) {
        String sql = "update bcu_experiment.work  set work_id=?,work_status=? where work_id=?";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, status);
            pstmt.setString(3,id);
            if (pstmt.executeUpdate() > 0) {
                conn.close();
                return true;
            }
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();

        }
        return false;
    }


    public ArrayList<Work> getAllWork() {
        ArrayList<Work> list = new ArrayList<Work>();
        String sql = "select * from bcu_experiment.work ";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Work work = new Work();
                work.setWorkId(rs.getString(1));
                work.setWorkName(rs.getString(2));
                work.setWorkLesson(rs.getString(3));
                work.setWorkRequirement(rs.getString(4));
                work.setWorkOutline(rs.getString(5));
                work.setWorkGuide(rs.getString(6));
                work.setWorkDesign(rs.getString(7));
                work.setWorkInitiator(rs.getString(8));
                work.setWorkCreateTime(rs.getString(9));
                work.setWorkEndTime(rs.getString(10));
                work.setWorkStatus(rs.getString(11));
                work.setWorkType(rs.getString(12));
                work.setWorkTarget(rs.getString(13));
                work.setWorkDetailPart(rs.getString(14));
                work.setWorkDetailContent(rs.getString(15));
                work.setWorkDetailScore(rs.getString(16));

                list.add(work);

            }
            conn.close();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public ArrayList<Work> getWorkByGroup(String groupId) {
        ArrayList<Work> list = new ArrayList<Work>();
        String sql = "select * from bcu_experiment.work where work_target like ? and work_status='1'";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,"%"+groupId+"%");  // 这里改为使用模糊查询 因为 班级编号在括号里
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Work w = new Work();
                w.setWorkId(rs.getString(1));
                w.setWorkName(rs.getString(2));
                w.setWorkLesson(rs.getString(3));
                w.setWorkRequirement(rs.getString(4));
                w.setWorkOutline(rs.getString(5));
                w.setWorkGuide(rs.getString(6));
                w.setWorkDesign(rs.getString(7));
                w.setWorkInitiator(rs.getString(8));
                w.setWorkCreateTime(rs.getString(9));
                w.setWorkEndTime(rs.getString(10));
                w.setWorkStatus(rs.getString(11));
                w.setWorkType(rs.getString(12));
                w.setWorkTarget(rs.getString(13));
                w.setWorkDetailPart(rs.getString(14));
                w.setWorkDetailContent(rs.getString(15));
                w.setWorkDetailScore(rs.getString(16));
                list.add(w);

            }
            conn.close();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public int getWorkId()
    {
        int id=-1;
        String sql="select max(work_id) from bcu_experiment.work";
        Connection conn=util.getConnection();
        try {
          PreparedStatement pstmt=conn.prepareStatement(sql);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
                  id=rs.getInt(1);
            conn.close();
            return id+1;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return -1;
    }


    public ArrayList<Work> getAllRunningWorkByTeacherId(String teacherId)
    {
        ArrayList<Work> list=new ArrayList<Work>();
        String sql="select * from bcu_experiment.work where work_initiator=? and work_status='1'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,teacherId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Work w=new Work();
                w.setWorkId(rs.getString(1));
                w.setWorkName(rs.getString(2));
                w.setWorkLesson(rs.getString(3));
                w.setWorkRequirement(rs.getString(4));
                w.setWorkOutline(rs.getString(5));
                w.setWorkGuide(rs.getString(6));
                w.setWorkDesign(rs.getString(7));
                w.setWorkInitiator(rs.getString(8));
                w.setWorkCreateTime(rs.getString(9));
                w.setWorkEndTime(rs.getString(10));
                w.setWorkStatus(rs.getString(11));
                w.setWorkType(rs.getString(12));
                w.setWorkTarget(rs.getString(13));
                w.setWorkDetailPart(rs.getString(14));
                w.setWorkDetailContent(rs.getString(15));
                w.setWorkDetailScore(rs.getString(16));
                list.add(w);
            }
            conn.close();
            return list;

        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Work> getAllStopWorkByTeacherId(String teacherId)
    {
        ArrayList<Work> list=new ArrayList<Work>();
        String sql="select * from bcu_experiment.work where work_initiator=? and work_status>=2";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,teacherId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Work w=new Work();
                w.setWorkId(rs.getString(1));
                w.setWorkName(rs.getString(2));
                w.setWorkLesson(rs.getString(3));
                w.setWorkRequirement(rs.getString(4));
                w.setWorkOutline(rs.getString(5));
                w.setWorkGuide(rs.getString(6));
                w.setWorkDesign(rs.getString(7));
                w.setWorkInitiator(rs.getString(8));
                w.setWorkCreateTime(rs.getString(9));
                w.setWorkEndTime(rs.getString(10));
                w.setWorkStatus(rs.getString(11));
                w.setWorkType(rs.getString(12));
                w.setWorkTarget(rs.getString(13));
                w.setWorkDetailPart(rs.getString(14));
                w.setWorkDetailContent(rs.getString(15));
                w.setWorkDetailScore(rs.getString(16));
                list.add(w);
            }
            conn.close();
            return list;

        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }


/*
    public ArrayList<Work> getWorkByGroupId(String groupId){
        ArrayList<Work> list=new ArrayList<Work>();
        String sql="select * from bcu_experiment.work_target where group_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,groupId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {

            }
        }catch (Exception e)
        {
            e.printStackTrace();
        }


    }
*/



public Work getWorkById(String workId)
{
    Work w=new Work();
    String sql="select * from bcu_experiment.work where work_id=?";
    Connection conn=util.getConnection();
    try {
        PreparedStatement pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,workId);
        ResultSet rs=pstmt.executeQuery();
        while (rs.next())
        {
            w.setWorkId(rs.getString(1));
            w.setWorkName(rs.getString(2));
            w.setWorkLesson(rs.getString(3));
            w.setWorkRequirement(rs.getString(4));
            w.setWorkOutline(rs.getString(5));
            w.setWorkGuide(rs.getString(6));
            w.setWorkDesign(rs.getString(7));
            w.setWorkInitiator(rs.getString(8));
            w.setWorkCreateTime(rs.getString(9));
            w.setWorkEndTime(rs.getString(10));
            w.setWorkStatus(rs.getString(11));
            w.setWorkType(rs.getString(12));
            w.setWorkTarget(rs.getString(13));
            w.setWorkDetailPart(rs.getString(14));
            w.setWorkDetailContent(rs.getString(15));
            w.setWorkDetailScore(rs.getString(16));
        }
        conn.close();
        return w;
    }catch (Exception e)
    {
        e.printStackTrace();
    }
    return null;
}

public String getWorkOutline(String workId)
{
    String path="Err";
    String sql="select * from bcu_experiment.work where work_id=?";
    Connection conn=util.getConnection();
    try {
        PreparedStatement pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,workId);
        ResultSet rs=pstmt.executeQuery();
        while (rs.next())
        {
            path=rs.getString(5);
        }
        conn.close();
        return path;
    }catch (Exception e)
    {
        e.printStackTrace();
    }
    return path;
}

    public String getWorkGuide(String workId)
    {
        String path="Err";
        String sql="select * from bcu_experiment.work where work_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                path=rs.getString(6);
            }
            conn.close();
            return path;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return path;
    }

    public String getWorkDesign(String workId)
    {
        String path="Err";
        String sql="select * from bcu_experiment.work where work_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                path=rs.getString(7);
            }
            conn.close();
            return path;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return path;
    }


    public String getWorkNameById(String workId)
    {
        String workName="";
        String sql="select * from bcu_experiment.work where work_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                workName=rs.getString(2);
            }
            conn.close();
            return workName;
        }catch (Exception e)
        {
            e.printStackTrace();
        }

        return "Err";
    }



}


