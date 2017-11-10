<%
if session("isLogin")= false then 
 response.Redirect("../../login.asp")
End If
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
    <title>demo</title>
    <link rel="stylesheet" href="../css/bootstrap.css"/>
    <style>
        *{
            font-size: 96%;
            font-family: 微软雅黑;
        }

        @media (max-width: 768px) {
          *{
                     font-size: 12px;
                     font-family: 微软雅黑;
                 }
        }
        td{
        vertical-align: middle;
        height:100%;
        }
    </style>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>
</head>
<body>
<div class="container">
       <div class="row"><div class="clearfix" style="margin-bottom: 10px;"></div><!-- 清除浮动 --></div>

       <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-3"><p>There are <%response.write(Application("visitors"))%> online now!</p> </div>

            <div class="col-lg-9 col-md-9 col-sm-9 text-right">
               <label>欢迎 <b class="text-success"><%=session("users")%></b> 登陆 </label>  <a class="btn btn-warning btn-sm" href="chatroom.asp">ChatRoom</a> <a class="btn btn-warning btn-sm" href="../../login.asp?tag=quit">退出</a>
            </div>
    	</div>

    <div class="row">
    <table class="table table-condensed table-responsive table-bordered table-responsive text-center table-hover table-striped">
     <span class=" text-center text-success "><h4>Server</h4></span>
        <thead >
        <tr >
            <th class="text-center">id</th>
            <th class="text-center">task</th>
            <th class="text-center">times</th>
            <th class="text-center">notes</th>
        </tr>
        </thead>
        <tbody id="show">
        </tbody>
    </table>
    </div>

   <div class="row text-center">
     <div class="col-sm-9">
     <span style="margin-left: -7%;">
     <a href="javascript:void(0);">上一页</a> &nbsp; &nbsp;<label for="" style="font-size: 12px">当前第 <b>5</b> 页</label>&nbsp; &nbsp; <a href="javascript:void(0);">下一页</a>
     </span>
     <span style="margin-left: 16%;">
     <label  for="">总共 <b id="allage">13</b> 页</label>
     </span>
    </div>

    <div class="col-sm-3">

      <button id="ints" style="outline: none;" class="btn btn-primary btn-sm">跳转</button> <input id="ipus" type="text" style="width: 26px;border-radius: 6px;outline: none;"> <label for="">页</label>
     </div>
    </div>


   <div class="row ">
        <div class="text-center">
            <div class="input-group" style="width:100%" >
            <input style="width:16%"  id="di" class="input-sm" placeholder="id"/>
            <input style="width:16%"  id="task" class="input-sm" placeholder="task"/>
            <input style="width:16%"  id="time" type="date" class="input-sm" placeholder="time"/>
            <input style="width:16%"  id="notes" class="input-sm" placeholder="notes"/>
			<input style="width:16%"  id="upname" class="input-sm" placeholder="upname"/>
			<input style="width:16%"  id="upvalue" class="input-sm" placeholder="upvalue"/>
            </div>
            </div>
    </div>

    <div class="row">
    <div class="clearfix" style="margin-bottom: 10px;"></div><!-- 清除浮动 -->
    </div>


    <div class="row">
	<div class="text-center">
        <div class="btn-group" style="width:100%" >
      
              <button style="width:20%" type="button" id="add" class="btn btn-success">add</button>
     
              <button  style="width:20%;" type="button" id="selone" class="btn btn-primary">selone</button>
       
              <button  style="width:20%;" type="button" id="delete" class="btn btn-danger">delete</button>
   
              <button  style="width:20%;" type="button" id="selall" class="btn btn-warning">selall</button>
       
              <button  style="width:20%;" type="button" id="update" class="btn btn-success">update</button>
     
       </div>
  </div>

   </div>
	
 </div>	
<script>
    var  ida,timea,taska,notea,allData=[],nowPage = 0;

    //添加数据
    $('#add').click(function(){
        ida =$('#di').val();
        timea =$('#time').val();
        taska =$('#task').val();
        notea =$('#notes').val();
        if(ida == '' || timea == '' || taska == '' || notea == '')return;
        $.ajax({
            type:'post',
            url:'../action/getcustomer.asp',
            data:{qq:'add',id:ida,task:taska,times:timea,notes:notea},
            success:function(data){
                console.log(data);
            },
            error:function(err){
                console.log(err);
            }
        });
    });

    //查询一条数据
    $('#selone').click(function(){
        ida =$('#di').val();
        if(ida == '')return;
       $.ajax({
            type:'post',
            url:'../action/getcustomer.asp',
			data:{qq:'selone',id:ida},
            success:function(data){//console.log(data);
            allData = [];

                data = data.split('spt').slice(0,length-1);

                for(var i=0;i<data.length;i++){


                    var cbn = data[i].split(',').slice(0,length-1);

                     allData.push(cbn);

//                    for(var m=0;m<cbn.length;m++){
//                        ss+='<td>'+cbn[m]+'</td>';
//                    }
//                    console.log(ss);
//
//                    htmlStr+='<tr>'+ss+'</tr>';
                }
               // $("#show").html(htmlStr);
               fenye(allData);
            },
            error:function(err){
                console.log(err);
            }
        });
    });

    //更新数据
   $('#update').click(function(){
        ida =$('#di').val();
		upname =$('#upname').val();
        upvalue =$('#upvalue').val();
		 if(upname == 'id'){
		 alert(" UPname修改值不能修改id");
		 }
		 
         if(ida == '' || upname == '' || upvalue == ''||upname == 'id')return;
		 if(upname != 'task' && upname != 'times' && upname != 'notes'){
		 alert(" UPname修改值为times,notes,task三个值");
		 return;
		 }
        $.ajax({
            type:'post',
            url:'../action/getcustomer.asp',
            data:{qq:'update',id:ida,upnames:upname,upvalues:upvalue},
            success:function(data){
                console.log(data);
            },
            error:function(err){
                console.log(err);
            }
        });
    });

   //删除一条数据
    $('#delete').click(function(){
        ida =$('#di').val();
        if(ida == '')return;
        $.ajax({
            type:'post',
            url:'../action/getcustomer.asp',
            data:{qq:'delete',id:ida},
            success:function(data){
                console.log(data);
            },
            error:function(err){
                console.log(err);
            }
        });
    });

    //查询全部数据
    $('#selall').click(function(){
       render()
    });
    function render(){
        $.ajax({
            type:'post',
            url:'../action/getcustomer.asp',
			data:{qq:'cc'},
            success:function(data){
                allData =[];
                data = data.split('spt').slice(0,length-1);

                for(var i=0;i<data.length;i++){


                    var cbn = data[i].split(',').slice(0,length-1);

                    allData.push(cbn);

//                    for(var m=0;m<cbn.length;m++){
//					if(cbn[m].length >10){
//					 ss+='<td>'+cbn[m].slice(0,10)+'....</td>';
//					}else{
//					 ss+='<td>'+cbn[m].slice(0,10)+'</td>';
//					}
//
//                    }
//                    console.log(ss);
//
//                    htmlStr+='<tr>'+ss+'</tr>';
                }
                //$("#show").html(htmlStr);
                fenye(allData);
            },
            error:function(err){
                console.log(err);
            }
        });
    };
    render();

    function fenye(data){
        var allPage = Math.ceil(data.length/7),htmlStr,ppst;

        if((nowPage+1)*6 > data.length){
            ppst = (data.length)%6;

        }else{
            ppst = 6;
        }
         console.log(ppst);
        for(var i=0;i<ppst;i++){
               var showcontent = data[nowPage*6+i],ss="";

            for(var m=0;m<showcontent.length;m++){
                if(showcontent[m].length >10){
                				 ss+='<td>'+showcontent[m].slice(0,10)+'....</td>';
                				}else{
                				 ss+='<td>'+showcontent[m].slice(0,10)+'</td>';
                				}
            }
                console.log(ss);

                htmlStr+='<tr>'+ss+'</tr>';
        }

        $("#show").html(htmlStr);

      $("#allage").text(allPage);


        console.log(data);
    };

    $("#ints").click(function(){
        var tts = parseInt($("#ipus").val());
        console.log(tts);
        nowPage = tts-1;
        console.log(nowPage);
        fenye(allData);


    });


</script>
</body>
</html>

