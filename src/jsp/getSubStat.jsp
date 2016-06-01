

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "conPool.jsp" %>
<%
 SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
 if(sessionHistory == null )
 {
   %>
      <%@ include file ="../logouterrorhome.jsp" %>
           <%
           session.invalidate();
            request.getSession(true).setAttribute("lang",defLangId);
   }
 else
 {

	SubStat subSt = new SubStat() ;
       subSt.setConnectionPool(conPool);
	int no_sub=subSt.getSubStat();
%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "pagefile/headerHome.html" %>

			<table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">

			<tr class="tableheader">
      <td colspan="4" ><%=TSSJavaUtil.instance().getKeyValue("Subliencehead",defLangId)%><br><br> </td></tr>
<tr class="tfields" bgcolor="#a5c7d0">
              <td ><%=TSSJavaUtil.instance().getKeyValue("Sublience",defLangId)%></td>

      <td colspan="4" align="center" bgcolor="#a5c7c2"><b><%=no_sub%></b></td></tr>
   </table>
</table>
<%@ include file = "pagefile/footer.html" %>
<%
 }

%>

