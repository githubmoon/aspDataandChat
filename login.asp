<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Login</title>
    <link rel="stylesheet" href="./DB/css/bootstrap.css"/>
<%
    tage = request.QueryString("tag")
    if tage = "quit" then
	    session("isLogin")= false
		session("users")= ""
        response.write("<script>alert('您已成功退出')</script>")
    end if  
%>
    <script src="./DB/js/jquery.js"></script>
    <script src="./DB/js/bootstrap.js"></script>
</head>
<body>
<div class="container">
    <form action="./DB/action/getcustomer.asp" method="post">
        <div class="mycenter">
            <div class="mysign">
                <div class="text-center text-info">
                    <h2>请登录</h2>
                </div>
                <div class="">
                    <input id="uname" type="text" class="form-control" name="username" placeholder="请输入账户名" required autofocus/>
                </div>
				    <div class="col-lg-2"></div>
                <div class="col-lg-12"></div>
                <div class="col-lg-2"></div>
                <div class="">
                    <input id="upassd" type="password" class="form-control" name="password" placeholder="请输入密码" required autofocus/>
                </div>
                <div class="">
                    <a style="margin:3px 10px 3px 0px;" class="pull-right text-success" href="DB/htm/register.html">注册?</a>
                </div>
                <!--<div class="col-lg-10 mycheckbox checkbox">-->
                <!--&lt;!&ndash;<input type="checkbox" class="col-lg-1">记住密码</input>&ndash;&gt;-->
                <!--</div>-->
                <div class="">
                    <button id="btn" type="button" class="btn btn-success col-lg-12 btn-block">登录</button>
                    <button type="reset"  class="btn btn-waring col-lg-12 btn-block">取消</button>
                </div>
				<div class="col-lg-2"></div>
                <div class="col-lg-12"></div>
                <div class="col-lg-2"></div>
                <div class="text-warning " id="show"></div>
            </div>
        </div>
        <br/>
    </form>

</div>


<script>
    $("#btn").click(function(){
        var named =$('#uname').val();
        var passd =$('#upassd').val();
        if(named == '' || passd == ''){
            $("#show").html("请输入用户名和密码！！！");
            setTimeout(function(){
                $("#show").html("");
            },1000)
            return;
        }
        $.ajax({
            type:'post',
            url:'DB/action/login.asp',
            data:{nameds:named,passds:passd},
            success:function(data){console.log(data);
                var tipsname ="没有此用户，请注册！！！",tipspassd="密码错误！！！",users=0;
                data = data.split('spt').slice(0,length-1);

                for(var i=0;i<data.length;i++){

                    var cbn = data[i].split(',').slice(0,length-1);

                    if(named == cbn[0]){
                        if(passd == cbn[1]){
                            window.location.href = "DB/htm/ajaxJQ.asp"					
                            return;
                        }else{
                            users=1;
                        }
                    }


                }

                if(users){
                    $("#show").html(tipspassd);
                    setTimeout(function(){
                        $("#show").html("");
                    },1000)
                }else{
                    $("#show").html(tipsname);
                    setTimeout(function(){
                        $("#show").html("");
                    },1000)
                }

            },
            error:function(err){
                console.log(err);
            }
        });
    });
</script>
</body>
</html>