
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
				AdvertiseManager adManager = new AdvertiseManager();
                  adManager.setConnectionPool(conPool);

				ArrayList advertiseAl = new ArrayList();
				ArrayList advertiseArr = new ArrayList();
									long catId	= 0;
									String catName="" ;
     
		    long adId = Long.parseLong( request.getParameter("adId") );
				int i = adManager.viewAdDetail(advertiseAl,adId);


 %>
<HTML>
<HEAD>
<TITLE><%=TSSJavaUtil.instance().getKeyValue("advManage")%> </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<link rel="stylesheet" type="text/css" media="all" href="../pagefile/calendar-win2k-cold-1.css" title="win2k-cold-1" />
<script type ="text/javascript" src="../pagefile/calendar.js"></script>
<script type ="text/javascript" src="../pagefile/calendar-setup.js"></script>
<script type ="text/javascript" src="../pagefile/lang/calendar-en.js"></script>
<script type ="text/javascript" src="../pagefile/DynamicOptionList.js"></script>
<script type ="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type ="text/javascript" src="../Scripts/dateCheck.js"></script>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript">

    function validate()
		{
		  var name=document.forms.form.adName.value;
			var adMax = document.forms.form.adMax.value;
			var adSent = document.forms.form.adSent.value;
			
			if( name =="" || adMax=="" || adSent =="")
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alalf")%> ")
								return false
				}
				
			return 	dateCheck()        //call dateCheck() function in /Scripts dir.
		
		}//validate

</script>

</HEAD>

<%@ include file = "../pagefile/header.html" %>
<form name="form" method="post" action="modifyAd.jsp?id=mod" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("modiaddet")%> </td></tr>
			<input type="hidden" name="adId" value="<%=adId%>">
			<%
			          for(int x=0;x<advertiseAl.size();x++)
								{
												Advertise advertise = (Advertise) advertiseAl.get(x);
			%>
			<tr class="tfields">
			  <td><%=TSSJavaUtil.instance().getKeyValue("adName")%> </td>
				<td><input type="text" name="adName" size="20" maxLength="20" value="<%=advertise.getAdName()%>"></td>
			</tr>
			<tr class="tfields">
			  <td><%=TSSJavaUtil.instance().getKeyValue("adCat")%>  </td>
				<td><select name="adCat">
				<%
				   int j = adManager.viewAdCategory(advertiseArr,0);
							for(int y=0;y<advertiseArr.size();y++)
							{
									Advertise ad =(Advertise) advertiseArr.get(y);
											catId = ad.getCatId();
											catName = ad.getCatName();
				%>
							<option value="<%=catId%>"><%=catName%></option>
				<%
				      }
				%>						
						</select> 
				</td>
			</tr>
			<tr class="tfields">
			  <td><%=TSSJavaUtil.instance().getKeyValue("adFreq")%>  </td>
				<td><select name="adFre">
				     <option value="1"><%=TSSJavaUtil.instance().getKeyValue("low")%> </option>
				     <option value="2"><%=TSSJavaUtil.instance().getKeyValue("medium")%> </option>
				     <option value="3"><%=TSSJavaUtil.instance().getKeyValue("high")%> </option>
						</select> 
				</td>
				<tr class="tfields">
			      <td> <%=TSSJavaUtil.instance().getKeyValue("stDate")%> </td>
					  <td><input type="text" name="start_date" id="f_date_c1" readonly="1" value="<%=advertise.getStartDate()%>" />
							  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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
      				  
			<tr class="tfields">
			      <td> <%=TSSJavaUtil.instance().getKeyValue("endDate")%> </td>
            <td><input type="text" name="end_date" id="f_date_c2" readonly="1"  value="<%=advertise.getEndDate()%>"/>
							  <img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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

			<tr class="tfields">
			  <td><%=TSSJavaUtil.instance().getKeyValue("maxAd")%> </td>
				<td><input type="text" name="adMax" maxLength="10" onkeyPress="return numberOnly(event)" value="<%=advertise.getAdMax()%>"></td>
			</tr>						
			<tr class="tfields">
			  <td><%=TSSJavaUtil.instance().getKeyValue("adsent")%> </td>
				<td><input type="text" name="adSent" maxLength="10" onkeyPress="return numberOnly(event)" value="<%=advertise.getAdSent()%>" ></td>
			</tr>						
		
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%> "> <input type="reset" name="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%> "></td>
			</tr>
        <% }%> 
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%

}

%>
