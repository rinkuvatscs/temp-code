
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(140))
	{
        %>
         <%@ include file ="../logouterror.jsp" %>
           <%
             session.invalidate();
                request.getSession(true).setAttribute("lang",defLangId);
        }
	else
	{
%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>

   <table border="0" width="80%" align="center" >

			 <tr><td colspan="2" class="tableheader"><%=TSSJavaUtil.instance().getKeyValue("prepostrule",defLangId)%><br><br> </td></tr>
            
			 <tr><td class="homemenu"><a href="prePostClass_view.jsp"><%=TSSJavaUtil.instance().getKeyValue("viewprepost",defLangId)%></a><br><br></td></tr>
			 
			 
 <%
	if(sessionHistory.isAllowed(142))
	{
%>
        <tr><td class="homemenu">  <a href="prePostClass_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("addprepost",defLangId)%></a><br> <br></td></tr>
<%
   }
  if(sessionHistory.isAllowed(143))
	{
%>
        <tr><td class="homemenu"> <a href="prePostClass_manage.jsp"><%=TSSJavaUtil.instance().getKeyValue("modifyprepost",defLangId)%></a><br> <br>  </td></tr>
<%
	}
%>
 </table>
 
<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>
