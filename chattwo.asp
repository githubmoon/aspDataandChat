<%
    set conn=Server.CreateObject("ADODB.Connection")
    conn.Open "driver={SQL Server};server=ms4932640.xincache1.cn;uid=ms4932640;pwd=z5J7a9r8;database=ms4932640"
	
	If request.Form("qq") = "insertabs" Then
	set rs=Server.CreateObject("ADODB.recordset")
     snID = request.Form("tabs")
	sql="create table "&snID&" (Id int identity(1,1) primary key,ids varchar(255) NULL,chat varchar(8000) NULL)"  
    Response.write(sql)    
    rs.Open sql,conn
	 rs.close()
    conn.close()
	ElseIf request.form("qq") = "delete" Then
	
	
	
	ElseIf request.Form("qq") = "add" Then
	nID = request.Form("tabs")
	txts = request.Form("texts")
	sql="SELECT * FROM "&nID
  set rs=Server.CreateObject("ADODB.recordset")
  rs.open sql,conn ,3,3
  rs.AddNew
  rs("chat") = txts
  rs.Update
  rs.close
  set rs = nothing
  conn.close
  set conn = nothing
	Else
    set rs=Server.CreateObject("ADODB.recordset")
	nID = request.Form("tabs")
    sql= "SELECT *  FROM dbo."&nID&" Order By id desc"
    rs.Open sql,conn
    do While not rs.eof     
    Response.write(rs(0)&","&rs(1)&","&rs(2)&",<br/>spt")     
    rs.MoveNext     
    Loop   
    rs.close()
    conn.close()
    End If
%>
