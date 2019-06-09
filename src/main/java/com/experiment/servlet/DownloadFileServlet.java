package com.experiment.servlet;

import com.experiment.dao.WorkDao;
import com.experiment.util.util;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

public class DownloadFileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");


        String type=req.getParameter("type");
        String work_id=req.getParameter("work_id");
        String report_id=req.getParameter("report_id");

        /**
         * type规定
         * 1、下载项目大纲
         * 2、下载实验指导书
         * 3、下载实验设计方案
         * 4、通过项目id，打包下载该项目的所有文件
         * 5、通过姓名和项目id，下载单一文件
         */

        String path="";
        switch (type)
        {
            case "1":
                path= util.getAbsolutePath(new WorkDao().getWorkOutline(work_id));
                break;

            case "2":
                path=util.getAbsolutePath(new WorkDao().getWorkGuide(work_id));
                break;

            case "3":
                path=util.getAbsolutePath(new WorkDao().getWorkDesign(work_id));
                break;

            case "4":
                String work_name=new WorkDao().getWorkNameById(work_id);
                boolean zip=util.fileToZip(util.getAbsolutePath(this.getServletContext().getRealPath("WEB-INF/upload/"+work_id+"/report/")),//文件来源地址
                        util.getAbsolutePath(this.getServletContext().getRealPath("WEB-INF/upload/"+work_id+"/")),
                        work_name+"的实验报告集");
                if (zip)
                    path=this.getServletContext().getRealPath("WEB-INF/upload/"+work_id+"/"+work_name+"的实验报告集.zip");
                break;

        }


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
        else
        {
            //resp.setContentType("text/html;charset=UTF8");
            resp.setCharacterEncoding("utf-8");
            PrintWriter out=resp.getWriter();
            out.println(path);
            out.println("Sorry , File Not Found !");
        }


    }
}
