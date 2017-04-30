<%-- 
    Document   : paymentadd
    Created on : Apr 15, 2017, 12:40:28 AM
    Author     : User
--%>

<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@page import="classes.*"%>
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
    try{
        connect = DriverManager.getConnection(url, USERNAME, password);
        connect.setAutoCommit(false);
    } catch (SQLException e){
        e.printStackTrace();
    }
    
    if(session.getAttribute("loginName")==null){
        response.sendRedirect("/BillManager/error.jsp?str=You have no access to this page ");
    }
    
    String loginName = (String)session.getAttribute("loginName");
    
    if(request.getParameter("save")!=null){
        String redirect = "/BillManager/payment.jsp";
            
        try{
            //create one new record
            stat = connect.prepareStatement("insert into payment (`payDate`,`payRefNo`,`payRefBank`,`payAmount`,`auditor`,`payType`,`payBy`,`payRemarks`) values (?,?,?,?,?,?,?,?)");
            stat.setString(1, request.getParameter("date"));
            stat.setString(2, request.getParameter("ref"));
            stat.setString(3, request.getParameter("bank"));
            stat.setString(4, request.getParameter("amount"));
            stat.setString(5, request.getParameter("auditor"));
            stat.setString(6, request.getParameter("type"));
            stat.setString(7, request.getParameter("by"));
            stat.setString(8, request.getParameter("remarks"));
            stat.execute();
            
            result = stat.executeQuery("select last_insert_id() as last_id from payment");
            result.next();
            int lastID = result.getInt("last_id");
            
            connect.commit();
        }
        catch(Exception e){
            e.printStackTrace();
            connect.rollback();
            redirect = "/BillManager/error.jsp?str=Ops, something went wrong and the record is not saved";
        }
            
        response.sendRedirect(redirect);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <title>Add Payment</title>
        
        <link rel="icon" href="images/b.png" type="image/x-icon" />
        <link rel="shortcut icon" href="images/b.png" type="image/x-icon" /> 
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
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
        
        <%
            Payment pay = new Payment();
        %>
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
                            <a href="/BillManager/customer.jsp" class="sidebarA">
                                <i class="fa fa-users fa-fw" aria-hidden="true"></i>Customer</a>
                        </li>
                        <li>
                            <a href="/BillManager/payment.jsp" class="sidebarA" style="background-color: #F7F7F7; font-weight: bold">
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
                        <h3 style="font-weight: bold">Payment > Add</h3>
                        <button class="btn pull-right pinkBtn" style="margin-top: -40px" onclick="location.href='/BillManager/payment.jsp'" data-toggle="tooltip" data-placement="bottom" title="Go back to the previous page">Cancel</button>
                    </div>
                    
                    <form id="addcus" action="/BillManager/paymentadd.jsp" method="POST" role="form" onsubmit="sub()"> 
                        <div class="form-inline">
                            Payment Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <% 
                                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                String today = format.format(new java.util.Date());
                            %>
                            <input type="date" class="form-control" name="date" value="<%= today %>" required>
                            <br>
                            Ref. No.: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" class="form-control" name="ref" placeholder="Reference" style="width: 30%" required>
                            <br>
                            Ref. Bank: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" class="form-control" name="bank" placeholder="Referenced Bank" style="width: 30%" required>
                            <br>
                            
                            <label style="padding: 0 77px 0 0; font-weight: normal">Auditor:</label>
                            <select id="employee" name="auditor" class="form-control" required>
                                <option></option>
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT * FROM employee ORDER BY employeeFName ASC");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                while(result.next()) {
                                out.print("<option value=\"" + result.getString("employeeID") + "\" ");
                                out.println(">" + result.getString("employeeFName") + " " + result.getString("employeeLName") + "</option>");
                                }
                            %>
                            </select>
                            <br>
                            <label style="padding: 0 32px 0 0; font-weight: normal">Payment Type:</label>
                            <select id="employee" name="type" class="form-control" required>
                                <option></option>
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT * FROM payment_type ORDER BY payTypeName ASC");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                while(result.next()) {
                                out.print("<option value=\"" + result.getString("payTypeID") + "\" ");
                                out.println(">" + result.getString("payTypeName") + "</option>");
                                }
                            %>
                            </select>
                            <br>
                            <label style="padding: 0 10px 0 0; font-weight: normal">Payment made by:</label>
                            <select id="customer" name="by" class="form-control" required>
                                <option></option>
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT * FROM company ORDER BY companyName ASC");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                while(result.next()) {
                                out.print("<option value=\"" + result.getString("comID") + "\" ");
                                out.println(">" + result.getString("companyName") + "</option>");
                                }
                            %>
                            </select>
                            <br>
                            Payment Amount: &nbsp;&nbsp;&nbsp;
                            <input type="text" class="form-control" name="amount" placeholder="Amount" style="width: 15%" required>
                            <br>
                            <p style="vertical-align: top; display: inline-block; padding: 5px 67px 5px 0px">Remarks:</p>
                            <textarea class="form-control" name="remarks" rows="4" cols="50" placeholder="Remarks"></textarea>
                            <br>
                        </div>
                        <hr>
                        <div>
                            <button class="btn pinkBtn pull-right" style="width: 20%" type="submit" name="save" data-toggle="tooltip" data-placement="top" title="Save payment">Add Payment</button>
                        </div>
                    </form>
                    
                </div>
            </div>
        </div>
        
        <script>
            function sub(){
                document.getElementById("addcus").submit();
            }
        </script>
            
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </body>
</html>