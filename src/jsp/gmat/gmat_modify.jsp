
<%@ page import="com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
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
						GMATManager gmatManager = new GMATManager();
                    gmatManager.setConnectionPool(conPool);
						ArrayList gmatConfigAl = new ArrayList();
						String name = request.getParameter("name");
 						int languageId = Integer.parseInt(request.getParameter("language") );
						
					
						int i = gmatManager.getGMAT(gmatConfigAl,name,languageId);

						
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
  
 <form name="form" action="modifyGMAT.jsp"	method="post" onSubmit="return validate()" >
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr class="tableheader"><td colspan="4">GMAT HELP MASTER </td></tr>
       <%
           if(i<0 || gmatConfigAl.size() <= 0 )
					 {
			 %>
			 <tr class="notice" >
			     <td colspan="2"> No Data found </td>
				</tr>
			<%
					 }
					 else
					 {
							for(int a=0; a< gmatConfigAl.size(); a++)
								{
										GMAT gmat = (GMAT) gmatConfigAl.get(a);
			
			%>	 
			<tr class="tfield">
				 <input type="hidden" name="name" value="<%=gmat.getName()%>" >
			   <td>Process Name</td>
				 <td><%=gmat.getName()%></td>

			</tr>
			<tr class="tfield">
			   <td>Help Message</td>
				 <td><textarea name="message" maxlength="400" onkeypress="return disableReturnKey(event)" ><%=gmat.getMessage()%></textarea></td>
			</tr>
			<tr class="tfield">
			   <td>language Id</td>
				 <td><input type="text" name="language" value="<%=gmat.getLanguage()%>" maxlength="3" readonly="1"  onkeypress="return numberOnly(event)"></td>
			</tr>
			<%
								}
					}
			%>
		 <tr class="button1">
		      <td colspan="2"><input type="submit" name="submit" Value="Add Gmat"> <input type="reset" name="reset" Value="Reset"></td>
		 </tr>			
			
		</table>
	</form>				

<%@ include file = "../pagefile/footer.html" %>
 <%
		}
 %>	
