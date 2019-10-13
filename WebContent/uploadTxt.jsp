<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.io.*,java.util.*,java.sql.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,
	com.myPack.jsp.querySQL"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>上传文章</title>
</head>
<body>
	<%String getid = "";
	  getid = getid + (String)session.getAttribute("getid");
	  querySQL qs = new querySQL();
	  qs.createTables("dailytext_15336152");
	  request.setCharacterEncoding("utf-8");
	  int id = 0;
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
					  String fileName=application.getRealPath("/file/text") + System.getProperty("file.separator") + FilenameUtils.getName(dfi.getName());
					  fileName = fileName.replaceAll("\\\\","/");
					  dir = fileName;
					  File makedir = new File(application.getRealPath("/file/text"));
					  if(!makedir.exists())
						  makedir.mkdirs();
					  filename = FilenameUtils.getName(dfi.getName());
					  dfi.write(new File(fileName));
					  id = qs.storeTextDir(fileName);
					  res = "上传成功！";
					  String msg = "";
					  String connectString = "jdbc:mysql://localhost:53306/dailytext_15336152" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"; 
					  String user="user"; 
					  String pwd="123";
					  Class.forName("com.mysql.jdbc.Driver");
					  Connection con = DriverManager.getConnection(connectString,user, pwd);
					  Statement stmt = con.createStatement();
					  String preid = "";
					  String newid = "";
					  try{ String fmt="select uploadID from user_table where uid = '%s';"; 
						String sql = String.format(fmt,getid);
						ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()){
							preid = preid + rs.getString("uploadID");
						}
					  }
					  catch (Exception e){ 
							msg = e.getMessage();
						}
					  if(preid != ""){
					  	newid = newid + preid + "," + id;
					  }
					  try{ String fmt2="update user_table set uploadID = '%s' where uid = '%s';"; 
						String sql2 = String.format(fmt2,newid,getid);
						int cnt = stmt.executeUpdate(sql2); 
						stmt.close();	
						con.close();
						}
						catch (Exception e){ 
							msg = e.getMessage();
						}
				  }
			  }
		  }
	  }
	  %>
<h1><%=res %></h1>
<a href="index.jsp">返回</a>
</body>
</html>