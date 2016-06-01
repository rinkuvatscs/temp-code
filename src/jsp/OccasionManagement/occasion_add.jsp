
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(1020))
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
<html>
<head>

<script type="text/javascript">
  function validate()
	{
					var occasionName = document.forms.form.occasionName.value.trim()
									var occasionDate = document.forms.form.occasionDate.value.trim()

									if(occasionName=="")
									{
													alert("<%=TSSJavaUtil.instance().getKeyValue("aloccmust",defLangId)%>")
																	return false
									}
					if(occasionDate=="")
					{
									alert("<%=TSSJavaUtil.instance().getKeyValue("aloccdmust",defLangId)%>")
													return false
					}
					var st=occasionDate;
					stdate = st.substring(0,2);
					stmonth = st.substring(3,5);
					styear = st.substring(6,10);
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
					if ( parseInt(styear+stmonth+stdate) < parseInt(syear+smonth+sday) )
					{
									alert("<%=TSSJavaUtil.instance().getKeyValue("aloccdatele",defLangId)%>");
									document.forms.form.occasionDate.focus();
									return false;
					}


					return true
	}
</script>

</head>

<%@ include file ="../pagefile/header.html" %>

    <form name="form" method="post" action="addOccasion.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
          <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("omAdd",defLangId)%><br><br> </td></tr>
					

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("omName",defLangId)%> </td>
             <td ><input type="text" name="occasionName" maxlength=25 >    </td>
          </tr>
				<tr >
  <td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("omDate",defLangId)%></td>
  <td class="tfield"><input type="text" name="occasionDate" id="f_date_c1" readonly="1"  />
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

						<tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("omPermanent",defLangId)%></td>
             <td ><select name="occasionConst">
														<option value="Y">Yes</option>
														<option value="N">No</option>
														
								</select>
						 </td>
          </tr>

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%> </td>
             <td ><textarea name="occasionDesc" rows="2" cols="25" >   </textarea></td>
          </tr>
				  <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("omAdd",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
%>
