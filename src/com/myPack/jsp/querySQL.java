package com.myPack.jsp;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.*;
import java.util.*;

public class querySQL {
	static private Connection conn;
	static String databaseName = "";
	public static void main(String[] args) {
		
	}
	
	private static boolean connect(boolean init) {
		String connectString = "";
		if(!init)
			connectString = "jdbc:mysql://localhost:53306/"+databaseName
				+"?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
		else
			connectString = "jdbc:mysql://localhost:53306"
					+"?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "user", "123");
			return true;
		} 
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
	
	public int createTables(String dbName){
		if(!connect(true)){
			System.out.println("Connect error");
			return -1;
		}
		databaseName = dbName;
		int rs = execute("CREATE DATABASE `"+dbName+"`");
		if(rs==1){
			String create1 = "CREATE TABLE `"+dbName+"`.`user_table` (";
			create1 += "`uid` INT NOT NULL AUTO_INCREMENT,";
			create1 += "`name` VARCHAR(50) NOT NULL,";
			create1 += "`password` VARCHAR(20) NOT NULL,";
			create1 += "`uploadID` VARCHAR(50) NULL,";
			create1 += "`collectionID` VARCHAR(50) NULL,";
			create1 += "PRIMARY KEY (`uid`))";
			create1 += "DEFAULT CHARACTER SET = utf8;";
			execute(create1);
			
			String create2 = "CREATE TABLE `"+dbName+"`.`text_table` (";
			create2 += "`textID` INT NOT NULL,";
			create2 += "`content` MEDIUMTEXT NULL,";
			create2 += "PRIMARY KEY (`textID`))";
			create2 += "DEFAULT CHARACTER SET = utf8;";
			execute(create2);
			
			String create3 = "CREATE TABLE `"+dbName+"`.`image_table` (";
			create3 += "`uid` INT NOT NULL,";
			create3 += "`imageDir` TEXT NULL,";
			create3 += "PRIMARY KEY (`uid`));";
			execute(create3);
			
			String create4 = "CREATE TABLE `"+dbName+"`.`comment_table` (";
			create4 += "`textID` INT NOT NULL,";
			create4 += "`comment` TEXT NULL,";
			create4 += "PRIMARY KEY (`textID`))";
			create4 += "DEFAULT CHARACTER SET = utf8;";
			execute(create4);
			
		}
		
		return rs;
	}
	
	public boolean storeImageDir(int id, String filename){
		if(!connect(false)){
			System.out.println("Connect error");
			return false;
		}
		String query = String.format("insert into image_table(uid,imageDir) values('%s','%s');",id,filename);
		int rs = execute(query);
		if(rs==0){
			query = String.format("update image_table set imageDir='%s' where uid='%s';",filename,id);
			int rs2 = execute(query);
		}
		return true;
	}
	public int storeTextDir(String filename){
		if(!connect(false)){
			System.out.println("Connect error");
			return -1;
		}
		int id = 0;
		ResultSet rs = executeQuery("Select max(textID) from text_table;");
	    try{
	    	while(rs.next()){
	    		String temp = rs.getString("max(textID)");
	    		id = Integer.parseInt(temp)+1;
	    	}
	    }
	    catch(Exception e){
	    	System.out.println(e.getMessage());
	    }
	    
		File file = new File(filename);
		BufferedReader reader = null;
		ArrayList<String> list = new ArrayList<String>();
		String content = "";
		try{
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));
			String line = null;
			int pos = 0;
			while((line=reader.readLine())!=null){
				if(pos>=3)
					content = content+"<p>"+line+"\r\n"+"</p>\r\n";
				else
					content = content+line+"\r\n";
				pos++;
			}
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(reader!=null){
				try{
					reader.close();
				}catch(IOException e){}
			}
		}
		file.delete();
		if(!content.isEmpty()){
			saveArt(filename,id+"~"+content);
		}
		String query = "load data local infile '"+filename+"' into table text_table fields terminated by '~' lines terminated by 'abc';";
		int res = execute(query);
		return id;
	}
	
	public int storeIniTxt(String filename){
		if(!connect(false)){
			return 0;
		}
		String query = "load data local infile '"+filename+"' into table text_table fields terminated by '~' lines terminated by 'abc';";
		execute(query);
		return 1;
	}
	
	private static void saveArt(String saveFile, String content){
		BufferedWriter writer = null;
		try{
			writer = new BufferedWriter(new OutputStreamWriter (new FileOutputStream (saveFile,true),"UTF-8"));
			writer.write(content);
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try{
				writer.flush();
				writer.close();
			}catch(IOException e){}
		}
	}
	static private int execute(String sqlSentence) {
	     Statement stat;
	     int rs = 0;
	     
	     try {
	    	 stat = conn.createStatement();
	    	 rs = stat.executeUpdate(sqlSentence);
	     } 
	     catch (Exception e) {
	    	 System.out.println(e.getMessage());
	     }
	     return rs;
	}
	static private ResultSet executeQuery(String sqlSentence) {
	     Statement stat;
	     ResultSet rs = null;	
	     try {
	    	 stat = conn.createStatement();
	    	 rs = stat.executeQuery(sqlSentence);
	     } 
	     catch (Exception e) {
	    	 System.out.println(e.getMessage());
	     }
	     return rs;
	}
}
