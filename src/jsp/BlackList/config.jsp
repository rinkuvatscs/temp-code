
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(320))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
//			String url = response.encodeRedirectURL("../logouterror.jsp");
//			response.sendRedirect(url);
}
else
{
    BlackListManager blacListManager  = new BlackListManager();
   blacListManager.setConnectionPool(conPool);
		ArrayList blackListAl = new ArrayList();

		int i  = blacListManager.viewBlackList(blackListAl,"xx","xx");  //viewBlackList(ArrayList,imsi,msisdn)
                                                                    //get all values
		long arr = blackListAl.size();

		
				
%>

<%@ include file="../pagefile/header.html" %>

   <table border"1" width="80%" align="center">

     <tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("manBllist")%></td></tr>

		 <tr class="tfields">
		    <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("imsi")%></td>
				<td width="15%"><%=TSSJavaUtil.instance().getKeyValue("msisdn")%></td>
				<td width="15%"><%=TSSJavaUtil.instance().getKeyValue("expDate")%></td>
				<td width="30%"><%=TSSJavaUtil.instance().getKeyValue("remarks")%></td>
		<%
		  if (sessionHistory.isAllowed(323) )
			{
		%>		
				<td ><%=TSSJavaUtil.instance().getKeyValue("modify")%></td>
		<%
			}
		  if (sessionHistory.isAllowed(323) )
			{
		%>		
				<td ><%=TSSJavaUtil.instance().getKeyValue("delete")%></td>
		<%
			}
	  %>		
		</tr>
		<%
        if(arr<=0 || i <= 0)
				{
		%>
		  <tr class="notice"><td colspan="6" align="center"><%=TSSJavaUtil.instance().getKeyValue("nobldata")%></td></tr>
		<%
				}
				else
				{
								for(int x=0;x<arr;x++)
								{
												BlackList blackList = (BlackList) blackListAl.get(x);
				
	  %>
		 <tr class="tabledata_center">
		     <td align="left"><%=blackList.getImsi()%></td>
				 <td align="left"><%=blackList.getMsisdn()%></td>
				 <td><%=blackList.getExDate()%></td>
				 <td align="left"><%=blackList.getRemark()%></td>
		<%
		  if (sessionHistory.isAllowed(323) )
			{
		%>		
				 <td><a href="modify.jsp?imsi=<%=blackList.getImsi()%>&msisdn=<%=blackList.getMsisdn()%>"><%=TSSJavaUtil.instance().getKeyValue("modify")%></a></td>
		<%
			}
		  if (sessionHistory.isAllowed(323) )
			{
		%>		
				 <td><a href="manage.jsp?id=del&imsi=<%=blackList.getImsi()%>&msisdn=<%=blackList.getMsisdn()%>"><%=TSSJavaUtil.instance().getKeyValue("delete")%></a></td>
		<%
			}
		%>	
		</tr>		
		<% 
								}
				}
		%>
				 
   </table>

<%@ include file="../pagefile/footer.html" %>

<%

}
%>
