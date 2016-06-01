<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2015))
{
	%>
		<%@ include file ="../logouterror.jsp" %>
		<%
}
else
{
 %>
 <%@ include file="../lang.jsp" %>
 <%
int promoId=Integer.parseInt(request.getParameter("promoId"));
	%>
		<HTML>
		<HEAD>

		<script type="text/javascript">
		function validate()
		{
			var startDate = document.forms.form1.startDate.value
				var endDate = document.forms.form1.endDate.value

				var st;
			var ed;	
			var dt;

			st = document.form1.startDate.value;
			ed = document.form1.endDate.value;

			stdate = st.substring(0,2);
			stmonth = st.substring(3,5);
			styear = st.substring(6,10);

			eddate = ed.substring(0,2);
			edmonth = ed.substring(3,5);
			edyear = ed.substring(6,10);

			dt = new Date();
			nowday = dt.getDate();
			nowmonth = dt.getMonth();
			nowyear = dt.getYear();
			nowmonth = nowmonth+1;
			nowyear += (nowyear<1900)? 1900:0


				var sday = nowday.toString();
			var smonth = nowmonth.toString();
			var syear = nowyear.toString();

			if(sday <= 9)
			{
				sday= '0'+sday;
			}
			if(smonth <= 9)
			{
				smonth = '0'+smonth;
			}	
			var Date_today = sday+'-'+smonth+'-'+syear;
			if ((ed == "") && (st == ""))
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstend",defLangId)%>");
				return false;
				document.form1.startDate.focus();

			}

			if (st == "")
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstdate",defLangId)%>");
				return false;
				document.form1.startDate.focus();

			}

			if (ed == "")
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alenddate",defLangId)%>");
				return false;
				document.form1.endDate.focus();

			}

			if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstless",defLangId)%>");
				return false;
				document.form1.startDate.focus();

			}

			if ( parseInt(edyear+edmonth+eddate) < parseInt(syear+smonth+sday) )
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alendgr",defLangId)%>"+Date_today);
				end="";
				document.form1.endDate.focus();
				return false;
			}
			if ( parseInt(styear+stmonth+stdate) < parseInt(syear+smonth+sday) )
			{
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstcur",defLangId)%>"+Date_today);
				end="";
				document.form1.startDate.focus();
				return false;
			}


			//		return true;
		}


	</script>
		</HEAD>


		<%@ include file = "../pagefile/header.html" %>
		<form name="form1" method="post" action="modifyPromoOffer.jsp?promoId=<%=promoId%>" onSubmit="return validate()">
		<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
		<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("pmdefine",defLangId)%><br><br> </td></tr>


		<tr class="tfield">
		<td ><%=TSSJavaUtil.instance().getKeyValue("sTime",defLangId)%> </td>
		<td class="tfield"><input type="text" name="startDate" id="f_date_c1" readonly="1"  />
		<img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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

</tr>
<tr class="tfield">
<td ><%=TSSJavaUtil.instance().getKeyValue("eTime",defLangId)%> </td>
<td class="tfield"><input type="text" name="endDate" id="f_date_c2" readonly="1"  />
<img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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


<tr class="button1">
<td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
</tr>

</table>

</form>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
