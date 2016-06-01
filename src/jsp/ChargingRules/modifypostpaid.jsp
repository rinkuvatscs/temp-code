<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%-- Show welcome page to the user, verify whether the user has been authenticated or not--%>
<%--
	All authentication logic resides in this class
	This class also initializes a SubscriberProfile Object depending on profile
	of msisdn. This SubscriberProfile Object is then used later by other jsps
--%>
<%@ page import = "com.telemune.dbutilities.ConnectionPool" %>
<%@ page import = "com.telemune.crbtadmin.webif.*" %>
<%@ page import = "com.telemune.crbtadmin.webif.Charge" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "org.apache.log4j.*" %>

<%@ include file="../conpool.jsp" %>
<%
Logger logger = Logger.getLogger("modifypostpaid.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
ArrayList chargeAl = (ArrayList)session.getAttribute("chargeal");
if(sessionHistory == null || !sessionHistory.isAllowed(161))
{
    logger.debug(
    session.invalidate();
    request.getSession(true).setAttribute("lang",defLangId);
%>
    <jsp:forward page="/logouterror.html" />
<%
}
else
{
    if(adminManager == null)
    {
        session.invalidate();
         request.getSession(true).setAttribute("lang",defLangId);
%>
        <script language="JavaScript">
            alert("Error!!! Try Again")
            window.location="../index.html"
        </script>
<%
    }
    String paramValueArr[] = (String [])request.getParameterValues("paramvalue");
    ArrayList newchargeAl = new ArrayList();
    Iterator ite = chargeAl.iterator();
    int count = 0;
    while(ite.hasNext())
    {
        Charge charge = (Charge)ite.next();
        String inc = request.getParameter(charge.getParam());
        if(inc == null)
        {
            charge.setInclude("N");
        }
        else
        {
            charge.setInclude("Y");
        }
// Number is not float so add .0 in it              
        if(paramValueArr[count].indexOf('.') == -1)
        {
            paramValueArr[count] = paramValueArr[count]+".0";
        }
        charge.setParamValue(Float.parseFloat(paramValueArr[count]));
        newchargeAl.add(charge);
        count++;
    }
    int i = adminManager.updateChargeData(newchargeAl, "post");
    if(i < 0)
    {
%>
        <script language="JavaScript">
            alert("Error!!! Try again ")
            window.location="charging_rules.jsp"
        </script>
<%
    }
    else
    {
        session.setAttribute("chargeal", newchargeAl);
%>
        <script language="JavaScript">
            alert("Upadtion Successful!!!")
            window.location="../home.jsp"
        </script>
<%
    }
}
%>
