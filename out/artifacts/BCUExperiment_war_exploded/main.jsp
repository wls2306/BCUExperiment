<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/11/30
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>北京城市学院实验项目管理系统</title>
</head>

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


<style type="text/css">

    #all{
        width: 1300px;
        margin-left: auto;
        margin-right: auto;
    }

    #title-1{
    /**    float: left;*/
    }

    .title{

        padding: 10px 0px 10px 10px;
        font-family:Arial,Helvetica,sans-serif;
        font-size: 40px;
        border-bottom: #00b3ee solid 2px;
    }

    #title-2{

      //  padding: 10px 0px 10px 10px;
       // font-family:Arial,Helvetica,sans-serif;
        font-size: 20px;
      //  border-bottom: #00b3ee solid 2px;
    }


    #main{
        display: table;
    }
    #row{
        display: table-row;
    }
    #menu{

        width: 200px;
        display: table-cell;
        border-right: #00b3ee 1px solid;
        vertical-align: top; /*对齐方式 ：顶部对齐 一定要加 不然会出现两边交错！！ 10min*/

    }
    #content{
        display: table-cell;
        vertical-align: top;
    }
    #menu-area{
       margin: 15px 30px 10px 30px;
    }
    #footer{

        padding: 15px 0px 15px 380px;
        border-top:#00b3ee 1px solid;
    }

    #user{
        padding: 25px;
        float: right;
        text-align: right;
        font-size: 15px;

    }


</style>


<body>

<div id="all">



    <div class="title">
        <span id="title-1" ><img src="image/bcu.jpg" >北京城市学院实验项目管理系统</span>

        <span id="user" >
        欢迎您，${user.userName}
        <C:choose>
            <C:when test="${user.userType eq '1'}">
                同学
            </C:when>

            <C:when test="${user.userType eq '2'}">
                老师
            </C:when>

            <C:when test="${user.userType eq '3'}">
                管理员
            </C:when>

        </C:choose>
        [<a href="login.jsp">注销</a>]
    </span>

    </div>




        <div id="main">
            <div id="row">
                <div id="menu">



                    <div id="menu-area">
                            <ul class="nav nav-pills nav-stacked" role="tablist">
                                <C:forEach var="list" items="${menu}"> <!-- 一定要注意这里的 menu一定要加大括号 ！因为从session中获得！！10min-->
                                    <C:choose>

                                    <%--<!-- 通过jquery方法改变iframe的地址，有效的解决了因为bootstrap胶囊菜单造成的target无效的问题 2h --> --%>
                                        <C:when test="${list.menuType eq '1'}">
                                             <li  role="presentation" href="${list.menuUrl}"> <a href="${list.menuUrl}" onclick="switich('${list.menuUrl}')" role="tab" data-toggle="tab" target="frame">${list.menuName}</a>  </li>
                                        </C:when>

                                        <C:when test="${list.menuType eq '2'}">
                                            <div><strong> ${list.menuName}</strong></div>
                                        </C:when>

                                    </C:choose>


                                </C:forEach>
                            </ul>
                    </div>
                </div>
                <div id="content">
                    <iframe name="frame" id="frame" width="1024px" height="768px" src="" frameborder="0" scrolling="1">
                        您的浏览器不支持HTML5，请升级浏览器再试
                    </iframe>

                </div>
            </div>
        </div>

    <div id="footer">
        © 2018 Beijing City University Mobile Application Development Studio All Right Received
    </div>
</div>

</body>

<script>
    function switich(url) {
        $("#frame").attr('src',url);
       // alert($("#frame").attr('src'));
    }

</script>




</html>
