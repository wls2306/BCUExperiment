<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/11/30
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>北京城市学院综合性设计性实验项目管理系统</title>

</head>

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 可选的 Bootstrap 主题文件（一般不用引入）
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
 -->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>




<style type="text/css">

    #page{

        width:100%;
        height: 900px;
    }

    #title{

        margin: 10px 0px 10px 10px;
        font-family:Arial,Helvetica,sans-serif;
        font-size: 40px;
    }

    #head{

        width: 100%;
        height: 70px;
    }

    #main{

        margin-top: 10px;
        font-family:Arial,Helvetica,sans-serif;
        width: 100%;
        height: 800px;
        background-image: url("image/login.jpg");
        background-size: cover;
        background-repeat:round;
    }

    #loginTitle{

        font-size: 30px;
        margin-left: 90px;
        margin-bottom: 10px;
    }

    #loginFrame{

        float: right;
        width: 300px;
        height: 200px;
        margin-top: 300px;
        margin-right: 150px;

        border-radius: 15px;

    }

    #button-area{

        margin-left: 105px;
    }

    .input-group{

       margin: 10px;
    }

    #foot-title{

        margin-top: 20px;
        margin-bottom: 20px;

    }

</style>






<body>

<div id="page">

    <div id="head">
        <div id="title"> <img src="image/bcu.jpg"> 北京城市学院实验项目管理系统</div>
    </div>


    <div id="main">

        <div id="loginFrame">

                    <div id="loginTitle" style="color: white">用户登录</div>
                    <form action="login" method="post" onsubmit="return check()">

                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-user"></span></span>
                            <input type="text" class="form-control" placeholder="your id" aria-describedby="basic-addon1" name="userId" id="userId">
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="password" class="form-control" placeholder="password" aria-describedby="basic-addon1" name="psw" id="pwd">
                        </div>


                        <div id="button-area">
                            <button type="submit" class="btn btn-primary" id="submit">
                                <span class="glyphicon glyphicon-ok"></span>  登录
                            </button>
                        </div>
                    </form>

        </div>

    </div>

    <div id="footer">
            <div id="foot-title" align="center">© 2018 Beijing City University Mobile Application Development Studio All Right Received</div>
    </div>
</div>

</body>

<script>
    function check() {
        var x=$("#userId").val();
        var y=$("#pwd").val();
        if(x==""||y=="")
        {
           alert("用户名或密码没有输入！");
            return false;
        }
        else
            return true;

    }

</script>





</html>
