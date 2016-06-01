
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(110) )
	{
	   %>
	    <%@ include file ="../logouterror.jsp" %>
	      <%
	        session.invalidate();
	           request.getSession(true).setAttribute("lang",defLangId);
	            }

	else
	{
     
String startDate="";
String endDate="";
String pagen="";
		startDate=request.getParameter("startDate");
		endDate=request.getParameter("endDate");
		pagen=request.getParameter("pageno");
	
		SystemConfigManager systemConfigManager = new SystemConfigManager();
       systemConfigManager.setConnectionPool(conPool);
		ArrayList systemConfigAl = new ArrayList();
int count=0;
	if((!startDate.equalsIgnoreCase("1"))||(!endDate.equalsIgnoreCase("1")))
			{	
		 count = systemConfigManager.getSystemConfiglog(systemConfigAl,startDate,endDate,pagen);
}
%>
<%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/headerlogs.html" %>
    <tr class="tableheader"><td colspan="4"><!-- <%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%>-->System Configuration logs<br><br> </td></tr>
<form name="form1" method="post" action="systemConfiglogs.jsp">
 
																								<tr width="80%">
<input type="hidden" name="pageno" value = "<%=pagen%>">
																								<td ><%=TSSJavaUtil.instance().getKeyValue("startdate",defLangId)%></td>
																								<td class="tfield"><input type="text" name="startDate" id="f_date_c1" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
																							<!--	</tr>-->
																								<script type ="text/javascript">
																								Calendar.setup({
inputField     :  "f_date_c1",  // id of the input field
ifFormat       :  "%d-%m-%Y", // format of the input field
button         :  "f_trigger_c1",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : false
});
</script>
<td></td>
<!-- <tr>-->
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("enddate",defLangId)%></td>
<td class="tfield"><input type="text" name="endDate" id="f_date_c2" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
<!--</tr>-->
<script type ="text/javascript">
Calendar.setup({
inputField     :  "f_date_c2",  // id of the input field
ifFormat       :  "%d-%m-%Y", // format of the input field
button         :  "f_trigger_c2",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : false
});
</script>
</tr>
<tr>
<td ></td><td></td><td align="right" > <input type="submit" name="submit" value="Search">  
</td><td></td>
</tr>

</form>
<%
if(count!=0)
{
%>
     
    <table width="90%" border="1" align="center" cellpadding="2" cellspacing="4">
     <tr class="tfields">

      <td width="15%"><!--<%=TSSJavaUtil.instance().getKeyValue("syscCol1",defLangId)%>-->Param Tag</td>
       <td width="5%"><!--<%=TSSJavaUtil.instance().getKeyValue("syscCol2",defLangId)%>-->Current Value</td>
      <td width="50%"><!--<%=TSSJavaUtil.instance().getKeyValue("syscCol3",defLangId)%>-->Previous value</td>
      <td width="50%"><!--<%=TSSJavaUtil.instance().getKeyValue("syscCol3",defLangId)%>-->Updated By</td>
      <td width="50%"><!--<%=TSSJavaUtil.instance().getKeyValue("syscCol3",defLangId)%>-->Updated Date</td>
					</tr>
<%
 		if(count < 0)
		{
%>
    <tr class="notice"><td colspan="5"><%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%> </td></tr> 
<%
		}
		else
		{
				Iterator ite = systemConfigAl.iterator();
				while(ite.hasNext())
				{
				SystemConfig systemConfig = (SystemConfig)ite.next();

%>
        <tr class="tabledata_center">
          <td align="left" ><%=systemConfig.getParamTag()%></td>
          <td  ><%= systemConfig.getParamValue()%></td>
          <td  ><%= systemConfig.getPrevalue()%></td>
          <td  ><%= systemConfig.getOwner()%></td>
          <td ><%= systemConfig.getUpDated()%></td>
			</tr>
<% 			}
%>
<%
			}//while
%>
<tr class="notice"><td colspan="4" align="center">
<%
int temp=Integer.parseInt(pagen);
if(temp>0)
{
temp= temp-1;
%>
<a href="systemConfiglogs.jsp?startDate=<%=request.getParameter("startDate")%>&endDate=<%=request.getParameter("endDate")%>&pageno=<%=temp%>">&lt;&lt; previous </a> &nbsp;&nbsp;&nbsp;&nbsp;
<%
}
int j=1,k=0;
 		while(count >= j)
			{
											if(k>=1)
											{
																			%>
																											,
																											<%
											}%>
											<a href="systemConfiglogs.jsp?startDate=<%=request.getParameter("startDate")%>&endDate=<%=request.getParameter("endDate")%>&pageno=<%=k%>"><%=j%></a>
																			<%
																			k++;
											j++;
			}
temp=Integer.parseInt(pagen);
if(k>=2 && count>temp+1)
{
%>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="systemConfiglogs.jsp?startDate=<%=request.getParameter("startDate")%>&endDate=<%=request.getParameter("endDate")%>&pageno=<%=temp%>">next &gt;&gt;</a>
<%
}
%>

</td></tr>
   </table>
<%
}
%>
<tr class="homemenu"><td><a href="../WebAdminLogs/home.jsp">Back</a></td></tr> 
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>

