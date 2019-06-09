package com.experiment.dao;

import com.experiment.entity.Report;
import com.experiment.entity.Work;
import com.experiment.util.util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.ArrayList;



public class demo {
    public static void main(String[] args) {
        String file = "abc.docx";
        String name = util.ext(file);
        System.out.println(name);
    }
}

