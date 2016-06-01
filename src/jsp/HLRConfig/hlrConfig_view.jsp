
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(280))
	{
        %>
          <%@ include file ="logouterror.jsp" %>
             <%
                 session.invalidate();
                   request.getSession(true).setAttribute("lang",defLangId);
        }
	else
	{
		HLRManager hlrManager = new HLRManager();
           hlrManager.setConnectionPool(conPool);
		HLR hlr = new HLR();
		ArrayList hlrConfigAl = new ArrayList();
		int hlrId=Integer.parseInt(request.getParameter("id"));
		
		int i = hlrManager.getHLRConfig(hlrConfigAl, hlrId);
		
%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>

     <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
        <tr class="tableheader"><td colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("HLR_Configuration",defLangId)%> <br><br></td></tr>
         <%
				 if( i < 0 || hlrConfigAl.size() <= 0)
				 {
				 %>
				 <tr class="notice"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("some_Error",defLangId)%></td></tr>
				 <%
				 }
				 else
				 {
								 for(int k = 0; k< hlrConfigAl.size(); k++)
								 {
												 hlr = (HLR) hlrConfigAl.get(k);
				 %>
				 <tr>
            <td class="tfield1"  ><%=TSSJavaUtil.instance().getKeyValue("Name",defLangId)%> </td>
            <td  class="tfield"> <%= hlr.getHLRName()%> </td>
          </tr>
          <tr >
            <td  class="tfield1" ><%=TSSJavaUtil.instance().getKeyValue("Server_IP",defLangId)%> </td>
            <td  class="tfield"><%=hlr.getHLRIp() %> </td>
          </tr>
          <tr >
            <td class="tfield1"  ><%=TSSJavaUtil.instance().getKeyValue("Server_Port",defLangId)%> </td>
            <td  class="tfield"><%=hlr.getHLRPort() %> </td>
          </tr>
          <tr >
            <td class="tfield1"  > <%=TSSJavaUtil.instance().getKeyValue("login",defLangId)%> </td>
            <td  class="tfield"><%=hlr.getLogin() %> </td>
          </tr>

<!--          <tr >
            <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("password",defLangId)%> </td>
            <td  class="tfield"><%=hlr.getPassword() %> </td>
          </tr>
 -->
          <tr >
            <td class="tfield1"  >Number of Simultaneous Connections Allowed </td>
            <td  class="tfield"> <%= hlr.getConnection()%> </td>
          </tr>
				<%
								 }//for
				 } //else
				%>	
     </table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
