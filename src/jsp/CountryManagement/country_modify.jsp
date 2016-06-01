
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{ %>
  <%@ include file ="../logouterror.jsp" %>
   <%
    session.invalidate();
   request.getSession(true).setAttribute("lang",defLangId);
 }
else
{
		String country_name= request.getParameter("name");
		String country_mcc = request.getParameter("mcc");
%>
 <%@ include file="../lang.jsp" %>
<HTML>
<HEAD>
<TITLE> <%=TSSJavaUtil.instance().getKeyValue("Country_Details_Modification",defLangId)%> </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" >


</head>

 <%@ include file = "../pagefile/header.html" %>
     
   <form name="form1" method="post" action="country_modify_delete.jsp?id=mod" >

			<table width="70%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		   <tr>  <td colspan="2" class="tableheader"> <%=TSSJavaUtil.instance().getKeyValue("Country_Configuration",defLangId)%><br<br> </td></tr>
			<tr class="tfields">
		 <td width="10%"> <%=TSSJavaUtil.instance().getKeyValue("Country_Name",defLangId)%> </td>
           <td align="left" > <%=country_name%>  <input type="hidden" name="mcc" value="<%=country_mcc%>">  </td>
       </tr>
       <tr class="tfields">
           <td width="10%"> <%=TSSJavaUtil.instance().getKeyValue("Inbound_Roamer",defLangId)%>  </td>
           <td width="10%" height="17" align="left"><input type="checkbox"id="txt1" name="inbound" value="A"></td>
       </tr>
       <tr class="tfields">
           <td width="10%"> <%=TSSJavaUtil.instance().getKeyValue("Outbound_Roamer",defLangId)%> </td>
           <td width="10%" height="17" align="left"><input type="checkbox"id="txt2" name="outbound" value="A"></td>
       </tr>
       <br><br>
			 <tr class="button1">
           <td colspan="2" > <input type="submit" name="submit" value="Modify"> <input type="reset" name="clear" value="Clear"> </td>
       </tr>
     </table>
   </form>
<%@ include file = "../pagefile/footer.html" %>  
<%
}
%>



