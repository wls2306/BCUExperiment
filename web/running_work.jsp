<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/7
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在进行的项目</title>


    <script src="script/jquery-3.3.1.min.js"></script>


    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入）
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
     -->
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


    <!-- 对话框  -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>

    <!-- 引入bootstrap-table样式 -->
    <link href="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.css" rel="stylesheet">

    <!-- bootstrap-table.min.js -->
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
    <!-- 引入中文语言包 -->
    <script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>

</head>

<style>
    h2{
        margin: 15px;
    }

    #myTab{
        margin: 15px;
    }

    #runningContent{
        padding-left: 15px;
    }

    #stopContent{
        padding-left: 15px;
    }


    #content{
        margin: 15px;
    }

    .btn{
        margin-right: 5px;
    }
</style>



<body>
<h2>我创建的项目</h2>




<!-- 标签栏效果 -->
<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#running" data-toggle="tab">
       正在进行的项目
    </a></li>

    <li><a href="#stop" data-toggle="tab">已结束的项目</a></li>

</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="running">
        <div id="runningContent">
            <table id="runningTable"></table>
        </div>
    </div>
    <div class="tab-pane fade" id="stop">
        <div id="stopContent">
            <table id="stopTable"></table>
        </div>
    </div>

</div>

<!--  -->





</body>





<script>


    $(function () {
        $('#myTab li:eq(0) a').tab('show');
    });

    /**
     * ***************************** ↓正在进行的项目 分页 ↓****************************
     */

    window.operateEvents={
            "click .see":function (index,value,row) {
                see(row.workId);
            },

            "click .end":function (index,value,row) {
                BootstrapDialog.confirm({
                    title:"二次确认",
                    message:"确认关闭该项目？该项目将无法再提交新的报告。",
                    type:BootstrapDialog.TYPE_DANGER,
                    btnCancelLabel: '取消', // <-- Default value is 'Cancel',
                    btnOKLabel: '确认', // <-- Default value is 'OK',
                    btnOKClass: 'btn-danger', // <-- If you didn't specify it, dialog type will be used,
                    callback: function(result) {
                        if(result)
                            stopSubmit(row.workId);
                    }
                })
            }
    }





    $("#runningTable").bootstrapTable({

        url: 'work?type=1&user=${user.userName}',         //请求后台的URL（*）
        method: 'get',                      //请求方式（*）
        toolbar: '#toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortOrder: "asc",                   //排序方式
        //    queryParams: oTableInit.queryParams,//传递参数（*）
        sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,                       //初始化加载第一页，默认第一页
        pageSize: 10,                       //每页的记录行数（*）
        pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
        search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
        showColumns: true,                  //是否显示所有的列
        showRefresh: true,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        // clickToSelect: true,                //是否启用点击选中行
        height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
        uniqueId: "workId",                     //每一行的唯一标识，一般为主键列
        showExport: true,                     //是否显示导出
        exportDataType: "basic",
        columns: [ {
            field:'workId',
            title:'项目编号',
            align:'center'
        },{
            field:'workName',
            title:'项目名称',
            align:'center'
        },{
            field:'workTarget',
            title:'使用班级',
            align:'center'
        },{
            field:'workEndTime',
            title:'截止日期',
            align:'center'
        },{
            field: 'operation',
            title: '操作',
            align: 'center',
            events:operateEvents,//给按钮注册事件
            formatter:addFunctionAlty//表格中增加按钮
        }]
    })

    function addFunctionAlty(value,row,index)
    {
        return [
            '<button id="change" type="button" class="btn btn-primary change">修改项目</button>',
            '<button id="see" type="button" class="btn btn-info see">查看提交状态</button>',
            '<button id="end" type="button" class="btn btn-danger end">截止提交</button>',
        ].join('');

    }


    /**
     * ***************************** ↑正在进行的项目 分页 ↑****************************
     */



    /**
     * ***************************** ↓已结束项目 分页 ↓****************************
     */

    window.operateEvents2={
        "click .download":function (index,value,row) {
            window.open("excel?workId="+row.workId )
        },

        "click .score":function (index,value,row)
        {
            window.location.replace("score?type=1&workId="+row.workId);
        },

        "click .publish":function (index,value,row) {
            BootstrapDialog.confirm({
                title:"二次确认",
                message:"确认公布成绩吗？成绩一旦公布将不得再次修改！",
                type:BootstrapDialog.TYPE_WARNING,
                btnCancelLabel:"取消",
                btnOKLabel:"确认",
                btnOKClass:'btn-warning',
                callback:function (result) {
                    if (result)
                        publishSubmit(row.workId)
                }
            })
        },

        "click .seeScore":function (index,value,row) {
            //   alert(row.workId)
            window.location.replace("score?type=3&workId="+row.workId);
        }


    }





    $("#stopTable").bootstrapTable({

        url: 'work?type=4&user=${user.userName}',         //请求后台的URL（*）
        method: 'get',                      //请求方式（*）
        toolbar: '#toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortOrder: "asc",                   //排序方式
        //    queryParams: oTableInit.queryParams,//传递参数（*）
        sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,                       //初始化加载第一页，默认第一页
        pageSize: 10,                       //每页的记录行数（*）
        pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
        search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
        showColumns: true,                  //是否显示所有的列
        showRefresh: true,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        // clickToSelect: true,                //是否启用点击选中行
        height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
        uniqueId: "workId",                     //每一行的唯一标识，一般为主键列
        showExport: true,                     //是否显示导出
        exportDataType: "basic",
        columns: [ {
            field:'workId',
            title:'项目编号',
            align:'center'
        },{
            field:'workName',
            title:'项目名称',
            align:'center'
        },{
            field:'workTarget',
            title:'使用班级',
            align:'center'
        },{
            field:'workStatus',
            title:'公布分数',
            align:'center',
            formatter:p
        },{
            field: 'operation',
            title: '操作',
            align: 'center',
            events:operateEvents2,//给按钮注册事件
            formatter:addFunctionAlty2//表格中增加按钮
        }]
    })

    function addFunctionAlty2(value,row,index)
    {
        return [
            '<button id="score" type="button" class="btn btn-primary score">前往评分</button>',
            '<button id="publish" type="button" class="btn btn-primary publish">公布分数</button>',
            '<button id="seeScore" type="button" class="btn btn-primary seeScore">查看评分表</button>',
            '<button id="download" type="button" class="btn btn-primary download">下载得分表</button>'
        ].join('');

    }

    function p(row,index,value) {
        switch (index.workStatus) {
            case "2":
                return  ['<span style="color: red"> 否 </span>'].join('');
                break;

            case "3":
                return  ['<span style="color:green"> 是 </span>'].join('');
                break;
        }

    }


    /**
     * ***************************** ↑已结束项目 分页 ↑****************************
     */





















    function stopSubmit(workId) {
        $.get(
            "work",
            {
                type:"5",
                workId:workId,
                workStatus:"2"
            },
            function (data) {
                //alert(data);
                BootstrapDialog.show({
                    title: "反馈结果",
                    message: data
                });
                $("#runningTable").bootstrapTable('refresh');
            }

        )

    }
    //Bootstrap Dialog 不显示  function(data)不执行 要注意 servlet的相应格式是不是 html  或者json格式正确
    function see(workId) {
        $.get(
            "work",
            {
                type:"6",
                workId:workId

            },
            function (data) {
                //alert(data);
                BootstrapDialog.show({
                    title: "反馈结果",
                    message: data
                });
                $("#runningTable").bootstrapTable('refresh');
            }

        )
    }


    function publishSubmit(workId) {
        $.get("work",
            {
                type:"7",
                workId:workId
            },function (data) {
                BootstrapDialog.show({
                    title:"反馈结果",
                    message:data
                });
                $("#stopTable").bootstrapTable('refresh');
        }
        )
    }



</script>


</html>
