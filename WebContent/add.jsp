<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); 
	String msg = "";
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"; 
	String user="user"; 
	String pwd="123";
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String table = "";
	if(request.getMethod().equalsIgnoreCase("post")){ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,user, pwd);
		Statement stmt = con.createStatement();
		
		try{ String fmt="select uid from user_table where name = '%s';"; 
		String sql = String.format(fmt,name);
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) { 
			table = table + (rs.getString("uid"));
		}
		if(table != "")
		{
			msg = "该帐号已存在！";
		}
		rs.close();
		}catch (Exception e){ 
			msg = e.getMessage();
		}
		if(msg == ""){
			try{ String fmt2="insert into user_table(name,password) values('%s', '%s')"; 
			String sql2 = String.format(fmt2,name,pass);
			int cnt = stmt.executeUpdate(sql2); if(cnt>0)msg = " 注 册 成 功 !"; 
			stmt.close();	
			con.close();
			}
			catch (Exception e){ 
				msg = e.getMessage();
			}
		}
	}	
%>
<!DOCTYPE HTML><html><head><title>注册</title>
	
	<style> a:link,a:visited {color:black;}
	body{margin:0 auto; 
		width:800px;
		height:800px;
		background-image:url('images/bg18.jpg');
		background-repeat:no-repeat;
		background-size:100% 100%;
		}
	.container{ 
		margin:0 auto; 
		width:800px;
		height:800px;
		text-align:center;
	}
	form {position:absolute;
			top:20%;
			left:45%;
			}
	#other {position:absolute;
			top:35%;
			left:48.5%;
			}
	</style>
	</head>
	<body>
	<div class="container">
		<form action="add.jsp" method="post" name="add">
			昵称:<input id="name" type="text" name="name" >
			<br><br>
			密码:<input id="pass" name="pass" type="password">
			<br><br>
			<input type="submit" name="sub" value="注册">
		</form>
		<h1 style="position:relative;top:50px;"><%=msg%></h1>
		<br><br>
		<div id="other">
		<a href='index.jsp'>返回</a>
		<a href="login.jsp">登录</a>
		</div>
	</div>
	</body>
</html>