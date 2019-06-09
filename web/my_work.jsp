<%--
  Created by IntelliJ IDEA.
  User: Wls
  Date: 2018/12/7
  Time: 23:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目清单</title>

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
    .btn{
        margin-right: 5px;
    }

    #main{
       margin-left: 15px;
    }

    h2{

        padding-left: 15px;
    }

    #detailTable{
       /*table-layout: fixed;*/

    }

    #Mytable{
        table-layout: fixed;
    }
    .table-left{
        width: 150px;
    }
    .table-right{
        width: 400px;
    }


</style>


<body>
    <h2>项目清单</h2>
    <div id="main">
        <table id="table"></table>
    </div>
    <!-- 详细信息模态框 ↓-->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">实验项目具体信息</h4>
                </div>
                <div class="modal-body">
                    <!-- 内容区域↓ -->
                        <div id="content">
                            <table id="Mytable" class="table table-hover table-condensed">

                                <tr>
                                    <td class="table-left">实验编号：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
                                    <td class="table-right"><input type="text" id="work_id" class="form-control" name="work_id" disabled></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验名称：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
                                    <td class="table-right"><input type="text" id="work_name" class="form-control" name="work_name" disabled></td>
                                </tr>

                                <tr>
                                    <td class="table-left">所属科目：</td>   <!-- 一定注意！！ 向后台传值一定要加name标签！！！！ 2.5h！ -->
                                    <td class="table-right"><input type="text" id="work_lesson" class="form-control" name="work_lesson" disabled></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验要求：</td>
                                    <td class="table-right"><textarea class="form-control" rows="3" style="resize: none ;" id="work_requirement" name="work_requirement" disabled></textarea></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验大纲：</td>
                                    <td class="table-right"><button id="outline" class="btn btn-primary" bind-url="" onclick="download('1')"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验指导书：</td>
                                    <td class="table-right"><button id="guide" class="btn btn-primary" bind-url="" onclick="download('2')"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验设计方案：</td>
                                    <td class="table-right"><button id="design"  class="btn btn-primary" bind-url="" onclick="download('3')"><span class="glyphicon glyphicon-cloud-download"></span>  下载</button></td>
                                </tr>

                                <tr>
                                    <td class="table-left">评分细则：</td>
                                    <td class="table-right">
                                                    <table id="detailTable" class="table table-bordered">
                                                        <tr>
                                                            <th width="300px">得分点描述</th>
                                                            <th width="80px">分值</th>
                                                        </tr>
                                                    </table>
                                    </td>
                                </tr>


                                <tr >
                                    <td class="table-left">项目发起人：</td>
                                    <td class="table-right"><input type="text" id="work_initiator" class="form-control" disabled></td>
                                </tr>

                                <tr>
                                    <td class="table-left">实验截止日期：</td>
                                    <td class="table-right"><input type="text"  id="work_endtime" class="form-control" disabled></td>
                                </tr>
                            </table>
                        </div>
                    <!-- 内容区域↑ -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 详细信息模态框 ↑-->




    <!-- 提交报告模态框 ↓-->
    <div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="uploadModalLabel">上传你的实验报告</h4>
                </div>
                <div class="modal-body">
                    <!-- 内容区域↓ -->
                    <capition>请核对要上交的实验项目内容后提交实验报告</capition>
                    <div id="uploadcontent">
                        <table id="uploadtable" class="table table-hover table-condensed">
                            <form action="" enctype="multipart/form-data" id="uploadForm">
                                <input type="text" id="workId" name="workId"  hidden>
                                <input type="text" id="userId" name="userId" value="${user.userId}"  hidden>
                                <tr>
                                    <td>所选项目编号</td>
                                    <td><input type="text" id="workId1" name="workId1" class="form-control" disabled></td>
                                </tr>
                                <tr>
                                    <td>所选项目名称</td>
                                    <td><input type="text" id="workName" name="workName" class="form-control" disabled></td>
                                </tr>
                                <tr>
                                    <td>实验报告</td>
                                    <td><input type="file" name="report" value="上传"  ></td>
                                </tr>

                            </form>

                            <tr>
                                <td colspan="2"> <button id="upload" class="btn btn-primary" onclick="submitReport()"><span class="glyphicon glyphicon-send"></span>  提交</button>  </td>
                            </tr>
                        </table>
                    </div>
                    <!-- 内容区域↑ -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 详细信息模态框 ↑-->


    <!-- 进度条 -->

    <!-- Modal -->
    <div class="modal fade" id="processModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myprocessModal">处理中!</h4>
                </div>
                <div class="modal-body">
                    <div id="processModalcontent">正在上传您的文件......</div>
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

    <!-- 进度条 -->

</body>

<script>
    window.operateEvents={
            "click .detail":function (value,row,index) {
               // alert(index.workId);
                getDetail(index.workId);
            },
    
            "click .uploadReport":function (value,row,index) {
                // alert(index.workId);
                showUploadModel(index.workId,index.workName)
            },

        "click .seeStatus":function (value,rows,index) {
            // alert(index.workId);
            checkUpload(index.workId)
        }
            
            
    }





    $("#table").bootstrapTable({

        url: 'work?type=2&group=${user.userClass}',         //请求后台的URL（*）
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
            field:'workLesson',
            title:'所属课程',
            align:'center'
        },
            {
            field:'workName',
            title:'项目名称',
            align:'center'
        },{
            field:'workType',
            title:'项目类别',
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
            '<button id="detail" type="button" class="btn btn-primary detail">查看要求</button>',
            '<button id="uploadReport" type="button" class="btn btn-primary uploadReport">提交报告</button>',
            '<button id="seeStatus" type="button" class="btn btn-primary seeStatus">查看提交状态</button>'
        ].join('');

    }

    /**
     * 移除时要注意写同级元素  15min
     * */
    $("#myModal").on('hide.bs.modal', function () {
         $("tr").remove('.detail')
    });


    function checkUpload(workId) {

     //   alert(rows.workId);
        $.get(
            "report",
            {
                type:"2",
                userId:"${user.userId}",
                workId:workId,
            }, result=function (data) {
                   if(data===true)
                      BootstrapDialog.show({
                          title:"已提交",
                          message:"您的报告已经成功提交，请耐心等待好成绩吧~",
                          type:BootstrapDialog.TYPE_SUCCESS
                      })
                    else
                       BootstrapDialog.show({
                           title:"未提交",
                           message:"您仍未提交实验报告，请在截止日期前提交，错过将无法提交",
                           type:BootstrapDialog.TYPE_DANGER
                       })
                }


        )

    }



    function getDetail(workId) {
        $.ajax({
            url:"work",
            async:true,
            type:"GET",
            data:{
                type:"3",
                workId:workId
            },
            success:showData,
            error:function () {
                BootstrapDialog.show({
                    title:"服务器错误",
                    type:BootstrapDialog.TYPE_DANGER,
                    message:"请求失败，请重试",
                    button:[{
                        id:'ok',
                        label: '好',
                        cssClass: 'btn-primary',
                        action:function (dialogRef) {
                            dialogRef.close();
                        }
                    }]
                })
            },
            dataType:"json"

        })
    }


    var outline="";
    var design="";
    var guide="";
    var workId="";

    function showData(data) {


            $("table").remove(".detail")

            $("#work_id").val(data.workId);
            workId=data.workId;
            $("#work_name").val(data.workName);
            $("#work_lesson").val(data.workLesson);
            $("#work_requirement").val(data.workRequirement);

            $("#outline").attr('bind-url',data.workOutline)
            $("#guide").attr('bind-url',data.workGuide)
            $("#design").attr('bind-url',data.workDesign)


            var MyDetailContent=data.workDetailContent;
            var MyDetailScore=data.workDetailScore;
            var detailContent=(MyDetailContent||"").split(";");
            var detailScore=(MyDetailScore||"").split(";");


            for (var i=0;i<detailContent.length-1;i++)
            {
                $("#detailTable").append(
                    "<tr class='detail'>"+
                        "<td class='detail'>"+detailContent[i]+"</td>"+
                        "<td class='detail'>"+detailScore[i]+" 分</td>"+
                    "</tr>"
                )
            }


            outline=data.workOutline;
            design=data.workGuide;
            guide=data.workDesign;
         //   workId=$("#work_id").val();

            $("#work_initiator").val(data.workInitiator);
            $("#work_endtime").val(data.workEndTime);
            $("#myModal").modal('show');
    }


    function download(type) {
        window.open("download?type="+type+"&work_id="+workId);

        }
/*
            alert($(this).attr("bind-url"));
            window.open($(this).attr("bind-url")+"","_blank");
*/

    function showUploadModel(workId,workName) {
        $("#workId").val(workId);
        $("#workId1").val(workId);
        $("#workName").val(workName);
        $("#uploadModal").modal('show');
    }

    /**
     * Uncaught TypeError: f[b] is not a function 原因是 $("#processModal").modal('open'); 应该将open改为show  2h
     */

    function submitReport() {
        $("#processModal").modal('show');
        var form=new FormData(document.getElementById('uploadForm'));
        form.append('author','${user.userName}');
        $.ajax({
            url: 'up',
            method: 'POST',
            data: form,
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
                $("#processModal").modal('hide');

                BootstrapDialog.show({
                    title:"提交成功",
                    message:"报告提交成功！",
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



        function progressHandlingFunction(e) {
            if (e.lengthComputable) {
                var percent = e.loaded/e.total*100;
                $('#progress').attr('aria-valuenow',percent); //更新数据到进度条
                $('#progress').css('width',percent+"%");
                $('#progress').html( percent.toFixed(0) + "%");
            }
        }





    }

</script>

</html>
