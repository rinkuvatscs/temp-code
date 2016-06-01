
<%@ page import="com.telemune.webadmin.webif.TSSJavaUtil"%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "pagefile/headerErrorHome.html" %>        

			<table width="70%" border="0" align="center">
			 <tr class="bluetext">  <td> <%=TSSJavaUtil.instance().getKeyValue("logoutnote1",defLangId)%> </td>		</tr>
				<tr class="notice">	  <td><%=TSSJavaUtil.instance().getKeyValue("logoutnote2",defLangId)%>  !!!</td>		</tr>	
			</table>	
					
<%@ include file = "pagefile/footer.html" %>
