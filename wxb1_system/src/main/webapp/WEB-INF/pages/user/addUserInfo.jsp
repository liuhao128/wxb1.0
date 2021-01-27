<%--
  Created by IntelliJ IDEA.
  User: 66952
  Date: 2021/1/22
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加用户信息</title>
    <base href="${pageContext.request.contextPath}/">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/layui/css/layui.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>添加用户信息</legend>
</fieldset>

<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">用户编号</label>
        <div class="layui-input-block">
            <input type="text" name="id" lay-verify="required" lay-reqtext="用户编号是必填项，不能为空鸭" autocomplete="off" placeholder="请输入角色编码" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="name"  autocomplete="off" placeholder="请输入用户名" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">登录账户</label>
        <div class="layui-input-block">
            <input type="text" name="account"  autocomplete="off" placeholder="请输入登录账户" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">登录密码</label>
        <div class="layui-input-block">
            <input type="text" name="password"  autocomplete="off" placeholder="请输入登录密码" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input type="text" name="remark"  autocomplete="off" placeholder="请输入备注" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">启用状态</label>
        <div class="layui-input-block">
            <input type="radio" name="enabled" value="1" title="启用" checked="">
            <input type="radio" name="enabled" value="0" title="禁用">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">最后登录时间</label>
        <div class="layui-input-inline">
            <input type="text" name="loginTime" class="layui-input" id="loginTime" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">提交</button>
            <button type="button" class="layui-btn layui-btn-primary" lay-active="btnCancel">取消</button>
        </div>
    </div>


</form>

<script src="/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form','util','jquery','laydate' ], function(){
        var form = layui.form
            ,layer = layui.layer
            ,$ = layui.jquery
            ,laydate = layui.laydate
            ,util = layui.util;

        //日期时间选择器
        laydate.render({
            elem: '#loginTime'
            ,type: 'datetime',
            trigger: 'click'
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            // layer.alert(JSON.stringify(data.field))
            console.log(JSON.stringify(data.field))
            $.ajax({
                type: "post",
                url: "/addUserInfo",
                contentType: "application/json",
                data: JSON.stringify(data.field),
                success: function (res) {
                    console.log(res)
                    if (res.code == 0) {
                        // 关闭弹出层
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                        // parent.layer.closeAll();
                        // parent.layer.alert(res.msg);
                        // parent.window.location.reload();
                    }else {
                        parent.layer.closeAll();
                        parent.layer.alert("添加失败");
                    }
                }
            });
            return false;
        });

        //处理属性 为 lay-active 的所有元素事件
        util.event('lay-active', {
            btnCancel: function(){
                parent.layer.closeAll();
            }
        });

    });
</script>
</body>
</html>
