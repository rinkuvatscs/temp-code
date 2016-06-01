<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2020))
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
 <%
 RequestNewCrbt reqMan=new RequestNewCrbt();
  reqMan.setConnectionPool(conPool);
 ArrayList reqAl =  new ArrayList();
 int val = reqMan.viewRequest(reqAl);
 %>
  <%@ include file = "../pagefile/header.html" %>

  <table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">

  <tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("Rbt_Request",defLangId)%><br><br></td></tr>
  <%
  if( val < 0 )
  {
   %>
   <script language=javascript>
   alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
   history.go(-1)
   </script>
    <%
  }
  else if( reqAl == null)
  {
   %>
    <tr class="notice"><td colspan="6"><p>No rbt req</p></td></tr>
    <%
  }
  else
  {
   %>
    <tr class="tfields" bgcolor="#a5c7d0">
  <td ><%=TSSJavaUtil.instance().getKeyValue("MSISDN",defLangId)%></td>
 <td ><%=TSSJavaUtil.instance().getKeyValue("Music_Name",defLangId)%></td>
    <td ><%=TSSJavaUtil.instance().getKeyValue("Artist_Name",defLangId)%></td>
    <td > <%=TSSJavaUtil.instance().getKeyValue("Album_Name",defLangId)%></td>
    <td > <%=TSSJavaUtil.instance().getKeyValue("req_Date",defLangId)%></td>
    </tr>

   <%
   for(int x=0;x<reqAl.size();x++)
   {
    RequestNewCrbt req = (RequestNewCrbt) reqAl.get(x);
    %>
      <tr <%if ( (x % 2) == 0){ %>class="rowcolor2"<%} else {%> class="rowcolor1"<%}%>   >
    <td><%=req.getMsisdn()%></td>
    <td><%=req.getRbtName()%></td>
    <td><%=req.getRbtArt()%></td>
    <td><%=req.getRbtAlb()%></td>
    <td><%=req.getReqdate()%></td>
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
       
