package com.experiment.util;

import com.alibaba.excel.metadata.BaseRowModel;
import com.experiment.entity.Report;

import java.util.ArrayList;
import java.util.List;

public class content extends BaseRowModel {
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
            if (r.getReportStatus().equals("0"))
                row.add("未提交报告");
            else
                row.add("");

            rows.add(row);
        }
        return rows;
    }
}
