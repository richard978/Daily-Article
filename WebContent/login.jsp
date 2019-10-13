<%@ page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String log = "0";
	log = (String)session.getAttribute("log");	
	String name = "";
	name = name + (String)session.getAttribute("name");
%>
<!DOCTYPE HTML>
<html>
<head>
	<base href="<%=basePath%>"> 
	<title>登录</title>
	<style> a:link,a:visited {color:blue;}
	.container{ 
		margin:0 auto; 
		width:500px;
		text-align:center;
	}
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
	form {position:absolute;
			top:15%;
			left:43%;
		}
	
	</style>
	
</head>
	<body>
	<div id="main">
	<h1 >登录</h1>
    <% 
      request.setCharacterEncoding("utf-8");
      String username="";
      String password = "";
      Cookie[] cookies = request.getCookies();
      if(cookies!=null&&cookies.length>0)
      {
           for(Cookie c:cookies)
           {
              if(c.getName().equals("id"))
              {
                   username =  URLDecoder.decode(c.getValue(),"utf-8");
              }
              if(c.getName().equals("password"))
              {
                   password =  URLDecoder.decode(c.getValue(),"utf-8");
              }
           }
      }
    %>
    <form name="loginForm" action="dologin.jsp" method="post">
       <table>
         <tr>
           <td>用户名：</td>
           <td><input type="text" name="id" value="<%=username %>"/></td>
         </tr>
         <tr>
         	<td style="height:10px;">     </td>
         </tr>
         <tr>
           <td>密码：</td>
           <td><input type="password" name="password" value="<%=password %>" /></td>
         </tr>
         </tr>
         <tr>
         	<td style="height:10px;">     </td>
         </tr>
         <tr>
         <tr>
           <td colspan="2"><input type="checkbox" name="isUseCookie" checked="checked"/>十天内记住我的登录状态</td>
         </tr>
         <tr>
         </tr>
         <tr>
         	<td style="height:10px;">     </td>
         </tr>
         <tr>
           <td id="l" colspan="2" align="center"><input type="submit" value="登录" style="background-color:white;"/>
           <a id="b" style="display:block;width:45px;height:20px;background-color:black;color:white;" href="javascript:history.back(-1)">返回</a>
         </tr>
       </table>
    </form>
    </div>
	</body>
</html>