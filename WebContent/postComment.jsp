<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/json"); 
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	String msg="";
	String uName=request.getParameter("uName");
	String textID=request.getParameter("textID");
	String time=request.getParameter("time");
	String comment=request.getParameter("content");
	if(uName.isEmpty()||uName==null)
		uName="游客";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, 
		         "user", "123");
		Statement stmt=con.createStatement();
		String fmt="UPDATE comment_table SET comment=JSON_ARRAY_APPEND(comment,'$.comments',JSON_OBJECT('time','%s','uName','%s','comment','%s')) WHERE textID = '%s';";
		String sql=String.format(fmt,time,uName,comment,textID); 
		int cnt = stmt.executeUpdate(sql); 
		if(cnt>0)
			msg = "评论成功!";
		stmt.close();
		con.close();
	}
	catch (Exception e){
		msg = e.getMessage();
	}
	out.print(msg);
%>