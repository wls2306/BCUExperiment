package com.experiment.servlet;

import com.experiment.dao.ReportDao;
import com.experiment.entity.Report;
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

public class ReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/json;charset=UTF8");

        PrintWriter out=resp.getWriter();

        String workId=req.getParameter("workId");
        String userId=req.getParameter("userId");
        String isUpload=req.getParameter("isUpload");
        String reportStatus=req.getParameter("reportStatus");

        HttpSession session=req.getSession();


        String type=req.getParameter("type");
        switch (type)
        {
            case "1":
                ArrayList<Report> list1=new ReportDao().getReportByIsUpload(userId,isUpload);
                JSONArray ja=JSONArray.fromObject(list1);
                out.println(ja);
                break;


            case "2":
                boolean result=new ReportDao().checkReportUploadByWorkId(workId,userId);
                out.print(result);
                break;


        }



    }
}
