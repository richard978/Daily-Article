<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	String uid=request.getParameter("uid");
	String msg="";
	String method=request.getParameter("method");
	String textID=request.getParameter("textID");
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, 
		         "user", "123");
		Statement stmt=con.createStatement();
		String sql=String.format("select * from user_table where uid=%s;",uid); 
		ResultSet rs=stmt.executeQuery(sql); 
		if(rs.next()){
			if(method.equals("set")){
				String collect=rs.getString("collectionID");
				out.println("1");
				if(collect==null||collect.equals(",")||collect.isEmpty())
					collect="";
				collect+=","+textID;
				out.print(textID);
				String fmt="UPDATE user_table SET collectionID='%s' WHERE uid=%s;"; 
				sql = String.format(fmt,collect,uid); 
				int cnt = stmt.executeUpdate(sql); 
				if(cnt>0)
					msg = "收藏成功!";
			}
			else if(method.equals("delete")){
				String collections[]=rs.getString("collectionID").split(",");
				StringBuilder collect=new StringBuilder("");
				for(int i=0;i<collections.length;i++)
				{
					if(collections[i].equals(textID)){
						continue;
					}
					collect.append(collections[i]+",");
				}
				String fmt="UPDATE user_table SET collectionID='%s' WHERE uid=%s;"; 
				sql = String.format(fmt,collect.toString(),uid); 
				int cnt = stmt.executeUpdate(sql); 
				if(cnt>0)
					msg = "取消成功";
				msg=collect.toString();
			}
		}
		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e){
		msg = "error";
	}
	out.print(msg);
%>
