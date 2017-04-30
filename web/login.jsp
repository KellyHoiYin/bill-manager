<%-- 
    Document   : home
    Created on : Mar 30, 2017, 9:41:35 PM
    Author     : Gan Hoi Yin
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
        String url = "jdbc:mysql://localhost:3306/billmanage";
        String USERNAME = "root";
        String password = "1234";
                
        Connection connect = null;
        PreparedStatement stat = null;
        ResultSet result = null;
%>

<%!
        public boolean authentication(String u, String p, String correctUser, String correctPass){
            if(u.equals(correctUser) && p.equals(correctPass)){
                return true;
            } else {
                return false;
            }
        }
%>

<%
    if(session.getAttribute("loginName")!=null){
        response.sendRedirect("/BillManager/error.jsp?str=What are you trying to do although you already logged in?");
    }
    
    String email = "";
    String userPass = "";
    boolean isAdmin = false;
    String name = "";
        
    try{
        connect = DriverManager.getConnection(url, USERNAME, password);
        stat = connect.prepareStatement("SELECT employeeEmail,employeePass,isAdmin,employeeFName FROM employee");
        result = stat.executeQuery();
    } catch (SQLException e){
        e.printStackTrace();
    }
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean authen = false;
    boolean error = false;
    String errorMsg = "";
        
    if(username != null){
        while(result.next()) { 
            if(username.equals(result.getString("employeeEmail"))){
                email = result.getString("employeeEmail");
                userPass = result.getString("employeePass");
                name = result.getString("employeeFName");
                break;
            }
        }
            
    if(email.isEmpty()){
        error = true;
            errorMsg = "No valid email found";
        }
    }
        
    if(!error && username != null && password != null){
        authen = authentication(username, password, email, userPass);
        if(!authen){
            error = true;
            errorMsg = "Invalid email or password";
        }
    }
    
    try{
        if(!authen) {
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <title>Login</title>
        
        <link rel="icon" href="images/b.png" type="image/x-icon" />
        <link rel="shortcut icon" href="images/b.png" type="image/x-icon" /> 
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/styleSheet.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    </head>
    <body>
        <div class="navbar navbar-default navbar-fixed-top" style="background-color: #caebf2; box-shadow: inset 0 0 15px #517DDB; ">
            <div class="navbar-header">
                <a class="navbar-brand" href="/BillManager/login.jsp" style="font-size: 1.5em; font-weight: bold; color: #5A5A5A">
                    Bill Manager
                </a>
            </div>
        </div>
        <div class="row" style="margin: 5px 0">
            <div class="col-md-7" style="padding: 0">
                <img src="images/loginbg.jpg" style="height: 760px; width: 100%">
            </div>
            
            <div id="main-wrapper" class="col-md-5" style="margin: 45px 0; padding: 50px 70px; box-shadow: inset 0 0 30px grey; height: 710px" >
                <form class="form-signin" action="/BillManager/login.jsp" method="POST" role="form">
                    <h2>Sign In</h2>
                    <div class="input-group" style="margin: 5px">
                        <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                        <input class="form-control" style="margin: 0" type="email" name="username"
                               <% 
                            if(username == null){
                                out.print("placeholder=\"Email\"");
                            } else {
                                out.print("value=\"" + username + "\"");
                            }
                           %> required autofocus>
                    </div>
                    <div class="input-group" style="margin: 5px">
                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                        <input class="form-control" style="margin: 0" type="password" name="password" placeholder="Password" required>
                    </div>
                    <% if(error) { %>
                    <span style="font-size: 15px; color: red; margin-left: 10px"><i><%= errorMsg %></i></span>
                    <% } %>
                    <br>
                    <button class="btn pinkBtn" style="width: 97%" align="center" type="submit">Sign in</button>
                </form>
                <div style="position: fixed; bottom: 10px; right: 0; padding: 0px 10px;"><p style="font-size: 0.7em; font-style: italic; margin: 0">Copyright &copy; 2017 Bill Manager</p></div>
            </div>
        </div>
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </body>
</html>
 <% } else { 
            session.setAttribute("loginName", name);
            session.setAttribute("admin", isAdmin);
                
            response.sendRedirect("/BillManager/dashboard.jsp");
        }
        
        } catch (Exception e){
            e.printStackTrace();
        }
        %>