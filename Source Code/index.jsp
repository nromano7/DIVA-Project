<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rutgers TA Match System</title>
    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Boostrap JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- FontAwesome -->
    <script src="./fontawesome-free-5.0.8/svg-with-js/js/fontawesome-all.js"></script>
    <!-- Bootstrap_v4.0: http://getbootstrap.com/docs/4.0/getting-started/introduction/ -->

	<script type="text/javascript" src="3D_Matching_Algorithm.js?v=2"></script>
	<style>
	table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
	}
	</style>
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
out.println("var priority_list = [];");
out.println("var matches = [];");
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
</head>

<body onload=load_viz()>
    <div>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand navbar-dark bg-dark justify-content-between">
            <!-- NAVBAR-BRAND -->
            <span class="navbar-brand" href="#">
                    <img src="./images/rutgers_logo_865_768.png" width="30" height="30" class="d-inline-block align-top" alt="">
                    <span style="PADDING-LEFT: 10px">
                        Rutgers TA Match Systems
                    </span>
            </span>
            <!-- NAVBAR-DROPDOWN -->
            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Actions
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#">
                        Log Out
                    </a>
                </div>
            </div>
        </nav>
    </div>

    <!-- MAIN  -->
    <section id="main">
        <div class="container">
            <div class="row">
                <!-- OPTIONS  CARD-->
                <div class "col-md-3 align-self-start">
                    <div class="card mt-4">
                        <div class="card-header">
                            Options
                        </div>
                        <ul class="list-group">
                            <!-- Triggers Modal -->
                            <a href="#" class="list-group-item" data-toggle="modal" data-target="#allAppsModal">
                                All Applications    
                                <span class="badge badge-pill badge-primary">
                                <script>
                                document.write(a_list.length);
                                </script>
                                </span>
                            </a>
                            <a href="#" class="list-group-item" data-toggle="modal" data-target="#prioritiesModal">
                                Priority List  <span class="badge badge-pill badge-secondary">0</span>
                            </a>
                            <a href="#" class="list-group-item" data-toggle="modal" data-target="#matchesModal">
                                Matches  <span class="badge badge-pill badge-secondary" id="matches">--</span>
                            </a>
                        </ul>
                    </div>
                </div>
                <!-- OVERVIEW CARD -->
                <div class="col-md-9">
                    <div class="card mt-4">
                        <div class="card-header">
                            Overview
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center text-center">
                                <div class="col-lg">
                                    <div class="card">
                                        <div class="card-body">
                                            <i class="fas fa-user fa-3x"></i>
                                            <h5 class="card-title">
                                                Students <a href="#">
                                                <script>
                                                document.write("(" + s_list.length + ")");
                                                </script>
                                                </a>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg">
                                    <div class="card">
                                        <div class="card-body">
                                            <i class="fas fa-users fa-3x"></i>
                                            <h5 class="card-title">
                                                Professors <a href="#">
                                                <script>
                                                document.write("(" + p_list.length + ")");
                                                </script>
                                                </a>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg">
                                    <div class="card">
                                        <div class="card-body">
                                            <i class="fas fa-book fa-3x"></i>
                                            <h5 class="card-title">
                                                Courses <a href="#">
                                                <script>
                                                document.write("(" + c_list.length + ")");
                                                </script>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- VISUALIZATIONS CARD -->
                    <div class="card text-center h-100 mt-4">
                        <div class="card-body" id="vis_body">

                            <!--h5 class="card-title">Visualization</h5-->
                            <div id="viz"></div>
                            <!--p class="card-text">This is where the D3 visualization will go.</p-->
                        </div>
                    </div>
                </div>
                <button id="clickMe">Generate Matching</button>
                <script>
                function update_matching_table(){
                	var ret = '<table><tr><th id="app_sort">Application_ID</th><th id="s_sort">' +
                				'Student_ID</th><th id="p_sort">Professor_ID</th>' +
                				'<th id="c_sort">Course_ID</th></tr>';
                    for(i = 0; i < matches.length; i++){
                    	ret += '<tr>';
                    	for(j = 0; j < matches[i].length; j++){
                    		ret += '<th>' + matches[i][j] + '</th>';
                    	}
                    	ret += '</tr>';
                    }
                    ret += '</table>';
                    return ret;
                }
                function addListeners(){
                	document.getElementById("app_sort").addEventListener("click", function(){
						matches.sort(function(a, b){
							return a[0].localeCompare(b[0]);
						});
						document.getElementById("matches_table").innerHTML = update_matching_table();
						addListeners();
					});
					document.getElementById("s_sort").addEventListener("click", function(){
						matches.sort(function(a, b){
							return a[1].localeCompare(b[1]);
						});
						document.getElementById("matches_table").innerHTML = update_matching_table();
						addListeners();
					});
					document.getElementById("p_sort").addEventListener("click", function(){
						matches.sort(function(a, b){
							return a[2].localeCompare(b[2]);
						});
						document.getElementById("matches_table").innerHTML = update_matching_table();
						addListeners();
					});
					document.getElementById("c_sort").addEventListener("click", function(){
						matches.sort(function(a, b){
							return a[3].localeCompare(b[3]);
						});
						document.getElementById("matches_table").innerHTML = update_matching_table();
						addListeners();
					});
                }
				document.getElementById("clickMe").addEventListener("click", function () { 
					var temp = generateMatching(s_list,p_list,c_list,a_list,priority_list);
					if(temp.length >= matches.length){
						matches = temp.slice();
						document.getElementById("matches").innerHTML = matches.length;
						document.getElementById("matches_table").innerHTML = update_matching_table();
						addListeners();
					}
					});
				</script>
            </div>
        </div>
    </section>

    <!-- MODALS -->
    <div class="modal fade" id="allAppsModal" tabindex="-1" role="dialog" aria-labelledby="allAppsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="allAppsModalLabel">All Applications</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Table showing all applications to go here.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="prioritiesModal" tabindex="-1" role="dialog" aria-labelledby="prioritiesModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="prioritiesModalLabel">Priorities</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Table of priorities and form to enter new priorities to go here.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="matchesModal" tabindex="-1" role="dialog" aria-labelledby="matchesModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="matchesModalLabel">Matches</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="matches_table" align="center" style="height:500px;overflow:auto;">
                    Table of all matches will go here.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function load_viz() {
            var width = $('#vis_body').offsetWidth;
            var height = $('#vis_body').offsetHeight;
            document.getElementById("viz").innerHTML = '<object type="text/html" data="example-tree/sample-tree.html" ></object>';
            console.log(height)
        }
    </script>

</body>

</html>
