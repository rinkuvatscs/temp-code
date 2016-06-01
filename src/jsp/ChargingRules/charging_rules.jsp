<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import = "org.apache.log4j.*" %>
<%@ page import = "com.telemune.crbtadmin.webif.*" %>
  <%@ include file="../lang.jsp" %>
<%@ include file="../conpool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
Logger logger = Logger.getLogger("charging_rules.jsp");
if(sessionHistory == null || !sessionHistory.isAllowed(160))
{
    session.invalidate();
    logger.debug("session invalidated");
    request.getSession(true).setAttribute("lang",defLangId);
%>
    <jsp:forward page="/logouterror.html" />
<%
}
else
{
%>
<HTML>
<HEAD>
<TITLE> <%=TSSJavaUtil.instance().getKeyValue("Charging_Rules",defLangId)%></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>
<BODY BGCOLOR=#000000 >
<table width="95%" border="0" align="center" >
  <tr>
    <td width="5%" HEIGHT="90" align="left" valign="top" bgcolor="#FFFFFF"><img src="../images/Logo.gif"  width="80" height="90" vspace="0" hspace="0"></td>
    <td width="95%" bgcolor="#FFFFFF" align="left" valign="top" height="90"><table WIDTH="100%" >
        <tr>
          <td WIDTH="50%" HEIGHT="90"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B><FONT SIZE="6" COLOR="#FF6C00">tele</FONT><FONT SIZE="6">mune</FONT></B></FONT></td>
          <td WIDTH="50%" HEIGHT="90" align="right"><FONT COLOR="#FF6C00" SIZE="7" FACE="Verdana, Arial, Helvetica, sans-serif"><B>CRBT</B></FONT></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="5%" bgcolor="#FF6C00" height="200">&nbsp;</td>
    <td width="95%" bgcolor="#CCCCCC" align="center" valign="top"><p align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><a href="../home.jsp">Main Menu</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../logout.jsp">Logout</a></b></font></p>
      <p><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="3"><b>Charging Rules</b></font></p>
      <table width="60%" border="0" bgcolor="#AAAAAA">
        <tr>
          <td width="33%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2" FACE="Verdana, Arial, Helvetica, sans-serif"><b>Type</b></font></DIV></td>
          <td width="33%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><B>View</B></FONT></DIV></td>
<%
    if (sessionHistory.isAllowed(161))
    {
%>
          <td width="33%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><B>Modify</B></FONT></DIV></td>
<%
    }
%>
        </tr>
        <tr bgcolor="#CCCCCC">
          <td width="33%"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif">Pre-paid</FONT></DIV></td>
          <td width="33%"><DIV ALIGN="CENTER"><FONT SIZE="2"><A HREF="prepaid_charging_rules_view.jsp"><IMG SRC="../images/view.gif" WIDTH="42" HEIGHT="20" BORDER="0"></A></FONT></DIV></td>
<%
    if (sessionHistory.isAllowed(161))
    {
%>
          <td width="33%"><DIV ALIGN="CENTER"><A HREF="prepaid_charging_rules_modify.jsp"><IMG SRC="../images/modify.gif" WIDTH="54" HEIGHT="20" BORDER="0"></A></DIV></td>
<%
    }
%>
        </tr>
        <tr bgcolor="#CCCCCC">
          <td width="33%"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif">Post-paid</FONT></DIV></td>
          <td width="33%"><DIV ALIGN="CENTER"><FONT SIZE="2"><A HREF="postpaid_charging_rules_view.jsp"><IMG SRC="../images/view.gif" WIDTH="42" HEIGHT="20" BORDER="0"></A></FONT></DIV></td>
<%
    if (sessionHistory.isAllowed(161))
    {
%>
          <td width="33%"><DIV ALIGN="CENTER"><A HREF="postpaid_charging_rules_modify.jsp"><IMG SRC="../images/modify.gif" WIDTH="54" HEIGHT="20" BORDER="0"></A></DIV></td>
<%
    }
%>
        </tr>
      </table>
      <p align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="../home.jsp">Back</a></font></b></p>
    </td>
  </tr>
</table>
</BODY>
</HTML>
<%
}
%>
