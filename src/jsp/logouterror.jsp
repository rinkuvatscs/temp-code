
<%@ page import="com.telemune.webadmin.webif.TSSJavaUtil"%>
<%@ include file="../lang.jsp" %>

<%@ include file = "../pagefile/headerError.html" %> 

 
			<table border="0" width="70%" align="center">
				<tr >
				   <td class="bluetext"><%=TSSJavaUtil.instance().getKeyValue("logoutnote1",defLangId)%>  ! </td>
				</tr>	 
        <tr>
						 <td class="notice" ><%=TSSJavaUtil.instance().getKeyValue("logoutnote2",defLangId)%>  </td>
				</tr>

			</table>

<%@ include file = "../pagefile/footer.html" %>
