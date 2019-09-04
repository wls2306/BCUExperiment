<%--
  Created by IntelliJ IDEA.
  User: 王镭树
  Date: 2018/12/3
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>upload demo</title>
</head>
<script src="script/jquery-3.3.1.min.js"></script>


<body>
<form action="upload" method="post" enctype="multipart/form-data">
    用户名：<input type="text" name="name"><br>
    文件1：<input type="file" name="f1"><br>
    文件2：<input type="file" name="f2"><br>
    <input type="submit" value="提交">
</form>
</body>

<script>

</script>


</html>
