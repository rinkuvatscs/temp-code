

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
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

%>
<%@ include file="../lang.jsp" %>
<%@ include file = "pagefile/headerHome.html" %>

    <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
    <tr class="t1">
      <td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("home1",defLangId)%> </td></tr>

   </table>
</table>
<%@ include file = "pagefile/footer.html" %>
<%
 }

%>

