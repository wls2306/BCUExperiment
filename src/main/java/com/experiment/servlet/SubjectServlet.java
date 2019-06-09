package com.experiment.servlet;

import com.experiment.dao.SubjectDao;
import com.experiment.entity.Subject;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class SubjectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/json;charset=UTF8");

        PrintWriter out=resp.getWriter();

        String type=req.getParameter("type");
        String subId=req.getParameter("subid");
        String subName=req.getParameter("subname");
        String subLeader=req.getParameter("subleader");
        String subStatus=req.getParameter("substatus");

        System.out.println("type:"+type+"subid"+subId+"subname"+subName+"substatus"+subStatus);

        /**
         * Type
         * 1.插入
         * 2.查找所有
         * 3.删除
         */

        switch (type)
        {
            case "1":
               out.println( new SubjectDao().insertSubject(subId,subName,subLeader,subStatus));
                break;


            case "2":
                ArrayList<Subject> list=new SubjectDao().selectAllSubject();
                out.println(JSONArray.fromObject(list));
                break;

            case "3":
                out.println(new SubjectDao().deleteSubject(subId));
                break;
        }




    }
}
