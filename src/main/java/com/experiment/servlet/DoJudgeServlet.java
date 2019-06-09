package com.experiment.servlet;

import com.experiment.dao.WorkDao;
import com.experiment.entity.Work;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/demo")
public class DoJudgeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF8");
        PrintWriter out=resp.getWriter();

        String username=req.getParameter("userId");
        String password=req.getParameter("password");
   /*     String name=req.getParameter("name");//学生姓名
        String type=req.getParameter("type");// 教师为1 学生为2 专家为3*/

        String workId=req.getParameter("reportGoal");
        Work w=new WorkDao().getWorkById(workId);
     /*   String projectType=w.getWorkType().equals("1")?"1A":"1B";
        String userClass=w.getWorkTarget().substring(0,w.getWorkTarget().indexOf("("));
        String projectName=w.getWorkName();
        String projectNum=w.getWorkId();
        String projectTeacher=w.getWorkInitiator();*/

        String urlPath="http://192.168.1.105:8080";
        String url1="/middleServlet?way=userLogin&username="+username+"&password="+password+"&projectNum="+workId;
        resp.sendRedirect(urlPath+url1);
    }



    public String get(String url){
        //ʵ����httpclient
        CloseableHttpClient httpclient = HttpClients.createDefault();
        //ʵ����get����
        HttpGet httpget = new HttpGet(url);
        //������
        CloseableHttpResponse response = null;
        String content ="";
        try {
            response = httpclient.execute(httpget);
            if(response.getStatusLine().getStatusCode()==200){
                content = EntityUtils.toString(response.getEntity(),"utf-8");
//                System.out.println(content);
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return content;
    }
}
