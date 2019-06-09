<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/15
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的实验报告</title>

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

<style type="text/css">

    h2{
        margin: 15px;
    }
   #runningContent{
       margin: 15px;
   }
    #alreadyContent{
        margin: 15px;
    }

    #missyContent{
        margin: 15px;
    }

</style>

<body>

<h2>我的实验报告</h2>
<!-- 标签栏效果 -->
<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#already" data-toggle="tab">
        已提交的报告
    </a></li>

    <li><a href="#miss" data-toggle="tab">逾期未提交的报告</a></li>
    <!-- <li><a href="#miss" data-toggle="tab">逾期未提交的报告</a></li> -->
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="already">
        <div id="alreadyContent">
            <table id="alreadyTable"></table>
        </div>
    </div>

    <div class="tab-pane fade" id="miss">
        <div id="missContent">
            <table id="missTable"></table>
        </div>
    </div>




</div>

<!--  -->
</body>


<script>
    /**
     * ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 已提交报告分页↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
     */
    
    window.operateEvents={
        "click  .toJudge":function (index, value, row) {
            dojudge(row.reportGoal)
        }
    }
    
        
    $("#alreadyTable").bootstrapTable({

        url: 'report?type=1&userId=${user.userId}&isUpload=1',         //请求后台的URL（*）
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
        uniqueId: "reportId",                     //每一行的唯一标识，一般为主键列
        showExport: true,                     //是否显示导出
        exportDataType: "basic",
        columns: [ {
            field:'reportId',
            title:'报告编号',
            align:'center'
        },{
            field:'reportGoal',
            title:'所属项目编号',
            align:'center'
        } ,{
            field:'reportGoalName',
            title:'所属项目名称',
            align:'center'
        },{
            field:'reportStatus',
            title:'当前状态',
            align:'center',
            formatter:status
        } ,{
            field:'reportScore',
            title:'报告得分',
            align:'center',
            formatter:score
        } ,{
            field:'reportRater',
            title:'评分人',
            align:'center'
        } ,{
                field: 'operation',
                title: '操作',
                align: 'center',
                events:operateEvents,//给按钮注册事件
                formatter:addFunctionAlty//表格中增加按钮
            }
            ]
    })

    function addFunctionAlty(value,row,index)
    {
        return [
           '<button id="uploadReport" type="button" class="btn btn-info toJudge">去评分</button>',
        ].join('');

    }

    function status(value,row,index) {
        switch (row.reportStatus) {
            case "0":
                return ['<span style="color: blue">待评阅</span>'].join('');
                break;

            case "1":
                return ['<span style="color: blue">待公布</span>'].join('');
                break;

            case "2":
                return ['<span style="color: blue">已完成</span>'].join('');
                break;

        }

    }


    function score(value,row,index) {
        var score=parseInt(row.reportScore);

        if(score>=85)
        {
            return ['<span style="color: green">'+score+'</span>'].join('')
        }else if (score>=70&&score<85)
        {
            return ['<span style="color: blue">'+score+'</span>'].join('')
        }else if (score>=60&&score<70)
        {
            return ['<span style="color: orange">'+score+'</span>'].join('')
        }else if (score>=0&&score<60)
        {
            return ['<span style="color: red">'+score+'</span>'].join('')
        }else
        {
            return [''].join('')
        }
    }


    function dojudge(id) {
            window.parent.location.href='demo?userId=${user.userId}&password=${user.userPwd}&reportGoal='+id;
    }



    /**
     * ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑待提交报告分页↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
     */
</script>

</html>
