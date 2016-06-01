
<%@ page import = "com.telemune.webadmin.webif.SessionHistory" %>
<%@ page import = "com.telemune.webadmin.webif.TSSJavaUtil" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("show.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null)
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
	String server = request.getParameter("ser");
	String parmtr = request.getParameter("par");
	String duratn = request.getParameter("dur");
	String backPage= request.getParameter("backPage");
	String url = "show.jsp?ser="+server+"&par="+parmtr+"&backPage="+backPage+"&dur=";
//	String url = "show.jsp?ser="+server+"&par="+parmtr+"&dur=";
	String graphtop = "";
	String pagetop = "";
	String name1 = "";
	String name2 = "";

	String imagename = "",mrtgpath="";
			 mrtgpath = TSSJavaUtil.instance().getMrtgPath();
			 imagename = mrtgpath+server+"."+parmtr+"-"+duratn+".png";
			 logger.info(imagename);

/*	 if (server.startsWith("webser"))
	 {
		// if(parmtr.equalsIgnoreCase("trafficeth0"))
		//	 imagename = "http://172.20.72.165/mrtg/"+parmtr+"-"+duratn+".png";
		 //  imagename = "http://10.151.58.202/mrtg/"+server+parmtr+"-"+duratn+".png";
		// else
			 imagename = "http://172.20.72.165/mrtg/"+server+"."+parmtr+"-"+duratn+".png";
			 logger.info(imagename);
	 }
*/

/*	if (server.startsWith("dan"))
	{
		imagename = "http://172.20.72.165/mrtg/"+server+parmtr+"-"+duratn+".png";
	}
	else if (server.startsWith("hcm"))
	{
		imagename = "http://172.20.72.165/mrtg/"+server+parmtr+"-"+duratn+".png";
	}
	else 
	{
		imagename = "http://172.20.72.165/mrtg/"+server+parmtr+"-"+duratn+".png";
	}
*/
	if (parmtr.equalsIgnoreCase("cpu")) {
		pagetop =TSSJavaUtil.instance().getKeyValue("sysmCPUTop",defLangId)+ " (%)";
		name1   ="## "+TSSJavaUtil.instance().getKeyValue("sysmCPUind1",defLangId);
		name2 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmCPUind2",defLangId);
	}

	else if (parmtr.equalsIgnoreCase("memory")) {
		pagetop =TSSJavaUtil.instance().getKeyValue("sysmMemTop",defLangId)+ " (%)";
		name1 = "";
		name2 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmMemind1",defLangId);
	}

	else if (parmtr.equalsIgnoreCase("trafficeth0")) {
		pagetop =TSSJavaUtil.instance().getKeyValue("sysmNetTop",defLangId)+ " eth(0) (%)";
		name1 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmNetind1",defLangId);
		name2 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmNetind2",defLangId);
	}

	else if (parmtr.equalsIgnoreCase("eth1")) {
		pagetop =TSSJavaUtil.instance().getKeyValue("sysmNetTop",defLangId)+ " eth(1) (%)";
		name1 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmNetind1",defLangId);
		name2 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmNetind2",defLangId);
	}

	else if (parmtr.equalsIgnoreCase("disk")) {
		pagetop =TSSJavaUtil.instance().getKeyValue("sysmDiskTop",defLangId)+ " (%)";
		name1 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmDiskind1",defLangId);
		name2 = "##  "+TSSJavaUtil.instance().getKeyValue("sysmDiskind2",defLangId);
	}

	if (duratn.equalsIgnoreCase("day")) 
		graphtop =TSSJavaUtil.instance().getKeyValue("sysmDaily",defLangId);

	else if (duratn.equalsIgnoreCase("week"))
		graphtop =TSSJavaUtil.instance().getKeyValue("sysmWeekly",defLangId);

	else if (duratn.equalsIgnoreCase("month"))
		graphtop =TSSJavaUtil.instance().getKeyValue("sysmMonthly",defLangId);

	else if (duratn.equalsIgnoreCase("year"))
		graphtop =TSSJavaUtil.instance().getKeyValue("sysmYearly",defLangId);
//%>

 
<%@ include file = "../pagefile/header.html" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Refresh" CONTENT="60">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
      
		
	
	<table width="80%" border="0" align="center">
      <tr class="tableheader"><td><%= pagetop %><br><br></td></tr>
	    <tr class="bluetext">
	       <td align="left"><%= graphtop %>   </td>
				 <td width="2%" align="center">
	    </tr>	
       <tr > 
            <td bgcolor="#BBBBBB" align="left"> 
                <img src="<%= imagename %>">
    				</td>
						<td><table width="2%" border="0">
						 
	     
		  <% if (!duratn.equalsIgnoreCase("day")) { %>
		  <tr class="mainmenu">
		     <td ><a href="<%= url %>day"><%=TSSJavaUtil.instance().getKeyValue("sysmDay",defLangId)%></a></td>
		  </tr>
		  <% } %>
		  <% if (!duratn.equalsIgnoreCase("week")) { %>
		  <tr class="mainmenu"> 
		     <td><a href="<%= url %>week"><%=TSSJavaUtil.instance().getKeyValue("sysmWeek",defLangId)%> </a> </td>
		  </tr>
		  <% } %>
		  <% if (!duratn.equalsIgnoreCase("month")) { %>
		  <tr class="mainmenu">
		     <td><a href="<%= url %>month"><%=TSSJavaUtil.instance().getKeyValue("sysmMon",defLangId)%> </a> </td>
		  </tr>
		  <% } %>
		  <% if (!duratn.equalsIgnoreCase("year")) { %>
		  <tr class="mainmenu">
		     <td> <a href="<%= url %>year"><%=TSSJavaUtil.instance().getKeyValue("sysmYear",defLangId)%></a> </td>
		  </tr>
		  <% } %>
			</table>
		</td>
		</tr>	
	    <tr class="normaltext">
					<td><font size="-1" color="#00cc00"><b><%= name1 %></b></td>
	    </tr>
	    <tr class="normaltext">
					<td><font size="-1" color="#0000ff"><b><%= name2 %></b></font></td>
	    </tr>
	    <tr class="homemenu"> 
<!--					<td  align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><a href="home.jsp">Monitoring home</a></b></font></td>-->
 <td  align="right" class="normaltext"><a href="<%=backPage%>"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></td>

	    </tr>		
          </table>

<%@ include file = "../pagefile/footer.html" %>
<% } %>


