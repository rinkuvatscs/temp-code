
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
						String x ="X";
						int l = -1;
					
						int a = gmatManager.getGMAT(gmatConfigAl,x,l);

						
%>
<%@ include file = "../pagefile/header.html" %>
  
	  <table width="80%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr class="tableheader"><td colspan="4">GMAT HELP MASTER </td></tr>

			<tr class="tfields">
			   <td>Process Name</td>
			   <td>Help Message</td>
			   <td>Language ID</td>
			   <td>Modify</td>
			</tr>
			
			<%
					for(int i=0; i< gmatConfigAl.size(); i++)
					{
									GMAT gmat = (GMAT) gmatConfigAl.get(i);
			
			%>	 
			<tr class="tabledata_center">
			   <td align="left"><%= gmat.getName()%></td>
			   <td align="left"><%= gmat.getMessage()%></td>
			   <td ><%= gmat.getLanguage()%></td>
				 <td ><a href="gmat_modify.jsp?name=<%=gmat.getName()%>&language=<%=gmat.getLanguage()%>">Modify</a></td>
			</tr>
			<%
					}
			%>
			
	</table>				
	
<%@ include file = "../pagefile/footer.html" %>
 <%
		}
 %>	
			
