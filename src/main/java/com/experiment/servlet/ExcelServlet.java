package com.experiment.servlet;

import com.experiment.dao.ReportDao;
import com.experiment.dao.WorkDao;
import com.experiment.entity.Report;
import com.experiment.entity.Work;
import com.experiment.util.ExcelUtil;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

public class ExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String workId=req.getParameter("workId");
        String path="";
        Work w= new WorkDao().getWorkById(workId);
        ArrayList<Report> reports= new ReportDao().getReportByWorkId(workId);
        if (w==null || reports==null)
            System.out.println("404");
        else
            try {
                path=this.getServletContext().getRealPath("WEB-INF/upload/"+workId+"/"+workId+".xlsx");
              new ExcelUtil().genernateExcel(w,reports,path);
              File file=new File(path);
                if(file.exists())
                {
                    FileInputStream fi=new FileInputStream(file);
                    String filename= URLEncoder.encode(file.getName(),"utf-8");
                    byte b[]=new byte[fi.available()];
                    fi.read(b);
                    resp.setCharacterEncoding("utf-8");
                    resp.setHeader("Content-Disposition","attachment;filename="+filename+"");
                    ServletOutputStream out=resp.getOutputStream();

                    out.write(b);
                    out.flush();
                    out.close();

                }
            }catch (Exception e)
            {
                e.printStackTrace();
            }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
