function postComment() {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				
			} else {
				
			}
		};
	};
	
	var uName = document.getElementById("name").innerHTML;
	var textID=document.getElementById("textID").innerHTML;
	
	var myDate = new Date();  
    var year=myDate.getFullYear();
    var month=myDate.getMonth(); 
    var day=myDate.getDate();    
    var hour=myDate.getHours();
    var minute=myDate.getMinutes();
    var timeNow=year+"/"+month+"/"+day+" "+hour+":"+minute;  //获取时间
	
    var content=document.getElementById("comment-content").innerHTML;//获取评论内容·
    
    var commentDiv=document.getElementById("messDivId");
	var outer=document.createElement("div");
	var pUserName=document.createElement("p");
	var pTime=document.createElement("p");
	var pContent=document.createElement("p");
	outer.classList.add("story");//添加评论
	pUserName.classList.add("story_t");
	pTime.classList.add("story_time");
	pContent.classList.add("story_m");
	pUserName.innerHTML=uName;
	pTime.innerHTML=timeNow;
	pContent.innerHTML=content;
	outer.appendChild(pUserName);
	outer.appendChild(pTime);
	outer.appendChild(pContent);
	commentDiv.appendChild(outer);
    
	var param = "textID=" + textID + "&time=" + timeNow + "&uName=" + encodeURIComponent(uName) + "&content=" +encodeURIComponent(content);
	xmlhttp.open("post", "postComment.jsp", true);
	xmlhttp.setRequestHeader("Content-Type",
	"application/x-www-form-urlencoded");
	xmlhttp.send(param);
}