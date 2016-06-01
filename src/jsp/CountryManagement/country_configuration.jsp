
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
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
//				int pageno=Integer.parseInt(request.getParameter("pageno") );
		CountryManager countryManager = new CountryManager();
          countryManager.setConnectionPool(conPool);
		ArrayList countryConfigAl = new ArrayList();

		int total_count = countryManager.viewCountryConfig(countryConfigAl);

//		int showing = pageno * 10;

%>

<html>
 <head>
	<title>Country Configuration</title>
	<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css">
  	
 </head>

 <%@ include file="../pagefile/header.html" %>

    	<table width="80%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		     <tr><td colspan="8" class="tableheader">Country  Configuration <br><br> </td></tr>
   					<tr class="tfields">
						<td width="5%" > Country Code   </td>
						<td width="25%" > Country Name</td>
						<td width="10%" > CC   </td>
						<td width="10%" >MCC   </td>
						<td width="5%" >InRoam  </td>
						<td width="5%" >OutRoam </td>
						<td width="10%">Modify  </td>
						<td width="10%">Delete  </td>
			</tr>
				 <%
						if (total_count <= 0 || countryConfigAl.size()<=0 )
						{
				 %>
					<tr><td  >&nbsp; </td> </tr>
				 	<tr class="notice"><td colspan="7">Country Configuration not Available</td></tr>
				 <%}
				  else
					{
						for(int i=0;i<countryConfigAl.size();i++)
								{
										Country country_config = (Country) countryConfigAl.get(i);
//										showing++;
					%>
					<tr class="tabledata">
							<td align="center"><%=country_config.getCode() %></td> 
							<td ><%=country_config.getName() %></td> 
							<td  align="center"><%=country_config.getCc() %></td> 
							<td  align="center"><%=country_config.getMcc() %></td> 
							<td  align="center"><%=country_config.getInbound() %></td> 
							<td  align="center"><%=country_config.getOutbound() %></td> 
							<td align="center"><a href="country_modify.jsp?name=<%=country_config.getName()%>&mcc=<%=country_config.getMcc()%>">Modify</a> </td>
							<td align="center"><a href="country_modify_delete.jsp?mcc=<%=country_config.getMcc()%>&id=del">Delete</a> </td>
					</tr>		
       	<%
							}//for
					}//else
				%>
	 </table>
	 
		
<%@ include file = "../pagefile/footer.html" %>  
<%
 }
 %>




	
