<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2019/1/25
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目报告单</title>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<style type="text/css">

    h2{
        margin-left: 15px;
    }

    h3{
        margin-left: 15px;
    }


    #info{
        margin-left: 15px;
        width: 500px;

    }
    #workInfo{
        table-layout: fixed;
    }
    #a1{
        width: 150px;
    }
    #a2{
        width: 350px;
    }
    #reportInfo{
        table-layout: fixed;
        width: 650px;
    }
    #b1{
        width: 150px;
    }
    #b2{
        width: 100px;
    }
    #b3{
        width: 100px;
    }
    #b4{
        width: 200px;
    }
    #b5{
        width: 100px;
    }
    #report{
        margin-left: 10px;
        margin-bottom: 30px;
    }


</style>


<body>
    <h2>实验项目成绩报告单</h2>

    <h3>项目信息</h3>
    <div id="info">
        <table id="workInfo" class="table table-condensed" >
            <tr>
                <td id="a1">项目编号：</td>
                <td id="a2">${work.workId}</td>
            </tr>
            <tr>
                <td>项目名称：</td>
                <td>${work.workName}</td>
            </tr>
            <tr>
                <td>实验要求：</td>
                <td>${work.workRequirement}</td>
            </tr>
            <tr>
                <td>实验大纲：</td>
                <td><button id="outline" class="btn btn-primary" bind-url="" onclick="download('1',${work.workId})"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
            </tr>
            <tr>
                <td>实验指导书：</td>
                <td><button id="guide" class="btn btn-primary" bind-url="" onclick="download('2',${work.workId})"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
            </tr>
            <tr>
                <td>实验设计方案：</td>
                <td><button id="design" class="btn btn-primary" bind-url="" onclick="download('3',${work.workId})"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
            </tr>

            <tr>
                <td>实验类型：</td>
                <td>
                    <c:choose>
                        <c:when test="${work.workType eq '1'}">综合性实验</c:when>
                        <c:when test="${work.workType eq '2'}">设计性实验</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>创建人：</td>
                <td>${work.workInitiator}</td>
            </tr>
            <tr>
                <td>创建日期：</td>
                <td>${work.workCreateTime}</td>
            </tr>
        </table>
    </div>
    <h3>实验报告信息</h3>
    <div id="report">
    <table id="reportInfo" class="table table-condensed table-bordered" >
        <tr>
            <th id="b1" style="text-align: center">报告编号</th>
            <th id="b2" style="text-align: center">作者姓名</th>
            <th id="b3" style="text-align: center">报告得分</th>
            <th id="b4" style="text-align: center">得分详情</th>
            <th id="b5" style="text-align: center">评阅人</th>
        </tr>
        <c:forEach var="r" items="${report}">
            <tr>

                <c:choose>

                <c:when test="${r.reportIsupload eq '0'}">
                    <td>${r.reportId}</td>
                    <td style="text-align: center">${r.reportAuthor}</td>
                    <td style="text-align: center">0</td>
                    <td style="text-align: center">未提交</td>
                    <td style="text-align: center">-</td>

                </c:when>

                <c:when test="${r.reportStatus eq '0'}">
                    <td>${r.reportId}</td>
                    <td style="text-align: center">${r.reportAuthor}</td>
                    <td style="text-align: center">0</td>
                    <td style="text-align: center">未评阅</td>
                    <td style="text-align: center">-</td>
                </c:when>

                <c:when test="${r.reportStatus eq '1'}">
                    <td>${r.reportId}</td>
                    <td style="text-align: center">${r.reportAuthor}</td>
                    <td style="text-align: center">${r.reportScore}</td>
                    <td style="text-align: center">${r.reportScoreDetail}</td>
                    <td style="text-align: center">${r.reportRater}</td>
                </c:when>

                <c:when test="${r.reportStatus eq '2'}">
                    <td>${r.reportId}</td>
                    <td style="text-align: center">${r.reportAuthor}</td>
                    <td style="text-align: center">${r.reportScore}</td>
                    <td style="text-align: center">${r.reportScoreDetail}</td>
                    <td style="text-align: center">${r.reportRater}</td>
                </c:when>


                </c:choose>
            </tr>
        </c:forEach>


    </table>
    </div>
</body>

<script>
    function download(type,workid) {

    }
</script>



</html>
