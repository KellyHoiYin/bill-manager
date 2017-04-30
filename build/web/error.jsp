<%-- 
    Document   : error
    Created on : Apr 10, 2017, 10:57:50 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <title>Error</title>
        
        <link rel="icon" href="images/b.png" type="image/x-icon" />
        <link rel="shortcut icon" href="images/b.png" type="image/x-icon" /> 
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/styleSheet.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    </head>
    <body>
        <div class="navbar navbar-default navbar-fixed-top" style="background-color: #caebf2; box-shadow: box-shadow: inset 0 0 15px #517DDB; ">
            <div class="navbar-header">
                <% if(session.getAttribute("loginName") != null) { %>
                <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                    <i class="fa fa-user fa-lg"></i>
                </button>
                <% } %>
                <a class="navbar-brand" href="/BillManager/dashboard.jsp" style="font-size: 1.5em; font-weight: bold; color: #5A5A5A">
                    Bill Manager
                </a>
            </div>
            
            <% if(session.getAttribute("loginName")!=null){ %>
            <nav class="collapse navbar-collapse">
                <ul class="nav navbar-nav pull-right" style="margin-right: 20px">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-color: transparent">
                           <i class="fa fa-user fa-lg" aria-hidden="true"></i><%= session.getAttribute("loginName") %><i class="fa fa-caret-down" aria-hidden="true"></i>
                        </a>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="/BillManager/logout">Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <% } %>
        </div>
        
        <div class="container" style="text-align: center; margin: 80px auto;">
            <h3><%= request.getParameter("str") %> :(</h3>
            
            <% if(session.getAttribute("loginName")!=null){ %>
                <button class="btn pinkBtn" onclick="location.href='/BillManager/dashboard.jsp'"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i><b>Understood</b></button>
            <% } else { %>
                <button class="btn pinkBtn" onclick="location.href='/BillManager/login.jsp'"><b>Go to login</b></button>
            <% } %>
            
            <div style="position: fixed; bottom: 10px; right: 0; padding: 0px 10px;"><p style="font-size: 0.7em; font-style: italic; margin: 0">Copyright &copy; 2017 Bill Manager</p></div>
        </div>
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </body>
</html>
