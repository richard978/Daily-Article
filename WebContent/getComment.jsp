<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"
%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/json"); 
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	String msg="";
	String textID=request.getParameter("textID");
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, 
		         "user", "123");
		Statement stmt=con.createStatement();
		String sql=String.format("select * from comment_table where textID='%s';",textID); 
		ResultSet rs=stmt.executeQuery(sql); 
		if(rs.next()){
			msg=rs.getString("comment");
			String fillBlankSql="UPDATE comment_table SET comment=JSON_OBJECT('comments',JSON_ARRAY()) WHERE textID = '%s';";
			if(msg==null||msg.isEmpty()){
				int cnt = stmt.executeUpdate(String.format(fillBlankSql,textID));
			}
		}
		else{
			String fillBlankSql="INSERT INTO comment_table(textID) VALUES(%s);";
			int cnt = stmt.executeUpdate(String.format(fillBlankSql,textID));
			fillBlankSql="UPDATE comment_table SET comment=JSON_OBJECT('comments',JSON_ARRAY()) WHERE textID = '%s';";
			cnt = stmt.executeUpdate(String.format(fillBlankSql,textID));
		}
		
		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e){
		msg = e.getMessage();
	}
	out.print(msg);
%>