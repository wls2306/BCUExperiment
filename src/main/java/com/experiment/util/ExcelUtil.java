package com.experiment.util;


import com.alibaba.excel.EasyExcelFactory;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.metadata.Font;
import com.alibaba.excel.metadata.Sheet;
import com.alibaba.excel.metadata.Table;
import com.alibaba.excel.metadata.TableStyle;
import com.experiment.entity.Report;
import com.experiment.entity.Work;
import org.apache.poi.ss.usermodel.IndexedColors;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelUtil {
    public boolean genernateExcel(Work w,List<Report> reports,String path)throws Exception {
        OutputStream out = new FileOutputStream(path);
        ExcelWriter writer = EasyExcelFactory.getWriter(out);

        Sheet sheet1 = new Sheet(1, 0);
        sheet1.setSheetName("得分表");
        Table table=new Table(1);
        table.setTableStyle(ExcelUtil.createTableStyle());
        table.setHead(head(w));
        Map widthMap = new HashMap();
            widthMap.put(0, 3500);
            widthMap.put(1, 3500);
            widthMap.put(2, 3500);
            widthMap.put(3, 3500);
            widthMap.put(4, 3500);
        sheet1.setColumnWidthMap(widthMap);
        writer.write1(ContentList(reports),sheet1,table);

        writer.finish();
        out.close();
        return true;
    }

    public List<List<String>> head(Work w)
    {
        List<List<String>> head =new ArrayList<>();
        List headCoulumn1=new ArrayList();
        List headCoulumn2=new ArrayList();
        List headCoulumn3=new ArrayList();
        List headCoulumn4=new ArrayList();
        List headCoulumn5=new ArrayList();
        List headCoulumn6=new ArrayList();
            headCoulumn1.add("实验项目得分表");
            headCoulumn1.add("项目编号："+w.getWorkId());
            headCoulumn1.add("项目名称："+w.getWorkName());
            if(w.getWorkType().equals("1"))
                headCoulumn1.add("项目类别：综合性实验项目");
            else
                headCoulumn1.add("项目类别：设计性实验项目");
            headCoulumn1.add("所属科目："+w.getWorkLesson());
            headCoulumn1.add("所属班级："+w.getWorkTarget());
            headCoulumn1.add("任课教师："+w.getWorkInitiator());
            headCoulumn1.add("发布日期："+w.getWorkCreateTime());
            headCoulumn1.add("学号");

            headCoulumn2.add("实验项目得分表");
            headCoulumn2.add("项目编号："+w.getWorkId());
            headCoulumn2.add("项目名称："+w.getWorkName());
            if(w.getWorkType().equals("1"))
                headCoulumn2.add("项目类别：综合性实验项目");
            else
                headCoulumn2.add("项目类别：设计性实验项目");
            headCoulumn2.add("所属科目："+w.getWorkLesson());
            headCoulumn2.add("所属班级："+w.getWorkTarget());
            headCoulumn2.add("任课教师："+w.getWorkInitiator());
            headCoulumn2.add("发布日期："+w.getWorkCreateTime());
            headCoulumn2.add("姓名");

            headCoulumn3.add("实验项目得分表");
            headCoulumn3.add("项目编号："+w.getWorkId());
            headCoulumn3.add("项目名称："+w.getWorkName());
            if(w.getWorkType().equals("1"))
                headCoulumn3.add("项目类别：综合性实验项目");
            else
                headCoulumn3.add("项目类别：设计性实验项目");
            headCoulumn3.add("所属科目："+w.getWorkLesson());
            headCoulumn3.add("所属班级："+w.getWorkTarget());
            headCoulumn3.add("任课教师："+w.getWorkInitiator());
            headCoulumn3.add("发布日期："+w.getWorkCreateTime());
            headCoulumn3.add("得分");

            headCoulumn4.add("实验项目得分表");
            headCoulumn4.add("项目编号："+w.getWorkId());
            headCoulumn4.add("项目名称："+w.getWorkName());
            if(w.getWorkType().equals("1"))
                headCoulumn4.add("项目类别：综合性实验项目");
            else
                headCoulumn4.add("项目类别：设计性实验项目");
            headCoulumn4.add("所属科目："+w.getWorkLesson());
            headCoulumn4.add("所属班级："+w.getWorkTarget());
            headCoulumn4.add("任课教师："+w.getWorkInitiator());
            headCoulumn4.add("发布日期："+w.getWorkCreateTime());
            headCoulumn4.add("评阅人");

            headCoulumn5.add("实验项目得分表");
            headCoulumn5.add("项目编号："+w.getWorkId());
            headCoulumn5.add("项目名称："+w.getWorkName());
            if(w.getWorkType().equals("1"))
                headCoulumn5.add("项目类别：综合性实验项目");
            else
                headCoulumn5.add("项目类别：设计性实验项目");
            headCoulumn5.add("所属科目："+w.getWorkLesson());
            headCoulumn5.add("所属班级："+w.getWorkTarget());
            headCoulumn5.add("任课教师："+w.getWorkInitiator());
            headCoulumn5.add("发布日期："+w.getWorkCreateTime());
            headCoulumn5.add("备注");

        head.add(headCoulumn1);
        head.add(headCoulumn2);
        head.add(headCoulumn3);
        head.add(headCoulumn4);
        head.add(headCoulumn5);

        return head;
    }

    public List<List<Object>> ContentList(List<Report> reports)
    {
        List<List<Object>> rows=new ArrayList<>();
        for (Report r:reports)
        {
            List<Object> row=new ArrayList<>();
            row.add(r.getReportAuthorId());
            row.add(r.getReportAuthor());
            row.add(r.getReportScore());
            row.add(r.getReportRater());
            if (r.getReportIsupload().equals("0"))
                row.add("未提交报告");
            else
                row.add("");

            rows.add(row);
        }
        return rows;
    }

    public static TableStyle createTableStyle() {
        TableStyle tableStyle = new TableStyle();
        Font headFont = new Font();
        headFont.setBold(false);
        headFont.setFontHeightInPoints((short)13);
        headFont.setFontName("楷体");
        tableStyle.setTableHeadFont(headFont);
        tableStyle.setTableHeadBackGroundColor(IndexedColors.WHITE);

        Font contentFont = new Font();
        contentFont.setBold(false);
        contentFont.setFontHeightInPoints((short)10);
        contentFont.setFontName("宋体");
        tableStyle.setTableContentFont(contentFont);
        tableStyle.setTableContentBackGroundColor(IndexedColors.WHITE);
        return tableStyle;
    }




}
