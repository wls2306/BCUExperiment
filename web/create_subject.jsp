<%--
  Created by IntelliJ IDEA.
  User: 王镭树
  Date: 2019/5/14
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建科目</title>

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


</head>


<style type="text/css">
    h2{
        margin: 15px;
    }

    #info-table{

        margin:15px;
        width: 500px;
    }

</style>
<body>
    <h2>新建科目</h2>
    <div id="info-table">
    <form id="info" name="info">
        <caption>请填写项目信息表格以创建一个新的实验任务</caption>
        <table class="table table-hover table-condensed">
            <tr>
                <td>科目编号：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
                <td><input type="text" id="subId" class="form-control" name="subid"></td>
            </tr>

            <tr>
                <td>科目名称：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
                <td><input type="subName" id="subName" class="form-control" name="subname"></td>
            </tr>

            <tr>
                <td>科目带头人：</td>
                <td><input  id="subLeader" name="subleader" class="form-control"></td>
            </tr>

        </table>
    </form>
    <button class="btn btn-info" onclick="ask()"><span class="glyphicon glyphicon-send"></span>  提交</button>
    </div>
</body>

<script>

    function ask() {
        BootstrapDialog.confirm({
            title:"二次确认",
            message:"确认创建该科目吗？",
            btnOKLabel:"确认",
            btnCancelLabel:"取消",
            callback:function(result) {
                if (result)
                    submit();
            }

        })

    }


    function submit() {

        $.ajax({
            url: 'subject?type=1&subid='+$("#subId").val()+"&subname="+$("#subName").val()+"&subleader="+$("#subLeader").val()+"&substatus=1",
            method: 'GET',
            contentType: false, // 注意这里应设为false
            processData: false,
            cache: false,
            success: function(data) {
                if (data===true) {
                    BootstrapDialog.show({
                        title: "请求成功",
                        message: "科目创建成功！",
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

    }

</script>
</html>
