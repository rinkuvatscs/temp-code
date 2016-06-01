
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*"%>
<%@ page import = "com.telemune.webadmin.webif.*"%>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("viralsms.jsp");
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
			ServicePromotionManager serviceManager = new ServicePromotionManager();
			serviceManager.setConnectionPool(conPool);
			int ret = -1;
			
			ret = serviceManager.isViralEnabled();
			logger.info("Viral SMS= "+ret);
			
%>
<html>
<head>
<script type="text/javascript">
function validate()
{
	var calls = document.forms.form.calls.value
	if (calls == "")
	{
		alert("Please enter number of calls")
		return false
	}
	if (calls < 50)
	{
		alert("Minimum number of calls should be 50")
		return false
	}
}
</script>
</head>

<%@ include file = "../pagefile/header.html" %>
      
			<form name="form" method="post" action="viralsms_execute.jsp" onSubmit="return validate()">
        <table width="80%" border="0" cellspacing="0" align="center">
          <tr class="tableheader">
            <td colspan="2">Send Viral SMS <br><bR> </td>
          </tr>
<%
		if (ret < 0)
		{
%>
          <tr class="notice">
            <td colspan="2" ><p> Neccessary Data Not Found, Please Try Again Later!!!.<br> Go to <a href="../home.jsp">Main Menu</a></p> 	</td>
          </tr>
<%
		}
		else if (ret == 0)  //Viral SMS is Disabled; enable it
		{
%>
          <tr class="tfield1">
            <td colspan="2" >  <input type="radio"  name="subs" value="1" size="1" checked>&nbsp; Enable Viral SMS</td>
          </tr>
          <tr class="tfield1">
            <td >Send SMS after calls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="text" name="calls" onkeypress="return numberOnly(event)"> </td>
          </tr>
          <tr class="button1">
            <td  colspan="2"><br> <input type="submit" name="Submit" value="Submit"> <input type="reset" name="Submit2" value="Clear"> </td>
          </tr>
<%
		}
		else if (ret == 1) //viral SMS is enabled; disable it
		{
%>
          <tr class="tfield1">
            <td valign="middle" >  <input type="radio"  name="subs" value ="0" size="1" checked >&nbsp; Disable Viral SMS &nbsp;
              <input type="submit" name="Submit" value="Submit">  </td>
          </tr>
<%
		}
%>
					
        </table>
     </form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%
	}
%>
