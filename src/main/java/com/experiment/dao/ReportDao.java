package com.experiment.dao;


import com.experiment.entity.Report;
import com.experiment.util.DBUtil;
import com.sun.org.apache.regexp.internal.RE;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.PseudoColumnUsage;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReportDao {


    DBUtil util = new DBUtil();

   public boolean createReport(String reportId,String goalId,String author_id,String author)
   {
       String sql="insert into bcu_experiment.report (report_id,report_goal,report_author_id,report_author,report_isupload) values(?,?,?,?,'0')";
       Connection conn=util.getConnection();
       try {
           PreparedStatement pstmt=conn.prepareStatement(sql);
           pstmt.setString(1,reportId);
           pstmt.setString(2,goalId);
           pstmt.setString(3,author_id);
           pstmt.setString(4,author);
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


    /**
     * 为闫润宁的表创建实验报告
     * @param id
     * @return
     */






    public boolean deleteReport(String id) {
        String sql = "delete from  bcu_experiment.report where report_id=?";
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


    public boolean uploadReport(String reportId,String url,String uploadTime)
    {
        String sql="update bcu_experiment.report set report_url=?,report_upload_time=?,report_isupload='1',report_status='0' where report_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,url);
            pstmt.setString(2,uploadTime);
            pstmt.setString(3,reportId);
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

    public int getReportCountById(String workTarget)
    {
        String sql="select * from bcu_experiment.report where report_goal=? and report_isupload='1'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workTarget);
            ResultSet rs=pstmt.executeQuery();
            int sum=0;
            while (rs.next())
            {
                sum+=1;
            }
            conn.close();
            return sum;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<String> getReportMissPeople(String workId)
    {
        ArrayList<String> userList=new ArrayList<String>();
        String sql="select * from bcu_experiment.report where report_goal=? and report_isUpload='0'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                userList.add(rs.getString(4)+"("+rs.getString(5)+")");
            }
            return userList;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }


    public ArrayList<Report> getReportByAuthorAndStatus(String authorId,String status){
        ArrayList<Report> list=new ArrayList<Report>();
        String sql = "select * from bcu_experiment.report where report_author_id=? and report_status=?";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, authorId);
            pstmt.setString(2,status);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Report r=new Report();
                r.setReportId(rs.getString(1));
                r.setReportGoal(rs.getString(2));
                r.setReportGoalName(new WorkDao().getWorkNameById(rs.getString(2)));
                r.setReportUrl(rs.getString(3));
                r.setReportAuthor(rs.getString(4));
                r.setReportAuthorId(rs.getString(5));
                r.setReportUploadTime(rs.getString(6));
                r.setReportIsupload(rs.getString(7));
                r.setReportStatus(rs.getString(8));
                r.setReportScore(rs.getString(9));
                r.setReportScoreDetail(rs.getString(10));
                r.setReportRater(rs.getString(11));
                list.add(r);
            }
            conn.close();
            return list;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Report> getReportByIsUpload(String authorId,String isUpload){
        ArrayList<Report> list=new ArrayList<Report>();
        String sql = "select * from bcu_experiment.report where report_author_id=? and report_isupload=?";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, authorId);
            pstmt.setString(2,isUpload);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Report r=new Report();
                r.setReportId(rs.getString(1));
                r.setReportGoal(rs.getString(2));
                r.setReportGoalName(new WorkDao().getWorkNameById(rs.getString(2)));
                r.setReportUrl(rs.getString(3));
                r.setReportAuthor(rs.getString(4));
                r.setReportAuthorId(rs.getString(5));
                r.setReportUploadTime(rs.getString(6));
                r.setReportIsupload(rs.getString(7));
                r.setReportStatus(rs.getString(8));

                if (rs.getInt(8)>1) {
                    r.setReportScore(rs.getString(9));
                    r.setReportScoreDetail(rs.getString(10));
                    r.setReportRater(rs.getString(11));
                }
                list.add(r);
            }
            conn.close();
            return list;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }





    public ArrayList<Report> getAllparts() {
        ArrayList<Report> list = new ArrayList<Report>();
        String sql = "select * from bcu_experiment.report ";
        Connection conn = util.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Report part = new Report();
                part.setReportId(rs.getString(1));
                part.setReportGoal(rs.getString(2));
                part.setReportUrl(rs.getString(3));
                part.setReportAuthor(rs.getString(4));
                part.setReportUploadTime(rs.getString(5));
                list.add(part);

            }
            conn.close();
            return list ;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkReportUploadByWorkId(String workId,String userId)
    {
        String sql="select * from bcu_experiment.report where report_id=? and report_author_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId+"-"+userId);
            pstmt.setString(2,userId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                if(Integer.valueOf(rs.getString(7))==1)
                {
                    conn.close();
                    return true;
                }
            }
            conn.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }


    public String getReportUrlByReportId(String reportId)
    {
        String url="";
        String sql="select * from bcu_experiment.report where report_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,reportId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                url=rs.getString(3);
            }
            conn.close();
            return url;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return "Err";
    }

    public ArrayList<Report> getAllUploadReportByWorkId(String workId)
    {
        ArrayList<Report> list=new ArrayList<Report>();
        String sql="select * from bcu_experiment.report where report_goal=? and report_isUpload='1'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Report r=new Report();
                r.setReportId(rs.getString(1));
                r.setReportGoal(rs.getString(2));
                r.setReportUrl(rs.getString(3));
                r.setReportAuthor(rs.getString(4));
                r.setReportAuthorId(rs.getString(5));
                r.setReportUploadTime(rs.getString(6));
                r.setReportScore(rs.getString(9));
                r.setReportScoreDetail(rs.getString(10));
                list.add(r);
            }
            conn.close();
            return list;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public boolean ScoreReportById(String reportId,String score,String scoreDetail,String rater)
    {
        String sql="update bcu_experiment.report set report_status='1',report_score=?,report_score_detail=?,report_rater=? where report_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,score);
            pstmt.setString(2,scoreDetail);
            pstmt.setString(3,rater);
            pstmt.setString(4,reportId);
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



    public boolean isAllScore(String workId)
    {
        boolean result=true;
        String sql="select * from bcu_experiment.report where report_status!='1' and report_goal=? and report_isupload='1'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                result=false;
            }
            conn.close();
            return  result;
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public boolean PublishScoreById(String workId)
    {
        String sql="update bcu_experiment.report set report_status='2' where report_goal=? and report_isupload='1'";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
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

    public Report getReportInfoByReportId(String ReportId)
    {
        Report r=new Report();
        String sql="select * from bcu_experiment.report where report_id=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, ReportId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                r.setReportId(rs.getString(1));
                r.setReportGoal(rs.getString(2));
                r.setReportGoalName(new WorkDao().getWorkNameById(rs.getString(2)));
                r.setReportUrl(rs.getString(3));
                r.setReportAuthor(rs.getString(4));
                r.setReportAuthorId(rs.getString(5));
                r.setReportUploadTime(rs.getString(6));
                r.setReportIsupload(rs.getString(7));
                r.setReportStatus(rs.getString(8));
                r.setReportScore(rs.getString(9));
                r.setReportScoreDetail(rs.getString(10));
                r.setReportRater(rs.getString(11));
            }
            conn.close();
            return r;
        }catch (Exception e )
        {
            e.printStackTrace();
        }
        return null;
    }


    public ArrayList<Report> getReportByWorkId(String workId)
    {
        ArrayList<Report> reportList=new ArrayList<>();
        String sql="select * from bcu_experiment.report where report_goal=?";
        Connection conn=util.getConnection();
        try {
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,workId);
            ResultSet rs=pstmt.executeQuery();
            while (rs.next())
            {
                Report r=new Report();
                r.setReportId(rs.getString(1));
                r.setReportGoal(rs.getString(2));
                r.setReportUrl(rs.getString(3));
                r.setReportAuthor(rs.getString(4));
                r.setReportAuthorId(rs.getString(5));
                r.setReportUploadTime(rs.getString(6));
                r.setReportIsupload(rs.getString(7));
                r.setReportStatus(rs.getString(8));
                r.setReportScore(rs.getString(9));
                r.setReportScoreDetail(rs.getString(10));
                r.setReportRater(rs.getString(11));
                reportList.add(r);
            }
            conn.close();
            return reportList;
        }catch (Exception e )
        {
            e.printStackTrace();
        }
        return null;
    }


}
