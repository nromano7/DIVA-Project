<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Registration</title>

<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333333;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 16px;
    text-decoration: none;
}

li a:hover {
    background-color: #111111;
}

input {

margin: 5px 0px 5px 0px;

}

</style>

<script type="text/javascript" src="3D_Matching_Algorithm.js?v=2"></script>

</head>

<body>
	<!--This page will be our customer registration screen-->

<ul>
  <li><a href="signin.html">Sign In</a></li>
</ul>

<div align="center">

<h1>Welcome to Hulton Hotels! </h1>
<h2>To make a reservation Sign In</h2>
<h4>Not a member? Please register below:</h4>


<button id="clickMe">Pls</button>

<script>
document.getElementById("clickMe").addEventListener("click", function () { test('Hey'); });
</script>

<% 

try{
	
Class.forName("com.mysql.jdbc.Driver").newInstance(); 

Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ta_apps","root","root123"); 

Statement stmt = conn.createStatement();

ResultSet rs = stmt.executeQuery("SELECT * from Students");

out.println("<script>");
out.println("var s_list = [");
if(rs.next())
	out.print("[\"" + rs.getString("sid") + "\"]");
while(rs.next()){
	out.print(",[\"" + rs.getString("sid") + "\"]");
}
out.println("];");

rs.close();

rs = stmt.executeQuery("SELECT * from Professors");

out.println("var p_list = [");
if(rs.next())
	out.print("[\"" + rs.getString("pid") + "\"]");
while(rs.next()){
	out.print(",[\"" + rs.getString("pid") + "\"]");
}
out.println("];");

rs.close();

rs = stmt.executeQuery("SELECT * from Courses");

out.println("var c_list = [");
if(rs.next())
	out.print("[\"" + rs.getString("cid")+ "\",\"" + rs.getString("cnumber") + "\"]");
while(rs.next()){
	out.print(",[\"" + rs.getString("cid")+ "\",\"" + rs.getString("cnumber") + "\"]");
}
out.println("];");

rs.close();

rs = stmt.executeQuery("SELECT * from Apps");

out.println("var a_list = [");
if(rs.next())
	out.print("[\"" + rs.getString("appid") 
			+ "\",\"" + rs.getString("sid") 
			+ "\",\"" + rs.getString("pid") 
			+ "\",\"" + rs.getString("cid") 
			+ "\"]");
while(rs.next()){
	out.print(",[\"" + rs.getString("appid")
	 		+ "\",\"" + rs.getString("sid") 
			+ "\",\"" + rs.getString("pid") 
			+ "\",\"" + rs.getString("cid") 
			+ "\"]");
}
out.println("];");
out.println("document.write(s_list);");
out.println("document.write(\"<br/>\");");
out.println("document.write(p_list);");
out.println("document.write(\"<br/>\");");
out.println("document.write(c_list);");
out.println("document.write(\"<br/>\");");
out.println("document.write(a_list);");
out.println("document.write(\"<br/>\");");
out.println("document.write(generateMatching(s_list,p_list,c_list,a_list,[['A0001','S0029','P0008','C0060'],['A0002','S0028','P0032','C0040']]));");
out.println("document.write(\"<br/>\");");
out.println("</script>");

//Close the ResultSet 
rs.close(); 
//ClosetheStatement
stmt.close();
//Close the Connection 
conn.close(); 
}catch(Exception e){ 
	out.println(e.getMessage());
}

%>

</div>

</body>

</html>