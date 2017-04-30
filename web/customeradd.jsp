<%-- 
    Document   : customeradd
    Created on : Apr 11, 2017, 2:33:57 PM
    Author     : User
--%>

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
        String redirect = "/BillManager/customer.jsp";
            
        try{
            //create one new record
            stat = connect.prepareStatement("insert into company (`companyName`,`companyAddress`,`companyNotes`,`companyGst`,`companyPhone`,`companyStat`) values (?,?,?,?,?,?)");
            stat.setString(1, request.getParameter("name"));
            stat.setString(2, request.getParameter("address"));
            stat.setString(3, request.getParameter("notes"));
            stat.setString(4, request.getParameter("gst"));
            stat.setString(5, request.getParameter("phone"));
            stat.setInt(6, 1);
            stat.execute();
            
            result = stat.executeQuery("select last_insert_id() as last_id from company");
            result.next();
            int lastID = result.getInt("last_id");
            
            //insert categories
            if(request.getParameterValues("catsValue")!=null){
                String[] tmp = request.getParameterValues("catsValue");
                String[] selected = tmp[0].split(",");
                
                for (int x = 0; x < selected.length; x++){
                    //create one new record
                    stat = connect.prepareStatement("insert into company_category (`comID`,`catID`) values (?,?)");
                    stat.setInt(1, lastID);
                    stat.setInt(2, Integer.parseInt(selected[x]));
                    stat.execute();
                }
            }
            
            //insert contact person
            int getNoOfCont = Integer.parseInt(request.getParameter("conCount"));
            
            if(getNoOfCont!=0){
                for (int x = 0; x < getNoOfCont; x++){
                    if(request.getParameter("fname" + x)==null) {
                        continue;
                    }
                    
                    //create one new record
                    stat = connect.prepareStatement("insert into contact_person (`contactFName`,`contactLName`,`contactPhoneNo`,`contactEmail`,`contactFax`,`contactCompany`) values (?,?,?,?,?,?)");
                    stat.setString(1, request.getParameter("fname" + x));
                    stat.setString(2, request.getParameter("lname" + x));
                    stat.setString(3, request.getParameter("phoneNo" + x));
                    stat.setString(4, request.getParameter("email" + x));
                    stat.setString(5, request.getParameter("fex" + x));
                    stat.setInt(6, lastID);
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
        
        <title>Add Customer</title>
        
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
            Company com = new Company();
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
                        <h3 style="font-weight: bold">Customer > Add</h3>
                        <button class="btn pull-right pinkBtn" style="margin-top: -40px" onclick="location.href='/BillManager/customer.jsp'" data-toggle="tooltip" data-placement="bottom" title="Go back to the previous page">Cancel</button>
                    </div>
                    
                    <form id="addcus" action="/BillManager/customeradd.jsp" method="POST" role="form" onsubmit="sub()"> 
                        <div class="form-inline">
                            Company Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" class="form-control" name="name" placeholder="Company name" style="width: 30%" required>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Company Office No.: 
                            <input type="text" class="form-control" name="phone" placeholder="Office No. (03-xxxx xxxx)" style="width: 30%" required>
                            <br>
                            Company Address:&nbsp;
                            <input type="text" class="form-control" name="address" placeholder="Company Address" style="width: 75%" required>
                            <br>
                            Company GST No.:
                            <input type="text" class="form-control" name="gst" placeholder="Company GST No." style="width: 30%" required>
                            <br>
                            <p style="vertical-align: top; display: inline-block; padding: 5px 82px 5px 0px">Notes:</p>
                            <textarea class="form-control" name="notes" rows="4" cols="50" placeholder="Notes"></textarea>
                            <br>
                            <label style="padding: 0 62px 0 0; font-weight: normal">Category:</label>
                            <span class="form-inline" id="categoryDiv"></span>
                            <select id="cat" name="cat" class="form-control">
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT * FROM category ORDER BY catName ASC");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                while(result.next()) {
                                out.print("<option value=\"" + result.getString("catID") + "\" ");
                                out.println(">" + result.getString("catName") + "</option>");
                                }
                            %>
                            </select>
                            <a onclick="addCat()" data-toggle="tooltip" data-placement="right" title="Add Category"><span class="glyphicon glyphicon-plus-sign" style="font-size: 23px; color: #FF595D; top: 8px"></span></a>
                            <br>
                            <label style="padding: 0 30px 0 0; font-weight: normal">Contact Person:</label>
                            <a onclick="addContact()" data-toggle="tooltip" data-placement="right" title="Add Contact Person Form">
                                <span class="glyphicon glyphicon-plus-sign" style="font-size: 23px; color: #FF595D; top: 8px"></span></a>
                            <span class="form-inline" id="contactDiv"></span>
                        </div>
                        <hr>
                        <div>
                            <input type="hidden" id="conCount" name="conCount" value=''>
                            <input type="hidden" id="catsValue" name="catsValue" value=''>
                            <button class="btn pinkBtn pull-right" style="width: 20%" type="submit" name="save" data-toggle="tooltip" data-placement="top" title="Save customer">Add Customer</button>
                        </div>
                    </form>
                    
                </div>
            </div>
        </div>
        
        <script>
            var count = 0;
            var cats = [];
            
            function addCat() {
                var selector = document.getElementById("cat");
                var index = selector.selectedIndex;
                var selected = selector.options[selector.selectedIndex].text;
                var value = selector.options[selector.selectedIndex].value;
                selector.remove(selector.selectedIndex);
                
                var addedCat = document.createElement('SPAN');
                addedCat.setAttribute('style', 'padding: 0px 10px;');
                addedCat.setAttribute('id', 'spanCat' + selected);
                addedCat.innerHTML = selected + "<a onclick=\"removeCat(\'" + index + "\',\'" + selected + "\')\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Remove Category\"><i class=\"fa fa-times\" aria-hidden=\"true\"></i></a>";
                
                var element = document.getElementById("categoryDiv");
                element.appendChild(addedCat);
                cats.push(value);
            }
            
            function removeCat(i, s){
                var str = "spanCat" + s;
                var element = document.getElementById(str);
                element.outerHTML = "";
                delete element;
                
                var selector = document.getElementById("cat");
                var opt = document.createElement('option');
                opt.value = s;
                opt.innerHTML = s;
                selector.appendChild(opt);
                
                var i = cats.indexOf(s);
                if(i != -1) {
                    cats.splice(i, 1);
                }
            }
            
            function addContact() {
                var addDiv = document.createElement('DIV');
                addDiv.setAttribute('class', 'form-inline');
                addDiv.setAttribute('style', 'margin-left: 120px; padding: 15px;');
                addDiv.setAttribute('id', 'conDD' + count);
                addDiv.innerHTML = "<a onclick=\"removeContact(\'" + count + "\')\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Remove Contact Person\"><i class=\"fa fa-times-circle fa-2x\" aria-hidden=\"true\" style=\"float:right; color: #FF595D;\"></i></a>" + 
                                "First Name: &nbsp" + 
                                "<input type=\"text\" class=\"form-control\" id=\"fname" + count + "\" name=\"fname" + count + "\" placeholder=\"First Name\" style=\"width: 30%\" required> " + 
                                "Last Name: " + 
                                "<input type=\"text\" class=\"form-control\" id=\"lname" + count + "\" name=\"lname" + count + "\" placeholder=\"Last Name\" style=\"width: 30%\" required> " + 
                                "<br> " + 
                                "Phone No.:&nbsp; " + 
                                "<input type=\"text\" class=\"form-control\" id=\"phoneNo" + count + "\" name=\"phoneNo" + count + "\" placeholder=\"Phone No.\" style=\"width: 30%\" required> " + 
                                "Fax No.:&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;" + 
                                "<input type=\"text\" class=\"form-control\" id=\"fax" + count + "\" name=\"fax" + count + "\" placeholder=\"Fax No.\" style=\"width: 30%\"> " + 
                                "<br> " + 
                                "Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; " + 
                                "<input type=\"email\" class=\"form-control\" id=\"email" + count + "\" name=\"email" + count + "\" placeholder=\"Email\" style=\"width: 40%\" required> ";
                var element = document.getElementById("contactDiv");
                element.appendChild(addDiv);
                count = count + 1;
            }
            
            function removeContact(i){
                var str = "conDD" + i;
                var element = document.getElementById(str);
                element.outerHTML = "";
                delete element;
                //count = count - 1;
            }
            
            function sub(){
                document.getElementById("conCount").value = count;
                document.getElementById("catsValue").value = cats;
                document.getElementById("addcus").submit();
            }
            
            </script>
            
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        
    </body>
</html>
