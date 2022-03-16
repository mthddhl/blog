<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>写文章 - 虎牙博客管理后台</title>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/back/style1.css">
    <link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon"/>
    <%--上传文件按钮美化--%>
    <style>
        .a-upload {
            padding: 5px 10px;
            height: 40px;
            line-height: 40px;
            position: relative;
            cursor: pointer;
            color: #888;
            background: #fafafa;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            display: inline;
            zoom: 1
        }

        .a-upload input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }

        .a-upload:hover {
            color: #444;
            background: #eee;
            border-color: #ccc;
            text-decoration: none
        }
    </style>
</head>

<body class="user-select">
<section class="container-fluid">
    <header>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1" aria-expanded="false"><span
                            class="sr-only">切换导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span>
                        <span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="/">AndyHu</a></div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="">消息 <span class="badge">1</span></a></li>
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" role="button"
                                                aria-haspopup="true" aria-expanded="false">admin <span
                                class="caret"></span></a>
                            <ul class="dropdown-menu dropdown-menu-left">
                                <li><a title="查看或修改个人信息" data-toggle="modal" data-target="#seeUserInfo">个人信息</a></li>
                                <li><a title="查看您的登录记录" data-toggle="modal" data-target="#seeUserLoginlog">登录记录</a></li>
                            </ul>
                        </li>
                        <li><a href="login.html" onClick="if(!confirm('是否确认退出？'))return false;">退出登录</a></li>
                        <li><a data-toggle="modal" data-target="#WeChat">帮助</a></li>
                    </ul>
                    <form action="" method="post" class="navbar-form navbar-right" role="search">
                        <div class="input-group">
                            <input type="text" class="form-control" autocomplete="off" placeholder="键入关键字搜索"
                                   maxlength="15">
                            <span class="input-group-btn">
              <button class="btn btn-default" type="submit">搜索</button>
              </span></div>
                    </form>
                </div>
            </div>
        </nav>
    </header>
    <div class="row">
        <aside class="col-sm-3 col-md-2 col-lg-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="index.html">报告</a></li>
            </ul>
            <ul class="nav nav-sidebar">
                <li class="active"><a href="toView/workbench/article/index">文章</a></li>
                <li><a href="notice.html">公告</a></li>
                <li><a href="comment.html">评论</a></li>
                <li><a data-toggle="tooltip" data-placement="top" title="网站暂无留言功能">留言</a></li>
            </ul>
            <ul class="nav nav-sidebar">
                <li><a href="category.html">栏目</a></li>
                <li><a class="dropdown-toggle" id="otherMenu" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">其他</a>
                    <ul class="dropdown-menu" aria-labelledby="otherMenu">
                        <li><a href="flink.html">友情链接</a></li>
                        <li><a href="loginlog.html">访问记录</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav nav-sidebar">
                <li><a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">用户</a>
                    <ul class="dropdown-menu" aria-labelledby="userMenu">
                        <li><a href="#">管理用户组</a></li>
                        <li><a href="manage-user.html">管理用户</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="loginlog.html">管理登录日志</a></li>
                    </ul>
                </li>
                <li><a class="dropdown-toggle" id="settingMenu" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">设置</a>
                    <ul class="dropdown-menu" aria-labelledby="settingMenu">
                        <li><a href="setting.html">基本设置</a></li>
                        <li><a href="readset.html">用户设置</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">安全配置</a></li>
                        <li role="separator" class="divider"></li>
                        <li class="disabled"><a>扩展菜单</a></li>
                    </ul>
                </li>
            </ul>
        </aside>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <div class="row">
                <form method="post" enctype="multipart/form-data"
                      class="add-article-form">
                    <input type="hidden" id="logo"/>
                    <div class="col-md-12">
                        <h1 class="page-header">撰写新文章</h1>
                        <div class="form-group">
                            <select name="cid" id="categories" class="form-control">
                            </select>
                            <label id="tags" style="margin-top: 10px">
<%--                                <input type="checkbox" value="户外运动"/>户外运动&nbsp;&nbsp;&nbsp;--%>
<%--                                <input type="checkbox" value="赛艇"/>赛艇&nbsp;&nbsp;&nbsp;--%>
<%--                                <input type="checkbox" value="羽毛球"/>羽毛球&nbsp;&nbsp;&nbsp;--%>
<%--                                <input type="checkbox" value="垒球"/>垒球&nbsp;&nbsp;&nbsp;--%>
                            </label>
                        </div>
                        <div class="form-group">
                            <label class="sr-only">标题</label>
                            <input type="text" id="title" class="form-control" placeholder="在此处输入标题" required autofocus
                                   autocomplete="off">
                        </div>
                        <div class="form-group">
                            <textarea id="digest" class="form-control" rows="3" placeholder="在此处输入文章摘要"></textarea>
                        </div>
                        <div class="form-group">
                            <a href="javascript:" class="a-upload">
                                <input type="file" name="img" id="img"/>上传文章LOGO
                                <input type="hidden" id="logourl" />
                            </a>
                        </div>
                        <div id="test-editor">
                <textarea name="content" id="content" style="display:none;">

                </textarea>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>发布</span></h2>
                            <div class="add-article-box-content">
                                <p><label>状态：</label><span id="state" class="article-status-display">未发布</span></p>
                                <p><label>公开度：</label><input type="radio" name="isOpen" value="1" checked/>公开 <input
                                        type="radio" name="isOpen" value="0"/>私密</p>
                                <p><label>发布于：</label><span class="article-time-display"><input style="border: none;"
                                                                                                type="datetime"
                                                                                                name="time"
                                                                                                id="punishTime"/></span>
                                </p>
                            </div>
                            <div class="add-article-box-footer">
                                <button class="btn btn-primary" type="button" onclick="punish()">发布</button>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</section>
<!--个人信息模态框-->
<div class="modal fade" id="seeUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <form action="" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">个人信息</h4>
                </div>
                <div class="modal-body">
                    <table class="table" style="margin-bottom:0px;">
                        <thead>
                        <tr></tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td wdith="20%">姓名:</td>
                            <td width="80%"><input type="text" value="王雨" class="form-control" name="truename"
                                                   maxlength="10" autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td wdith="20%">用户名:</td>
                            <td width="80%"><input type="text" value="admin" class="form-control" name="username"
                                                   maxlength="10" autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td wdith="20%">电话:</td>
                            <td width="80%"><input type="text" value="18538078281" class="form-control" name="usertel"
                                                   maxlength="13" autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td wdith="20%">旧密码:</td>
                            <td width="80%"><input type="password" class="form-control" name="old_password"
                                                   maxlength="18" autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td wdith="20%">新密码:</td>
                            <td width="80%"><input type="password" class="form-control" name="password" maxlength="18"
                                                   autocomplete="off"/></td>
                        </tr>
                        <tr>
                            <td wdith="20%">确认密码:</td>
                            <td width="80%"><input type="password" class="form-control" name="new_password"
                                                   maxlength="18" autocomplete="off"/></td>
                        </tr>
                        </tbody>
                        <tfoot>
                        <tr></tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!--个人登录记录模态框-->
<div class="modal fade" id="seeUserLoginlog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">登录记录</h4>
            </div>
            <div class="modal-body">
                <table class="table" style="margin-bottom:0px;">
                    <thead>
                    <tr>
                        <th>登录IP</th>
                        <th>登录时间</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>::1:55570</td>
                        <td>2016-01-08 15:50:28</td>
                        <td>成功</td>
                    </tr>
                    <tr>
                        <td>::1:64377</td>
                        <td>2016-01-08 10:27:44</td>
                        <td>成功</td>
                    </tr>
                    <tr>
                        <td>::1:64027</td>
                        <td>2016-01-08 10:19:25</td>
                        <td>成功</td>
                    </tr>
                    <tr>
                        <td>::1:57081</td>
                        <td>2016-01-06 10:35:12</td>
                        <td>成功</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">朕已阅</button>
            </div>
        </div>
    </div>
</div>
<!--提示模态框-->
<div class="modal fade user-select" id="areDeveloping" tabindex="-1" role="dialog"
     aria-labelledby="areDevelopingModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="areDevelopingModalLabel" style="cursor:default;">该功能正在日以继夜的开发中…</h4>
            </div>
            <div class="modal-body"><img src="images/baoman/baoman_01.gif" alt="深思熟虑"/>
                <p style="padding:15px 15px 15px 100px; position:absolute; top:15px; cursor:default;">
                    很抱歉，程序猿正在日以继夜的开发此功能，本程序将会在以后的版本中持续完善！</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">朕已阅</button>
            </div>
        </div>
    </div>
</div>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<%--Editormd--%>
<script src="js/jquery/jquery-2.1.1.min.js"></script>
<link rel="stylesheet" href="editormd/css/editormd.css"/>

<script src="editormd/editormd.js"></script>

<script src="js/admin-scripts.js"></script>
<script src="js/layer-3.5.1/layer.js" type="text/javascript"></script>


<%--异步上传文件js--%>
<script src="js/ajaxfileupload.js"></script>

<script>
    var editor;
    $(function () {
        editor = editormd("test-editor", {
            width: "100%",
            height: "500px",
            path: "editormd/lib/",//第三方依赖库
            saveHTMLToTextarea: true,//获取用户编辑的内容，将其放入到textarea中
            emoji: true,//emoji表情，默认关闭
            syncScrolling: "single",
            /*上传文件配置*/
            imageUpload: true,//开启上传文件功能
            imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],//上传图片格式
            imageUploadURL: "editorUpload",//后端上传图片服务地址
        });
    });

    $('#img').change(function () {
        $.ajaxFileUpload({
            url: 'logoUpload', //用于文件上传的服务器端请求地址
            fileElementId: 'img', //文件上传域的ID
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data) {
                if(data.success == 1) {
                    alert(data.message);
                    $("#logourl").val(data.url)
                }
            },
        })
        return false;
    });
    $.ajax({
        url:"article/selectCategory",
        dataType:"json",
        type:"get",
        success: function (data) {
            var html='';
            $.each(data,function (i,n) {
                html+='<option value ="'+n.cid+'">'+n.cname+'</option>'
            })
            $("#categories").html(html)
            tageChang();
        }
    })

    $("#categories").change(function () {
        tageChang();
    })
    function tageChang() {
        $.ajax({
            url:"artrcle/selectTag",
            data:{
                "cid":$("#categories").val()
            },
            dataType:"json",
            type:"get",
            success: function (data) {
                var html='';
                $.each(data,function (i,n) {
                    html+='    <input type="checkbox" value="'+n.tname+'"/>'+n.tname+'&nbsp;&nbsp;&nbsp;'
                })
                $("#tags").html(html)
            }
        })
    }
    function punish() {
        var tags=[];
        $("input[type=checkbox]:checked").each(function () {
            tags.push($(this).val());
        })
        var tagName=tags.join();
        $.ajax({
            url:'article/addArticle',
            data:{
                "cid":$("#categories").val(),
                "tagNames":tagName,
                "title":$("#title").val(),
                "logo":$("#logourl").val(),
                "digest":$("#digest").val(),
                "content":$("#content").val(),
                "isOpen":$("input[type=radio]:checked").val()
            },
            dataType:"json",
            type:"post",
            success:function (data) {
                if(!data.ok){
                    layer.alert(data.mess,{icon:6});
                }else {
                    $("#state").text("已发布")
                    $("#punishTime").val(data.object.create_time);
                    window.location='toView/workbench/article/index';
                }
            }
        })
    }
</script>


</body>
</html>
