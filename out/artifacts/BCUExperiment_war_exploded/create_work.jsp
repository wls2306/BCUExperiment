<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/1
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建实验项目</title>
</head>

<!--  <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
-->

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

<h2>新建实验项目</h2>

<div id="info-table" >
    <form enctype="multipart/form-data" id="info" name="info">
    <caption>请填写项目信息表格以创建一个新的实验任务</caption>
    <table class="table table-hover table-condensed">
        <tr>
            <td>实验名称：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
            <td><input type="text" id="work_name" class="form-control" name="work_name"></td>
        </tr>

        <tr>
            <td>所属科目：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
            <td><input type="text" id="work_lesson" class="form-control" name="work_lesson"></td>
        </tr>

        <tr>
            <td>实验要求：</td>
            <td><textarea class="form-control" rows="3" style="resize: none ;" id="work_requirement" name="work_requirement"></textarea></td>
        </tr>

        <tr>
            <td>实验大纲：</td>
            <td><input type="file" name="outline"></td>
        </tr>

        <tr>
            <td>实验指导书：</td>
            <td><input type="file" name="guide"></td>
        </tr>

        <tr>
            <td>实验设计方案：</td>
            <td><input type="file" name="design"></td>
        </tr>

        <tr>
            <td>得分点设置：</td>
            <td><a onclick="openDetail()">点此设置</a>    <span id="detailStatus" style="color: red;">(尚未设置)</span>     </td>
        </tr>

        <tr>
            <td>项目类别</td>
            <td>
                <label class="radio-inline">
                    <input type="radio" name="work_type" id="inlineRadio1" value="1"> 综合性实验
                </label>
                <label class="radio-inline">
                    <input type="radio" name="work_type" id="inlineRadio2" value="2"> 设计性实验
                </label>
            </td>
        </tr>


        <tr>
            <td>使用班级</td>
            <td>
                <input type="text" class="form-control" name="work_group" list="group" >
                <datalist id="group">
                    <c:forEach var="g" items="${group}">
                        <option value="${g.groupName}(${g.groupId})"/>
                    </c:forEach>
                </datalist>

            </td>
        </tr>



        <tr>
            <td>实验截止日期：</td>
            <td><input type="datetime-local" name="endtime" class="form-control"></td>
        </tr>

    </table>
    </form>
    <button class="btn btn-info" onclick="ask()"><span class="glyphicon glyphicon-send"></span>  提交</button>
</div>


<!-- 进度条模态框部分  -->

<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">处理中!</h4>
            </div>
            <div class="modal-body">
                <div id="content">正在上传您的文件......</div>
                <!-- 进度条 -->
                <div class="progress">
                    <div  id="progress"  class="progress-bar" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                        0%
                    </div>
                </div>
                <!-- 进度条 -->
            </div>
            <!--
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div> -->
        </div>
    </div>
</div>

<!-- 模态框 -->


<!-- 得分点设置模态框 -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="uploadModalLabel">设置得分点内容与分值</h4>
            </div>
            <div class="modal-body">
                <!-- 内容区域↓ -->
                <capition>请设置得分点内容与分值</capition>
                <div>
                    <button class="btn btn-primary" onclick="insertdetail()" style="margin: 5px">增加项目</button>
                </div>
                <table class="table table-hover table-condensed " id="detailTable">
                    <tr>
                        <th>序号</th>
                        <th>得分点描述</th>
                        <th>分值</th>
                        <th>操作</th>
                    </tr>
                </table>
                <div>分数总计：<b><span id="totalScore"></span></b> 分</div>
                <div style="margin-right: 5px" ><button class="btn btn-primary" onclick="detailCheck()">保存</button></div>
            </div>
        </div>
    </div>
</div>
                <!-- 得分点设置模态框 -->








</body>


<script>
    function ask() {
        BootstrapDialog.confirm({
            title:"二次确认",
            message:"确认创建该项目吗？",
            btnOKLabel:"确认",
            btnCancelLabel:"取消",
            callback:function(result) {
                if (result)
                    submit();
            }

    })

    }

    /**
     * 注意 jquery版本！！！
     */
    function submit() {
        $("#myModal").modal('show');
        var formdata = new FormData(document.getElementById("info"));
        formdata.append("initiator","${user.userName}");
        formdata.append("detailPart",detailNo)
        formdata.append("detailContent",mydetailContent);
        formdata.append("detailScore",mydetailScore);

        $.ajax({
            url: 'create_work',
            method: 'POST',
            data: formdata,

            xhr: function(){ //获取ajaxSettings中的xhr对象，为它的upload属性绑定progress事件的处理函数
                myXhr = $.ajaxSettings.xhr();
                if(myXhr.upload){ //检查upload属性是否存在
                    //绑定progress事件的回调函数
                    myXhr.upload.addEventListener('progress',progressHandlingFunction, false);
                }
                return myXhr; //xhr对象返回给jQuery使用
            },



            contentType: false, // 注意这里应设为false
            processData: false,
            cache: false,
            success: function(data) {
                $("#myModal").modal('hide');

                BootstrapDialog.show({
                    title:"请求成功",
                    message:"项目创建成功！",
                    type:BootstrapDialog.TYPE_SUCCESS


                });

            },
            error: function (jqXHR) {

                BootstrapDialog.show({
                    title:"反馈",
                    message:"上传出现错误",
                    type:BootstrapDialog.TYPE_WARNING
                })


                console.log(JSON.stringify(jqXHR));
            },


            fail:function () {

            }

        })

    }


    function progressHandlingFunction(e) {
        if (e.lengthComputable) {
            var percent = e.loaded/e.total*100;
            $('#progress').attr('aria-valuenow',percent); //更新数据到进度条
            $('#progress').css('width',percent+"%");
            $('#progress').html( percent.toFixed(0) + "%");
        }
    }

    /**
     * 表单动态增删部分 耗时2小时
     * 删除时参数传this
     * 删除函数寻找两次寻找parents 寻找至 tr 进行删除
     * @type {number}
     */
    var detailNo=1;
    function insertdetail() {
        $("#detailTable").append(
            "<tr class='detail-"+detailNo+"'>" +
              "<td class='detailNo detail-"+detailNo+"'>"+detailNo+"</td>"+
              "<td> <input type='text' class='detailContent detail-"+detailNo+"'> </td>"+
              "<td> <input type='text' class='detailScore detail-"+detailNo+"' onblur='scoreCount()'> </td>"+
              "<td> <button class='detail-"+detailNo+"' onclick='deletedetail(this)'>删除</button> </td>"+
            "</tr>"
        )
        detailNo=detailNo+1;

    }

    function deletedetail(nowTr) {

     $(nowTr).parent().parent().remove();
      detailNo=detailNo-1;
    }

    function openDetail() {
        $("#detailModal").modal('show');
    }


    /**
     * 元素遍历求和 用each（）~！
     */
    function scoreCount() {
        var total=0;
        $(".detailScore").each(function () {
            if($(this).val()!="")
            {
                total+=parseInt($(this).val());
            }
        })
        $("#totalScore").text(total);

        if (total!="100")
            $("#totalScore").css("color","red");
        else
            $("#totalScore").css("color","green");
    }



        var mydetailcheck=false
        var mydetailContent=""
        var mydetailScore="";
    function detailCheck() {
        var detailContent="";
        var detailScore="";

        var contentCheck=true;
        var scoreCheck=true;
        var totalCheck=true
        $(".detailContent").each(function () {
            if ($(this).val()=="") {
                contentCheck = false;
                BootstrapDialog.alert("请确认您填写了所有的得分点描述");
            }
            detailContent+=$(this).val()+";";
        })
     //   alert(detailContent);

        $(".detailScore").each(function () {
            if ($(this).val()==""){
                scoreCheck=false;
                BootstrapDialog.alert("请确认您填写了所有的分值");
            }
            detailScore+=$(this).val()+";";

        })
      //  alert(detailScore);

        if(parseInt($("#totalScore").text())!="100") {
            totalCheck = false;
            BootstrapDialog.alert("请确认总分值满分为100分");
        }
    //    alert("ContentCheck"+contentCheck);
    //    alert("ScoreCheck"+scoreCheck);
    //    alert("TotalCheck"+totalCheck);



        if (contentCheck&&scoreCheck&&totalCheck) {
            $("#detailStatus").text("(设置完成)");
            $("#detailStatus").css("color", "green");
            mydetailContent=detailContent;
            mydetailScore=detailScore;
            mydetailcheck=true;
            $("#detailModal").modal('hide')
        }else{
             detailContent="";
             detailScore="";
        }

    }

</script>







</html>
