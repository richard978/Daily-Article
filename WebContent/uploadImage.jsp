<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,
	com.myPack.jsp.querySQL"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	body{margin:0 auto;
		text-align: center;
		background-image:url('images/bg20.jpg');
        background-size:100% 100%;
        background-attachment:fixed;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>上传头像</title>
</head>
<body>
	<%String getid = "";
	  getid = getid + (String)session.getAttribute("getid");
	  querySQL qs = new querySQL();
	  request.setCharacterEncoding("utf-8");
	  int userID = Integer.parseInt(getid);;
	  String dir = "";
	  String filename = "";
	  String res = "上传失败！";
	  boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	  if(isMultipart){
		  DiskFileItemFactory  factory = new DiskFileItemFactory();
		  ServletFileUpload upload = new ServletFileUpload(factory);
		  upload.setHeaderEncoding("utf-8");
		  upload.setSizeMax(1024*1024);
		  List items = upload.parseRequest(request);
		  for(int i=0;i<items.size();i++){
			  FileItem fi = (FileItem)items.get(i);
			  if(fi.isFormField()){
			  }
			  else{
				  DiskFileItem dfi = (DiskFileItem) fi;
				  if (!dfi.getName().trim().equals("")){
					  String fileName=application.getRealPath("/file/images") + System.getProperty("file.separator") + FilenameUtils.getName(dfi.getName());
					  //String fileName =request.getSession().getServletContext().getRealPath("/");
					  fileName = fileName.replaceAll("\\\\","/");
					  dir = fileName;
					  File makedir = new File(application.getRealPath("/file/images"));
					  if(!makedir.exists())
						  makedir.mkdirs();
					  filename = FilenameUtils.getName(dfi.getName());
					  //out.print(new File(fileName).getAbsolutePath());
					  dfi.write(new File(fileName));
					  boolean flag = qs.storeImageDir(userID,fileName);
					  res = "上传成功！";
				  }
			  }
		  }
	  }
	  %>
	  <br>
<h1><%=res %></h1>
<a href="user.jsp">返回</a>
</body>
</html>