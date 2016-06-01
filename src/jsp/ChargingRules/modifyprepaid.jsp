<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%-- Show welcome page to the user, verify whether the user has been authenticated or not--%>
<%--
	All authentication logic resides in this class
	This class also initializes a SubscriberProfile Object depending on profile
	of msisdn. This SubscriberProfile Object is then used later by other jsps
--%>
<%@ page import = "com.telemune.dbutilities.ConnectionPool" %>
<%@ page import = "com.telemune.crbtadmin.webif.AdminManagerUtil" %>
<%@ page import = "com.telemune.crbtadmin.webif.Charge" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.telemune.crbtadmin.webif.*" %>
<%@ page import = "org.apache.log4j.*" %>
 <%@ include file="../lang.jsp" %>
<%@ include file="../conpool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("modifyprepaid.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	ArrayList chargeAl = (ArrayList)session.getAttribute("chargeal");
	if(sessionHistory == null || !sessionHistory.isAllowed(161))
	{
           
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
				
                                  alert(<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>)
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
                logger.debug("Test2 in modifyprepaid.jsp");
		int i = adminManager.updateChargeData(newchargeAl, "pre");
		if(i < 0)
		{
		%>
			<script language="JavaScript">
				//alert("Error!!! Try again ")
				alert(<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>)
				window.location="charging_rules.jsp"
			</script>
		<%
		}
	else
	{
            session.setAttribute("chargeal", newchargeAl);
	%>
			<script language="JavaScript">
				//alert("Upadtion Successful!!!")
				 alert(<%=TSSJavaUtil.instance().getKeyValue("Upadtion_Successful",defLangId)%>)
				window.location="charging_rules.jsp"
			</script>
	<%
	}
}
%>
