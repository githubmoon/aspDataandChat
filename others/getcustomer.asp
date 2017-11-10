<%
set conn=Server.CreateObject("ADODB.Connection")
conn.Open "driver={SQL Server};server=ms4932640.xincache1.cn;uid=ms4932640;pwd=z5J7a9r8;database=ms4932640"

If request.form("qq") = "add" Then
  sql="SELECT * FROM guest.ts"
  set rs=Server.CreateObject("ADODB.recordset")
  rs.open"select * from guest.ts" ,conn ,3,3
  rs.AddNew
  rs("id") = request.Form("id")
  rs("task") = request.Form("task")
  rs("times") = request.Form("times")
  rs("notes") = request.Form("notes")
  rs.Update
  rs.close
  set rs = nothing
  conn.close
  set conn = nothing
  response.Redirect("getcustomer.asp")
ElseIf request.form("qq") = "update" Then 
  nID = request.Form("id")
  upname = request.Form("upnames")
  upvalue = request.Form("upvalues")
  set rs = server.CreateObject("ADODB.RecordSet")
  sql = "select * from guest.ts where id = "&nID
  rs.open sql, conn, 1, 3
  rs(upname) = upvalue
  rs.Update
  rs.close
  set rs = nothing
  conn.close
  set conn = nothing
  response.Redirect("getcustomer.asp")
ElseIf request.form("qq") = "delete" Then
   nID = request.Form("id")
   sql = "delete from guest.ts where id = "&nID
   conn.Execute(sql)
   conn.close
   set conn = nothing
   response.Redirect("getcustomer.asp")
ElseIf request.form("qq") = "selone" Then
    nID = request.Form("id")
    sql="SELECT * FROM guest.ts where id = "&nID
    set rs=Server.CreateObject("ADODB.recordset")
    rs.open sql ,conn 
    do While not rs.eof     
    Response.write(rs(0)&","&rs(1)&","&rs(2)&","&rs(3)&",<br/>spt")     
    rs.MoveNext     
Loop    
rs.close()     
Conn.close()   
Else
sql="SELECT * FROM guest.ts"
set rs=Server.CreateObject("ADODB.recordset")
rs.open"select * from guest.ts" ,conn 
    do While not rs.eof     
    Response.write(rs(0)&","&rs(1)&","&rs(2)&","&rs(3)&",<br/>spt")     
    rs.MoveNext     
Loop    
rs.close()     
Conn.close() 
End If
%>
