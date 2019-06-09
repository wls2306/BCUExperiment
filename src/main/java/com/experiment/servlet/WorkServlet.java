package com.experiment.servlet;

import com.experiment.dao.GroupDao;
import com.experiment.dao.ReportDao;
import com.experiment.dao.WorkDao;
import com.experiment.entity.Work;
import com.experiment.util.util;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

public class WorkServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF8");
        PrintWriter out=resp.getWriter();

        String userName=req.getParameter("user");
        String type=req.getParameter("type");
        String group=req.getParameter("group");
        String workId=req.getParameter("workId");
        String workStatus=req.getParameter("workStatus");

        /**
         * Type
         * 1.查询教师名下所有已开始的项目
         * 2.查询学生班级下的所有已开始的项目
         * 3.根据项目编号获得项目详细信息
         * 4.查询教师名下所有已结束的项目
         * 5.修改项目状态
         * 6.查询项目提交情况
         * 7.公布分数
         * 8.列出系统中所有的项目（全）
        */

        switch (type)
        {
            case "1":
                ArrayList<Work> list=new WorkDao().getAllRunningWorkByTeacherId(userName);
                out.println(JSONArray.fromObject(list));
                break;

            case "2":
                ArrayList<Work> list2=new WorkDao().getWorkByGroup(group);
                out.println(JSONArray.fromObject(list2));
                break;

            case "3":
                Work w=new WorkDao().getWorkById(workId);
                 out.println(JSONObject.fromObject(w));
                break;

            case "4":
                ArrayList<Work> list3=new WorkDao().getAllStopWorkByTeacherId(userName);
                out.println(JSONArray.fromObject(list3));
                break;


            case "5":
                if(new WorkDao().changeWorkStatus(workId,workStatus))
                    out.println("修改成功");
                else
                    out.println("修改失败");

                break;

            case "6":
                Work w6=new WorkDao().getWorkById(workId);
                String sum=new GroupDao().getGroupPeopleCount(util.getBellow(w6.getWorkTarget()));
                int count=new ReportDao().getReportCountById(w6.getWorkId());
                System.out.println("count"+count);
                ArrayList<String> miss=new ReportDao().getReportMissPeople(w6.getWorkId());
                out.println("您查询的项目编号是："+w6.getWorkId());
                out.println("您查询的项目名称是："+w6.getWorkName());
                out.println("当前实验报告提交情况："+count+" / "+sum);
                out.println("以下学生还没有提交");
                for(int i=0;i<miss.size();i++)
                    out.println(miss.get(i));

                break;

            case "7":
                boolean rs7=false;
                boolean rs8=false;
                boolean allJudge=new ReportDao().isAllScore(workId);
                if (allJudge) {
                    rs7 = new ReportDao().PublishScoreById(workId);
                    rs8 = new WorkDao().changeWorkStatus(workId, "3");
                    if (rs7&&rs8)
                        out.println("分数公布成功");
                    else
                        out.println("系统错误，分数公布失败，请再试一次");
                }else
                {
                    out.println("报告中存在未评分的实验报告，请确保评分后再公布分数");
                }
                break;


            case "8":
                ArrayList<Work> allwork=new WorkDao().getAllWork();
                out.println(JSONArray.fromObject(allwork));
                break;

        }





    }
}
