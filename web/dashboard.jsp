<%-- 
    Document   : home
    Created on : Mar 30, 2017, 9:41:35 PM
    Author     : Gan Hoi Yin
--%>

<%@page import="java.sql.*"%>
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
    if(session.getAttribute("loginName")==null){
        response.sendRedirect("/BillManager/error.jsp?str=You have no access to this page ");
    }
    
    String loginName = (String)session.getAttribute("loginName");
    
    try{
        connect = DriverManager.getConnection(url, USERNAME, password);
        connect.setAutoCommit(false);
    } catch (SQLException e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <title>Dashboard</title>
        
        <link rel="icon" href="images/b.png" type="image/x-icon" />
        <link rel="shortcut icon" href="images/b.png" type="image/x-icon" /> 
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/styleSheet.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    </head>
    <body>
        <div style="right: 20px; bottom: 20px; position: absolute; z-index: -1; opacity: 0.3">
            <img src="images/bg.png" style="height: 300px; width: 800px">
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
                            <a href="/BillManager/dashboard.jsp" class="sidebarA" style="background-color: #F7F7F7; font-weight: bold">
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
                        <h3 style="font-weight: bold">Dashboard</h3>
                    </div>
                    <div style="border-style: solid; border-color: #EBEBEB; margin: 30px 50px; background-color: white; box-shadow: 0 5px 5px grey;" align="center">
                        <%
                            Calendar today = Calendar.getInstance();
                            Integer thisMonth = ((int)today.get(Calendar.MONTH) + 1);
                            Integer thisYear = today.get(Calendar.YEAR);
                            
                            String[][] graph = new String[6][4];
                            
                            int count = 0;
                            for(int x = 5; x > -1; x--){
                                String str = "";
                                Integer yr = thisYear;
                                Boolean minus = (thisMonth-x <= 0)? true: false;
                                
                                switch (thisMonth-x) {
                                    case 1:
                                        str = "January";
                                        break; 
                                    case 2:
                                        str = "February";
                                        break; 
                                    case 3:
                                        str = "March";
                                        break; 
                                    case 4:
                                        str = "April";
                                        break; 
                                    case 5:
                                        str = "May";
                                        break; 
                                    case 6:
                                        str = "June";
                                        break; 
                                    case 7:
                                        str = "July";
                                        break; 
                                    case 8: case -4:
                                        str = "August";
                                        break; 
                                    case 9: case -3:
                                        str = "September";
                                        break; 
                                    case 10: case -2:
                                        str = "October";
                                        break; 
                                     case 11: case -1:
                                        str = "November";
                                        break; 
                                    case 12: case 0:
                                        str = "December";
                                        break; 
                                }
                                
                                if(minus){
                                    yr--;
                                }
                                
                                graph[count][0] = str;
                                graph[count][1] = yr.toString();
                                count++;
                            }
                            
                            try{
                                for(int x = 0; x < 6; x++){                                    
                                    stat = connect.prepareStatement("SELECT `bills`,`pays` FROM " +
                                        "(SELECT COUNT(`billID`) AS bills FROM bill " + 
                                        "WHERE MONTH(`billIssuedDate`) = " + (thisMonth-(5-x)) + " AND YEAR(`billIssuedDate`) = " + graph[x][1] + " ) b JOIN " +
                                        "(SELECT COUNT(`paymentID`) AS pays FROM payment " + 
                                        "WHERE MONTH(`payDate`) = " + (thisMonth-(5-x)) + " AND YEAR(`payDate`) = " + graph[x][1] + ") p ");
                                    result = stat.executeQuery();
                                    
                                    if(result.next()) {
                                        graph[x][2] = result.getString("bills");
                                        graph[x][3] = result.getString("pays");
                                    }
                                }
                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                        %>
                        <div id="curve_chart" style="padding: 20px" ></div>
                    </div>
                    <div style="margin: 30px 50px" align="center">
                        <div style="padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px; float: left; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #F4FBFC, #ffffff, #E2E3F4);">
                            <i class="fa fa-archive fa-2x" aria-hidden="true" align="center" style="margin: 0 0 0 3px"></i>
                            <br><span style="font-size: 3em; margin: 0 0 0 10px">
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT COUNT(`billID`) AS cnt FROM bill " + 
                                        "WHERE MONTH(`billIssuedDate`) = " + thisMonth + " AND YEAR(`billIssuedDate`) = " + thisYear + ";");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                if(result.next()) {
                                    out.println(result.getString("cnt"));
                                }
                                %></span>
                            <br>Bills this month
                        </div>
                        <div style="padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px;; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #F0FFF0, #ffffff, #D9FFF2);">
                            <i class="fa fa-line-chart fa-2x" aria-hidden="true" align="center" style="margin: 0 0 0 3px"></i>
                            <br><span style="font-size: 3em; margin: 0 0 0 10px">
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT (paid/bills)*100 AS percent FROM " + 
                                        "(SELECT COUNT(`billID`) AS bills FROM bill ) b1 JOIN " +
                                        "(SELECT COUNT(`billID`) AS paid FROM bill WHERE `billStatus` = 2) b2");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                if(result.next()) {
                                    out.println(String.format("%.2f", Float.parseFloat(result.getString("percent"))) + "%");
                                }
                                %></span>
                            <br>Bills fully paid
                        </div>
                        <div style="padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px; float: right; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #FFF5FF, #ffffff, #FFE0EB);">
                            <i class="fa fa-money fa-2x" aria-hidden="true" align="center" style="margin: 0 0 0 3px"></i>
                            <br><span style="font-size: 3em; margin: 0 0 0 10px">
                            <% 
                                try{
                                    stat = connect.prepareStatement("SELECT SUM(remain) AS debt FROM ( " +
                                        "SELECT `billID`,`total`,`paid`,(total-paid) AS remain FROM bill " +
                                        "LEFT JOIN ( " +
                                                "SELECT SUM(`purchaseQty`*`purchasePrice`) AS total,`billID` FROM bill_product GROUP BY `billID` " +
                                        ") prod USING (`billID`) " +
                                        "LEFT JOIN ( " +
                                                "SELECT SUM(`amount`) AS paid,`billID` FROM payment_made GROUP BY `billID` " +
                                        ") pay USING (`billID`) " +
                                        "WHERE billStatus != 2 " +
                                        ") totalBills;");
                                    result = stat.executeQuery();
                                } catch (SQLException e){
                                    e.printStackTrace();
                                }

                                if(result.next()) {
                                    out.println(String.format("%.2f", Float.parseFloat(result.getString("debt"))));
                                }
                                %></span>
                            <br>Unreceived payment
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
        <script type="text/javascript" src="css/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Month', 'Bill', 'Payment'],
                    ['<%= graph[0][0] %>' + " " + '<%= graph[0][1] %>', parseInt(<%= graph[0][2] %>), parseInt(<%= graph[0][3] %>)],
                    ['<%= graph[1][0] %>' + " " + '<%= graph[1][1] %>', parseInt(<%= graph[1][2] %>), parseInt(<%= graph[1][3] %>)],
                    ['<%= graph[2][0] %>' + " " + '<%= graph[2][1] %>', parseInt(<%= graph[2][2] %>), parseInt(<%= graph[2][3] %>)],
                    ['<%= graph[3][0] %>' + " " + '<%= graph[3][1] %>', parseInt(<%= graph[3][2] %>), parseInt(<%= graph[3][3] %>)],
                    ['<%= graph[4][0] %>' + " " + '<%= graph[4][1] %>', parseInt(<%= graph[4][2] %>), parseInt(<%= graph[4][3] %>)],
                    ['<%= graph[5][0] %>' + " " + '<%= graph[5][1] %>', parseInt(<%= graph[5][2] %>), parseInt(<%= graph[5][3] %>)]
              ]);

              var options = {
                title: 'Bill & Payment',
                curveType: 'none',
                lineWidth: 3,
                colors: ['#FB0939', '#AEAEAE'],
                legend: { position: 'bottom' }
              };

              var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

              chart.draw(data, options);
            }
          </script>
    </body>
</html>
