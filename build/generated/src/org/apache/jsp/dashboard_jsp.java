package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;

public final class dashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


        String url = "jdbc:mysql://localhost:3306/billmanage";
        String USERNAME = "root";
        String password = "1234";
                
        Connection connect = null;
        PreparedStatement stat = null;
        ResultSet result = null;

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 Class.forName("com.mysql.jdbc.Driver"); 
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
 
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

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n");
      out.write("        \n");
      out.write("        <title>Dashboard</title>\n");
      out.write("        \n");
      out.write("        <link rel=\"icon\" href=\"images/b.png\" type=\"image/x-icon\" />\n");
      out.write("        <link rel=\"shortcut icon\" href=\"images/b.png\" type=\"image/x-icon\" /> \n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/styleSheet.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/font-awesome.min.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div style=\"right: 20px; bottom: 20px; position: absolute; z-index: -1; opacity: 0.3\">\n");
      out.write("            <img src=\"images/bg.png\" style=\"height: 300px; width: 800px\">\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"navbar navbar-default navbar-fixed-top\" style=\"background-color: #caebf2; box-shadow: inset 0 0 15px #517DDB; \">\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <button class=\"navbar-toggle collapsed\" type=\"button\" data-toggle=\"collapse\" data-target=\".navbar-collapse\">\n");
      out.write("                    <i class=\"fa fa-user fa-lg\"></i>\n");
      out.write("                </button>\n");
      out.write("                <a class=\"navbar-brand\" href=\"/BillManager/dashboard.jsp\" style=\"font-size: 1.5em; font-weight: bold; color: #5A5A5A\">\n");
      out.write("                    Bill Manager\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <nav class=\"collapse navbar-collapse\">\n");
      out.write("                <ul class=\"nav navbar-nav pull-right\" style=\"margin-right: 20px\">\n");
      out.write("                    <li class=\"dropdown\">\n");
      out.write("                        <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" style=\"background-color: transparent\">\n");
      out.write("                            <i class=\"fa fa-user fa-lg\" aria-hidden=\"true\"></i>");
      out.print( loginName );
      out.write("<i class=\"fa fa-caret-down\" aria-hidden=\"true\"></i>\n");
      out.write("                        </a>\n");
      out.write("                        <ul class=\"dropdown-menu pull-right\">\n");
      out.write("                            <li><a href=\"/BillManager/logout\">Log Out</a></li>\n");
      out.write("                        </ul>\n");
      out.write("                    </li>\n");
      out.write("                </ul>\n");
      out.write("            </nav>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <!-- Wrapper -->\n");
      out.write("        <div id=\"wrapper\" style=\"margin-top: 50px\">\n");
      out.write("            <!-- Sidebar -->\n");
      out.write("            <div class=\"col-md-2\" style=\"background-color: #bdbdbd; height: 100%; position: fixed; padding: 10px 0px;\">\n");
      out.write("                \n");
      out.write("                <div id=\"sidebar\">\n");
      out.write("                    <br>\n");
      out.write("                    <br>\n");
      out.write("                    <ul class=\"nav list-group\">\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/dashboard.jsp\" class=\"sidebarA\" style=\"background-color: #F7F7F7; font-weight: bold\">\n");
      out.write("                                <i class=\"fa fa-tachometer fa-fw\" aria-hidden=\"true\"></i>Dashboard</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/bill.jsp\" class=\"sidebarA\">\n");
      out.write("                                <i class=\"fa fa-file-text-o fa-fw\" aria-hidden=\"true\"></i>Bill</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/customer.jsp\" class=\"sidebarA\">\n");
      out.write("                                <i class=\"fa fa-users fa-fw\" aria-hidden=\"true\"></i>Customer</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/payment.jsp\" class=\"sidebarA\">\n");
      out.write("                                <i class=\"fa fa-credit-card fa-fw\" aria-hidden=\"true\"></i>Payment</a>\n");
      out.write("                        </li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <div style=\"position: fixed; bottom: 10px; padding: 0px 10px;\"><p style=\"font-size: 0.7em; font-style: italic; margin: 0\">Copyright &copy; 2017 Bill Manager</p></div>\n");
      out.write("                \n");
      out.write("            <div style=\"right: 10px; bottom: 100px; position: absolute; z-index: -1; opacity: 0.3; font-size: 6em;transform: rotate(90deg); transform-origin: left top 0px;\">\n");
      out.write("                    <!--<img src=\"images/sidebg.png\">-->\n");
      out.write("                    BM\n");
      out.write("            </div>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <!-- Content -->\n");
      out.write("            <div id=\"main-wrapper\" class=\"col-md-10 pull-right\">\n");
      out.write("                <div id=\"main\">\n");
      out.write("                    <div class=\"page-header\">\n");
      out.write("                        <h3 style=\"font-weight: bold\">Dashboard</h3>\n");
      out.write("                    </div>\n");
      out.write("                    <div style=\"border-style: solid; border-color: #EBEBEB; margin: 30px 50px; background-color: white; box-shadow: 0 5px 5px grey;\" align=\"center\">\n");
      out.write("                        ");

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
                        
      out.write("\n");
      out.write("                        <div id=\"curve_chart\" style=\"padding: 20px\" ></div>\n");
      out.write("                    </div>\n");
      out.write("                    <div style=\"margin: 30px 50px\" align=\"center\">\n");
      out.write("                        <div style=\"padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px; float: left; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #F4FBFC, #ffffff, #E2E3F4);\">\n");
      out.write("                            <i class=\"fa fa-archive fa-2x\" aria-hidden=\"true\" align=\"center\" style=\"margin: 0 0 0 3px\"></i>\n");
      out.write("                            <br><span style=\"font-size: 3em; margin: 0 0 0 10px\">\n");
      out.write("                            ");
 
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
                                
      out.write("</span>\n");
      out.write("                            <br>Bills this month\n");
      out.write("                        </div>\n");
      out.write("                        <div style=\"padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px;; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #F0FFF0, #ffffff, #D9FFF2);\">\n");
      out.write("                            <i class=\"fa fa-line-chart fa-2x\" aria-hidden=\"true\" align=\"center\" style=\"margin: 0 0 0 3px\"></i>\n");
      out.write("                            <br><span style=\"font-size: 3em; margin: 0 0 0 10px\">\n");
      out.write("                            ");
 
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
                                
      out.write("</span>\n");
      out.write("                            <br>Bills fully paid\n");
      out.write("                        </div>\n");
      out.write("                        <div style=\"padding: 20px; width: 30%; border-style: solid; border-color: #EBEBEB; display: inline-block; margin: 10px; float: right; background-color: white; box-shadow: 0 5px 5px grey; background: linear-gradient(to bottom right, #FFF5FF, #ffffff, #FFE0EB);\">\n");
      out.write("                            <i class=\"fa fa-money fa-2x\" aria-hidden=\"true\" align=\"center\" style=\"margin: 0 0 0 3px\"></i>\n");
      out.write("                            <br><span style=\"font-size: 3em; margin: 0 0 0 10px\">\n");
      out.write("                            ");
 
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
                                
      out.write("</span>\n");
      out.write("                            <br>Unreceived payment\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <script src=\"css/jquery.min.js\"></script>\n");
      out.write("        <script src=\"css/bootstrap.min.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"css/loader.js\"></script>\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            google.charts.load('current', {'packages':['corechart']});\n");
      out.write("            google.charts.setOnLoadCallback(drawChart);\n");
      out.write("\n");
      out.write("            function drawChart() {\n");
      out.write("                var data = google.visualization.arrayToDataTable([\n");
      out.write("                    ['Month', 'Bill', 'Payment'],\n");
      out.write("                    ['");
      out.print( graph[0][0] );
      out.write("' + \" \" + '");
      out.print( graph[0][1] );
      out.write("', parseInt(");
      out.print( graph[0][2] );
      out.write("), parseInt(");
      out.print( graph[0][3] );
      out.write(")],\n");
      out.write("                    ['");
      out.print( graph[1][0] );
      out.write("' + \" \" + '");
      out.print( graph[1][1] );
      out.write("', parseInt(");
      out.print( graph[1][2] );
      out.write("), parseInt(");
      out.print( graph[1][3] );
      out.write(")],\n");
      out.write("                    ['");
      out.print( graph[2][0] );
      out.write("' + \" \" + '");
      out.print( graph[2][1] );
      out.write("', parseInt(");
      out.print( graph[2][2] );
      out.write("), parseInt(");
      out.print( graph[2][3] );
      out.write(")],\n");
      out.write("                    ['");
      out.print( graph[3][0] );
      out.write("' + \" \" + '");
      out.print( graph[3][1] );
      out.write("', parseInt(");
      out.print( graph[3][2] );
      out.write("), parseInt(");
      out.print( graph[3][3] );
      out.write(")],\n");
      out.write("                    ['");
      out.print( graph[4][0] );
      out.write("' + \" \" + '");
      out.print( graph[4][1] );
      out.write("', parseInt(");
      out.print( graph[4][2] );
      out.write("), parseInt(");
      out.print( graph[4][3] );
      out.write(")],\n");
      out.write("                    ['");
      out.print( graph[5][0] );
      out.write("' + \" \" + '");
      out.print( graph[5][1] );
      out.write("', parseInt(");
      out.print( graph[5][2] );
      out.write("), parseInt(");
      out.print( graph[5][3] );
      out.write(")]\n");
      out.write("              ]);\n");
      out.write("\n");
      out.write("              var options = {\n");
      out.write("                title: 'Bill & Payment',\n");
      out.write("                curveType: 'none',\n");
      out.write("                lineWidth: 3,\n");
      out.write("                colors: ['#FB0939', '#AEAEAE'],\n");
      out.write("                legend: { position: 'bottom' }\n");
      out.write("              };\n");
      out.write("\n");
      out.write("              var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));\n");
      out.write("\n");
      out.write("              chart.draw(data, options);\n");
      out.write("            }\n");
      out.write("          </script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
