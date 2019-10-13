<%@ page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String log = "0";	
%>
<% request.setCharacterEncoding("utf-8"); 
	String msg = "";
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"; 
	String user="user"; 
	String pwd="123";
	String id = request.getParameter("id"); 
	String pass = request.getParameter("password");
	String upID = "";
	String coID = "";
	if(request.getMethod().equalsIgnoreCase("post")){ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,user, pwd);
		Statement stmt = con.createStatement();
		try{ 
			String sql="select * from user_table where name ='" + id + "';"; 
			ResultSet rs=stmt.executeQuery(sql);
			String getpass = "";
			String getid = "";
			while(rs.next()){
				getpass = getpass + rs.getString("password");
				getid = getid + rs.getString("uid");
				upID = upID + rs.getString("uploadID");
				coID = coID + rs.getString("collectionID");
			}
			if(getpass.equals(pass))
				{	
					msg = " 登 录 成 功 !"; 
					log = "1";
					session.setAttribute("name",id);
					session.setAttribute("getid",getid); 
					session.setAttribute("upID",upID);
					session.setAttribute("coID",coID);
				}
			else if(getpass.equals(""))
				msg = " 帐 号 不 存 在 ！";
			else
				msg = " 密 码 错 误 ！";
			rs.close();
			stmt.close();	
			con.close();
		}
		catch (Exception e){ 
			msg = e.getMessage();
		}
	}
	session.setAttribute("log",log);
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dologin.jsp' starting page</title>

  </head>
  <style>
  	body{margin:0 auto; 
		width:800px;
		height:800px;
		background-image:url('images/bg18.jpg');
		background-repeat:no-repeat;
		background-size:100% 100%;
		}
	#main { 
		margin:0 auto; 
		width:600px;
		height:600px;
		text-align:center;
		}
	#success{
		position:relative;
		margin:0 auto;
	}
	#fail{
		position:relative;
		margin:0 auto;
	}
	.one{
		position:absolute;
		top:50px;
		left:-100px;
	}
	.two{
		position:absolute;
		top:50px;
		left:0px;
	}
  </style>
  <body>
  <div id="main">
    <h1 style="position:relative;top:50px;"><%=msg%></h1>
    <br>
    <br>
    <br>
    <% 
       request.setCharacterEncoding("utf-8");
       String[] isUseCookies = request.getParameterValues("isUseCookie");
       if(isUseCookies!=null&&isUseCookies.length>0)
       {
          String username = request.getParameter("id");
          String password = request.getParameter("password");
          
          Cookie usernameCookie = new Cookie("username",username);
          Cookie passwordCookie = new Cookie("password",password);
          usernameCookie.setMaxAge(864000);
          passwordCookie.setMaxAge(864000);
          response.addCookie(usernameCookie);
          response.addCookie(passwordCookie);
       }
       else
       {
          Cookie[] cookies = request.getCookies();
          if(cookies!=null&&cookies.length>0)
          {
             for(Cookie c:cookies)
             {
                if(c.getName().equals("username")||c.getName().equals("password"))
                {
                    c.setMaxAge(0); 
                    response.addCookie(c); 
                }
             }
          }
       }
    %>
<div id="success">
    <a class="one" style="display:block;width:90px;height:20px;background-color:black;color:white;"href="user.jsp"  class="success">用户信息</a>
    <a class="two" style="display:block;width:90px;height:20px;background-color:black;color:white;"href="index.jsp">返回</a>
</div>
<div id="fail">
    <a class="one" style="display:block;width:90px;height:20px;background-color:black;color:white;"href="javascript:history.back(-1)" class="fail">返回</a>
    <a class="two" style="display:block;width:90px;height:20px;background-color:black;color:white;"href="add.jsp" class="fail">注册</a>
</div>
    <script type="text/javascript">
		a = "<%=log%>";
		if(a=="1"){
			fail.setAttribute('style', 'display:none');
			success.setAttribute('style', 'display:inline');
		}
		else if(a=="0"||"null"){
			fail.setAttribute('style', 'display:inline');
			success.setAttribute('style', 'display:none');
		}
		function exit(){
			sessionStorage.clear();
			a = "0";
			fail.setAttribute('style', 'display:inline');
			success.setAttribute('style', 'display:none');
		}
</script>
</div>
  </body>
</html>
