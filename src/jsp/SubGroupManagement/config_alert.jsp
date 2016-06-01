
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
}
else
{  
        SubGroupManager subGroupManager = new SubGroupManager();
        subGroupManager.setConnectionPool(conPool);
				 SubGroup subGroup = new SubGroup();
				 ArrayList subGroupAl = new ArrayList();

				 int i = -1;
				 i = subGroupManager.viewSubGroup(subGroupAl, 0);
				 

 %>
<HTML>
<HEAD>
<TITLE>Subscriber Group Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
     
		 <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="8">Subscriber Group Configuration</td></tr>
			<tr class="tfields">
			  <td width="10%">Group Name </td>
			  <td width="20%">Start Msisdn </td>
			  <td width="20%">End Msisdn </td>
			  <td width="10%">Modify </td>
			  <td width="10%">Delete </td>
      </tr>
			<% 
			       if(i<=0 || subGroupAl.size()<=0)
						 {
			%>
			 <tr class="notice"><td colspan="8">No Subscriber Group Found!!! </tD></tr>
			<%
						 }
						 else
										{
															for(int x =0;x<subGroupAl.size();x++)
															{
																			subGroup = (SubGroup) subGroupAl.get(x);

			%>
			<tr class="tabledata_center">
			  <td align="left"><%=subGroup.getGrpName()%> </td> 	
        <td ><%=subGroup.getStartMsisdn()%></td>	
        <td ><%=subGroup.getEndMsisdn()%></td>	
			  <td><a href="alert_modify.jsp?grpId=<%=subGroup.getGrpId()%>">Modify</a> </td> 	
			  <td><a href="alertModify.jsp?grpId=<%=subGroup.getGrpId()%>&id=del&grpName=<%=subGroup.getGrpName()%>">Delete</a> </td> 
			</tr>
			  <%
															}
										}
				%>
		</table>
	        	
<%@ include file = "../pagefile/footer.html" %>
<% 
}
%>	
			
	

				
