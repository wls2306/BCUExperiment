package com.experiment.servlet;

import com.experiment.dao.UserDao;
import com.sun.javafx.image.BytePixelSetter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.Caret;
import javax.swing.text.html.CSS;
import java.io.IOException;
import java.io.PrintWriter;

public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF8");

        PrintWriter out=resp.getWriter();

        String userId=req.getParameter("userId");
        String oldPwd=req.getParameter("oldPwd");
        String newPwd=req.getParameter("newPwd");
        String type=req.getParameter("type");


        /**
         * Type
         * 1.修改密码
         */
        switch (type)
        {
            case "1":
                boolean result=false;
                boolean rs1=new UserDao().checkUser(userId,oldPwd);
                if(rs1)
                   result=new UserDao().changePwd(userId,newPwd);

                if (result)
                    out.println("操作成功");
                else
                    out.println("操作失败");

                break;
        }

    }
}
