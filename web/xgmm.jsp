<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/8
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>

    <script src="script/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <!-- 对话框  -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>

</head>

<style>

    h2{
        margin: 15px;
    }

    #table{
        width: 500px;
        margin: 15px;
    }
</style>


<body>
<h2>修改密码</h2>

<table id="table" class="table table-hover table-condensed">
    <tr>
        <td>旧密码</td>
        <td><input type="password" id="oldPwd"></td>
    </tr>
    <tr>
        <td>新密码</td>
        <td><input type="password" id="pwd"></td>
    </tr>
    <tr>
        <td>确认密码</td>
        <td><input type="password" id="configpwd"></td>
    </tr>

    <tr>
        <td colspan="2"><button class="btn btn-primary" onclick="submit()" >提交</button></td>
    </tr>
</table>


</body>

<script>
    function check() {
       return $("#pwd").val()==$("#configpwd").val()?true:false;
    }

    function submit() {

        if(check())
        {
            $.post(
               "user",
                {
                    type:"1",
                    userId:"${user.userId}",
                    oldPwd:$("#oldPwd").val(),
                    newPwd:$("#pwd").val(),
                },
                function (data) {
                  BootstrapDialog.show({
                      title:"反馈结果",
                      message:data
                  })
                }

            )
        }else {
            BootstrapDialog.show({
                type:BootstrapDialog.TYPE_DANGER,
                title:"错误",
                message:"两次密码输入不一致"
            })
        }

    }
</script>




</html>
