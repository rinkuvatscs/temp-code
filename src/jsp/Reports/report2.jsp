
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("report2.jsp");
SubscriberProfile subscriberProfile = (SubscriberProfile)session.getAttribute("subscriberProfile");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
//if(sessionHistory == null || !sessionHistory.isAllowed(230))
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
	String title = "Report";
	String catName="", rbtName="";
	ReportUtil2 reputil = new ReportUtil2();
       reputil.setConnectionPool(conPool);
	ContentProvider cp = new ContentProvider();
	int cpCode = Integer.parseInt(request.getParameter("contentp"));
	cp.setCode(cpCode);
	int getCp = reputil.getContentProvider(cp);

	int pageId=0, rbtId=0;
	int catId=-1;
	int a = Integer.parseInt(request.getParameter("a"));
	int reportId = Integer.parseInt(request.getParameter("reportId"));
	if(a==2){ rbtName = request.getParameter("rbtname").toUpperCase();}
	logger.info("reportId= "+reportId+" a= "+a+" rbtName= "+rbtName);
	switch (reportId)
	{
		case 1:
			title = TSSJavaUtil.instance().getKeyValue("curRBTsubs",defLangId);
			break;
		case 2:
			title = TSSJavaUtil.instance().getKeyValue("curSUBmsisdn",defLangId);
			break;
		case 3:
			title = "";
			break;
	}

%>
<HTML>
<HEAD>
<script type="text/javascript">
function validate()
{
	var rbtname = document.forms.form.rbtname.value
	rbtname = rbtname.replace(/^\s+/, ''); // trim leading white spaces
	rbtname = rbtname.replace(/\s+$/, ''); // trim trailing white spaces
	if(rbtname == "")
	{
		alert("<%=TSSJavaUtil.instance().getKeyValue("alrbtname",defLangId)%>");
		document.forms.form1.rbtname.focus();
		return false;
	}
	if(/[^A-Za-z0-9_ ]/.test(rbtname))
	{
		alert("<%=TSSJavaUtil.instance().getKeyValue("alrtill",defLangId)%>");
		document.forms.form1.rbtname.focus();
		return false;
	}
	
} //validate()
</script>

<%@include file = "../pagefile/headerReport.html"%>
   
   
  <table width="70%" border="0" cellspacing="1" cellpadding="3" align="center">
   	<tr class="tableheader"> <td colspan="2"><%=title%> for <%=cp.getName()%><br></td>  </tr>
	 <form name="form" method="post" action="report2.jsp?reportId=<%=reportId%>&a=2&contentp=<%=cpCode%>" onsubmit="return validate()" >
    <tr class="notice">
			<td colspan="3"><%=TSSJavaUtil.instance().getKeyValue("writeName",defLangId)%></td>
		</tr>	
 		<tr class="tfield1">
				<td><%=TSSJavaUtil.instance().getKeyValue("rbtName",defLangId)%> </td>
			  <td><input name="rbtname" type="text" tabindex="1"> &nbsp; &nbsp;<input type="submit" value="GO" name="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>" tabindex="2"><%if (a!=2) {%><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"><%}%></td>
		</tr>
		</form>
  <%
		if(a==2)
		{
	%>
 <form name="form1" method="post" action="results.jsp?pageId=1&reportId=<%=reportId%>&lookif=1&cpName=<%=cp.getName()%>" >
 
  <tr class="tfield1">
		 	<td><%=TSSJavaUtil.instance().getKeyValue("selectRBT",defLangId)%> </td>
			<td>	<select name="getvalue" size="1">
	<%
				RbtManager rbManager = new RbtManager();
                          rbManager.setConnectionPool(conPool);

	  	//	rbManager.setConnectionPool(conPool);
				ArrayList rbtList = new ArrayList();
				int tot =  rbManager.searchRbtCP(catId,cpCode, rbtList,rbtName, pageId); 
				logger.info("got rbt list, size="+ rbtList.size());
	%>
			   <%
				 	if(rbtList.size() <=0 || tot <=0)
					{
				 %>
				 		<script language="Javascript">
						  alert("No Match Found!");
							location.href="report2.jsp?reportId=2&a=1&contentp=<%=cpCode%>";
						</script>	
				 <%} else{
						for(int i=0; i < rbtList.size(); i++)
						{	
							Rbt rbt = (Rbt) rbtList.get(i);
							rbtName = rbt.getRbtMaskedName();
							rbtId = rbt.getRbtId();
							
				 %>
				 
				 <OPTION VALUE="<%=rbtId%>,<%=rbt.getCategoryId()%>"><%=rbtName%></OPTION>
				 <%}%>
	<%
	  		}
	%>
	</SELECT> 
		</TD>
	</TR>
   <tr><td></td></tr>	
   <tr><td></td></tr>	
   <tr><td></td></tr>	
	 <!--
	 <tr class="bluetext" colspan="2">
            <td > <input type="radio"  name="reportType" value="0" size="1" checked onClick="disablefield()"> Current</td>
            <td > <input type="radio"  name="reportType" value ="1" size="1" onClick = "enablefield()"> Archive </td>
          </tr>
	<tr >
  <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("startdate",defLangId)%></td>
  <td class="tfield"><input type="text" name="start" id="f_date_c1" readonly="1"  />
  <img src="images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
	Calendar.setup({
	inputField     :  "f_date_c1",  // id of the input field
	ifFormat       :  "%d-%m-%Y", // format of the input field
	button         :  "f_trigger_c1",// trigger for the calendar (button ID)
  align          :  "Tl",           // alignment (defaults to "Bl")
	singleClick    :  true
	});
</script>

<tr >
  <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("endDate",defLangId)%></td>
  <td class="tfield"><input type="text" name="end" id="f_date_c2" readonly="1"  />
  <img src="images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;"  name = "c2" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
	Calendar.setup({
	inputField     :  "f_date_c2",  // id of the input field
	ifFormat       :  "%d-%m-%Y", // format of the input field
	button         :  "f_trigger_c2",// trigger for the calendar (button ID)
  align          :  "Tl",           // alignment (defaults to "Bl")
	singleClick    :  true
	});
</script>

<tr>
    <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curAggre",defLangId)%></td>
            <td class="tfield">
                <select name="aggre" size="1" >
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("Hourly",defLangId)%></option>
		  <option><%=TSSJavaUtil.instance().getKeyValue("sysmDay",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("sysmMon",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("sysmYear",defLangId)%></option>
		</select>
            </td>
   </tr>
-->
<tr >
     <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curFormat",defLangId)%></td>
            <td class="tfield">
                <select name="format" size="1">
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("Tabular",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("CSV",defLangId)%></option>
                </select>
            </td>
   </tr>
<!--
  
	<tr >
       <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curSubType",defLangId)%></td>
            <td class="tfield">
                <select name="subtype" size="1">
                  <option value="P"><%=TSSJavaUtil.instance().getKeyValue("prepaid",defLangId)%></option>
                  <option value="O"><%=TSSJavaUtil.instance().getKeyValue("postpaid",defLangId)%></option>
                  <option value="B" selected><%=TSSJavaUtil.instance().getKeyValue("BOTH",defLangId)%></option>
                </select>
            </td>
   </tr>
	-->
	<input type="hidden" name="cat_id" value="<%=catId%>">
	<!--
	  <input type="hidden" name="rbtName" value="<%=rbtName%>">
		<input type="hidden" name="catName" value="<%=catName%>">
	-->	
   <tr class="button1">
        <td colspan="2"> <input type="submit" name="Submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">  <input type="reset" name="Submit2" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td>
   </tr>
   </table>
      </form>
<% }//if a==2%>
<%@include file = "../pagefile/footer.html"%>

<%
}
%>
