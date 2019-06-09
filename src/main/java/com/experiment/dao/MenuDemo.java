package com.experiment.dao;

import com.experiment.entity.Menu;
import net.sf.json.JSONArray;

import java.util.ArrayList;

public class MenuDemo {
    public static void main(String[] args) {
        MenuDao md=new MenuDao();
        ArrayList<Menu> list=md.getMenuByAccess("2");
        JSONArray ja=JSONArray.fromObject(list);
        System.out.println(ja);

    }
}
