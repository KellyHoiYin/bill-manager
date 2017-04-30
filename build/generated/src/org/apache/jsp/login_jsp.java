package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.sql.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


        String url = "jdbc:mysql://localhost:3306/billmanage";
        String USERNAME = "root";
        String password = "1234";
                
        Connection connect = null;
        PreparedStatement stat = null;
        ResultSet result = null;


        public boolean authentication(String u, String p, String correctUser, String correctPass){
            if(u.equals(correctUser) && p.equals(correctPass)){
                return true;
            } else {
                return false;
            }
        }

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
      out.write("\n");
      out.write("\n");
 Class.forName("com.mysql.jdbc.Driver"); 
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');

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

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n");
      out.write("        \n");
      out.write("        <title>Login</title>\n");
      out.write("        \n");
      out.write("        <link rel=\"icon\" href=\"images/b.png\" type=\"image/x-icon\" />\n");
      out.write("        <link rel=\"shortcut icon\" href=\"images/b.png\" type=\"image/x-icon\" /> \n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/styleSheet.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/font-awesome.min.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"navbar navbar-default navbar-fixed-top\" style=\"background: #ACC8E5; background: linear-gradient(to bottom right, #caebf2, #98B0DC, #3D47B4); box-shadow: inset 0 0 30px grey; \">\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <a class=\"navbar-brand\" href=\"/BillManager/login.jsp\" style=\"font-size: 1.5em; font-weight: bold; color: #5A5A5A\">\n");
      out.write("                    Bill Manager\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"row\" style=\"margin: 5px 0\">\n");
      out.write("            <div class=\"col-md-7\" style=\"padding: 0\">\n");
      out.write("                <img src=\"images/loginbg.jpg\" style=\"height: 760px; width: 100%\">\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div id=\"main-wrapper\" class=\"col-md-5\" style=\"margin: 45px 0; padding: 50px 70px; box-shadow: inset 0 0 30px grey; height: 710px\" >\n");
      out.write("                <form class=\"form-signin\" action=\"/BillManager/login.jsp\" method=\"POST\" role=\"form\">\n");
      out.write("                    <h2>Sign In</h2>\n");
      out.write("                    <div class=\"input-group\" style=\"margin: 5px\">\n");
      out.write("                        <span class=\"input-group-addon\"><i class=\"fa fa-envelope-o fa-fw\"></i></span>\n");
      out.write("                        <input class=\"form-control\" style=\"margin: 0\" type=\"email\" name=\"username\"\n");
      out.write("                               ");
 
                            if(username == null){
                                out.print("placeholder=\"Email\"");
                            } else {
                                out.print("value=\"" + username + "\"");
                            }
                           
      out.write(" required autofocus>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"input-group\" style=\"margin: 5px\">\n");
      out.write("                        <span class=\"input-group-addon\"><i class=\"fa fa-key fa-fw\"></i></span>\n");
      out.write("                        <input class=\"form-control\" style=\"margin: 0\" type=\"password\" name=\"password\" placeholder=\"Password\" required>\n");
      out.write("                    </div>\n");
      out.write("                    ");
 if(error) { 
      out.write("\n");
      out.write("                    <span style=\"font-size: 15px; color: red; margin-left: 10px\"><i>");
      out.print( errorMsg );
      out.write("</i></span>\n");
      out.write("                    ");
 } 
      out.write("\n");
      out.write("                    <br>\n");
      out.write("                    <button class=\"btn pinkBtn\" style=\"width: 97%\" align=\"center\" type=\"submit\">Sign in</button>\n");
      out.write("                </form>\n");
      out.write("                <div style=\"position: fixed; bottom: 10px; right: 0; padding: 0px 10px;\"><p style=\"font-size: 0.7em; font-style: italic; margin: 0\">Copyright &copy; 2017 Bill Manager</p></div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <script src=\"css/jquery.min.js\"></script>\n");
      out.write("        <script src=\"css/bootstrap.min.js\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write(" ");
 } else { 
            session.setAttribute("loginName", name);
            session.setAttribute("admin", isAdmin);
                
            response.sendRedirect("/BillManager/dashboard.jsp");
        }
        
        } catch (Exception e){
            e.printStackTrace();
        }
        
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
