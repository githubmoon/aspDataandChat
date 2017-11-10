
<!DOCTYPE html>
<html>
<head lang="en">
    <%
    if session("isLogin")= false then
    response.Redirect("../../login.asp")
    End If
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>demo</title>
    <link rel="stylesheet" href="../css/bootstrap.css"/>
    <style>
        *{
            font-size: 96%;
            font-family: 微软雅黑;
        }
    </style>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>
</head>
<body>
<div class="container">

           <div class="row"><div class="clearfix" style="margin-bottom: 10px;"></div><!-- 清除浮动 --></div>

           <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-3"><span>To <label id="tsts"></label></span></div>

                <div class="col-lg-9 col-md-9 col-sm-9 text-right">
                        <label>欢迎 <b style="color:red;"><%=session("users")%></b> 登陆 chatroom</label> <button id="quits"  class="btn btn-warning btn-sm" >退出</button>
                </div>
        	</div>
    
    <div class="row ">
        <div class="chatlist" style="border-radius:13px;overflow-y: scroll;width: 29%;height:360px;background: #888;float:left;margin-top:39px;">
            
        </div>

        <div class="chatcontent" style="border-radius:13px;overflow-y: scroll;width: 69%;height:360px;border:2px solid #666;margin-left:1px;float:left;margin-top:39px">
            
        </div>
    </div>
    
    <div class="row">
        <textarea id="texts" style="outline:none;border-radius:13px;margin:10px 16px 6px 26px;width:88%" name="" id=""  rows="3"></textarea>  <button type="button" id="add" class="center-block btn btn-success">Send</button>
    </div>
    <input id="uersid" type="hidden" value=<%=session("users")%>>

</div>
<script type="text/javascript">
     var uersid,shoowlist="",tst,chattab="",chatwo,alltxt,chatagree,rejname;


		
		//聊天列表显示判断
		 function render(){
		 
		  $.ajax({
            type:'post',
		
            url:'../action/chatDB.asp',
            success:function(data){
			  shoowlist="";
			
                data = data.split('spt').slice(0,length-1);

                for(var i=0;i<data.length;i++){

                      var cbn = data[i].split(',').slice(0,length-1);
					  if(cbn[1] == $("#uersid").val()){
					   shoowlist+='<div  class="chatlsr" style="font-size: 20px;text-align: center;color:red;cursor:pointer;background:#9cf;margin-top:2px;">'+cbn[1]+'</div>';
					  }else{
					   shoowlist+='<div  class="chatls" style="font-size: 20px;text-align: center;color: white;cursor:pointer;background:#9cf;margin-top:2px;">'+cbn[1]+'</div>';
					  };
					  
					  if($("#tsts").text() == cbn[0]){
					    // console.log("正在与"+cbn[0]+"聊天");
					         if(($("#tsts").text() !="")&&(cbn[0] !="")){
							 	  $.ajax({
            type:'post',
			data:{qq:"delete",userd:$("#uersid").val()},
            url:'../action/chatDB.asp',
            success:function(data){
				 console.log("正在一起聊天，不用请求");
            },
            error:function(err){
                console.log(err);
            }
        });
							 }
					  }else{
					  
					  	  if(cbn[2] == $("#uersid").val()){
					    console.log(cbn[0]);
						chatagree = confirm(cbn[0]+"请求聊天");
						 $.ajax({
            type:'post',
			data:{qq:"delete",userd:$("#uersid").val()},
            url:'../action/chatDB.asp',
            success:function(data){
		
				  if(chatagree){
			  clearInterval(chatwo);
			  if(cbn[0] > cbn[2]){
			  chattab=cbn[0]+cbn[2];
			  }else{
			  chattab=cbn[2]+cbn[0];
			  }
				  
				  console.log(chattab);
				    renderchat();
				    console.log("同意聊天");
					$("#tsts").text(cbn[0]);
				  }else{
				    $.ajax({
            type:'post',
            url:'../action/chatDB.asp',
            data:{qq:'addinsert',qs:cbn[0],qt:"rejects"},
            success:function(data){
			 console.log(data);
              console.log("请求添加");
            },
            error:function(err){
                console.log(err);
            }
        });
				   console.log("拒绝聊天");
				  }
            },
            error:function(err){
                console.log(err);
            }
        });
		}
					  }
					  
					  if(cbn[0] == $("#uersid").val()){
					     if(cbn[2] == "rejects"){
						  $.ajax({
            type:'post',
			data:{qq:"delete",userd:$("#uersid").val()},
            url:'../action/chatDB.asp',
            success:function(data){
			
			 clearInterval(chatwo);
			
				  $("#tsts").text(rejname+"拒绝了聊天请求！");
				   $("#tsts").css({color:"yellow"});
				 setTimeout(function(){
				  
				   $(".chatcontent").html("");
				   $("#tsts").text("");
				    $("#tsts").css({color:"black"});
				 },2000)
            },
            error:function(err){
                console.log(err);
            }
        });
						  console.log(rejname+"拒绝了聊天请求！");
						 }
					  }
				
					  
                       
                };
	
				$(".chatlist").html(shoowlist);
               
            },
            error:function(err){
                console.log("查询错误");
            }
             });
		 
		 };
		 
		 //刷新聊天内容
		function renderchat(){
		chatwo = setInterval(function () {
		  $.ajax({
            type:'post',
            url:'../action/chattwo.asp',
			data:{tabs:chattab},
            success:function(data){
			  shoowlist="";
			
                data = data.split('spt').slice(0,length-1);

                for(var i=0;i<data.length;i++){

                      var cbn = data[i].split(',').slice(0,length-1);
					  if($("#uersid").val() == $("#username").text()){
					   shoowlist+='<div  class="chatlsr" style="padding-left:10px;font-size: 20px;text-align: left; color:#888;cursor:pointer;background:#9cf;margin-top:2px;">'+cbn[2]+'</div>';
					  }else{
					   shoowlist+='<div  class="chatls" style="padding-left:10px;text-align:left;font-size: 20px; color:#888;cursor:pointer;background:#9cf;margin-top:2px;">'+cbn[2]+'</div>';
					  }
                       
                };
	
				$(".chatcontent").html(shoowlist);
            },
            error:function(err){
                console.log("查询错误");
            }
             });
		 },1000);
		 };
		 
		 
		 //创建聊天列表
		tst= setInterval(function () {
		var usids =true;
            $.ajax({
            type:'post',
            url:'../action/chatDB.asp',
            success:function(data){
             	data = data.split('spt').slice(0,length-1);
                for(var i=0;i<data.length;i++){
				     var cbn = data[i].split(',').slice(0,length-1);
                          if($("#uersid").val() == cbn[1]){
						   usids =false;
						   render();
						  }
                };
			if(usids){
			$.ajax({
            type:'post',
			data:{qq:'inerts',userd:$("#uersid").val()},
            url:'../action/chatDB.asp',
            success:function(data){
			              render();                     										
            },
            error:function(err){
                console.log(err);
            }
        });
		}
			},
            error:function(err){
                console.log(err);
            }
        });
		
		
         },800);

		//退出聊天页面
		 $("#quits").click(function(){	
		 clearInterval(tst);
		 
		
		 $.ajax({
            type:'post',
			data:{qq:"delete",userd:$("#uersid").val()},
            url:'../action/chatDB.asp',
            success:function(data){
				  window.location.href ="../../login.asp";
            },
            error:function(err){
                console.log(err);
            }
        });
		 
		 });

		 //选择聊天对象
		 $(".chatlist").delegate(".chatls","click",function(){
              clearInterval(chatwo);
			  alltxt = $(this).text();
			  if($(this).text() > $("#uersid").val()){
			  chattab=$(this).text()+$("#uersid").val();
			  }else{
			  chattab=$("#uersid").val() + $(this).text();
			  }
			  
			  $.ajax({
                 type:'post',
			     data:{tabs:chattab},
                 url:'../action/chattwo.asp',
                 success:function(data){
				   renderchat();
				   $("#tsts").text(alltxt);
				   qiusei();
            },
            error:function(err){
              //  console.log("为创建表");
				
				 $.ajax({
                 type:'post',
			     data:{tabs:chattab,qq:"insertabs"},
                 url:'../action/chattwo.asp',
                 success:function(data){
				    renderchat();
				   // console.log("创建表成功");
					$("#tsts").text(alltxt);
					qiusei();
            },
            error:function(err){
                console.log("创建表失败");
            }
             });
				
            }
             });
			 
         });

		 
		 //发送信息
		 $("#add").click(function(){
		  if($("#texts").val() == '')return;
		  var nowtime =new Date();
		  var mnhm=nowtime.getMonth()+1;
		 var tyty ='<span style="font-size:12px;color:#fff;">'+ nowtime.getFullYear()+"/"+mnhm+"/"+nowtime.getDate()+" "+nowtime.getHours()+":"+nowtime.getMinutes()+":"+nowtime.getSeconds()+"</span>";
		  console.log(tyty);
        $.ajax({
            type:'post',
            url:'../action/chattwo.asp',
            data:{qq:'add',texts:'<span  id="username" style="font-size:16px;color:blue;">'+$("#uersid").val()+"</span> : "+ $("#texts").val()+" "+tyty,tabs:chattab},
            success:function(data){
                $("#texts").val("");
            },
            error:function(err){
                console.log(err);
            }
        });
		 });

		  //请求添加聊天
		 function qiusei(){
		 rejname = alltxt
		    $.ajax({
            type:'post',
            url:'../action/chatDB.asp',
            data:{qq:'addinsert',qs:$("#uersid").val(),qt:alltxt},
            success:function(data){
			 console.log(data);
             // console.log("请求添加");
            },
            error:function(err){
                console.log(err);
            }
        });
		 
		 };
</script>
</body>
</html>

