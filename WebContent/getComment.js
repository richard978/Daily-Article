function getComment(){
	var textID=document.getElementById("textID").innerHTML;
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () { 
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) { // 200~299-OK 304-unmodified
				var jsonText=xmlhttp.responseText;
				var jsonObj=JSON.parse(jsonText);
				var commentDiv=document.getElementById("messDivId");
				for(i in jsonObj.comments)
				{
					var outer=document.createElement("div");
					var uName=document.createElement("p");
					var time=document.createElement("p");
					var content=document.createElement("p");
					outer.classList.add("story");
					uName.classList.add("story_t");
					time.classList.add("story_time");
					content.classList.add("story_m");
					uName.innerHTML=jsonObj.comments[i].uName;
					time.innerHTML=jsonObj.comments[i].time;
					content.innerHTML=jsonObj.comments[i].comment;
					outer.appendChild(uName);
					outer.appendChild(time);
					outer.appendChild(content);
					commentDiv.appendChild(outer);
				}

			} else {
				
			}
		};
	};
	xmlhttp.open("get", "getComment.jsp?textID="+textID, true);
	xmlhttp.send(null);
}
getComment();