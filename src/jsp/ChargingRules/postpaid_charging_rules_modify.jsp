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

<%@ include file="../conpool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	ArrayList chargeAl = new ArrayList();
	if(sessionHistory == null || !sessionHistory.isAllowed(161))
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
    alert("Error!!! Try Again")
    window.location="../index.html"
</script>
<%
		}
		int i = adminManager.viewChargeData(chargeAl, "post");
		if(i < 0)
		{
		%>
<script language="JavaScript">
    alert("Error!!! Try Again")
    window.location="../home.jsp"
</script>
<%
		}
	else
	{
%>
 <%@ include file="../lang.jsp" %>
<HTML>
    <HEAD>
        <TITLE> <%=TSSJavaUtil.instance().getKeyValue("Post-paid_Charging",defLangId)%></TITLE>
        <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
        <script src ="../Scripts/UtilityFunc.js" language="javascript" type ="text/javascript" ></script>
        <script type="text/javascript">
        <!--
        function validate()
        {
            for(var i=0; i<document.forms["form1"].elements.length; i++)
            {
                if(document.forms["form1"].elements[i].type == "text")
                {
                    document.forms["form1"].elements[i].value = document.forms["form1"].elements[i].value.trim();
                    if(document.forms["form1"].elements[i].value == "" || !(isNumeric(document.forms["form1"].elements[i].value)))
                    {
                        alert(<%=TSSJavaUtil.instance().getKeyValue("Error!",defLangId)%>);
                        document.forms["form1"].elements[i].select();
                        document.forms["form1"].elements[i].focus();
                        return false;
                    }
                }
            }
            return true;
        }
    -->
    </script>
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
            <p><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="3"><b> <%=TSSJavaUtil.instance().getKeyValue("Post-paid_Charging",defLangId)%></b></font></p>
            <form name="form1" method="post" action="modifypostpaid.jsp" onSubmit= "return validate()">
            <TABLE WIDTH="97%" BORDER="0" BGCOLOR="#AAAAAA">
                <TR>
                    <TD WIDTH="135" BGCOLOR="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2"><FONT SIZE="2"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B>Included</B></FONT></FONT></FONT></FONT></DIV></TD>
                    <TD WIDTH="324" BGCOLOR="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2"><FONT SIZE="2"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B>Parameter</B></FONT></FONT></FONT></FONT></DIV></TD>
                    <TD WIDTH="252" BGCOLOR="#BBBBBB"><DIV ALIGN="CENTER"><FONT SIZE="2"><FONT SIZE="2"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><FONT FACE="Verdana, Arial, Helvetica, sans-serif"><B>Parameter Value </B></FONT></FONT></FONT></FONT></DIV></TD>
                </TR>
            <%
	Iterator ite = chargeAl.iterator();
	while(ite.hasNext())
	{
		Charge charge = (Charge) ite.next();
		if(charge.getInclude().equals("Y"))
		{
%>
                <TR BGCOLOR="#CCCCCC">
                    <TD WIDTH="135"><DIV ALIGN="CENTER">
                        <INPUT TYPE="checkbox" NAME="<%= charge.getParam() %>" VALUE="checkbox" CHECKED>
                    </DIV></TD>
                    <TD WIDTH="324"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%=charge.getParam() %></FONT></DIV></TD>
                    <TD WIDTH="252"><DIV ALIGN="CENTER"><FONT SIZE="2">
                        <INPUT TYPE="text" NAME="paramvalue" value ="<%= charge.getParamValue()%>">
                    </FONT></DIV></TD>
                </TR>
            <%
		}
		else
		{
%>
                <TR BGCOLOR="#CCCCCC">
                    <TD WIDTH="135"><DIV ALIGN="CENTER">
                        <INPUT TYPE="checkbox" NAME="<%= charge.getParam() %>" VALUE="checkbox">
                    </DIV></TD>
                    <TD WIDTH="324"><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%=charge.getParam() %></FONT></DIV></TD>
                    <TD WIDTH="252"><DIV ALIGN="CENTER"><FONT SIZE="2">
                        <INPUT TYPE="text" NAME="paramvalue" value ="<%= charge.getParamValue()%>">
                    </FONT></DIV></TD>
                </TR>
            <%
		}
	}
        session.setAttribute("chargeal",chargeAl);
%>
                <TR BGCOLOR="#BBBBBB">
                    <TD COLSPAN="3"><DIV ALIGN="CENTER">
                        <INPUT TYPE="submit" NAME="chrgSubmit" VALUE="Submit">
                        <INPUT TYPE="reset" NAME="chrgReset" VALUE="Reset">
                    </DIV></TD>
                </TR>
            </TABLE>
            </form>
            <p align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="charging_rules.jsp">Back</a></font></b></p></td>
            </tr>
        </table>
    </BODY>
</HTML>
<%
	}
}
%>
