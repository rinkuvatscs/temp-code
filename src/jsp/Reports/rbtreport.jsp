
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SubscriberProfile subscriberProfile = (SubscriberProfile)session.getAttribute("subscriberProfile");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2031))
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
 int reportId = Integer.parseInt(request.getParameter("reportId"));
 String title = TSSJavaUtil.instance().getKeyValue("curdetailTop",defLangId);

  ReportUtil2 cpManager = new ReportUtil2();
   cpManager.setConnectionPool(conPool);

        cpManager.setConnectionPool(conPool);
	ArrayList cpList = new ArrayList();
	int cd = cpManager.getAllContentProviders(cpList);
%>

<%@include file = "../pagefile/headerReport.html"%>
<body onload="disablefield()">   
	 <form name="form1" method="post" action="rbtresult.jsp?pageId=1&reportId=<%=reportId%>" onSubmit="return validatemonth()">
   
  <table width="70%" border="0" cellspacing="1" cellpadding="3" align="center">
   <tr class="tableheader"> <td colspan="2"><%=title%><br><BR></td>  </tr>
	 <tr class="bluetext" colspan="2">
        <td > <input type="radio"  name="reportType" value="0" size="1" checked onClick="disablefield()"><%=TSSJavaUtil.instance().getKeyValue("curCurr",defLangId)%></td>
        <td > <input type="radio"  name="reportType" value ="1" size="1" onClick = "enablefield()"><%=TSSJavaUtil.instance().getKeyValue("curArch",defLangId)%> </td>
   </tr>
	<tr >
 		 <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("cursMonth",defLangId)%></td>
  	 <td class="tfield"><input type="text" name="start" id="f_date_c1" readonly="1"  />
  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript" >
	Calendar.setup({
	inputField     :  "f_date_c1",  // id of the input field
	ifFormat       :  "%m-%Y", // format of the input field
	button         :  "f_trigger_c1",// trigger for the calendar (button ID)
  align          :  "Tl",           // alignment (defaults to "Bl")
	singleClick    :  true
	});
</script>

<tr >
  <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("cureMonth",defLangId)%></td>
  <td class="tfield"><input type="text" name="end" id="f_date_c2" readonly="1"  />
  <img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;"  name = "c2" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
	Calendar.setup({
	inputField     :  "f_date_c2",  // id of the input field
	ifFormat       :  "%m-%Y", // format of the input field
	button         :  "f_trigger_c2",// trigger for the calendar (button ID)
  align          :  "Tl",           // alignment (defaults to "Bl")
	singleClick    :  true
	});
</script>

<tr>
    <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curAggre",defLangId)%></td>
            <td class="tfield">
                <select name="aggre" id="aggre" size="1" >
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("sysmMon",defLangId)%></option>
                  <option ><%=TSSJavaUtil.instance().getKeyValue("sysmYear",defLangId)%></option>
		</select>
            </td>
   </tr>
  <tr >
     <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curFormat",defLangId)%></td>
            <td class="tfield">
                <select name="format" size="1">
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("Tabular",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("CSV",defLangId)%></option>
	<!--	  <option><%=TSSJavaUtil.instance().getKeyValue("Line_Graph",defLangId)%></option>
		  <option><%=TSSJavaUtil.instance().getKeyValue("Bar_Graph",defLangId)%></option>	-->
                </select>
            </td>
   </tr>
	<tr class="tfield1">
		<TD><%=TSSJavaUtil.instance().getKeyValue("curCP",defLangId)%></TD>
		<TD> 
			<SELECT NAME="contentp" SIZE="1" >
<% 
	for(int j=0; j< cpList.size(); j++)
	{
		ContentProvider cp = (ContentProvider) cpList.get(j);
%>
				<OPTION VALUE="<%=cp.getCode()%>"><%=cp.getName()%></OPTION>
<%
	}
%>
			</SELECT> 
		</TD>
	</TR>

  <!--
	<tr >
       <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curSubType",defLangId)%> </td>
            <td class="tfield">
                <select name="subtype" size="1">
                  <option value="P"><%=TSSJavaUtil.instance().getKeyValue("prepaid",defLangId)%></option>
                  <option value="O"><%=TSSJavaUtil.instance().getKeyValue("postpaid",defLangId)%>     </option>
                  <option value="B" selected><%=TSSJavaUtil.instance().getKeyValue("Both",defLangId)%> </option>
                </select>
            </td>
   </tr>
	-->
   <tr class="button1">
				<td colspan="2"> <input type="submit" name="Submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">  <input type="reset" name="Submit2" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td>
   </tr>
   </table>
      </form>
<%@include file = "../pagefile/footer.html"%>

<%
}
%>
