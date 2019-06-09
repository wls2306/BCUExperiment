package com.experiment.util;

import com.alibaba.excel.metadata.BaseRowModel;
import com.experiment.entity.Work;

import java.util.ArrayList;
import java.util.List;

public class head extends BaseRowModel {
    public List<List<String>> head(Work w)
    {
        List<List<String>> head =new ArrayList<>();
        List headCoulumn1=new ArrayList();
        List headCoulumn2=new ArrayList();
        List headCoulumn3=new ArrayList();
        List headCoulumn4=new ArrayList();
        List headCoulumn5=new ArrayList();
        headCoulumn1.add("实验项目得分表");
        headCoulumn1.add("项目编号："+w.getWorkId());
        headCoulumn1.add("项目名称："+w.getWorkName());
        if (w.getWorkType().equals("1"))
             headCoulumn1.add("项目类别：综合性实验");
        else
             headCoulumn1.add("项目类别：设计性实验");
        headCoulumn1.add("所属科目："+w.getWorkLesson());
        headCoulumn1.add("任课教师："+w.getWorkInitiator());
        headCoulumn1.add("学号"); headCoulumn2.add("姓名"); headCoulumn3.add("得分"); headCoulumn4.add("评阅人"); headCoulumn5.add("备注");
        head.add(headCoulumn1);
        head.add(headCoulumn2);
        head.add(headCoulumn3);
        head.add(headCoulumn4);
        head.add(headCoulumn5);
        return head;
    }
}
