<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,java.sql.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%!  
	String databaseOperation(Statement stmt,String tableName,String colName,String checkValue,String targetCol){
		String msg="";
		try{
			  String sql;
			  String fmt="SELECT * FROM %s WHERE %s='%s';";
			  sql=String.format(fmt,tableName,colName,checkValue);
			  ResultSet rs=stmt.executeQuery(sql);
			  if(rs.next())
			  	msg=rs.getString(targetCol);
			  rs.close();
		}
		catch (Exception e){
			msg = e.getMessage();
		}
		return msg;
	}
%>
<%
String log = "0";
log = (String)session.getAttribute("log");	
String name = "";
name = name + (String)session.getAttribute("name");
String getid = "";
getid = getid + (String)session.getAttribute("getid");
	request.setCharacterEncoding("utf-8");
	String rootPath=application.getRealPath("\\text_set");
	String textID="";//文章编号
	String title="";//文章标题
	String author="";//文章作者
	String text="";//文章正文
	String uid=getid;//用户ID
	String uName="";//昵称
	String headPic="";//头像路径
	uid=getid;
	String assignName=request.getParameter("assignName");//指定文章编号（可选
	String isCollect="加入收藏";
	StringBuilder table=new StringBuilder("");
	
	String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152"//数据库操作，上交时改localhost，与数据库名
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection(connectString, 
	                 "user", "123");
	Statement stmt=con.createStatement();
	//System.out.println(con.getClass().getClassLoader().getResource(con.getClass().getName().replace('.', '/') + ".class"));
	
	int index=(int)(Math.random()*770)+1;//随机文章，范围1-10，上交时改为实际编号
	textID=Integer.toString(index);
		
	if(assignName!=null&&!assignName.isEmpty()){
		textID=assignName;
	}	
	
	uName=databaseOperation(stmt,"user_table","uid",uid,"name");//获取用户名与ID
	headPic=databaseOperation(stmt,"image_table","uid",uid,"imageDir");
	
	String collect=databaseOperation(stmt,"user_table","uid",uid,"collectionID");//获取收藏文章
	if(collect!=null&&!collect.isEmpty()){
		String collections[]=collect.split(",");
	  	if(collect.indexOf(textID)>=0)
			isCollect="取消收藏";
	  	for(int i=0;i<collections.length;i++) {
		    if(collections[i]==null||collections[i].isEmpty())
			    continue;
		    String collectText=databaseOperation(stmt,"text_table","textID",collections[i],"content");
		    String strSplit[]=collectText.split("\n");
		    if(strSplit.length>2){
		    	collectText=strSplit[0]+strSplit[1];
		    }
		    table.append(String.format( 
				  "<li>%s</li>", 
				  "<a href='mainPage.jsp?assignName="+collections[i]+"'>"+collectText+"</a>"));
	  	}
	}
  	
  	text=databaseOperation(stmt,"text_table","textID",textID,"content");//获取随机文章

	if(!text.isEmpty()){//分割文章
		String strSplit[]=text.split("\n");
		if(strSplit.length>2)
		{
			title=strSplit[0];
			author=strSplit[1];
			text="";
			for(int i=2;i<strSplit.length;i++){
				text+=strSplit[i];
			}
		}
	}
	stmt.close();
	con.close();
%>
<!DOCTYPE html>
<html>
<head>
<title>每日一文</title>
<link rel="stylesheet" type="text/css" href="css/textPage.css">
<link rel="stylesheet" type="text/css" href="css/comment.css">
<script src="get.js" type="text/javascript" charset="utf-8"></script>
<script src="postComment.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
	
    <header id="head">
	    <div id="icon" style="z-index:2" onclick=refresh()>
	    	<img src="images/title.png" style="width:250px;height:80px">
	    </div>
	    <div id=func style="z-index:2">
	    	<span id="addCollect" onclick="collectFunc()"><%=isCollect %></span>丨
	    	<div id="header">
				<div id="register"><a href="add.jsp" class="tp"><img src="images/register.PNG" style="width:70px;"></a></div>
				<div id="signin"><a href="login.jsp" class="tp"><img src="images/login.PNG" style="height:30px;"></a></div>
			</div>
			<div id="header2">
				<span><a href="index.jsp" style="color:black">主页</a></span>
				<span><a href="user.jsp" id="username" style="color:black"><%=name%></a></span>
				<span id="exit" onclick="exit()" style="text-decoration:none;color:black">退出</span>
			</div>
	    	
	    </div>
	    <div class="bk">
    	</div>
    	<span id="textID" style="display:none;"><%=textID %></span>
    </header>
    <div class="main">
        <div class="content" id="content">
	        <div id="main-text">
	        	<h1 id="title"><%=title%></h1>
	        	<h3 id="author"><%=author%></h3>
	        	<div id="artical">
	        		<%=
	        			text
	        		%>	
	        	</div>
	        </div>
	        <div id="comment">
	        	<div class="ylcon">
					<p class="tit">
					所有留言
					</p>
					<div id="messDivId">
					</div>
				</div>
	        	<div class="comment-add">                       
			     <div class="commentguest">  
			           <img src=<%=headPic %> class="img-circle">  
			     </div>  
			     <div id="comment-input" class="comment-input">  
		       		<div class="commentarea">  
		             	<textarea  id="comment-content" rows="6" cols="80" onpropertychange="if(this.scrollHeight> 80)this.style.posHeight=this.scrollHeight+5" placeholder="请写下您的评论"></textarea>  
		           	</div>                                   
		       		<div class="commentbtn" onclick="postComment()">  
		         		<div class="commentmask"></div>  
		         		<a href="javascript:;" class="getcomment btn btn-block" role="button">评论</a>  
		           	</div>  
			      </div>  
				</div> 
	        </div>
        </div>
        <div class="left">
        	<div id="user-msg">
        		<img src=<%=headPic %>> 
        		<p id="uid"><%=uid %></p>
        		<p id="name"><%=uName %></p>
        	</div>
        	<div class="left-nav" id="left-nav1">
        		<h3 class="left-nav-title">最新文章</h3>
        		<div class="left-nav-content">
        			<ul>
	        			<li><a href='mainPage.jsp?assignName=1'>软座包厢-雷蒙德.卡佛</a></li>
	        			<li><a href='mainPage.jsp?assignName=2'>小站-袁鹰</a></li>
	        			<li><a href='mainPage.jsp?assignName=3'>动乱时代-朱自清</a></li>
        			</ul>
        		</div>
			</div>
        	<div class="left-nav" id="left-nav2">
        		<h3 class="left-nav-title">个人收藏</h3>
        		<div class="left-nav-content">
        			<ul>
	        			<%=table.toString() %>
        			</ul>
        		</div>
        	</div>
        	<div class="left-nav" id="left-nav3">
        		<h3 class="left-nav-title">热门文章</h3>
        		<div class="left-nav-content">
        			<ul>
	        			<li><a href='mainPage.jsp?assignName=10'>我的母亲-老舍</a></li>
	        			<li><a href='mainPage.jsp?assignName=9'>爱与恨-李碧华</a></li>
	        			<li><a href='mainPage.jsp?assignName=8'>幸福就在此刻-铁凝</a></li>
        			</ul>
        		</div>
        	</div>
        </div>
        <div class="right"></div>
    </div>
    <footer id=foot>
    	<div class="footer-bk">
    	</div>
    </footer>
    <script src="getComment.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
	    function rnd(n, m){
	        var random = Math.floor(Math.random()*(m-n+1)+n);
	        return random;
	    }
	    function refresh()
	    {
	        window.location.replace("mainPage.jsp");
	    }
	    
	    var bg_idx=rnd(1,98);
		document.getElementById("content").style.backgroundImage="url('images/bg/bg_"+bg_idx+".jpg')";
		document.getElementById("head").style.backgroundImage="url('images/bg/bg_"+bg_idx+".jpg')";
		a = "<%=log%>";
		if(a=="1"){
			register.setAttribute('style', 'display:none');
			signin.setAttribute('style', 'display:none');
			header2.setAttribute('style', 'display:inline');
		}
		else if(a=="0"||"null"){
			register.setAttribute('style', 'display:inline');
			signin.setAttribute('style', 'display:inline');
			header2.setAttribute('style', 'display:none');
		}
		function exit(){
			sessionStorage.clear();
			a = "0";
			sessionStorage.setItem('log', '0');
			register.setAttribute('style', 'display:inline');
			signin.setAttribute('style', 'display:inline');
			header2.setAttribute('style', 'display:none');
			c.setMaxAge(0); 
            response.addCookie(c);
		}
	</script>
</body>
</html>