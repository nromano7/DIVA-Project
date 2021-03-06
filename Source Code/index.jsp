<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.sql.*"%>
    <!doctype html>
    <html lang="en">

    <head>

      <title>Rutgers TA Match System</title>

      <!-- META -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

      <!-- CSS -->
      <link rel="stylesheet" href="./css/bootstrap.min.css">
      <link rel="stylesheet" href="./css/custom.css">
      <link rel="stylesheet" href="./css/tree.css">

      <!-- JS -->
      <script src="./js/fontawesome-all.js"></script>
      <script src="./js/d3.js"></script>
      <script type="text/javascript" src="./js/3D_Matching_Algorithm.js"></script>
      <script type="text/javascript" src="./js/tree.js"></script>
      <script type="text/javascript" src="./js/tables.js"></script>
      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

      <!-- TEMPORARY HARD CODED DATA -->
      <script>
        var s_list = [
          ["S0001"],
          ["S0002"],
          ["S0003"],
          ["S0004"],
          ["S0005"],
          ["S0006"],
          ["S0007"],
          ["S0008"],
          ["S0009"],
          ["S0010"],
          ["S0011"],
          ["S0012"],
          ["S0013"],
          ["S0014"],
          ["S0015"],
          ["S0016"],
          ["S0017"],
          ["S0018"],
          ["S0019"],
          ["S0020"],
          ["S0021"],
          ["S0022"],
          ["S0023"],
          ["S0024"],
          ["S0025"],
          ["S0026"],
          ["S0027"],
          ["S0028"],
          ["S0029"],
          ["S0030"],
          ["S0031"],
          ["S0032"],
          ["S0033"],
          ["S0034"],
          ["S0035"],
          ["S0036"],
          ["S0037"],
          ["S0038"],
          ["S0039"],
          ["S0040"],
          ["S0041"],
          ["S0042"],
          ["S0043"],
          ["S0044"],
          ["S0045"],
          ["S0046"],
          ["S0047"],
          ["S0048"],
          ["S0049"],
          ["S0050"],
          ["S0051"],
          ["S0052"],
          ["S0053"],
          ["S0054"],
          ["S0055"],
          ["S0056"],
          ["S0057"],
          ["S0058"],
          ["S0059"],
          ["S0060"],
          ["S0061"],
          ["S0062"],
          ["S0063"],
          ["S0064"],
          ["S0065"],
          ["S0066"],
          ["S0067"],
          ["S0068"],
          ["S0069"],
          ["S0070"],
          ["S0071"],
          ["S0072"],
          ["S0073"],
          ["S0074"],
          ["S0075"],
          ["S0076"],
          ["S0077"],
          ["S0078"],
          ["S0079"],
          ["S0080"],
          ["S0081"],
          ["S0082"],
          ["S0083"],
          ["S0084"],
          ["S0085"],
          ["S0086"],
          ["S0087"],
          ["S0088"],
          ["S0089"],
          ["S0090"],
          ["S0091"],
          ["S0092"],
          ["S0093"],
          ["S0094"],
          ["S0095"],
          ["S0096"],
          ["S0097"],
          ["S0098"],
          ["S0099"],
          ["S0100"]
        ];
        var p_list = [
          ["P0001"],
          ["P0002"],
          ["P0003"],
          ["P0004"],
          ["P0005"],
          ["P0006"],
          ["P0007"],
          ["P0008"],
          ["P0009"],
          ["P0010"],
          ["P0011"],
          ["P0012"],
          ["P0013"],
          ["P0014"],
          ["P0015"],
          ["P0016"],
          ["P0017"],
          ["P0018"],
          ["P0019"],
          ["P0020"],
          ["P0021"],
          ["P0022"],
          ["P0023"],
          ["P0024"],
          ["P0025"],
          ["P0026"],
          ["P0027"],
          ["P0028"],
          ["P0029"],
          ["P0030"],
          ["P0031"],
          ["P0032"],
          ["P0033"],
          ["P0034"],
          ["P0035"],
          ["P0036"],
          ["P0037"],
          ["P0038"],
          ["P0039"],
          ["P0040"],
          ["P0041"],
          ["P0042"],
          ["P0043"],
          ["P0044"],
          ["P0045"],
          ["P0046"],
          ["P0047"],
          ["P0048"],
          ["P0049"],
          ["P0050"],
          ["P0051"],
          ["P0052"],
          ["P0053"],
          ["P0054"],
          ["P0055"],
          ["P0056"],
          ["P0057"],
          ["P0058"],
          ["P0059"],
          ["P0060"],
          ["P0061"],
          ["P0062"],
          ["P0063"],
          ["P0064"],
          ["P0065"],
          ["P0066"],
          ["P0067"],
          ["P0068"],
          ["P0069"],
          ["P0070"],
          ["P0071"],
          ["P0072"],
          ["P0073"],
          ["P0074"],
          ["P0075"],
          ["P0076"],
          ["P0077"],
          ["P0078"],
          ["P0079"],
          ["P0080"],
          ["P0081"],
          ["P0082"],
          ["P0083"],
          ["P0084"],
          ["P0085"],
          ["P0086"],
          ["P0087"],
          ["P0088"],
          ["P0089"],
          ["P0090"],
          ["P0091"],
          ["P0092"],
          ["P0093"],
          ["P0094"],
          ["P0095"],
          ["P0096"],
          ["P0097"],
          ["P0098"],
          ["P0099"],
          ["P0100"]
        ];
        var c_list = [
          ["C0001", "198:105"],
          ["C0002", "198:107"],
          ["C0003", "198:110"],
          ["C0004", "198:111"],
          ["C0005", "198:112"],
          ["C0006", "198:142"],
          ["C0007", "198:143"],
          ["C0008", "198:170"],
          ["C0009", "198:195"],
          ["C0010", "198:205"],
          ["C0011", "198:206"],
          ["C0012", "198:211"],
          ["C0013", "198:213"],
          ["C0014", "198:214"],
          ["C0015", "198:314"],
          ["C0016", "198:323"],
          ["C0017", "198:324"],
          ["C0018", "198:334"],
          ["C0019", "198:336"],
          ["C0020", "198:344"],
          ["C0021", "198:352"],
          ["C0022", "198:405"],
          ["C0023", "198:411"],
          ["C0024", "198:415"],
          ["C0025", "198:416"],
          ["C0026", "198:417"],
          ["C0027", "198:419"],
          ["C0028", "198:424"],
          ["C0029", "198:425"],
          ["C0030", "198:428"],
          ["C0031", "198:431"],
          ["C0032", "198:437"],
          ["C0033", "198:439"],
          ["C0034", "198:440"],
          ["C0035", "198:442"],
          ["C0036", "198:443"],
          ["C0037", "198:444"],
          ["C0038", "198:445"],
          ["C0039", "198:452"],
          ["C0040", "198:460"],
          ["C0041", "198:493"],
          ["C0042", "198:500"],
          ["C0043", "198:503"],
          ["C0044", "198:504"],
          ["C0045", "198:505"],
          ["C0046", "198:507"],
          ["C0047", "198:508"],
          ["C0048", "198:509"],
          ["C0049", "198:510"],
          ["C0050", "198:512"],
          ["C0051", "198:513"],
          ["C0052", "198:514"],
          ["C0053", "198:515"],
          ["C0054", "198:516"],
          ["C0055", "198:518"],
          ["C0056", "198:519"],
          ["C0057", "198:520"],
          ["C0058", "198:521"],
          ["C0059", "198:522"],
          ["C0060", "198:523"],
          ["C0061", "198:525"],
          ["C0062", "198:526"],
          ["C0063", "198:527"],
          ["C0064", "198:529"],
          ["C0065", "198:530"],
          ["C0066", "198:532"],
          ["C0067", "198:533"],
          ["C0068", "198:534"],
          ["C0069", "198:535"],
          ["C0070", "198:536"],
          ["C0071", "198:538"],
          ["C0072", "198:539"],
          ["C0073", "198:540"],
          ["C0074", "198:541"],
          ["C0075", "198:543"],
          ["C0076", "198:544"],
          ["C0077", "198:545"],
          ["C0078", "198:546"],
          ["C0079", "198:547"],
          ["C0080", "198:550"],
          ["C0081", "198:552"],
          ["C0082", "198:553"],
          ["C0083", "198:554"],
          ["C0084", "198:555"],
          ["C0085", "198:560"],
          ["C0086", "198:580"],
          ["C0087", "198:583"],
          ["C0088", "198:596"],
          ["C0089", "198:598"],
          ["C0090", "198:601"],
          ["C0091", "198:602"],
          ["C0092", "198:603"],
          ["C0093", "198:604"],
          ["C0094", "198:605"],
          ["C0095", "198:606"],
          ["C0096", "198:607"],
          ["C0097", "198:608"],
          ["C0098", "198:671"],
          ["C0099", "198:672"],
          ["C0100", "198:673"]
        ];
        var a_list = [
          ["A0001", "S0029", "P0008", "C0060"],
          ["A0002", "S0028", "P0032", "C0040"],
          ["A0003", "S0044", "P0027", "C0014"],
          ["A0004", "S0071", "P0059", "C0036"],
          ["A0005", "S0006", "P0077", "C0008"],
          ["A0006", "S0064", "P0074", "C0006"],
          ["A0007", "S0017", "P0060", "C0097"],
          ["A0008", "S0039", "P0043", "C0050"],
          ["A0009", "S0072", "P0058", "C0034"],
          ["A0010", "S0027", "P0084", "C0010"],
          ["A0011", "S0081", "P0014", "C0002"],
          ["A0012", "S0031", "P0002", "C0046"],
          ["A0013", "S0078", "P0036", "C0064"],
          ["A0014", "S0018", "P0056", "C0007"],
          ["A0015", "S0062", "P0057", "C0067"],
          ["A0016", "S0020", "P0046", "C0041"],
          ["A0017", "S0097", "P0072", "C0068"],
          ["A0018", "S0058", "P0034", "C0006"],
          ["A0019", "S0081", "P0100", "C0008"],
          ["A0020", "S0053", "P0051", "C0031"],
          ["A0021", "S0036", "P0050", "C0081"],
          ["A0022", "S0016", "P0058", "C0083"],
          ["A0023", "S0001", "P0009", "C0025"],
          ["A0024", "S0056", "P0090", "C0086"],
          ["A0025", "S0015", "P0033", "C0060"],
          ["A0026", "S0044", "P0043", "C0076"],
          ["A0027", "S0051", "P0026", "C0048"],
          ["A0028", "S0033", "P0044", "C0084"],
          ["A0029", "S0003", "P0062", "C0002"],
          ["A0030", "S0092", "P0044", "C0076"],
          ["A0031", "S0074", "P0009", "C0038"],
          ["A0032", "S0035", "P0082", "C0011"],
          ["A0033", "S0031", "P0047", "C0089"],
          ["A0034", "S0029", "P0057", "C0004"],
          ["A0035", "S0081", "P0087", "C0022"],
          ["A0036", "S0070", "P0070", "C0072"],
          ["A0037", "S0051", "P0090", "C0075"],
          ["A0038", "S0031", "P0015", "C0092"],
          ["A0039", "S0088", "P0037", "C0057"],
          ["A0040", "S0007", "P0091", "C0046"],
          ["A0041", "S0090", "P0053", "C0046"],
          ["A0042", "S0010", "P0074", "C0007"],
          ["A0043", "S0039", "P0006", "C0056"],
          ["A0044", "S0044", "P0058", "C0047"],
          ["A0045", "S0093", "P0004", "C0100"],
          ["A0046", "S0066", "P0072", "C0024"],
          ["A0047", "S0045", "P0042", "C0021"],
          ["A0048", "S0043", "P0043", "C0043"],
          ["A0049", "S0010", "P0010", "C0065"],
          ["A0050", "S0003", "P0050", "C0010"],
          ["A0051", "S0058", "P0026", "C0052"],
          ["A0052", "S0009", "P0002", "C0042"],
          ["A0053", "S0074", "P0055", "C0035"],
          ["A0054", "S0083", "P0053", "C0067"],
          ["A0055", "S0086", "P0072", "C0002"],
          ["A0056", "S0085", "P0030", "C0012"],
          ["A0057", "S0020", "P0094", "C0045"],
          ["A0058", "S0072", "P0073", "C0016"],
          ["A0059", "S0048", "P0092", "C0100"],
          ["A0060", "S0022", "P0002", "C0019"],
          ["A0061", "S0086", "P0091", "C0034"],
          ["A0062", "S0004", "P0010", "C0018"],
          ["A0063", "S0073", "P0015", "C0054"],
          ["A0064", "S0027", "P0089", "C0055"],
          ["A0065", "S0003", "P0016", "C0097"],
          ["A0066", "S0034", "P0020", "C0017"],
          ["A0067", "S0019", "P0096", "C0001"],
          ["A0068", "S0063", "P0092", "C0032"],
          ["A0069", "S0091", "P0049", "C0066"],
          ["A0070", "S0089", "P0077", "C0052"],
          ["A0071", "S0001", "P0003", "C0020"],
          ["A0072", "S0012", "P0059", "C0095"],
          ["A0073", "S0076", "P0090", "C0068"],
          ["A0074", "S0031", "P0022", "C0036"],
          ["A0075", "S0088", "P0017", "C0017"],
          ["A0076", "S0080", "P0035", "C0093"],
          ["A0077", "S0082", "P0058", "C0063"],
          ["A0078", "S0098", "P0061", "C0058"],
          ["A0079", "S0042", "P0008", "C0076"],
          ["A0080", "S0087", "P0096", "C0068"],
          ["A0081", "S0079", "P0074", "C0068"],
          ["A0082", "S0053", "P0011", "C0086"],
          ["A0083", "S0024", "P0090", "C0089"],
          ["A0084", "S0090", "P0022", "C0040"],
          ["A0085", "S0095", "P0033", "C0017"],
          ["A0086", "S0011", "P0075", "C0036"],
          ["A0087", "S0041", "P0043", "C0093"],
          ["A0088", "S0097", "P0063", "C0064"],
          ["A0089", "S0076", "P0030", "C0055"],
          ["A0090", "S0024", "P0013", "C0085"],
          ["A0091", "S0080", "P0043", "C0034"],
          ["A0092", "S0079", "P0007", "C0004"],
          ["A0093", "S0030", "P0036", "C0081"],
          ["A0094", "S0085", "P0004", "C0017"],
          ["A0095", "S0057", "P0066", "C0075"],
          ["A0096", "S0056", "P0094", "C0073"],
          ["A0097", "S0066", "P0061", "C0048"],
          ["A0098", "S0080", "P0083", "C0010"],
          ["A0099", "S0070", "P0043", "C0055"],
          ["A0100", "S0004", "P0061", "C0052"]
        ];
      </script>
      <!-- JSP -->
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

    <body>

      <!-- NAVBAR -->
      <nav class="navbar navbar-expand navbar-dark bg-dark justify-content-between">
        <span class="navbar-brand" href="#">
          <img src="./images/rutgers_logo_865_768.png" width="30" height="30" class="d-inline-block align-top" alt="">
          <span style="PADDING-LEFT: 10px">
            Rutgers TA Match Systems
          </span>
        </span>
        <div class="dropdown">
          <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
            aria-expanded="false">
            Actions
          </button>
          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="#">
              Log Out
            </a>
          </div>
        </div>
      </nav>

      <div class="container-fluid h-100" style="padding-right: 1%; padding-left: 1%;">
        <div class="row mt-4 mb-4 h-100">

          <!-- MENU -->
          <div class="col-sm-2">
            <div class="row">
              <div class="col">
                <div class="card">
                  <div class="card-header">
                    Menu
                  </div>
                  <ul class="list-group list-group-flush">
                    <a href="#" class="list-group-item" data-toggle="modal" data-target="#allAppsModal">
                      All Applications
                      <span class="badge badge-pill badge-primary">
                        <script>
                          document.write(a_list.length);
                        </script>
                      </span>
                    </a>
                    <a href="#" class="list-group-item" data-toggle="modal" data-target="#prioritiesModal">
                      Priority List
                      <span class="badge badge-pill badge-secondary">0</span>
                    </a>
                    <a href="#" class="list-group-item" data-toggle="modal" data-target="#matchesModal">
                      Matches
                      <span class="badge badge-pill badge-secondary" id="matches">--</span>
                    </a>
                  </ul>
                </div>
              </div>

            </div>
            <div class="row mt-4">
              <div class="col text-center">
                <button type="button" class="btn btn-secondary" id="clickMe" style="justify-content: center;">Generate Matching</button>
                <script>
                  document.getElementById("clickMe").addEventListener("click", function () {
                    var temp = [];
                    for (let i = 0; i < 20; i++) {
                      temp = generateMatching(s_list, p_list, c_list, a_list, priority_list);
                      if (temp.length >= matches.length)
                        matches = temp.slice();
                    }
                    document.getElementById("matches").innerHTML = matches.length;
                    document.getElementById("matches_table").innerHTML = update_matching_table();
                    addListenersToMatches();
                  });
                </script>
              </div>
            </div>
          </div>

          <!-- MAIN -->
          <div class="col-sm-10">

            <!-- TREE CARD -->
            <div id="tree" class="card h-100">
              <div class="card-header text-right">
                <button id="students_button" type="button" class="btn btn-primary">
                  <i class="fas fa-users"></i> Students
                  <span class="badge badge-pill badge-primary" id="matches">
                    <script>
                      document.write(s_list.length);
                    </script>
                  </span>
                  <script>
                    document.getElementById("students_button").addEventListener("click", function () {
                      document.getElementById("students_button").setAttribute("class", "btn btn-primary")
                      document.getElementById("professors_button").setAttribute("class", "btn btn-outline-info")
                      document.getElementById("courses_button").setAttribute("class", "btn btn-outline-secondary")
                      treeData = generateDatabaseJSON(a_list, 0);
                      var h = document.getElementById('tree').clientHeight,
                        w = document.getElementById('tree').clientWidth,
                        size = {
                          height: h,
                          width: w
                        };
                      var margin = {
                        top: 10,
                        right: 10,
                        bottom: 100,
                        left: 0
                      };
                      d3.selectAll("#tree_svg").remove();
                      render_tree(treeData, size, margin);
                    });
                  </script>
                </button>
                <button id="professors_button" type="button" class="btn btn-outline-info">
                  <i class="fas fa-users"></i> Professors
                  <span class="badge badge-pill badge-info" id="matches">
                    <script>
                      document.write(p_list.length);
                    </script>
                  </span>
                  <script>
                    document.getElementById("professors_button").addEventListener("click", function () {
                      document.getElementById("students_button").setAttribute("class", "btn btn-outline-primary")
                      document.getElementById("professors_button").setAttribute("class", "btn btn-info")
                      document.getElementById("courses_button").setAttribute("class", "btn btn-outline-secondary")
                      treeData = generateDatabaseJSON(a_list, 1);
                      var h = document.getElementById('tree').clientHeight,
                        w = document.getElementById('tree').clientWidth,
                        size = {
                          height: h,
                          width: w
                        };
                      var margin = {
                        top: 10,
                        right: 10,
                        bottom: 100,
                        left: 0
                      };
                      d3.selectAll("#tree_svg").remove();
                      render_tree(treeData, size, margin);
                    });
                  </script>
                </button>
                <button id="courses_button" type="button" class="btn btn-outline-secondary">
                  <i class="fas fa-book"></i> Courses
                  <span class="badge badge-pill badge-secondary" id="matches">
                    <script>
                      document.write(c_list.length);
                    </script>
                  </span>
                  <script>
                    document.getElementById("courses_button").addEventListener("click", function () {
                      document.getElementById("students_button").setAttribute("class", "btn btn-outline-primary")
                      document.getElementById("professors_button").setAttribute("class", "btn btn-outline-info")
                      document.getElementById("courses_button").setAttribute("class", "btn btn-secondary")
                      treeData = generateDatabaseJSON(a_list, 2);
                      var h = document.getElementById('tree').clientHeight,
                        w = document.getElementById('tree').clientWidth,
                        size = {
                          height: h,
                          width: w
                        };
                      var margin = {
                        top: 10,
                        right: 10,
                        bottom: 100,
                        left: 0
                      };
                      d3.selectAll("#tree_svg").remove();
                      render_tree(treeData, size, margin);
                    });
                  </script>
                </button>
                <button id="priority_button" type="button" class="btn btn-outline-success ml-auto" disabled>
                  Add To Priority List
                </button>
              </div>
              <!-- TREE VISUALIZATION -->
              <script>
                treeData = generateDatabaseJSON(a_list, 0);
                var h = document.getElementById('tree').clientHeight,
                  w = document.getElementById('tree').clientWidth,
                  size = {
                    height: h,
                    width: w
                  };
                var margin = {
                  top: 10,
                  right: 10,
                  bottom: 100,
                  left: 0
                };
                render_tree(treeData, size, margin);
              </script>
            </div>


          </div>
        </div>
      </div>

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
            <div class="modal-body" id="apps_table" align="center" style="height:500px;overflow:auto;">
              Table showing all applications to go here.
              <script>
                document.getElementById("apps_table").innerHTML = update_apps_table();
                addListenersToApps();
              </script>
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

    </body>

    </html>