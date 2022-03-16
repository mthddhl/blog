//粒子背景特效
$('body').particleground({
    dotColor: '#E8DFE8',
    lineColor: '#1b3273'
});

code();

function code() {
    $.ajax({
        url: "code",
        type: "get",
        dataType: "text",
        success: function (data) {
            showCheck(data);
        }
    })

}

// function code() {
//     $.get("/blog/code",function (data) {
//         alert(data)
//         showCheck(data);
//     },'json');
// }
function showCheck(code) {
    var c = document.getElementById("myCanvas");
    var ctx = c.getContext("2d");
    ctx.clearRect(0, 0, 1000, 1000);
    ctx.font = "80px 'Hiragino Sans GB'";
    ctx.fillStyle = "#E8DFE8";
    ctx.fillText(code, 0, 100);
}

$("#loginBtn").click(function () {
    if ($.trim($("#username").val()).length == 0) {
        errorAlert("用户名不能为空");
        return;
    }
    if ($.trim($("#password").val()).length == 0) {
        errorAlert("密码不能为空");
        return;

    }
    if ($.trim($("#code").val()).length == 0) {
        errorAlert("验证码不能为空");
        return;
    }
    login();
    $('.login').addClass('test'); //倾斜特效
    setTimeout(function () {
        $('.login').addClass('testtwo'); //平移特效
    }, 300);
    setTimeout(function () {
        $('.authent').show().animate({right: -320}, {
            easing: 'easeOutQuint',
            duration: 600,
            queue: false
        });
        $('.authent').animate({opacity: 1}, {
            duration: 200,
            queue: false
        }).addClass('visible');
    }, 500);

})

function errorAlert(message) {
    layer.msg(message, {offset: 't'});
}

function login() {
    $.post("login", {
        "username": $.trim($("#username").val()), "password": $.trim($("#password").val()),
        "code": $.trim($("#code").val())
    }, function (data) {
        setTimeout(function () {
            $('.authent').show().animate({right: 90}, {
                easing: 'easeOutQuint',
                duration: 600,
                queue: false
            });
            $('.authent').animate({opacity: 0}, {
                duration: 200,
                queue: false
            }).addClass('visible');
            $('.login').removeClass('testtwo'); //平移特效
            $('.authent').hide();
        }, 100);

        if (!data.ok) {
            //清空原先表单
            $('#username').val("");
            $('#password').val("");
            $('#code').val("");
            setTimeout(function () {
                $('.login').removeClass('test');
                errorAlert(data.mess);
                //登录失败，再次发送验证码
                code();
            }, 100);
        } else {
            setTimeout(function () {
                $('.login').fadeOut(100);
                //登录校验成功，跳转到后台首页
                location.href = "workbench/index";
            }, 100);
        }
    }, "json")
}
