
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
    SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
    if ((sessionHistory == null) || (!sessionHistory.isAllowed(130)))
    {
 %>
  <%@ include file ="../logouterror.jsp" %>
    <%
      session.invalidate();
         request.getSession(true).setAttribute("lang",defLangId);
          }

	else	
    {
       float curValue = 97f;
       String msg = "Normal";     // Message to be displayed 
       String msgColor = "Red";
%>
<HTML>
<HEaD>
<TITLE>Ringback Tone - Monitoring</TITLE>
<METa HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<METa HTTP-EQUIV="Refresh" CONTENT="60">
<METa HTTP-EQUIV="Pragma" CONTENT="no-cache">
<METa HTTP-EQUIV="Expires" CONTENT="-1">
</HEaD>
 <%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>
<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("sysmTop",defLangId)%><br><br></td></tr>
<% int server=0;
server=TSSJavaUtil.instance().getTotalServer();
int count=0;
int count1=0;
int count2=1;
boolean show=false;
%>    
    <table width="80%" border="0" align="center" cellpadding="3" cellspacing="4">
<%
while(count<server)
{
String Ser_name1="SERVER.";
String Ser_name2="SERVER.";
count1=count1+1;
Ser_name1=Ser_name1+count1;
count1=count1+1;
Ser_name2=Ser_name2+count1;
if((server-count)>=2)
show=true;
else
show=false;
%>

        <tr class="tfield1" >
           <td ><%=TSSJavaUtil.instance().getKeyValue("sysmserver",defLangId)%><%=count2%></td>
											<% if(show)
														{
													%>
           <td ><%=TSSJavaUtil.instance().getKeyValue("sysmserver",defLangId)%><%=count2+1%></td>
<% count=count+2;
               }
											else
count=count+1;
											{%>
											<td></td>
<%}%>                                                                        </tr>
        <tr class="homemenu">
           <td><a hreF="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name1)%>&par=cpu&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmCPU",defLangId)%></a></td>
											<% if(show)
														{
													%>
          <td><a hreF="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name2)%>&par=cpu&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmCPU",defLangId)%></a></td>
											<%}
											else
{%>
<td></td>
<%}%>
        </tr>
         <tr class="homemenu">
           <td ><a href="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name1)%>&par=mem&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmMem",defLangId)%></a></td>
											<% if(show)
														{
													%>
          <td ><a href="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name2)%>&par=mem&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmMem",defLangId)%></a></td>
							<%}
						else
							{%>
						<td></td>
							<%}%>
         </tr>
         <tr class="homemenu">
           <td ><a hreF="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name1)%>&par=disk&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmDisk",defLangId)%></a></td>
											<% if(show)
														{
													%>
           <td ><a hreF="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name2)%>&par=disk&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmDisk",defLangId)%></a></td>
											<%}
												else
											{%>
										<td></td>
										<%}%>
         </tr>
         <tr class="homemenu">
            <td ><a href="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name1)%>&par=bond0&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmNet",defLangId)%></a></td>
											<% if(show)
														{
													%>
            <td ><a href="show.jsp?ser=<%=TSSJavaUtil.instance().getServerName(Ser_name2)%>&par=bond0&dur=day&backPage=han.jsp"><%=TSSJavaUtil.instance().getKeyValue("sysmNet",defLangId)%></a></td>
													<%}
													else
													{%>
												<td></td>
											<%}%>
         </tr>
        <tr></td>&nbsp;</td></tr>
        <tr></td>&nbsp;</td></tr>
<%
		count2=count2+2;
 }
%>
<tr class="homemenu"><td></td><td><a href="../home.jsp">Go back</a></td></tr>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
} 
%>



