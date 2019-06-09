<%--
  Created by IntelliJ IDEA.
  User: 王镭树
  Date: 2019/5/14
  Time: 20:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>科目管理</title>
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
        margin-left: 15px;
    }
    #tableArea{
        margin-left: 15px;
    }
</style>
<body>
    <h2>科目管理</h2>
    <div id="tableArea">
        <table id="table"></table>
    </div>

</body>

<script>
    window.operateEvents={
        "click .delete":function (index,value,row) {
            BootstrapDialog.confirm({
                title:"二次确认",
                message:"确认删除该科目吗？",
                btnOKLabel:"确认",
                btnCancelLabel:"取消",
                callback:function(result) {
                    if (result)
                        dodelete(row.subId);
                }

            })
        }
    }


    $("#table").bootstrapTable({

        url: 'subject?type=2',         //请求后台的URL（*）
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
            field:'subId',
            title:'科目编号',
            align:'center'
        },{
            field:'subName',
            title:'科目名称',
            align:'center'
        },{
            field:'subLeader',
            title:'科目带头人',
            align:'center'
        },{
            field:'subStatus',
            title:'科目状态',
            align:'center',
            formatter:workStatus
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
            '<button id="delete" type="button" class="btn btn-danger delete">删除</button>',
        ].join('');

    }


    function workStatus(value,row,index) {
        switch (row.subStatus) {
            case "1":
                return ['<span style="color:green"> 开启 </span>'].join('');
                break;

            case "0":
                return ['<span style="color:blue"> 关闭 </span>'].join('');
                break;

        }
    }

    function dodelete(id) {
        $.ajax({
            url: 'subject?type=3&subid='+id,
            method: 'GET',
            contentType: false, // 注意这里应设为false
            processData: false,
            cache: false,
            success: function(data) {
                if (data===true) {
                    BootstrapDialog.show({
                        title: "请求成功",
                        message: "科目删除成功！",
                        type: BootstrapDialog.TYPE_SUCCESS
                    });
                }else {
                    BootstrapDialog.show({
                        title:"反馈",
                        message:"网络异常",
                        type:BootstrapDialog.TYPE_WARNING
                    })
                }
            },
            error: function (jqXHR) {

            },


            fail:function () {
                BootstrapDialog.show({
                    title:"反馈",
                    message:"网络异常",
                    type:BootstrapDialog.TYPE_WARNING
                })
            }

        })

        $("#table").bootstrapTable('refresh')

    }




</script>

</html>
