<%
set conn=Server.CreateObject("ADODB.Connection")
conn.Open "driver={SQL Server};server=ms4932640.xincache1.cn;uid=ms4932640;pwd=z5J7a9r8;database=ms4932640"

If request.form("qq") = "inerts" Then
  sql="SELECT * FROM guest.chatroom"
  set rs=Server.CreateObject("ADODB.recordset")
  rs.open"select * from guest.chatroom" ,conn ,3,3
  rs.AddNew
  rs("user") = request.Form("userd")
  rs.Update
  rs.close
  set rs = nothing
  conn.close
  set conn = nothing
ElseIf request.form("qq") = "addinsert" Then
    nID = request.Form("qs")
    upname = request.Form("qt") 
    set rs = server.CreateObject("ADODB.RecordSet")
    sql = "select * from guest.chatroom"
	rs.open sql,conn,3,3
	rs.AddNew
	rs("id") = nID
    rs("user") = ""
	rs("ts") = upname
    rs.Update
    rs.close
    conn.close
ElseIf request.form("qq") = "delete" Then
    sql="delete from guest.chatroom "  
	 Response.write(sql)     
    conn.Execute(sql)
    conn.close
    set conn = nothing
Else
sql="SELECT * FROM guest.chatroom"
set rs=Server.CreateObject("ADODB.recordset")
rs.open"select * from guest.chatroom" ,conn 
    do While not rs.eof     
    Response.write(rs(0)&","&rs(1)&","&rs(2)&",<br/>spt")     
    rs.MoveNext     
Loop    
rs.close()     
Conn.close() 
End If
%>
