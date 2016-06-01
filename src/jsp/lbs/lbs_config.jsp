 <%@ include file = "../conPool.jsp" %>
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
            lbManage.setConnectionPool(conPool); 
			ArrayList lbsConfigAl  = new ArrayList();
		  String y="X";
			int i = lbManage.getLBSConfig(lbsConfigAl,y);
%>

<%@ include file = "../pagefile/header.html" %>

      <table width="70%" border="1" align="center">
        <tr class="tableheader"<td colspan="6">LBS Configuration - Modify </td></tr>
        <tr class="tfields">
              <td width="20%"> Process Name </td>
							<td width="10%">Package Name</td>
							<td width="5%">Min Arguments </td>
							<td width="5%" >Max Arguments </td>
							<td width="30%"> Syntax</td>
							<td>Modify</td>
			 </tr>
		<%
		     for(int x=0; x<lbsConfigAl.size();x++)
				 {
								 lbs lb = (lbs) lbsConfigAl.get(x);
		%>		
			 	<tr class="tabledata_center">
				  <td align="left"><%=lb.getProcessName()%> </td>			
				  <td><%=lb.getPackageName()%> </td>			
				  <td><%=lb.getMinArg()%> </td>			
				  <td><%=lb.getMaxArg()%> </td>			
				  <td align="left"><%=lb.getSyntax()%> </td>			
					<td><a href="lbs_modify.jsp?name=<%=lb.getProcessName()%>">Modify</a></td>
				</tr>
		<% 
		      }
		%>		
			</table>		
 
<%@ include file = "../pagefile/footer.html" %>
<%
				
}
%>
