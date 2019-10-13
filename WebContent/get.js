function collectFunc(){
	var collected=document.getElementById("addCollect");
	if(collected.innerHTML=="加入收藏")
		setCollect();
	else{
		unsetCollect()
	}
}
function setCollect() {
	var uid=document.getElementById("uid").innerHTML;
	var textID=document.getElementById("textID").innerHTML;
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () { 
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) { // 200~299-OK 304-unmodified
				//alert(xmlhttp.responseText);
				var oTest = document.getElementById("addCollect");
				oTest.innerHTML = "取消收藏";
			} else {
				alert("error");
			}
		};
	};
	xmlhttp.open("get", "getFromDatabase.jsp?uid="+uid+"&method=set&textID="+textID, true);
	xmlhttp.send(null);
}
function unsetCollect() {
	var uid=document.getElementById("uid").innerHTML;
	var textID=document.getElementById("textID").innerHTML;
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () { 
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) { // 200~299-OK 304-unmodified
				//alert(xmlhttp.responseText);
				var oTest = document.getElementById("addCollect");
				oTest.innerHTML = "加入收藏";
			} else {
				alert("error");
			}
		};
	};
	xmlhttp.open("get", "getFromDatabase.jsp?uid="+uid+"&method=delete&textID="+textID, true);
	xmlhttp.send(null);
}
