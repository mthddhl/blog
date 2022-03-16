//退出系统
function loginOut() {
    layer.alert('确定退出系统吗？', {
        time: 0 //不自动关闭
        ,btn: ['确定', '取消']
        ,yes: function(index){
            layer.close(index);
            location.href = "user/loginOut";
        }
    });
}
//
// //异步更新用户信息
// function updateUser() {
//     //表单序列化 能够把表单的内容拼接成 key=值&key=值...,返回值是字符串
//     var form = $('#updateUserForm').serialize();
//     $.post("/blog/user/updateUser",form,function (data) {
//         if(data.ok){
//             layer.alert(data.mess, {icon: 6});
//
//             setTimeout(function () {
//                 //重新登录,跳转到登录页面
//                 //setTimeout:隔多长时间执行指定代码
//                 location.href = "/blog/login.jsp";
//             },1000);
//
//         }
//     },'json');
// }
function updateUser() {
    if($("#password").val()!=$("#new_password").val()){
        alert("两次新密码不一致")
    }else{
        var s1=$("#updateUserForm").serialize();
        $.ajax({
            url: "user/update",
            data:s1,
            type: "POST",
            dataType: "json",
            success: function(data) {
                if(!data.ok){
                    layer.msg(data.mess, {offset:'t'});
                }else {
                    layer.msg(data.mess, {offset:'t'});
                    setTimeout(function () {
                        location.href = "user/loginOut"
                    },1000)
                }
            }
        })
    }

}