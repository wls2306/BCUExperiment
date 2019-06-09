package com.experiment.servlet;

import com.experiment.dao.ReportDao;
import com.experiment.dao.WorkDao;
import com.experiment.entity.Report;
import com.experiment.entity.Work;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.CSS;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ScoringServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String workId = req.getParameter("workId");
        String type = req.getParameter("type");
        String reportId=req.getParameter("reportId");


        /**
         * Type：
         * 1、获取实验报告总名单 （提交与未提交）
         * 2、通过实验报告编号获得实验报告信息
         * 3、成绩报告单 信息获取
         */
        switch (type) {
            case "":
                break;

            case "1":
                req.setCharacterEncoding("utf-8");
                resp.setCharacterEncoding("utf-8");
                resp.setContentType("text/html;charset=UTF8");
                PrintWriter out = resp.getWriter();

                ArrayList<Report> reportList = new ReportDao().getAllUploadReportByWorkId(workId);
                Work w = new WorkDao().getWorkById(workId);
                if (Integer.valueOf(w.getWorkStatus()) == 2) {
                    ArrayList<String> m = new ReportDao().getReportMissPeople(workId);
                    HttpSession session = req.getSession();
                    session.setAttribute("report", reportList);
                    session.setAttribute("miss", m);
                    session.setAttribute("work", w);
                    resp.sendRedirect("score.jsp");
                } else {
                    out.println("<h2>当前项目不再接受评分</h2>");
                    out.println("<div>页面将在3秒钟后跳回</div>");
                    resp.setHeader("refresh", "3;url=running_work.jsp#stop");
                }
                break;

            case "2":
                req.setCharacterEncoding("utf-8");
                resp.setCharacterEncoding("utf-8");
                resp.setContentType("text/json;charset=UTF8");
                PrintWriter out2 = resp.getWriter();

                Report r=new ReportDao().getReportInfoByReportId(reportId);
                out2.println(JSONObject.fromObject(r));
                break;

            case "3":
                req.setCharacterEncoding("utf-8");
                resp.setCharacterEncoding("utf-8");
                resp.setContentType("text/html;charset=UTF8");
                PrintWriter out3 = resp.getWriter();

                ArrayList<Report> reportList3 = new ReportDao().getReportByWorkId(workId);
                Work w3 = new WorkDao().getWorkById(workId);

                HttpSession session3=req.getSession();
                session3.setAttribute("report",reportList3);
                session3.setAttribute("work",w3);
                resp.sendRedirect("work_score.jsp");
                break;

        }

    }


    //处理上传得分数据
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/json;charset=UTF8");

        PrintWriter out=resp.getWriter();

        String reportId=req.getParameter("reportId");
        String reportScore=req.getParameter("reportScore");
        String reportDetail=req.getParameter("reportDetail");
        String rater=req.getParameter("reportRater");
        boolean rs=new ReportDao().ScoreReportById(reportId,reportScore,reportDetail,rater);
        out.println(rs);


    }
}