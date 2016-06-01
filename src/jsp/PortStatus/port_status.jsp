<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import = "com.telemune.crbtadmin.webif.AdminManagerUtil" %>
<%@ page import = "com.telemune.crbtadmin.webif.CallStates" %>
<%@ page import = "com.telemune.crbtadmin.webif.PortStatus" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.lang.Integer" %>
<%@ page import = "java.io.*"%>
<%@ page import = "com.telemune.crbtadmin.webif.*" %>
<%@ page import = "org.apache.log4j.*" %>
<%@ include file="../conpool.jsp" %>
<%@ include file="../lang.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(170))
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
else
{
    ArrayList portStatAl= new ArrayList();
    ArrayList callStatesAl= new ArrayList();
    ArrayList instanceAl = new ArrayList();
    ArrayList summaryAl = new ArrayList();
    int portBlocked=0;
    int portBusy=0;
    int ivrCalls=0;
    int otherCalls=0;
    String strInstance = request.getParameter("instanceId");
    int instanceId ;
    int showInstance ;
    if(strInstance==null || strInstance.equals("") || strInstance.equals("null"))
    {
        showInstance=1;
        instanceId=0;
    }
    else
    {
        showInstance = Integer.parseInt(strInstance);
        instanceId = Integer.parseInt(strInstance);
    }
    int i = adminManager.portStatus(portStatAl, callStatesAl, instanceAl, instanceId);
    if(i<0 && i!=-2)
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
<HTML>
<HEAD>
<TITLE>Port Status</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript">
    function dispInstanceId(index1)
    {
        var strUrl= 'port_status.jsp?instanceId='+index1
        window.location=strUrl
    }
</script>
</HEAD>
<BODY BGCOLOR=#000000 >
<table width="95%" border="0" align="center" >
  <tr>
    <td width="5%" HEIGHT="90" align="left" valign="top" bgcolor="#FFFFFF"><img src="../images/Logo.gif" width="80" height="90" vspace="0" hspace="0"></td>
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
      <p align="center"><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="3"><b>Port Status </b></font></p>
<%
        if(i==-2)
	{
%>
      <table bgcolor="#CCCCCC">
        <tr>
          <td  align="left" valign="middle" height="13" colspan="2"><div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> No Data Available/Wrong Instance ID </font></b></div></td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
          <td  align="center" valign="middle" height="13" ><div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <a href="../home.jsp">Back </a> </font></b></div></td>
        </tr>
      </table>
<%
	}
	else
	{
%>
      <table bgcolor="#CCCCCC" align="CENTER">
        <tr>
          <td bgcolor="#CCCCCC" align="center" valign="middle" height="13" colspan="2"><div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> Select Instance ID: </font></b></div></td>
          <td bgcolor="#CCCCCC" align="center" valign="middle" height="13" colspan="4"><div align="left"> <span id="group" style"display: block;">
              <select name="group" OnChange= "dispInstanceId(this.value)">
<%
            Iterator iteIns = instanceAl.iterator();
            PortStatus instanceStats = new PortStatus();
            while(iteIns.hasNext())
            {
                instanceStats = (PortStatus)iteIns.next();
                if(instanceStats.getInstanceId()==showInstance)
                {
%>
                <option value="<%=instanceStats.getInstanceId()%>" selected ><%=instanceStats.getInstanceId()%></option>
<%
                }
                else
                {
%>
                <option value="<%=instanceStats.getInstanceId()%>" ><%=instanceStats.getInstanceId()%></option>
<%
                }
            }
%>
              </select>
              </span> </div></td>
        </tr>
      </table>
<%
	// ****************** Port Summary **********************
            Iterator iteSummary = portStatAl.iterator();
            PortStatus portStats1 = new PortStatus();
            while(iteSummary.hasNext())
            {
		portStats1 = (PortStatus)iteSummary.next();
		if(portStats1.getCallState()==3)
			portBlocked++;
		if(portStats1.getCallState()==2)
			portBusy++;
		if( (portStats1.getCallNature()).equals("IVR")  && portStats1.getCallState()==2)
			ivrCalls++;
		if( !(portStats1.getCallNature()).equals("IVR")  && portStats1.getCallState()==2)
			otherCalls++;
            }
%>
      <font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Summary
      <table width="59%" border="0" bgcolor="#AAAAAA">
        <tr>
          <td width="53%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Total number of blocked ports</b></font></font></font></font></DIV></td>
          <td width="47%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><%=portBlocked%> </font></font></font></font></DIV></td>
        </tr>
        <tr>
          <td width="53%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b> Total number of Busy Ports </b></font></font></font></font></DIV></td>
          <td width="47%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><%=portBusy%> </font></font></font></font></DIV></td>
        </tr>
        <tr>
          <td width="53%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Total number of calls to IVR </b></font></font></font></font></DIV></td>
          <td width="47%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><%=ivrCalls%> </font></font></font></font></DIV></td>
        </tr>
        <tr>
          <td width="53%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b> Total number of other calls </b></font></font></font></font></DIV></td>
          <td width="47%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><%=otherCalls%></font></font></font></font></DIV></td>
        </tr>
      </table>
      </b></font> <br>
      <font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2"> <b> <STRONG>Details </STRONG>
      <table width="83%" border="0" ALIGN="CENTER" bgcolor="#AAAAAA">
        <tr>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>In Channel </b></font></font></font></font></DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Out Channel</b></font></font></font></font> </DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Call Status</b></font></font></font></font></DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Calling No.</b></font></font></font></font></DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Called No.</b></font></font></font></font></DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Call Time </b></font></font></font></font></DIV></td>
          <td width="10%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Last Call Time</b></font></font></font></font></DIV></td>
          <td width="16%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Call Nature</b></font></font></font></font></DIV></td>
          <td width="16%" bgcolor="#BBBBBB"><DIV ALIGN="CENTER"><font size="2"><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif"><b>Forwarding No.</b></font></font></font></font></DIV></td>
        </tr>
<%
            Iterator ite = portStatAl.iterator();
            PortStatus portStats = new PortStatus();
            while(ite.hasNext())
            {
                portStats = (PortStatus)ite.next();
                int  callstate = portStats.getCallState();
                Iterator iteCallState = callStatesAl.iterator();
                String colorcode = "";
                String description = "";
                while(iteCallState.hasNext())
                {
                    CallStates callStat = new CallStates();
                    callStat = (CallStates)iteCallState.next();
                    if(callStat.getCallState()==callstate)
                    {
                        colorcode = callStat.getColorCode();
                        description = callStat.getDescription();
                    }
                }
%>
        <tr bgcolor="#CCCCCC">
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getInChannel()%></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getOutChannel() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= description%></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getCallingNo() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getCalledNo() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getCallTime() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getLastCallTime() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getCallNature() %></FONT></DIV></td>
          <td><DIV ALIGN="CENTER"><FONT SIZE="2" FACE="Verdana, Arial, Helvetica, sans-serif"><%= portStats.getForwardNo() %></FONT></DIV></td>
        </tr>
<%
                }
            }
%>
      </table>
      </td>
  </tr>
</TABLE>
</BODY>
</HTML>
<%
        }
    }
}
%>
