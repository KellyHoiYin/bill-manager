<%-- 
    Document   : billadd
    Created on : Apr 14, 2017, 9:49:22 PM
    Author     : User
--%>

<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@page import="classes.*"%>
<%@page import="java.util.*"%>
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
        String redirect = "/BillManager/bill.jsp";
            
        try{
            //create one new record
            stat = connect.prepareStatement("insert into bill (`billIssuedDate`,`billRemarks`,`billStatus`,`billIssueTo`,`billIssuedBy`,`billRef`) values (?,?,?,?,?,?)");
            stat.setString(1, request.getParameter("date"));
            stat.setString(2, request.getParameter("remarks"));
            stat.setInt(3, 1);
            stat.setString(4, request.getParameter("customer"));
            stat.setString(5, request.getParameter("salesman"));
            stat.setString(6, request.getParameter("ref"));
            stat.execute();
            
            result = stat.executeQuery("select last_insert_id() as last_id from bill");
            result.next();
            int lastID = result.getInt("last_id");
            
            //insert products
            int getNoOfCont = Integer.parseInt(request.getParameter("prodCount"));
            
            if(getNoOfCont!=0){
                for (int x = 0; x < getNoOfCont; x++){
                    if(request.getParameter("code" + x)==null) {
                        continue;
                    }
                    
                    ResultSet result2 = stat.executeQuery("select productID from product where productCode = \'" + request.getParameter("code" + x) + "\';");
                    result2.next();
                    int prodId = result2.getInt("productID");
                    
                    //create one new record
                    stat = connect.prepareStatement("insert into bill_product (`billID`,`productID`,`purchaseQty`,`purchasePrice`,`purchaseDesc`) values (?,?,?,?,?)");
                    stat.setInt(1, lastID);
                    stat.setInt(2, prodId);
                    stat.setString(3, request.getParameter("qty" + x));
                    stat.setString(4, request.getParameter("price" + x));
                    stat.setString(5, request.getParameter("desc" + x));
                    stat.execute();
                }
            }
            
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
        
        <title>Add Bill</title>
        
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
            Bill bill = new Bill();
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
                            <a href="/BillManager/bill.jsp" class="sidebarA" style="background-color: #F7F7F7; font-weight: bold">
                                <i class="fa fa-file-text-o fa-fw" aria-hidden="true"></i>Bill</a>
                        </li>
                        <li>
                            <a href="/BillManager/customer.jsp" class="sidebarA">
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
                        <h3 style="font-weight: bold">Bill > Add</h3>
                        <button class="btn pull-right pinkBtn" style="margin-top: -40px" onclick="location.href='/BillManager/bill.jsp'" data-toggle="tooltip" data-placement="bottom" title="Go back to the previous page">Cancel</button>
                    </div>
                    
                    <form id="addbill" action="/BillManager/billadd.jsp" method="POST" role="form" onsubmit="sub()"> 
                        <div class="form-inline">
                            Issue Date:&nbsp;&nbsp;&nbsp;&nbsp;
                            <% 
                                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                String today = format.format(new java.util.Date());
                            %>
                            <input type="date" class="form-control" name="date" value="<%= today %>" required>
                            <br>
                            Our Ref.: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" class="form-control" name="ref" placeholder="Reference" style="width: 30%" required>
                            <br>
                            <label style="padding: 0 20px 0 0; font-weight: normal">Customer:</label>
                            <select id="customer" name="customer" class="form-control" required>
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
                            <label style="padding: 0 20px 0 0; font-weight: normal">Salesman:</label>
                            <select id="employee" name="salesman" class="form-control" required>
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
                            
                            <p style="vertical-align: top; display: inline-block; padding: 5px 28px 5px 0px">Remarks:</p>
                            <textarea class="form-control" name="remarks" rows="4" cols="50" placeholder="Remarks"></textarea>
                            <br>
                            
                            <label style="padding: 0 30px 0 0; font-weight: normal">Products:</label>
                            <a onclick="addProd()" data-toggle="tooltip" data-placement="right" title="Add Product Field">
                                <span class="glyphicon glyphicon-plus-sign" style="font-size: 23px; color: #FF595D; top: 8px"></span></a>
                            <table style="width: 95%; margin-left: 20px">
                                <thead>
                                    <th style="width: 7%">Code</th>
                                    <th style="width: 40%">Description</th>
                                    <th style="width: 7%">Qty</th>
                                    <th style="width: 7%">Price</th>
                                    <th style="width: 7%">Amount</th>
                                </thead>
                            </table>
<!--                            <input type="text" class="form-control" name="code0" id="code0" placeholder="Code" style="width: 7%; margin-left: 15px" required>
                            <input type="text" class="form-control" name="desc0" id="desc0" placeholder="Description" style="width: 47%; margin-left: 18px" required>
                            <input type="text" class="form-control" name="qty0" id="qty0" placeholder="Qty" style="width: 6%; margin-left: 20px" required>
                            <input type="text" class="form-control" name="unit0" id="unit0" placeholder="Unit" style="width: 6%; margin-left: 25px" required disabled>
                            <input type="text" class="form-control" name="price0" id="price0" placeholder="Price" style="width: 7%; margin-left: 25px" required>
                            <input type="text" class="form-control" name="amt0" id="amt0" placeholder="Amount" style="width: 7%; margin-left: 25px" required>
                            <a onclick="removeContact('0')"><i class="fa fa-times-circle fa-2x" aria-hidden="true" style="float:right; color: #FF595D; margin-top: 6px"></i></a>-->
                            <span id="prodDiv"></span>
                        </div>
                        <hr>
                        <div>
                            <input type="hidden" id="prodCount" name="prodCount" value=''>
                            <button class="btn pinkBtn pull-right" style="width: 20%" type="submit" id="save" name="save" disabled data-toggle="tooltip" data-placement="top" title="Save Bill">Add Bill</button>
                        </div>
                    </form>
                    
                </div>
            </div>
        </div>
        
        <script>
            var count = 0;
            var removed = 0;
            
            function addProd() {
                var addDiv = document.createElement('DIV');
                addDiv.setAttribute('class', 'form-inline');
                addDiv.setAttribute('id', 'prodD' + count);
                addDiv.innerHTML = 
                            "<input type=\"text\" class=\"form-control\" name=\"code" + count + "\" id=\"code" + count + "\" placeholder=\"Code\" style=\"width: 7%; margin-left: 15px\" required>" + 
                            "<input type=\"text\" class=\"form-control\" name=\"desc" + count + "\" id=\"desc" + count + "\" placeholder=\"Description\" style=\"width: 50%; margin-left: 30px\" required>" + 
                            "<input type=\"text\" class=\"form-control\" name=\"qty" + count + "\" id=\"qty" + count + "\" onChange=\"setAmt(\'" + count + "\')\" placeholder=\"Qty\" style=\"width: 6%; margin-left: 50px\" required>" + 
                            "<input type=\"text\" class=\"form-control\" name=\"price" + count + "\" id=\"price" + count + "\" onChange=\"setAmt(\'" + count + "\')\" placeholder=\"Price\" style=\"width: 7%; margin-left: 40px\" required>" + 
                            "<input type=\"text\" class=\"form-control\" name=\"amt" + count + "\" id=\"amt" + count + "\" placeholder=\"Amount\" style=\"width: 7%; margin-left: 40px\" disabled>" +
                            "<a onclick=\"removeProd(\'" + count + "\')\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Remove Product\"><i class=\"fa fa-times-circle fa-2x\" aria-hidden=\"true\" style=\"float:right; color: #FF595D; margin-top: 6px\"></i></a>";
                
                var element = document.getElementById("prodDiv");
                element.appendChild(addDiv);
                count = count + 1;
                document.getElementById("save").disabled = false;
            }
            
            function removeProd(i){
                var str = "prodD" + i;
                var element = document.getElementById(str);
                element.outerHTML = "";
                delete element;
                removed = removed + 1;
                if(removed === count){
                    document.getElementById("save").disabled = true;
                }
            }
            
            function sub(){
                document.getElementById("prodCount").value = count;
                document.getElementById("addbill").submit();
            }
            
            function setAmt(i){
                var a = document.getElementById("qty" + i).value;
                var b = document.getElementById("price" + i).value;
                document.getElementById("amt" + i).value = parseFloat(Math.round((+a * +b) * 100) / 100).toFixed(2);
            }
            
            </script>
            
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </body>
</html>
