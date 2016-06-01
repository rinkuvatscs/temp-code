
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
<%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("report.jsp");
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
	ReportUtil2 reputil = new ReportUtil2();
    reputil.setConnectionPool(conPool);
	String title = "Report";
	String catName="", rbtName="";
	ContentProvider cp = new ContentProvider();
	int cpCode = Integer.parseInt(request.getParameter("contentp"));
	cp.setCode(cpCode);
	int getCp = reputil.getContentProvider(cp);

	int pageId=0, rbtId=0;
	int catId=-1;
	int a = Integer.parseInt(request.getParameter("a"));
	int reportId = Integer.parseInt(request.getParameter("reportId"));
	logger.info("cpCode="+cpCode+" reportId= "+reportId);
	if(a==2){  catId = Integer.parseInt(request.getParameter("cat_id"));}
	switch (reportId)
	{
		case 1:
			title =TSSJavaUtil.instance().getKeyValue("curRBTsubs",defLangId);
			break;
		case 2:
			title = "";
			break;
		case 3:
			title = "";
			break;
	}

%>
<HTML>
<HEAD>
<script type="text/javascript">
function back()
{
history.go(-1);
}
function validate()
{
	var rbtname = document.forms.form1.rbtname.value
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
		alert("<%=TSSJavaUtil.instance().getKeyValue("alrbtill",defLangId)%>");
		document.forms.form1.rbtname.focus();
		return false;
	}
} //validate()
function getRBT()
{
  var go = 	document.forms.form1.category;
	var page = go.options[go.selectedIndex].value;
	if(page) location.href= page;
	
}
</script>

<%@include file = "../pagefile/headerReport.html"%>
<% if(a==2)
{%>
<body onload="disablefield()">   
<%}%>  
 <form name="form1" method="post" action="results.jsp?pageId=1&reportId=<%=reportId%>&lookif=0&cpName=<%=cp.getName()%>" onSubmit="return validatemonth()">


  <table width="70%" border="0" cellspacing="1" cellpadding="3" align="center">
   	<tr class="tableheader"> <td colspan="2"><%=title%> for <%=cp.getName()%><br><BR></td>  </tr>
  	<tr class="tfield1">
				<td><%=TSSJavaUtil.instance().getKeyValue("selectCat",defLangId)%> </td>
				<td>		<select name="category" size="1" onchange="return getRBT()">
										<Option value="">Select Category</option>
				<%
						CategoryManager catManager = new CategoryManager();
                          catManager.setConnectionPool(conPool);
 						ArrayList catList = new ArrayList();
					 	int ct = catManager.searchCategory("",catList);
						logger.info("got CAtegory list, size="+ catList.size());
						for(int i=0; i < catList.size(); i++)
						{
							com.telemune.webadmin.webif.Category cat = (com.telemune.webadmin.webif.Category) catList.get(i);
						//	catId = cat.getCategoryId();
							catName = cat.getMaskedName();
				%>
						<OPTION VALUE="report.jsp?cat_id=<%=cat.getCategoryId()%>&a=2&reportId=<%=reportId%>&contentp=<%=cpCode%>" <%if(catId==cat.getCategoryId()){%>selected<%}%>><%=catName%></OPTION>
				<%
						}
				%>
				</select> 
			</td>
		</tr>
  <%
		if(a==2)
		{
	%>
 		<tr class="tfield1">
		 	<td><%=TSSJavaUtil.instance().getKeyValue("selectRBT",defLangId)%> </td>
			<td>		<select name="rbt_id" size="1">
	<%
				RbtManager rbManager = new RbtManager();
                rbManager.setConnectionPool(conPool);

				ArrayList rbtList = new ArrayList();
				int tot =  rbManager.searchRbtCP(catId, cpCode, rbtList); 
				logger.info("got rbt list, size="+ rbtList.size());
	%>
			   <%
				 	if(rbtList.size() <=0)
					{
				 %>
				 		<script language="Javascript">
						  alert("<%=TSSJavaUtil.instance().getKeyValue("alnoCat",defLangId)%>");
							location.href="report.jsp?reportId=1&a=1&contentp=<%=cpCode%>";
						</script>	
				 <%} else{
						for(int i=0; i < rbtList.size(); i++)
						{	
							Rbt rbt = (Rbt) rbtList.get(i);
							rbtName = rbt.getRbtMaskedName();
							rbtId = rbt.getRbtId();
				 %>
				 
				 <OPTION VALUE="<%=rbtId%>"><%=rbtName%></OPTION>
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
	 <tr class="bluetext" colspan="2">
            <td > <input type="radio"  name="reportType" value="0" size="1" checked onClick="disablefield()"><%=TSSJavaUtil.instance().getKeyValue("curCurr",defLangId)%></td>
            <td > <input type="radio"  name="reportType" value ="1" size="1" onClick = "enablefield()"><%=TSSJavaUtil.instance().getKeyValue("curArch",defLangId)%> </td>
          </tr>
	<tr >
  <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("sTime",defLangId)%></td>
  <td class="tfield"><input type="text" name="start" id="f_date_c1" readonly="1"  />
  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
	Calendar.setup({
	inputField     :  "f_date_c1",  // id of the input field
	ifFormat       :  "%m-%Y", // format of the input field
	button         :  "f_trigger_c1",// trigger for the calendar (button ID)
  align          :  "Tl",           // alignment (defaults to "Bl")
	singleClick    :  true
	});
</script>

<tr >
  <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("eTime",defLangId)%></td>
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
                <select name="aggre" size="1" >
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("sysmMon",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("sysmYear",defLangId)%></option>
		</select>
            </td>
   </tr>
  <tr >
     <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curFormat",defLangId)%></td>
            <td class="tfield">
                <select name="format" size="1">
                  <option selected><%=TSSJavaUtil.instance().getKeyValue("Tabular",defLangId)%></option>
                  <option><%=TSSJavaUtil.instance().getKeyValue("CSV",defLangId)%></option>
		  <option><%=TSSJavaUtil.instance().getKeyValue("Line_Graph",defLangId)%></option>
		  <option><%=TSSJavaUtil.instance().getKeyValue("Bar_Graph",defLangId)%></option>	
                </select>
            </td>
   </tr>
<!--	
<tr id="setting1">
       <td class="tfield1"> <%=TSSJavaUtil.instance().getKeyValue("Select_SProfile",defLangId)%> </td>
            <td class="tfield">
                <select name="setting" size="1" >
                  <option value="day"><%=TSSJavaUtil.instance().getKeyValue("Day-date",defLangId)%></option>
                  <option value="fr" selected><%=TSSJavaUtil.instance().getKeyValue("Friend",defLangId)%></option>
                  <option value="gr"><%=TSSJavaUtil.instance().getKeyValue("Group",defLangId)%></option>
                  <option value="de"><%=TSSJavaUtil.instance().getKeyValue("default",defLangId)%></option>
                </select>
            </td>
   </tr>
			-->
  <!--
	<tr >
       <td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("curSubType",defLangId)%> </td>
            <td class="tfield">
                <select name="subtype" size="1">
                  <option value="P"><%=TSSJavaUtil.instance().getKeyValue("prepaid",defLangId)%></option>
                  <option value="O"><%=TSSJavaUtil.instance().getKeyValue("postpaid",defLangId)%></option>
                  <option value="B" selected><%=TSSJavaUtil.instance().getKeyValue("Both",defLangId)%></option>
                </select>
            </td>
   </tr>
	-->
	<input type="hidden" name="cat_id" value="<%=catId%>">
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
