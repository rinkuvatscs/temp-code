
<%@ page import="com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>

<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory ==null || !sessionHistory.isAllowed(143) )
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
<html>
<head>
		<script type="text/javascript">
		function validate()
		{
			var name = document.forms.form.name.value
			var mesg =  document.forms.form.message.value

			if(name == "" || mesg =="")
			{
							alert("Enter All Fields");
							return false
			}
			return true;
	 }		
		</script>
		
</head>
</html>

<%@ include file = "../pagefile/header.html" %>
  
 <form name="form" action="addGMAT.jsp"	method="post" onSubmit="return validate()" >
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr class="tableheader"><td colspan="2">GMAT HELP MASTER </td></tr>

			<tr class="tfield">
			   <td>Process Name</td>
				 <td> <input type="text" name="name"></td>
		 </tr>		 	
			<tr class="tfield">
			   <td>Help Message </td>
				 <td> <textarea  name="message" cols="40" rows="10" maxlength="400" onkeypress="return disableReturnKey(event)"></textarea></td>
		 </tr>		 	
			<tr class="tfield">
			   <td>Language Id</td>
				 <td> <input type="text" name="language" maxlength="3" onkeypress="return numberOnly(event)"></td>
		 </tr>		 
		 <tr class="button1">
		      <td colspan="2"><input type="submit" name="submit" Value="Add Gmat"> <input type="reset" name="reset" Value="Reset"></td>
		 </tr>			
	
	</table>	 			
 </form>
 
<%@ include file = "../pagefile/footer.html" %>
 <%
		}
 %>	
			
	
