
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(281))
	{
               %>
                <%@ include file ="../logouterror.jsp" %>
                  <%
                    session.invalidate();
                       request.getSession(true).setAttribute("lang",defLangId);
              }
	else
	{
		
			lbsManager lbManage = new lbsManager();
			ArrayList lbsConfigAl  = new ArrayList();
		
		  String name = request.getParameter("name");
			int i = lbManage.getLBSConfig(lbsConfigAl,name);
%>

<%@ include file = "../pagefile/header.html" %>

  <form name="form" method="post" action="modifyLBS.jsp" onSubmit="return validate()">
      <table width="70%" border="1" align="center">
        <tr class="tableheader"<td colspan="2">LBS Configuration - Modify </td></tr>
		<%
		     for(int x=0; x<lbsConfigAl.size();x++)
				 {
								 lbs lb = (lbs) lbsConfigAl.get(x);
		%>		
        <tr class="tfield">
            <input type="hidden" name="processName" value = "<%=lb.getProcessName()%>" >
						<input type="hidden" name="packageName" value = "<%=lb.getPackageName()%>" >
						 
            <td width="30%" > Process Name </td>
            <td ><input type="text" name="processName1" value = "<%=lb.getProcessName()%>" disabled>  </td>
        </tr>
				<tr class="tfield">
							<td width="30%" >PAckage NAme</td>
							<td ><input type="text" name="packageName1" value = "<%=lb.getPackageName()%>" disabled> </td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Min Arguments </td>
							<td ><input type="text" name="minArg" value = "<%=lb.getMinArg()%>" onkeypress="return numberOnly(event)" >	</td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Max Arguments</td>
							<td ><input type="text" name="maxArg" value = "<%=lb.getMaxArg()%>" onkeypress="return numberOnly(event)" ></td>
				</tr>
				<tr class="tfield">
							<td width="30%" >Syntax Message</td>
							<td ><input type="text" name="syntax" value = "<%=lb.getSyntax()%>" ></td>
				</tr>
				<tr class="button1">
							<td colspan="2">  <input type="submit" name="submit" value="Submit"><input type="reset" name="clear" value="Clear"></td>
				</tr>
		<% 
				}
		%>				
        </table>
      </form>
        <script language="JavaScript">
		<!--
		document.form.minArg.focus();
		//-->
	</script>

<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
