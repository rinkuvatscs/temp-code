<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2010) )
{
%>
    <%@ include file ="../logouterror.jsp" %>
<%
}
else
{
%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>

     <table width="80%" border="0" align="center">
					
        <tr class="tableheader"><td > <%=TSSJavaUtil.instance().getKeyValue("pmTop",defLangId)%><br><br> </td></tr>
  <tr><td class="tfields"> <%=TSSJavaUtil.instance().getKeyValue("pmPack",defLangId)%></td></tr>
<%
		if(sessionHistory.isAllowed(2011) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="promopack_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("pmaddpack",defLangId)%></a><br><br> </td>
        </tr>
	<%
		}
		if(sessionHistory.isAllowed(2012) )
		{
%>
        <tr class="homemenu" >
           <td ><a href="promopack_manage.jsp"><%=TSSJavaUtil.instance().getKeyValue("pmManage",defLangId)%></a><br><br> </td>
        </tr>
								<%
								}
				%>				
				
  <tr><td class="tfields"><%=TSSJavaUtil.instance().getKeyValue("pmoffer",defLangId)%></td></tr>
				<%
		if(sessionHistory.isAllowed(2014) )
		{
								%>
        <tr class="homemenu" >
           <td ><a href="promo_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("pmoffercreate",defLangId)%></a><br><br> </td>
        </tr>
  <%
		}
		if(sessionHistory.isAllowed(2015) )
		{
				
		%>
		<tr class="homemenu" >
           <td ><a href="promooffer_manage.jsp"><%=TSSJavaUtil.instance().getKeyValue("showpromo",defLangId)%></a><br><br> </td>
        </tr>
		<%
		}
		%>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
