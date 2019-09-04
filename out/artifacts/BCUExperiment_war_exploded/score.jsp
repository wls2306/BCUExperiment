<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/16
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实验报告评分</title>
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

    #info{
        width: 800px;
        border: 3px solid deepskyblue;
        padding: 15px;
        margin: 15px;
    }

    #rate{
        margin: 15px;
        width: 800px;
    }

    #miss{
        width: 500px;
        margin: 20px;
    }

    #buttonArea{
        margin: 10px;
    }

    .btnArea{
        margin: 5px;
    }
    #detailContentTable{
        table-layout: fixed;
    }

/*
    #detailContentTable{
        width: 500px;
        margin-left: 100px;
    }*/

    .detailScore{
        width: 50px;
    }

    #totalScore{
        font-size: 30px;
        color: red;
    }

    #scoreDiv{
       text-align: right;
        margin-right: 50px;
        font-size: 25px;
    }
</style>

<body>
    <h2>实验报告打分</h2>

    <div id="info">
        <div >实验项目编号：<span id="nowWorkId"><b>${work.workId}</b></span></div>
        <div >实验项目名称：<span id="nowWorkName"><b>${work.workName}</b></span></div>
        <div> 实验项目使用班级：<span id="nowWorkClass"><b>${work.workTarget}</b></span></div>
        <div> 实验项目发起人：<span id="nowWorkInitiator"><b>${work.workInitiator}</b></span></div>
        <!--   <div>

               <div>评分规则：</div>
               <div>
                   <table id="detailContentTable" class="table table-bordered" width="430px" >
                       <tr>
                           <th class="detail" width="100px">得分点编号</th>
                           <th class="detail" width="300px">得分点描述</th>
                           <th class="detail" width="50px">分值</th>
                       </tr>
                   </table>
               </div>
           </div> -->
    </div>

    <div id="buttonArea">
       <span class="btnArea"><button class="btn btn-info" id="download" onclick="download()"><span class="glyphicon glyphicon-cloud-download"></span>  下载实验报告</button></span>
        <span class="btnArea"><button class="btn btn-info" id="exit" onclick="exit()"><span class="glyphicon glyphicon-log-in"></span>  退出打分</button></span>
    </div>

    <div id="rate">
            <table  class="table table-hover table-condensed">
                <caption>以下为将实验报告上传至本系统中的学生名单，请打分</caption>
                <tr>
                    <th>报告编号</th>
                    <th>报告作者</th>
                    <th>当前分数</th>
                    <th>操作</th>
                </tr>

                    <c:forEach items="${report}" var="r">
                        <tr>
                            <td>${r.reportId}</td>
                            <td>${r.reportAuthor}</td>
                            <td><span id="reportScore-${r.reportId}">${r.reportScore}</span> </td>
                            <td> <button class="btn btn-primary" data="${r.reportId}" id="${r.reportId}" onclick="getDetail(this)"> 评分</button> </td>
                        </tr>
                    </c:forEach>

                <tr>
                    <!--  <td colspan="3"><button class="btn btn-primary" onclick="submit()"><span class="glyphicon glyphicon-send"></span>  提交</button></td>-->
                </tr>

            </table>
    </div>


    <div id="miss">
        <table class="table table-hover table-condensed">
            <caption>以下学生未在规定时间内提交实验报告</caption>
            <c:if test="${empty miss}">
                <tr>
                    <td> 没有迟交记录 </td>
                </tr>
            </c:if>


            <c:forEach items="${miss}" var="m">
                <tr>
                    <td>${m}</td>
                </tr>
            </c:forEach>
        </table>
    </div>


    <!-- 评分模态框  -->
    <div class="modal fade" id="ScoreModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">为实验报告评分</h4>
                </div>
                <div class="modal-body">
                    <!--     <table> -->
                        <div id="id-div">
                            <span>报告编号：</span>
                            <b><span id="reportId"></span></b>
                        </div>

                        <div style="margin-bottom: 20px">
                            <span>作者姓名：</span>
                            <b><span id="reportName"></span></b>
                        </div>

                        <div style="margin-top: 20px">
                            <div>评分规则：</div>
                            <div>

                                <table id="detailContentTable" class="table table-bordered"  >
                                    <tr>
                                        <th class="detail" width="50px">编号</th>
                                        <th class="detail" width="250px">描述</th>
                                        <th class="detail" width="50px">分值</th>
                                        <th class="detail" width="50px" >得分</th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <!--
                        <tr>
                            <td>录入分数：</td>
                            <td>
                                    <table id="detailScoreTable" class="table table-bordered" >
                                        <tr>
                                            <td class="detail">得分点编号</td>
                                            <td class="detail">分数</td>
                                        </tr>
                                    </table>
                            </td>
                        </tr>
                        -->
                        <div id="scoreDiv">
                            <span>总分：</span>
                            <span id="totalScore">0<span> 分</span></span>
                        </div>

                       <!--    </table> -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="submit()"><span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> 提交</button>
                </div>
            </div>
        </div>
    </div>






</body>

<script>


    var detailContent=("${work.workDetailContent}"||"").split(";");
    var detailScore=("${work.workDetailScore}"||"").split(";");

    for (var i=0;i<detailContent.length-1;i++)
    {
        $("#detailContentTable").append(
            "<tr class='newDetails'>"+
            "<td>"+(i+1)+"</td>"+
            "<td>"+detailContent[i]+"</td>"+
            "<td>"+detailScore[i]+"</td>"+
            "<td width='80px'> <input type='text' class='detailScore' id='"+i+"'  onblur='inputCheck(this)' width='50px'> </td>"+
            "</tr>"
        )
    }

 //   var mydetailScore=(data.reportScoreDetail||"").split(";");
 /*
    for (var i=0;i<=detailContent.length-2;i++)
    {
        $("#detailScoreTable").append(
            "<tr class='newDetails'>"+
            "<td>"+(i+1)+"</td>"+
            "<td> <input type='text' class='score' id='detail-'"+i+" > </td>"+
            "</tr>"
        )
    }*/



    /**
     * {"reportAuthor":"王镭树","reportAuthorId":"17111652110","reportGoal":"10","reportGoalName":"a'b'c","reportId":"10-17111652110","reportIsupload":"1","reportRater":"","reportScore":"92","reportScoreDetail":"","reportStatus":"2","reportUploadTime":"2019-01-18 15:55","reportUrl":"D:\\BCUExperiment\\out\\artifacts\\BCUExperiment_war_exploded\\WEB-INF\\upload\\10\\report【挖空】《计算机网络》期末考试复习大纲 .doc"}
     **/

    function initModel(data) {
  //      alert(data.reportId+","+data.reportAuthor)
        $("#reportId").text(data.reportId);
        $("#reportName").text(data.reportAuthor);
        $("#ScoreModal").modal("show");
    }

    function submit() {
        if (inputCheck())
        {

            $.post(
                "score",
                {
                    reportId:$("#reportId").text(),
                    reportScore:$("#totalScore").text(),
                    reportDetail:StudetailScore,
                    reportRater:"${user.userName}"
                },function (data) {
                   if (data===true)
                   {
                       BootstrapDialog.show({
                           type: BootstrapDialog.TYPE_SUCCESS,
                           title: "请求成功",
                           message:"分数已保存"
                       });
                       $("#reportScore-"+$("#reportId").text()).text($("#totalScore").text());
                       $("#ScoreModal").modal('hide');
                       $(".detailScore").val("");

                   }else{
                       BootstrapDialog.show({
                           type: BootstrapDialog.TYPE_DANGER,
                           title: "请求出错",
                           message:"分数上传出错"
                       });
                   }

                }
            )

        }
    }

    /**
     * button 前端想jquery函数传值 前端传this 脚本用 e  去接 ！
     * @param e
     */

    function getDetail(e) {
        $("table").remove(".newDetails");
        var reportId=e.id;
    //    alert(e.id)
        $.ajax({
            url: "score",
            async: true,
            type:"GET",
            data:{
                type:"2",
                reportId:reportId
            },
            success:initModel,
            error:function () {
                BootstrapDialog.show({
                    title:"出错",
                    message:"请求失败"
                })
            }

        })
    }



    function download() {
        window.open("download?type=4&work_id="+${work.workId})
    }

    function exit() {
        window.location.replace("running_work.jsp#stop");
    }


    var StudetailScore="";
    function inputCheck(e) {
        StudetailScore="";
        var result=true;
        var totalScore=0;

        $(".detailScore").each(function () {

            var index=$(this).attr('id');
            var score=parseInt($(this).val());
            if (score<0||score>detailScore[index]||$(this).val()=="") {
                $(this)[0].style.border = "1px solid red";
                result=false;
            }
            else {
                $(this)[0].style.border = "1px solid green";
                totalScore+=score;
                StudetailScore+=score+";";
                console.log(StudetailScore);
                $("#totalScore").text(totalScore);


            }
        })

        console.log(result)
        return result;
    }
    
    
</script>

</html>
