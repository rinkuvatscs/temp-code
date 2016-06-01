<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import = "com.telemune.dbutilities.ConnectionPool" %>
<%@ page import = "com.telemune.crbtadmin.webif.AdminManagerUtil" %>
<%@ page import = "com.telemune.crbtadmin.webif.Charge" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.telemune.crbtadmin.webif.*" %>
<%@ page import = "org.apache.log4j.*" %>
 <%@ include file="../lang.jsp" %>

<%@ include file="../conpool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	ArrayList chargeAl = new ArrayList();
	if(sessionHistory == null || !sessionHistory.isAllowed(160))
	{
				session.invalidate();
                      request.getSession(true).setAttribute("lang",defLangId);
%>
<jsp:forward page="/logouterror.html" />
<%
	}
	else
	{
		if(adminManager == null)
		{
			session.invalidate();
                        request.getSession(true).setAttribute("lang",defLangId);
%>
<script language="JavaScript">
				//alert("Error!!! Try Again")
				 alert(<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>)
				window.location="../index.html"
			</script>
<%
		}
		int i = adminManager.viewChargeData(chargeAl, "pre");
		if(i < 0)
		{
		%>
<script language="JavaScript">
				//alert("Error!!! Try Again")
				alert(<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>)
				window.location="../home.jsp"
			</script>
<%
		}
	else
	{
%>
<HTML>
<HEAD>
<TITLE> <%=TSSJavaUtil.instance().getKeyValue(" Pre-paid_Charging_Rules",defLangId)%></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>
<BODY BGCOLOR=#000000 >
<table width="95%" border="0" align="center" >
  <tr>
    <td width="5%" HEIGHT="90" align="left" valign="top" bgcolor="#FFFFFF"><img src="../images/Logo.gif"  width="80" height="90" vspace="0" hspace="0"></td>
    <td width="95%" bgcolor="#FFFFFF" align="left" valign="top" height="90">
	  <table WIDTH="100%" >
       	  <tr>
       		  <td WIDTH="50%" HEIGHT="90"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B><FONT SIZE="6" COLOR="#FF6C00">tele</FONT><FONT SIZE="6">mune</FONT></B></FONT></td>
          	<td WIDTH="50%" HEIGHT="90" align="right"><FONT COLOR="#FF6C00" SIZE="7" FACE="Verdana, Arial, Helvetica, sans-serif"><B>CRBT</B></FONT></td>
       	</tr>
      </table>
	</td>
  </tr>
  <tr>
    <td width="5%" bgcolor="#FF6C00" height="200">&nbsp;</td>
    <td width="95%" bgcolor="#CCCCCC" align="center" valign="top"><p align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><a href="../home.jsp">Main Menu</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../logout.jsp">Logout</a></b></font></p>
      <blockquote>
        <p><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="3"><b><%=TSSJavaUtil.instance().getKeyValue(" Pre-paid_Charging_Rules",defLangId)%></b></font></p>
        <form name="form1" method="post" action="">
          <table width="600" border="0" bgcolor="#AAAAAA">
            <tr>
              <td width="108" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Included</b></font></font></font></font></DIV></td>
              <td width="259" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Parameter</b></font></font></font></font></DIV></td>
              <td width="219" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2"><FONT SIZE="2"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B>Parameter Value </B></FONT></FONT></FONT></FONT></DIV></td>
            </tr>
            <%
	Iterator ite = chargeAl.iterator();
	while(ite.hasNext())
	{
		Charge charge = (Charge) ite.next();
		if(charge.getInclude().equals("Y"))
		{
%>
            <tr bgcolor="#CCCCCC">
              <td width="108"><DIV ALIGN="CENTER"><FONT SIZE="2"><IMG SRC="../images/tick.jpg" WIDTH="10" HEIGHT="10"></FONT></DIV></td>
              <td width="259"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= charge.getParam()%> </FONT></DIV></td>
              <td width="219"><%= charge.getParamValue()%>
                <DIV ALIGN="CENTER"><FONT SIZE="2"></FONT></DIV></td>
            </tr>
            <%
		}
		else
		{
%>
            <tr bgcolor="#CCCCCC">
              <td width="108"><DIV ALIGN="CENTER"><FONT SIZE="2"><IMG SRC="../images/cross.jpg" WIDTH="10" HEIGHT="10"></FONT></DIV></td>
              <td width="259"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%=charge.getParam() %></FONT></DIV></td>
              <td width="219"><%=charge.getParam() %>
                <DIV ALIGN="CENTER"><FONT SIZE="2"></FONT></DIV></td>
            </tr>
            <%
	}//else
}//while
%>
          </table>
        </form>
      </blockquote>
      <p align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="charging_rules.jsp">Back</a></font></b></p></td>
  </tr>
</table>
</BODY>
</HTML>
<%
	}
}
%>
