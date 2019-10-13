<%@ page language="java" import="java.util.*,java.net.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name = "";
name = name + (String)session.getAttribute("name");
String imageDir = "";
String getid = "";
getid = getid + (String)session.getAttribute("getid");


String upID = "";
upID = upID + (String)session.getAttribute("upID");
String[] upIDs = upID.split(",");
StringBuilder tableu = new StringBuilder();


String coID = "";
coID = coID + (String)session.getAttribute("coID");
String[] coIDs = coID.split(",");
StringBuilder tablec = new StringBuilder();


String msg = "";
String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"; 
String user="user"; 
String pwd="123";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();

try{
	  String sql;
	  String fmt="SELECT * FROM %s WHERE %s=%s;";
	  sql=String.format(fmt,"image_table","uid",getid);
	  ResultSet rs=stmt.executeQuery(sql);
	  rs.next();
	  imageDir=rs.getString("imageDir");
	  rs.close();
}
catch (Exception e){
	msg = e.getMessage();
}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>个人主页</title>
    
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style>
  * {color:black;}
  body{ 
		margin:0 auto; 
		width:1000px;
		text-align:center;
		background-image:url('images/bg16.jpg');
		background-repeat:no-repeat;
		background-size:100% 100%;
		
		}
  #header{
  		width:900px;
  		height:170px;
  		background-color:rgba(252,252,252,0.9);
  		position:absolute;
  		top:10px;
  		left:416px;
  		z-index:-10;
  		}
  #im {width:100px;
  		height:100px;
  		position:absolute;
  		top:50px;
  		left:450px;
  		border-style: solid; border-width: 1px;
  		}
  #upim{position:absolute;
  		top:300px;
  		left:470px;
  		z-index:20;
  		}
  	h1{position:relative;
  		top:30px;
  		}
  	#us {position:absolute;
  		top:260px;
  		left:470px;}
  	#main {width:663px;
  		height:700px;
  		background-color:rgba(252,252,252,0.9);
  		position:absolute;
  		top:200px;
  		left:650px;
  		
  	}
  	#text {
  		margin:0 auto;
  		position:relative;
  		top:40px;
  	}
  	#left {width:215px;
  		height:500px;
  		position:absolute;
  		background-color:rgba(252,252,252,0.9);
  		top:200px;
  		left:415px;
  	}
  	#con {
  		margin:0 auto;
  		position:relative;
  		top:100px;
  		left:60px;
  	}
  </style>
  <body>
    <h1>用户信息</h1>
    <% 
      request.setCharacterEncoding("utf-8");
      String username="";
      String password = "";
      Cookie[] cookies = request.getCookies();
      if(cookies!=null&&cookies.length>0)
      {
           for(Cookie c:cookies)
           {
              if(c.getName().equals("username"))
              {
                   username = URLDecoder.decode(c.getValue(),"utf-8");
              }
              if(c.getName().equals("password"))
              {
                   password = URLDecoder.decode(c.getValue(),"utf-8");
              }
           }
      }
    %>
    <BR>
    <BR>
    <BR>

    <div id="header"></div>
    <div id="left"></div>
    <div id="us">用户名：<%=name %></div><br>
    <img src="<%=imageDir%>" id="im"><br>
	<a href="image.html" id="upim">上传头像</a><br>
	<div id="main">
		<div id="text">我的文章</div>
	</div>
<%for(int i = 0; i < upIDs.length; i ++)
{
	String table="";
	String title="";
	try{ 
		String sql="select content from text_table where textID =" + upIDs[i] + ";"; 
		ResultSet rs1=stmt.executeQuery(sql);
		while(rs1.next()){
			table = table + rs1.getString("content");
		}
		int pos = table.indexOf("<");
		if(pos != -1)
		{
			title = table.substring(0,pos);
		}
		else
		{
			title = table;
		}
		tableu.append("<a href=\"mainPage.jsp?assignName=");
		tableu.append(upIDs[i]);
		tableu.append("\">");
		tableu.append(title);
		tableu.append("</a><br><br>");
		rs1.close();
	}
	catch (Exception e){ 
		msg = e.getMessage();
	}
}
%>
	<div id="con">
	<%=tableu%>
	</div>
     <a style="position:absolute;left:700px;bottom:30px;" href="index.jsp">返回</a>
  </body>
</html>
