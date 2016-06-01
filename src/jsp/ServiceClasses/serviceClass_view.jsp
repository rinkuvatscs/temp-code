
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2060))
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
	ServiceClassManager serviceManager = new ServiceClassManager();
         serviceManager.setConnectionPool(conPool);
	ArrayList serviceDetailAl  = new ArrayList();
	RbtRatePlanManager ratePlanManager=new RbtRatePlanManager();
        ratePlanManager.setConnectionPool(conPool);
	ArrayList  rateplanAl = new ArrayList();
	ratePlanManager.getRatePlans(rateplanAl);	

	int i = serviceManager.getServiceClass(serviceDetailAl);

	%>
		<html>
		<head>
		<Script Language="JavaScript">
		function ConfirmChoice()
		{
			answer = confirm("Are you sure you want to delete the selected service class?")
				if (answer !=0)
				{
					return true;
				}
				else
				{
					return false;
				}
		}
	function validate()
	{
		var checkBoxSelected = document.forms.form.rangeid
			var count = 0
			var isSelected = "false"
			if(checkBoxSelected.length != undefined)
			{
				while(count<checkBoxSelected.length)
				{
					if(checkBoxSelected[count].checked==false)
					{
						isSelected  = "false"
					}
					else
					{
						isSelected ="true"
							break
					}
					count +=1
				}
			}
			else
			{
				if(document.forms.form.rangeid.checked==true)
					isSelected = "true"
			}
		if(isSelected=="true")
		{
			return ConfirmChoice()
		}
		else
		{
			alert("Please select at least one record to delete.")
				return false
		}
	}

	</script>
		</head>

		<%@ include file = "../pagefile/header.html" %>

		<form name="form" method="post" action="deleteserviceclass.jsp" onSubmit="return validate()">

		<table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
		<tr class="tableheader" ><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("serviceclassview",defLangId)%><br><br></td></tr>
		<%
		if ( i < 0 || serviceDetailAl.size() <= 0)
		{
			%>
				<tr class="notice">
				<td colspan="4" align="center"> <p>No Service Class  defined!!! <br> Firstly you <a href="serviceClass_add.jsp"> Define Service Class</a> and then View / Delete Service Classes  </P></td></tr>
				<%
		}
		else
		{
			%>
				<tr class="tfields" bgcolor="#a5c7d0">
				<td >Range </td>
				<td >Rate Plan</td>
				<%
				if(sessionHistory.isAllowed(2063))
				{
					%>
						<td >Delete</td>
						<%
				}
			%>
				</tr>
				<%
				int r=0;
			Iterator ite = serviceDetailAl.iterator();
			String remarks="";
			while(ite.hasNext())
			{
				ServiceClass serviceClassDetail = (ServiceClass)ite.next();


				%>
					<tr class="tabledata_center"
					<%if ( (r % 2) == 0){ %><%} else {%> bgcolor="#a5c7c2"<%} r++ ;%>  >
					<td ><%= serviceClassDetail.getStartsAt() %> - <%=serviceClassDetail.getEndsAt() %> </td>
					<%
					Iterator it= rateplanAl.iterator();
				while(it.hasNext())
				{
					RbtRatePlan rateplan=(RbtRatePlan)it.next();
					if(rateplan.getPlanId()==serviceClassDetail.getRatePlan())
					{
						remarks=rateplan.getRemarks();

						break;
					}
				}
				%>
					<td align="centre"><%=remarks%></td>
					<%
					if(sessionHistory.isAllowed(2063))
					{
						%>
							<td>   <input type="checkbox" name="rangeid" value="<%= serviceClassDetail.getRangeId()%>"> </td>
							<%
					}
				%>
					</tr>
					<%
			}
			if(sessionHistory.isAllowed(2063))
			{
				%>
					<tr class="button1">
					<td colspan="4"> <br> <input type="submit" name="submit" value="Delete Record(s)"> <input type="reset" name="Clear" value="Clear"></td>
					</tr>
					<%
			}
			%>
				<%
		}
	%>
		</table>
		</form>

		<%@ include file = "../pagefile/footer.html" %>
		<%
}
%>
