	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(160))
{
 %>
  <%@ include file ="../logouterror.jsp" %>
    <%
      session.invalidate();
         request.getSession(true).setAttribute("lang",defLangId);
          }
 
else
{
           %>
                    <%@ include file="../lang.jsp" %>
                             <%

	ServicePromotionManager	serviceManager = new ServicePromotionManager();
         serviceManager.setConnectionPool(conPool);
	int ret = -1;
	ret = serviceManager.isContentEnabled();

%>

<%@ include file = "../pagefile/header.html" %>

    <form name="form1" method="post" action="contentpromo_execute.jsp">
       <table width="70%" border="0" cellspacing="2" align="center">
          <tr class="tableheader">
            <td colspan="2">Send Content Promotional SMS<br><BR> </td>
          </tr>
<%
    if ( ret < 0)
		{
%>
          <tr class="notice">
        	   <td colspan="2">  There is some error in Data Retrieval. Please Try again Later!!! </td>
					</tr>
<%
		}
		else if (ret == 0)
		{
%>
          <tr class="tfield1">
        	   <td colspan="2">  <input type="radio"  name="subs" value="1" size="1" checked>Enable Content Promotion SMS </td>
					</tr>
<%
		}
		else if (ret == 1)
		{
%>
          <tr class="tfield1">
        	   <td > <input type="radio"  name="subs" value ="0" size="1" checked>Disable Content Promotion SMS </td>
          </tr>
<%
		}
%>
          <tr class="button1">
         		  <td align="left"><BR> <input type="submit" name="Submit" value="Submit"> </td>
          </tr>
					
        </table>
      </form>
<%@ include file = "../pagefile/footer.html"%>

<%
}
%>
