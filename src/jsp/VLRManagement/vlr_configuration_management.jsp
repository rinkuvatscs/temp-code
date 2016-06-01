
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    %>
     <%@ include file ="../logouterror.jsp" %>
       <%
         session.invalidate();
            request.getSession(true).setAttribute("lang",defLangId);
             }

else
{
	VLRManager vlrManager = new VLRManager();
	ArrayList vlrConfigAl = new ArrayList();
	int config_count = vlrManager.viewVLRConfig(vlrConfigAl);

%>
<HTML>
<HEAD>
<TITLE>VLR Configuration & Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

</HEAD>
<%@ include file = "../pagefile/header.html" %>
     

			<table width="70%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		     <tr><td colspan="5" class="tableheader"> VLR Configuration <br><br> </td></tr>
   					<tr class="tfields">
						<td width="10%" > VLR Name   </td>
						<td width="30%" > Description </td>
						<td width="10%" > Enabled     </td>
						<td width="10%" >Modify   </td>
						<td width="10%" >Delete   </td>
			</tr>
				 <%
						if (config_count <= 0 || vlrConfigAl.size()<=0 )
						{
				 %>
				 	<tr class="notice"><td colspan="5" align="center">VLR Configuration not Available</td></tr>
				 <%}
				  else
					{
						for(int i=0;i<vlrConfigAl.size();i++)
						{
									VLR vlr_config = (VLR) vlrConfigAl.get(i);
					%>
					<tr class="tabledata">
							<td ><%=vlr_config.getVlrId() %></td> 
							<td ><%=vlr_config.getDescription() %></td> 
							<td  align="center"><%=vlr_config.getEnabled() %></td> 
							<td align="center"><a href="vlr_modify.jsp?num=<%=vlr_config.getVlrId()%>">Modify</a> </td>
							<td align="center"><a href="vlr_modify_delete.jsp?num=<%=vlr_config.getVlrId()%>&id=del">Delete</a> </td>
					</tr>		
       	<%
						}//for
					}//else
				%>
	 </table>

			 
<%@ include file = "../pagefile/footer.html" %>  

<% } %>
