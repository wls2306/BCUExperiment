package com.experiment.util;

import com.experiment.entity.Report;
import com.experiment.entity.Work;

import java.util.ArrayList;
import java.util.List;

public class demo {
    public static void main(String[] args) {
        Work w=new Work();
        w.setWorkId("10001");
        w.setWorkName("基于JavaEE的云端商城实践");
        w.setWorkInitiator("王镭树");
        w.setWorkLesson("JavaEE云端开发");
        w.setWorkCreateTime("2019-05-03");
        w.setWorkType("1");
        int i;
        List<Report> reports=new ArrayList<>();
        for (i=0;i<100;i++) {
            Report r = new Report();
            r.setReportAuthorId("1000"+i);
            r.setReportAuthor("测试"+i);
            r.setReportScore((int)(1+Math.random()*(100-0+1))+"");
            r.setReportStatus("1");
            r.setReportRater("管理员");
            reports.add(r);
        }
        try {
           /* new ExcelUtil().genernateExcel(w,reports,);*/
        }catch (Exception e)
        {
            e.printStackTrace();
        }

    }
}
