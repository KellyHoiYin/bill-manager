package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class payment_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("        <title>Payment</title>\n");
      out.write("        \n");
      out.write("        <link rel=\"icon\" href=\"images/b.png\" type=\"image/x-icon\" />\n");
      out.write("        <link rel=\"shortcut icon\" href=\"images/b.png\" type=\"image/x-icon\" /> \n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/font-awesome.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/dataTables.bootstrap4.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/styleSheet.css\" />\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        <div style=\"right: 0px; bottom: 0px; position: absolute; z-index: -1; opacity: 0.2\">\n");
      out.write("            <img src=\"images/background1.jpg\">\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"navbar navbar-default navbar-fixed-top\" style=\"background-color: #caebf2\">\n");
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
      out.write("                <div id=\"sidebar\">\n");
      out.write("                    <br>\n");
      out.write("                    <br>\n");
      out.write("                    <ul class=\"nav list-group\">\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/dashboard.jsp\" class=\"sidebarA\">\n");
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
      out.write("                            <a href=\"/BillManager/payment.jsp\" class=\"sidebarA\" style=\"background-color: #F7F7F7; font-weight: bold\">\n");
      out.write("                                <i class=\"fa fa-credit-card fa-fw\" aria-hidden=\"true\"></i>Payment</a>\n");
      out.write("                        </li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <div style=\"position: fixed; bottom: 10px; padding: 0px 10px;\"><p style=\"font-size: 0.7em; font-style: italic; margin: 0\">Copyright &copy; 2015 Bill Manager</p></div>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <!-- Content -->\n");
      out.write("            <div id=\"main-wrapper\" class=\"col-md-10 pull-right\">\n");
      out.write("                <div id=\"main\">\n");
      out.write("                    <div class=\"page-header\">\n");
      out.write("                        <h3>Payment</h3>\n");
      out.write("                        <button class=\"btn pull-right pinkBtn\" style=\"margin-top: -40px\" onclick=\"location.href='/BillManager/paymentadd.jsp'\">Add Payment</button>\n");
      out.write("                    </div>\n");
      out.write("                    \n");
      out.write("                    <table id=\"myTable\" class=\"table table-striped\" >  \n");
      out.write("                        <thead>  \n");
      out.write("                            <tr>  \n");
      out.write("                                <th>ID</th>\n");
      out.write("                                <th>Ref. No.</th>  \n");
      out.write("                                <th>Auditor</th>\n");
      out.write("                                <th>Payment Type</th>  \n");
      out.write("                                <th>Paid by</th>  \n");
      out.write("                                <th>Amount</th>\n");
      out.write("                            </tr>  \n");
      out.write("                        </thead>  \n");
      out.write("                        \n");
      out.write("                        <tbody>  \n");
      out.write("                        ");

                            try{
                                stat = connect.prepareStatement("SELECT `paymentID`,`payRefNo`,CONCAT(`employeeFName`,' ',`employeeLName`) as auditName, " + 
                                    "`payTypeName`,`companyName`,`payAmount` FROM payment " + 
                                    "LEFT JOIN company ON payBy = comID " + 
                                    "LEFT JOIN employee ON auditor = employeeID " + 
                                    "LEFT JOIN payment_type ON payType = payTypeID " + 
                                   "ORDER BY paymentID DESC;");
                                result = stat.executeQuery();
                            } catch (SQLException e){
                                e.printStackTrace();
                            }

                            while(result.next()) {
                                out.print("<tr>");
                                out.println("<td>" + result.getString("paymentID") + "</td>");
                                out.println("<td>" + result.getString("payRefNo") + "</td>");
                                out.println("<td>" + result.getString("auditName") + "</td>");
                                out.println("<td>" + result.getString("payTypeName") + "</td>");
                                out.println("<td>" + result.getString("companyName") + "</td>");
                                out.println("<td>" + result.getString("payAmount") + "</td>");
                                
                                out.println("</tr>");
                            }
                        
      out.write("\n");
      out.write("                        </tbody>  \n");
      out.write("                    </table>  \n");
      out.write("                    \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <script src=\"css/jquery.min.js\"></script>\n");
      out.write("        <script src=\"css/bootstrap.min.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"css/jquery.dataTables.min.js\"></script>s\n");
      out.write("        <script type=\"text/javascript\" src=\"css/dataTables.bootstrap4.min.js\"></script>\n");
      out.write("        \n");
      out.write("        <script>\n");
      out.write("            $(document).ready(function(){\n");
      out.write("                $('#myTable').dataTable();\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
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
