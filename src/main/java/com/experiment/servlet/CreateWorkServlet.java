package com.experiment.servlet;

import com.experiment.dao.ReportDao;
import com.experiment.dao.UserDao;
import com.experiment.dao.WorkDao;
import com.experiment.entity.User;
import com.experiment.util.util;
import net.sf.json.JSONArray;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class CreateWorkServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            String workId=getId();


            //得到上传文件的保存目录。 将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
            String realPath="";//  /WEB-INF/files
            String fileName="";
            //设置临时目录。 上传文件大于缓冲区则先放于临时目录中
            String tempPath = this.getServletContext().getRealPath("WEB-INF/upload/temPath");

            //判断存放上传文件的目录是否存在（不存在则创建）
            //判断临时目录是否存在（不存在则创建）



            /**
             * 使用Apache文件上传组件处理文件上传步骤：
             *
             * */
            //1、设置环境:创建一个DiskFileItemFactory工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();

            //设置上传文件的临时目录
            File f1 = new File(tempPath);
            if (!f1.isDirectory()) {
                System.out.println("临时文件目录不存在! 创建临时文件目录");
                f1.mkdir();
            }
            factory.setRepository(f1);

            //2、核心操作类:创建一个文件上传解析器。
            ServletFileUpload upload = new ServletFileUpload(factory);
            //解决上传"文件名"的中文乱码
            upload.setHeaderEncoding("UTF-8");

            //3、判断enctype:判断提交上来的数据是否是上传表单的数据
            if (!ServletFileUpload.isMultipartContent(req)) {
                System.out.println("不是上传文件，终止");
                //按照传统方式获取数据
                return;
            }

            //==获取输入项==
//            //限制单个上传文件大小(5M)
//            upload.setFileSizeMax(1024*1024*4);
//            //限制总上传文件大小(10M)
//            upload.setSizeMax(1024*1024*6);


            /**
             * 自行更改部分：
             *  使用HashMap对 表单非文件数据进行存储！
             *  使用规则：
             *  一定要将项目id的数值先于文件传入
             *  文件的储存文件夹依赖于项目id，不这样做会无法储存！
             *
             */


            HashMap<String,String> info =new HashMap<String, String>();



            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
            List<FileItem> items = upload.parseRequest(req);
            for (FileItem item : items) {
                //如果fileitem中封装的是普通输入项的数据（输出名、值）
                if (item.isFormField()) {
                    String filedName = item.getFieldName();//普通输入项数据的名
                    //解决普通输入项的数据的中文乱码问题
                    String filedValue = item.getString("UTF-8");//普通输入项的值
                    System.out.println("普通字段:" + filedName + "==" + filedValue);
                    info.put(filedName,filedValue);
                    /**
                     * ↑ 向 HashMap中存值！！
                     */
                } else {
                    //如果fileitem中封装的是上传文件，得到上传的文件名称，
                    String filedName = item.getFieldName();

                    switch (filedName){
                        case "outline":
                            realPath=this.getServletContext().getRealPath("WEB-INF/upload/"+workId+"/");
                            CreateFolider(realPath,tempPath);
                            fileName = item.getName();
                            info.put("outline",realPath+fileName);

                            break;

                        case "guide":
                            realPath=this.getServletContext().getRealPath("WEB-INF/upload/"+workId+"/");
                            CreateFolider(realPath,tempPath);
                            fileName = item.getName();
                            info.put("guide",realPath+fileName);//修复粘贴造成的key值未更改错误
                            break;

                        case "design":
                            realPath=this.getServletContext().getRealPath("WEB-INF/upload/"+workId+"/");
                            CreateFolider(realPath,tempPath);
                            fileName = item.getName();
                            info.put("design",realPath+fileName);
                            break;
                    }


                    /**
                     * String fileName = item.getName();//上传文件的名
                     */

                    //多个文件上传输入框有空 的 异常处理
                    if (fileName == null || "".equals(fileName.trim())) {  //去空格是否为空
                        continue;// 为空，跳过当次循环，  第一个没输入则跳过可以继续输入第二个
                    }


                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    //拼接上传路径。存放路径+上传的文件名
                    String filePath = realPath + "\\" + fileName;
                    System.out.println("保存在了--"+filePath);
                    //构建输入输出流
                    InputStream in = item.getInputStream(); //获取item中的上传文件的输入流
                    OutputStream out = new FileOutputStream(filePath); //创建一个文件输出流

                    //创建一个缓冲区
                    byte b[] = new byte[1024];
                    //判断输入流中的数据是否已经读完的标识
                    int len = -1;
                    //循环将输入流读入到缓冲区当中，(len=in.read(buffer))！=-1就表示in里面还有数据
                    while ((len = in.read(b)) != -1) {  //没数据了返回-1
                        //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath+"\\"+filename)当中
                        out.write(b, 0, len);
                    }
                    //关闭流
                    out.close();
                    in.close();
                    //删除临时文件
                    try {
                        Thread.sleep(3000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    item.delete();//删除处理文件上传时生成的临时文件
                    System.out.println("文件上传成功");

                }
            }
            System.out.println(JSONArray.fromObject(info));

            boolean rs=new WorkDao().insertWork(info.get("work_name"),info.get("work_lesson"),info.get("work_requirement"),info.get("outline"),info.get("guide"),info.get("design"),info.get("initiator"),new util().getTime(),info.get("endtime"),"1",info.get("work_type"),info.get("work_group"),info.get("detailPart"),info.get("detailContent"),info.get("detailScore"));

            String group=util.getBellow(info.get("work_group"));
            CreateReport(workId,group);
        } catch (FileUploadException e) {
            //e.printStackTrace();
          //  throw new RuntimeException("服务器繁忙，文件上传失败");
            e.printStackTrace();
        }
    }



    private void CreateFolider(String realPath,String tempPath)
    {
        File f = new File(realPath);
        if (!f.exists() && !f.isDirectory()) {
            System.out.println("目录或文件不存在! 创建目标目录。");
            f.mkdir();
        }

    }


    private String getId()
    {
        String id=new WorkDao().getWorkId()+"";
        return id;
    }

    private void CreateReport(String workId,String classId)
    {
        ArrayList<User> stuList=new UserDao().getUserByGroup(classId);
        for (User u:stuList)
        {
            System.out.println("须学生提交的实验报告记录创建中：正在创建"+u.getUserId()+","+u.getUserName()+"的实验报告记录,创建结果为： "+new ReportDao().createReport(workId+"-"+u.getUserId(),workId,u.getUserId(),u.getUserName()));
        }
    }


}
