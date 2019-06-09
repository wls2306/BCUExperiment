package com.experiment.servlet;

import com.experiment.dao.GroupDao;
import com.experiment.dao.MenuDao;
import com.experiment.dao.UserDao;
import com.experiment.entity.Group;
import com.experiment.entity.Menu;
import com.experiment.entity.User;
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
import java.util.HashMap;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF8");
        PrintWriter out=resp.getWriter();

        String userId=req.getParameter("userId");
        String password=req.getParameter("psw");

        if(new UserDao().checkUser(userId,password))
        {
            User u=new UserDao().getUser(userId,password);
            ArrayList<Menu> menu=new MenuDao().getMenuByAccess(u.getUserType());
            HttpSession session=req.getSession();
            session.setAttribute("user",u);
            session.setAttribute("menu",menu);
            JSONArray ja=JSONArray.fromObject(menu);

            if (Integer.valueOf(u.getUserType())>1) {
                ArrayList<Group> g = new GroupDao().getAllGroup();
                session.setAttribute("group", g);
            }
            resp.sendRedirect("main.jsp");

        }else
        {
            out.println("用户名或密码有误，请再试一次！");
            resp.setHeader("refresh","2;url=login.jsp");
        }



    }

    //小程序测试
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/json;charset=UTF8");
        PrintWriter out=resp.getWriter();
        String userId=req.getParameter("userId");
        String password=req.getParameter("psw");
        HashMap LoginRs =new HashMap();

        if(new UserDao().checkUser(userId,password))
        {
            LoginRs.put("result",true);
            LoginRs.put("msg","登陆成功");
        }else
        {
            LoginRs.put("result",false);
            LoginRs.put("msg","登陆失败");
        }

        out.println(JSONObject.fromObject(LoginRs));


    }



}
