<%-- 
    Document   : customer
    Created on : Apr 11, 2017, 2:33:34 PM
    Author     : User
--%>

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

<% 
    if(session.getAttribute("loginName")==null){
        response.sendRedirect("/BillManager/error.jsp?str=You have no access to this page ");
    }
    
    String loginName = (String)session.getAttribute("loginName");
    
    try{
        connect = DriverManager.getConnection(url, USERNAME, password);
    } catch (SQLException e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <title>Customer</title>
        
        <link rel="icon" href="images/b.png" type="image/x-icon" />
        <link rel="shortcut icon" href="images/b.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="css/styleSheet.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">

    </head>
    <body>
        <div style="right: 20px; bottom: 20px; position: absolute; z-index: -1; opacity: 0.1">
            <img src="images/bg.png" style="height: 350px; width: 800px">
        </div>
        
        <div class="navbar navbar-default navbar-fixed-top" style="background-color: #caebf2; box-shadow: inset 0 0 15px #517DDB; ">
            <div class="navbar-header">
                <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                    <i class="fa fa-user fa-lg"></i>
                </button>
                <a class="navbar-brand" href="/BillManager/dashboard.jsp" style="font-size: 1.5em; font-weight: bold; color: #5A5A5A">
                    Bill Manager
                </a>
            </div>
            <nav class="collapse navbar-collapse">
                <ul class="nav navbar-nav pull-right" style="margin-right: 20px">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-color: transparent">
                            <i class="fa fa-user fa-lg" aria-hidden="true"></i><%= loginName %><i class="fa fa-caret-down" aria-hidden="true"></i>
                        </a>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="/BillManager/logout">Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
        
        <!-- Wrapper -->
        <div id="wrapper" style="margin-top: 50px">
            <!-- Sidebar -->
            <div class="col-md-2" style="background-color: #bdbdbd; height: 100%; position: fixed; padding: 10px 0px;">
                <div id="sidebar">
                    <br>
                    <br>
                    <ul class="nav list-group">
                        <li>
                            <a href="/BillManager/dashboard.jsp" class="sidebarA">
                                <i class="fa fa-tachometer fa-fw" aria-hidden="true"></i>Dashboard</a>
                        </li>
                        <li>
                            <a href="/BillManager/bill.jsp" class="sidebarA">
                                <i class="fa fa-file-text-o fa-fw" aria-hidden="true"></i>Bill</a>
                        </li>
                        <li>
                            <a href="/BillManager/customer.jsp" class="sidebarA" style="background-color: #F7F7F7; font-weight: bold">
                                <i class="fa fa-users fa-fw" aria-hidden="true"></i>Customer</a>
                        </li>
                        <li>
                            <a href="/BillManager/payment.jsp" class="sidebarA">
                                <i class="fa fa-credit-card fa-fw" aria-hidden="true"></i>Payment</a>
                        </li>
                    </ul>
                </div>
                <div style="position: fixed; bottom: 10px; padding: 0px 10px;"><p style="font-size: 0.7em; font-style: italic; margin: 0">Copyright &copy; 2017 Bill Manager</p></div>
                    
            <div style="right: 10px; bottom: 100px; position: absolute; z-index: -1; opacity: 0.3; font-size: 6em;transform: rotate(90deg); transform-origin: left top 0px;">
                    <!--<img src="images/sidebg.png">-->
                    BM
            </div>
            </div>
            
            <!-- Content -->
            <div id="main-wrapper" class="col-md-10 pull-right">
                <div id="main">
                    <div class="page-header">
                        <h3 style="font-weight: bold">Customer</h3>
                        <button class="btn pull-right pinkBtn" style="margin-top: -40px" onclick="location.href='/BillManager/customeradd.jsp'" data-toggle="tooltip" data-placement="bottom" title="Go to Add Customer form">Add Customer</button>
                    </div>
                    
                    <table id="cusTable" class="table table-striped" >  
                        <thead>  
                            <tr>  
                                <th>ID</th>
                                <th>Company Name</th>  
                                <th>Address</th>
                                <th>Office Phone</th>  
                                <th>Status</th>  
                                <th>Category</th>
                                <th>Contact Person</th>
                            </tr>  
                        </thead>  
                        
                        <tbody>  
                        <%
                            try{
                                stat = connect.prepareStatement("SELECT `comID`,`companyName`,`companyAddress`,`cstatsName`,`companyPhone`,`cat`, `contactFName`,`cstatsColor` " +
                                    "FROM company LEFT JOIN " +
                                        "( SELECT comID, GROUP_CONCAT(catName SEPARATOR ', ') AS cat FROM " +
                                            "( SELECT comID, catName " +
                                                "FROM company_category JOIN category USING (`catID`) ) a GROUP BY comID " +
                                        ") cats USING (`comID`) " +
                                   "LEFT JOIN " +
                                        "(SELECT contactFName, contactCompany " +
                                            "FROM contact_person GROUP BY contactCompany) ppl ON comID = contactCompany " +
                                   "LEFT JOIN company_stats ON companyStat = cstatsID " +
                                   "ORDER BY comID DESC;");
                                result = stat.executeQuery();
                            } catch (SQLException e){
                                e.printStackTrace();
                            }

                            while(result.next()) {
                                out.print("<tr>");
                                out.println("<td>" + result.getString("comID") + "</td>");
                                out.println("<td>" + result.getString("companyName") + "</td>");
                                out.println("<td>" + result.getString("companyAddress") + "</td>");
                                out.println("<td>" + result.getString("companyPhone") + "</td>");
                                out.println("<td>");
                                out.println("<i class=\"fa fa-circle\" aria-hidden=\"true\" style=\"color: " + result.getString("cstatsColor") + " \"></i>");
                                out.println(result.getString("cstatsName") + "</td>");
                                if(result.getString("cat") == null) {
                                    out.println("<td>N/A</td>");
                                } else {
                                    out.println("<td>" + result.getString("cat") + "</td>");
                                }
                                if(result.getString("contactFName") == null) {
                                    out.println("<td>N/A</td>");
                                } else {
                                    out.println("<td>" + result.getString("contactFName") + "</td>");
                                }
                                out.println("</tr>");
                            }
                        %>
                        </tbody>  
                    </table>  
                    
                </div>
            </div>
        </div>
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        <!--<script type="text/javascript" src="css/jquery-1.12.4.js"></script>-->
        <script type="text/javascript" src="css/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="css/dataTables.bootstrap4.min.js"></script>
        
        <script>
            $(document).ready(function(){
                $('#cusTable').dataTable();
            });
        </script>
    </body>
</html>
