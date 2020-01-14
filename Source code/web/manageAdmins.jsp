
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.Dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="sessioncheck.jsp" %>
<html>
<head>
    <title>Manage Groups</title>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
        
	<!-- Fonts -->
 	<link href="lib/font/montserrat.css" rel="stylesheet" type="text/css">
  	<link href="lib/font/lato.css" rel="stylesheet" type="text/css">
  	
  	<!--Bootstrap-->
  	<link rel="stylesheet" href="lib/bootstrap/css/bootstrap.min.css">

	<!--Css-->
	<link rel="stylesheet" href="css/dashboard.css">
      	<link rel="stylesheet" href="css/statistics.css">

</head>
<body id="page-top">

<!--Navigation bar-->
	<nav class="navbar navbar-expand navbar-dark bg-dark fixed-top">
		<div id="menu_icon">
		<a href="#home"  class="navbar-brand mr-1" onclick="opensidebar()"><img src="img/menu_icon1.png" style="height:20px;width:20px"></img></a>
		</div>                                                        
	    <a class="navbar-brand mr-1" href="home.jsp">#SIGMS</a>
		<!-- Navbar Search -->
		<form class="d-none d-md-inline-block form-inline ml-auto mr-md-3 my-md-0" style="visibility:hidden;">
		    <div class="input-group">
				<input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" style="font-size:12px;width: 200px;">
				<div class="input-group-append">
			  		<button class="btn btn-primary" type="button">
			    		<span class="glyphicon glyphicon-search"></span>
			  		</button>
				</div>
		    </div>
		</form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0">
            <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="badge badge-danger">Profile</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">	
                      <a class="dropdown-item" href="#">Settings</a>
                      <a class="dropdown-item" href="#">Activity Log</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="logout.jsp">Logout</a>
                    </div>
            </li>
	</ul>
	</nav>

		

<!----------Side bar----------------->

		
<div class="sidebar bg-dark" id="mySidebar"> 						<!--C-->
  <div class="closeSideBarButton" id="closeSection">
      <button onclick="closeSideBar()" style="float:right;background:grey;border:0;radius:30">x</button>   
  </div>										<!--C-->
  <a href="home.jsp" id="home">Home</a>
  <a href="newSigs.jsp" id="newSigs">SIGs</a>
  <a href="mySigs.jsp" id="mySigs">My SIGs</a>
  <%
      String sig = (session.getAttribute("sigid") != null) ? session.getAttribute("sigid").toString() : "null";
      if(!sig.equals("null"))
      {
  %>
        <a href="groupDashboard.jsp" class="active"><%=session.getAttribute("sigid")%></a>
  <%
      }
  %>  
  <a href="newEvents.jsp" id="newEvents">Events</a>
  <a href="myContributions.jsp" id="myContributions">My Contributions</a>
  
</div>

<!---------------------------------content -------------------------------->
<div class="content">
    <%@include file="messages.jsp"%>   

<!--Group Manage Section-->
<div class="text-center" style="width:100%;">
    <a style="width:20%;" class="btn btn-lg btn-info" href="manageAdmins.jsp">
        Manage Admins
    </a>
    <a style="width:20%;" class="btn btn-lg btn-info" href="manageUsers.jsp">
        Manage Users
    </a>
</div>    
<hr> 

<!--Group name and Description-->

<div class="jumbotron">
    <div class="text-center">
            <h1>Manage Admin Users</h1>
    </div>
    <div class="row align-items-center"  style="padding-left:1vw">
    	<div class="float-left clear-left" style="margin-right: 15px; max-width: 100%;" id='grpname'>
            <h2><%=session.getAttribute("grpnme")%></h2>
        </div>    
    </div>    
    <hr>   
    <div>
        
        
        <table class="table table-hover table-bordered text-center table-striped ">
        <thead class="thead-dark">
            <tr>
                <th class="w-50" scope="col">People</th>
                <th class="w-50" scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            try{
                //Connect db
                Dbconn db = new Dbconn();
                Connection con = db.connect();

                Statement st = con.createStatement();

                ResultSet rs = st.executeQuery("select * from `group_members` where group_id='"+session.getAttribute("sigid")+"' and designation in ('moderator','admin') order by designation ");
            
                while(rs.next()){
                   Statement st2 = con.createStatement();
                   ResultSet rs2 = st2.executeQuery("select name from users where user_id='"+rs.getString("user_id")+"' ");
                   rs2.next();
        %>
            <tr>
                <th class="w-25" scope="col"><%=rs2.getString("name")%></th>
                <th class="w-25" scope="col">
                    <%
                        if(!rs.getString("designation").equals("admin")){
                    %>
                            <button class="btn btn-danger" onclick="location.href='rmMod?sigid=<%=session.getAttribute("sigid")%>&uid=<%=rs.getString("user_id")%>'">Remove Moderator</button>
                    <%
                        }else{
                    %>
                            <button class="btn btn-success">Owner</button>
                    <%
                        }
                    %>
                </th>
            </tr>
        <%
                }
            
            }catch(Exception ex){
                System.out.println("Exception on manege admin page "+ex);
            }
        %>
        </tbody>
        </table>
    </div>
</div>    
<!-- end of content section-->
</div>
<script src="js/sidebar_size.js"></script>
<script src="js/manageGroups.js"></script>
<script src="lib/jquery/jquery.min.js"></script>
<script src="lib/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>     