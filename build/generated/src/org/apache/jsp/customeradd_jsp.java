package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import classes.*;

public final class customeradd_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n");
      out.write("        \n");
      out.write("        <title>Add Customer</title>\n");
      out.write("        \n");
      out.write("        <link rel=\"icon\" href=\"images/b.png\" type=\"image/x-icon\" />\n");
      out.write("        <link rel=\"shortcut icon\" href=\"images/b.png\" type=\"image/x-icon\" /> \n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/styleSheet.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/font-awesome.min.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
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
      out.write("        ");

            Company com = new Company();
        
      out.write("\n");
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
      out.write("                            <a href=\"/BillManager/customer.jsp\" class=\"sidebarA\" style=\"background-color: #F7F7F7; font-weight: bold\">\n");
      out.write("                                <i class=\"fa fa-users fa-fw\" aria-hidden=\"true\"></i>Customer</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"/BillManager/payment.jsp\" class=\"sidebarA\">\n");
      out.write("                                <i class=\"fa fa-credit-card fa-fw\" aria-hidden=\"true\"></i>Payment</a>\n");
      out.write("                        </li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <div style=\"position: fixed; bottom: 10px; padding: 0px 10px;\"><p style=\"font-size: 0.7em; font-style: italic; margin: 0\">Copyright &copy; 2015 Bill Manager</p></div>\n");
      out.write("                    \n");
      out.write("            <div style=\"right: 0px; bottom: 0px; position: absolute; z-index: -1; opacity: 0.3\">\n");
      out.write("                    <img src=\"images/sidebg.png\">\n");
      out.write("            </div>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <!-- Content -->\n");
      out.write("            <div id=\"main-wrapper\" class=\"col-md-10 pull-right\">\n");
      out.write("                <div id=\"main\">\n");
      out.write("                    <div class=\"page-header\">\n");
      out.write("                        <h3>Customer > Add</h3>\n");
      out.write("                        <button class=\"btn pull-right pinkBtn\" style=\"margin-top: -40px\" onclick=\"location.href='/BillManager/customer.jsp'\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"Go back to the previous page\">Cancel</button>\n");
      out.write("                    </div>\n");
      out.write("                    \n");
      out.write("                    <form id=\"addcus\" action=\"/BillManager/customeradd.jsp\" method=\"POST\" role=\"form\" onsubmit=\"sub()\"> \n");
      out.write("                        <div class=\"form-inline\">\n");
      out.write("                            Company Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("                            <input type=\"text\" class=\"form-control\" name=\"name\" placeholder=\"Company name\" style=\"width: 30%\" required>\n");
      out.write("                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("                            Company Office No.: \n");
      out.write("                            <input type=\"text\" class=\"form-control\" name=\"phone\" placeholder=\"Office No. (03-xxxx xxxx)\" style=\"width: 30%\" required>\n");
      out.write("                            <br>\n");
      out.write("                            Company Address:&nbsp;\n");
      out.write("                            <input type=\"text\" class=\"form-control\" name=\"address\" placeholder=\"Company Address\" style=\"width: 75%\" required>\n");
      out.write("                            <br>\n");
      out.write("                            Company GST No.:\n");
      out.write("                            <input type=\"text\" class=\"form-control\" name=\"gst\" placeholder=\"Company GST No.\" style=\"width: 30%\" required>\n");
      out.write("                            <br>\n");
      out.write("                            <p style=\"vertical-align: top; display: inline-block; padding: 5px 82px 5px 0px\">Notes:</p>\n");
      out.write("                            <textarea class=\"form-control\" name=\"notes\" rows=\"4\" cols=\"50\" placeholder=\"Notes\"></textarea>\n");
      out.write("                            <br>\n");
      out.write("                            <label style=\"padding: 0 62px 0 0; font-weight: normal\">Category:</label>\n");
      out.write("                            <span class=\"form-inline\" id=\"categoryDiv\"></span>\n");
      out.write("                            <select id=\"cat\" name=\"cat\" class=\"form-control\">\n");
      out.write("                            ");
 
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
                            
      out.write("\n");
      out.write("                            </select>\n");
      out.write("                            <a onclick=\"addCat()\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"Add Category\"><span class=\"glyphicon glyphicon-plus-sign\" style=\"font-size: 23px; color: #FF595D; top: 8px\"></span></a>\n");
      out.write("                            <br>\n");
      out.write("                            <label style=\"padding: 0 30px 0 0; font-weight: normal\">Contact Person:</label>\n");
      out.write("                            <a onclick=\"addContact()\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"Add Contact Person Form\">\n");
      out.write("                                <span class=\"glyphicon glyphicon-plus-sign\" style=\"font-size: 23px; color: #FF595D; top: 8px\"></span></a>\n");
      out.write("                            <span class=\"form-inline\" id=\"contactDiv\"></span>\n");
      out.write("                        </div>\n");
      out.write("                        <hr>\n");
      out.write("                        <div>\n");
      out.write("                            <input type=\"hidden\" id=\"conCount\" name=\"conCount\" value=''>\n");
      out.write("                            <input type=\"hidden\" id=\"catsValue\" name=\"catsValue\" value=''>\n");
      out.write("                            <button class=\"btn pinkBtn pull-right\" style=\"width: 20%\" type=\"submit\" name=\"save\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Save customer\">Add Customer</button>\n");
      out.write("                        </div>\n");
      out.write("                    </form>\n");
      out.write("                    \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <script>\n");
      out.write("            var count = 0;\n");
      out.write("            var cats = [];\n");
      out.write("            \n");
      out.write("            function addCat() {\n");
      out.write("                var selector = document.getElementById(\"cat\");\n");
      out.write("                var index = selector.selectedIndex;\n");
      out.write("                var selected = selector.options[selector.selectedIndex].text;\n");
      out.write("                var value = selector.options[selector.selectedIndex].value;\n");
      out.write("                selector.remove(selector.selectedIndex);\n");
      out.write("                \n");
      out.write("                var addedCat = document.createElement('SPAN');\n");
      out.write("                addedCat.setAttribute('style', 'padding: 0px 10px;');\n");
      out.write("                addedCat.setAttribute('id', 'spanCat' + selected);\n");
      out.write("                addedCat.innerHTML = selected + \"<a onclick=\\\"removeCat(\\'\" + index + \"\\',\\'\" + selected + \"\\')\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Remove Category\\\"><i class=\\\"fa fa-times\\\" aria-hidden=\\\"true\\\"></i></a>\";\n");
      out.write("                \n");
      out.write("                var element = document.getElementById(\"categoryDiv\");\n");
      out.write("                element.appendChild(addedCat);\n");
      out.write("                cats.push(value);\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            function removeCat(i, s){\n");
      out.write("                var str = \"spanCat\" + s;\n");
      out.write("                var element = document.getElementById(str);\n");
      out.write("                element.outerHTML = \"\";\n");
      out.write("                delete element;\n");
      out.write("                \n");
      out.write("                var selector = document.getElementById(\"cat\");\n");
      out.write("                var opt = document.createElement('option');\n");
      out.write("                opt.value = s;\n");
      out.write("                opt.innerHTML = s;\n");
      out.write("                selector.appendChild(opt);\n");
      out.write("                \n");
      out.write("                var i = cats.indexOf(s);\n");
      out.write("                if(i != -1) {\n");
      out.write("                    cats.splice(i, 1);\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            function addContact() {\n");
      out.write("                var addDiv = document.createElement('DIV');\n");
      out.write("                addDiv.setAttribute('class', 'form-inline');\n");
      out.write("                addDiv.setAttribute('style', 'margin-left: 120px; padding: 15px;');\n");
      out.write("                addDiv.setAttribute('id', 'conDD' + count);\n");
      out.write("                addDiv.innerHTML = \"<a onclick=\\\"removeContact(\\'\" + count + \"\\')\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Remove Contact Person\\\"><i class=\\\"fa fa-times-circle fa-2x\\\" aria-hidden=\\\"true\\\" style=\\\"float:right; color: #FF595D;\\\"></i></a>\" + \n");
      out.write("                                \"First Name: &nbsp\" + \n");
      out.write("                                \"<input type=\\\"text\\\" class=\\\"form-control\\\" id=\\\"fname\" + count + \"\\\" name=\\\"fname\" + count + \"\\\" placeholder=\\\"First Name\\\" style=\\\"width: 30%\\\" required> \" + \n");
      out.write("                                \"Last Name: \" + \n");
      out.write("                                \"<input type=\\\"text\\\" class=\\\"form-control\\\" id=\\\"lname\" + count + \"\\\" name=\\\"lname\" + count + \"\\\" placeholder=\\\"Last Name\\\" style=\\\"width: 30%\\\" required> \" + \n");
      out.write("                                \"<br> \" + \n");
      out.write("                                \"Phone No.:&nbsp; \" + \n");
      out.write("                                \"<input type=\\\"text\\\" class=\\\"form-control\\\" id=\\\"phoneNo\" + count + \"\\\" name=\\\"phoneNo\" + count + \"\\\" placeholder=\\\"Phone No.\\\" style=\\\"width: 30%\\\" required> \" + \n");
      out.write("                                \"Fax No.:&nbsp;&nbsp;&nbsp;&nbsp; \" + \n");
      out.write("                                \"<input type=\\\"text\\\" class=\\\"form-control\\\" id=\\\"fax\" + count + \"\\\" name=\\\"fax\" + count + \"\\\" placeholder=\\\"Fax No.\\\" style=\\\"width: 30%\\\"> \" + \n");
      out.write("                                \"<br> \" + \n");
      out.write("                                \"Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \" + \n");
      out.write("                                \"<input type=\\\"email\\\" class=\\\"form-control\\\" id=\\\"email\" + count + \"\\\" name=\\\"email\" + count + \"\\\" placeholder=\\\"Email\\\" style=\\\"width: 40%\\\" required> \";\n");
      out.write("                var element = document.getElementById(\"contactDiv\");\n");
      out.write("                element.appendChild(addDiv);\n");
      out.write("                count = count + 1;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            function removeContact(i){\n");
      out.write("                var str = \"conDD\" + i;\n");
      out.write("                var element = document.getElementById(str);\n");
      out.write("                element.outerHTML = \"\";\n");
      out.write("                delete element;\n");
      out.write("                //count = count - 1;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            function sub(){\n");
      out.write("                document.getElementById(\"conCount\").value = count;\n");
      out.write("                document.getElementById(\"catsValue\").value = cats;\n");
      out.write("                document.getElementById(\"addcus\").submit();\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            </script>\n");
      out.write("            \n");
      out.write("        <script src=\"css/jquery.min.js\"></script>\n");
      out.write("        <script src=\"css/bootstrap.min.js\"></script>\n");
      out.write("        \n");
      out.write("        <script>\n");
      out.write("            $(document).ready(function(){\n");
      out.write("                $('[data-toggle=\"tooltip\"]').tooltip();   \n");
      out.write("            });\n");
      out.write("        </script>\n");
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
