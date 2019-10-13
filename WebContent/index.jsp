<%@ page language="java" import="java.util.*,java.sql.*,com.myPack.jsp.querySQL" contentType="text/html; charset=utf-8"%>
<%
	String log = "0";
	log = (String)session.getAttribute("log");	
	String name = "";
	name = name + (String)session.getAttribute("name");
	String getid = "";
	getid = getid + (String)session.getAttribute("getid");
%>
<%querySQL qs = new querySQL();
int flag = qs.createTables("dailytext_15336152");
if(flag==1){
String totalDir =request.getSession().getServletContext().getRealPath("/").replaceAll("\\\\","/");
for(int i=1;i<=775;i++){
	  String filename = "text"+Integer.toString(i)+".txt";
	  qs.storeIniTxt(totalDir+"textset/"+filename);
}
}
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>每日一文</title>
	<style>
		* {font-family:楷体;}
		#register {position:absolute;
			top:-3px;
			right:66px;
			height:47px;
			padding:11px 0px 0px 0px;
			background-image:url('images/reg_bg.png');
			background-repeat: no-repeat;
			background-position:-220px 0px;
			transition-property:background-position;
			transition-duration:0.5s;
			}
		#register:hover {
			background-position:0px 0px;
			}
		#signin {position:absolute;
			top:0px;
			right:0px;
			height:45px;
			padding:10px 0px 0px 0px;
			background-image:url('images/reg_bg.png');
			background-repeat: no-repeat;
			background-position:-250px 0px;
			transition-property:background-position;
			transition-duration:0.5s;
			}
		#signin:hover {
			background-position:0px 0px;
			}
		#header {width:100%;
			height:55px;
			background-color:rgba(80,80,80,0.7);
			}
		#exit {
			position:absolute;
			right:8px;
			top:25px;
			}
		#exit:hover {cursor:pointer;}
		#username {position:absolute;
			top:25px;
			right:75px;
			}
		#logo {position:absolute;
			top:0px;
			left:10px;
			}
		body {background-image:url('images/bg17.jpg');
			background-size:100% 100%;
			background-repeat:no-repeat;
			width:100%;
			margin:0 auto;
			animation-name:bg1;
			animation-duration:2s;
			animation-timing-function:linear;
			animation-iteration-count:infinite;
			}
		/*#body2 {
			width:100%;
			height:640px;
			position:absolute;
			background-image:url('images/bg10.jpg');
			background-size:1858px 640px;
			background-repeat:no-repeat;
			background-position-y:110%;
			animation-name:bg1;
			animation-duration:2s;
			animation-timing-function:linear;
			animation-iteration-count:infinite;
			z-index:-2;
			}
			@keyframes bg1{
			0% {}
			100% {background:rgba(255,255,255,0);}
			}
		*/
		#main {
			width:1858px;
			margin:0 auto;
			}
		#mainbody {margin:0 auto;
			text-align:center;
			position:relative;
			left:-50px;
			}
		#mainpng {position:relative;
			left:40px;}
		.ink {position:absolute;
			margin:0 auto;
			width:300px;
			z-index:-1;
			opacity:0;
			transition-property:opacity;
			transition-duration:0.5s;
		}
		.su:hover .ink{
			opacity:1;
		}
		li {list-style:none;}
		#ink1 {top:92%;
			left:30%;
			}
		#ink2 {top:92%;
			left:45%;
			}
		#ink3 {top:92%;
			left:60%;
			}
		.sp {position:absolute;}
		#tag1 {top:100%;
			left:35%;
		}
		#tag2 {top:100%;
			left:50%;
		}
		#tag3 {top:100%;
			left:65%;
		}
		#split1 {width: 2px;height: 130px; background: #ff461f;
    		position:absolute;
    		top:107%;
			left:45%;}
    	#split2 {width: 2px;height: 130px; background: #ff461f;
    		position:absolute;
    		top:107%;
			left:60%;}
		#right {
			width:250px;
			height:545px;
			background-color:rgba(248,248,248,0.7);
			position:absolute;
			right:200px;
			top:55px;
			transition-property:background-color;
			transition-duration:0.3s;
			}
		#right:hover {background-color:rgba(218,187,164,0.8);}
		#rwords {
			vertical-align:middle;
			}
			
		#footer {
			width:100%;
			position:absolute;
			left:-20px;
			margin:0 auto;
			text-align:center;
			bottom:0px;
			}
			
		#shadow {position:absolute;display:block;top:0;left:0;z-index:80;
           background-color:gray;opacity:0.5;}
    #hideShadow {position:absolute;z-index:900;left:230px;top20px}
    #okBtn{
        position:absolute;
        top:300px;
        left:200px;
        height:100px;
        width:100px;
    }
    #div1{
        position:fixed;
        width:300px;
        height:200px;
        background-image:url('bg2.jpg');
        background-size:100% 100%;
        visibility:hidden;
        z-index:999;
        border:1px solid;
        box-shadow:5px 5px 1px #808080;
    }
    #title{
        position:absolute;
        top:0px;
        left:0px;
        display:inline-block;
        width:270px;
        height:23px;
        background-color:rgb(221,221,221);
        border-bottom:1px solid;
        border-right:1px solid;
        padding-left:5px;
        padding-top:5px;
        font-size:95%;
    }
    #close{
        position:absolute;
        top:0px;
        right:0px;
        display:inline-block;
        height:25px;
        width:28px;
        background-color:rgb(175,175,175);
        border-bottom:1px solid;
        border-left:1px solid;
        text-align:center;
        padding-top:3px;
        font-size:95%;
    }
    #close:hover{cursor:pointer}
    #showTxt{
        position:absolute;
        top:70px;
        left:40px;
    }
    #btn{
        position:absolute;
        top:145px;
        left:80px;
    }
    #yes{margin-right:50px;}
    
	</style>
	
</head>
<body>
	<div id="shadow"></div>
    <div id="div1">
        <div id="title">文件上传</div>
        <div id="close" onclick="hideShadow()">X</div>
        <form name="fileupload" id="f1" action="uploadTxt.jsp" method="POST" enctype="multipart/form-data">
            <input type="file" name="file" id="showTxt" accept="text/plain" size=24>
            <div id="btn">
                <input type="submit" id="yes" value="确认">
                <button type="button" id="no" onclick="hideShadow()">取消</button>
            </div>
        </form>
    </div>
    
	<div id="header">
		<div id="register"><a href="add.jsp" class="tp"><img src="images/register.PNG" style="width:70px;"></a></div>
		<div id="signin"><a href="login.jsp" class="tp"><img src="images/login.PNG" style="height:30px;"></a></div>
	</div>
	<div id="header2">
		<a href="user.jsp" id="username" style="font-size:24px;color:black"><%=name%></a>
		<span id="exit" onclick="exit()" style="text-decoration:none;color:#ff461f;font-size:24px;">退出</span>
	</div>
<div id="main">
	<div id="logo">
		<img src="images/logo1.png" alt="logo" style="width:50px;">
		<img src="images/title1.png" alt="每日一文" style="height:40px;position:relative;top:-5px;">
	</div>
	<div id ="mainbody" style="position:relative;margin:0 auto;">
		<li class="su">
			<a href="index.jsp" class="a"><img src="images/tag1.PNG" class="sp" id="tag1" style="width:100px"></a>
			<img src="images/ink.png" class="ink" id="ink1">
			<div id="split1"></div>
		</li>
		<img src="images/main.png" alt="main" style="width:600px;" id="mainpng">
		<li class="su">
			<a href="mainPage.jsp" class="a"><img src="images/tag2.PNG" class="sp" id="tag2" style="width:100px"></a>
			<img src="images/ink.png" class="ink" id="ink2">
			<div id="split2"></div>
		</li>
		<li class="su">
			<a href="javascript:void(0);" onclick="showWindow()" class="a"><img src="images/tag3.PNG" class="sp" id="tag3" style="width:100px"></a>
			<img src="images/ink.png" class="ink" id="ink3">
		</li>
	</div>
	<div id="right">
		<div id="rwords"></div>
		<img src="images/right1.PNG" style="position:absolute;left:30px;">
		<img src="images/right2.PNG" style="position:absolute;left:120px;top:200px;">
	</div>
	<div id="footer">
		<a href="http://report.ccm.gov.cn/">12318 全国文化市场举报网站</a>
		<div>联系我们：邵同学 1468619963@qq.com</div>
		<div>网上有害信息举报专区、违法和不良信息举报：1468619963@qq.com</div>
	</div>
</div>
<script type="text/javascript">
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
		function pos(){
	        var msgbox=document.getElementById("div1");
	        msgbox.style.left = (document.documentElement.clientWidth/2-msgbox.clientWidth/2)+"px";
	        msgbox.style.top = (document.documentElement.clientHeight/2-msgbox.clientHeight/2)+"px";
	        msgbox.style.visibility = "visible";
	    }
	    function showShadow(){
	        var shadow=document.getElementById("shadow");
	        shadow.style.width= ""+document.documentElement.scrollWidth+"px";
	        if(document.documentElement.clientHeight>document.documentElement.scrollHeight)
	            shadow.style.height=""+document.documentElement.clientHeight+"px";
	        else
	            shadow.style.height=""+document.documentElement.scrollHeight+"px";
	        shadow.style.display="block";
	    }

	    function hideShadow(){
	        var msgbox=document.getElementById("div1");
	        msgbox.style.visibility="hidden";
	        var shadow=document.getElementById("shadow");
	        shadow.style.display="none";
	    }
	    function showWindow(){
	    	if(a=="1")
	        {
	    		pos();
	        	showShadow();
	        }
	    	else{
	    		alert("请先登录！");
	    	}
	    }
</script>

</body>
</html>