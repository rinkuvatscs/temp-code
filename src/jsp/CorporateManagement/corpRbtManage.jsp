
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("corpRbtManage.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if (sessionHistory == null || !(sessionHistory.isAllowed(158)))
{
	%>
		<%@ include file="../logouterror.jsp" %>
		<%		
}
else {
 %>
         <%@ include file="../lang.jsp" %>
 <%

        CorpManager corpManager = new CorpManager();  
        corpManager.setConnectionPool(conPool);
				CorpUser corpUser =   new CorpUser();
								
				int x = corpManager.getCorpRbtSettings(corpUser);
				if(x<0)
				{
		%>
		<script language="javascript">
		  alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
			history.go(-1);
		</script>
<% }
 else
 {
          int startTime=Integer.parseInt(corpUser.getStartTime());
					int endTime =Integer.parseInt( corpUser.getEndTime());
					String day =    corpUser.getDays();
					int days =   Integer.parseInt( corpUser.getDays());
					int stId = corpUser.getStParamId();
					int edId = corpUser.getEndParamId();
					int dayId= corpUser.getDayParamId();
					logger.info("days ="+ day+" "+days);

 %>
 <html>
 <head>
	<Script Language="JavaScript"><!--Hide from non-JavaScript Browsers 

		function validate()
		{
		
			var x= document.getElementById("select1")
		  var start_time = x.selectedIndex
			var y= document.getElementById("select2")
		  var  end_time = y.selectedIndex
				
				if (end_time <= start_time)
				{
					alert("<%=TSSJavaUtil.instance().getKeyValue("alendgrst",defLangId)%>")
						return false
				}
			
			var testday = document.forms.form1.checkbox1
					var count=0
					var isSelected = "false"
					while(count<testday.length)
					{
						if(testday[count].checked==true)
						{
							isSelected = "true"
								break
						}
						else
						{
							isSelected = "false"
						}
						count=count + 1
					}
				if(isSelected=="false")
				{
					alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("alminiaday",defLangId)%>")
						return false
				}
 }//validate
-->
</script>
 <%@ include file="../pagefile/header.html"%>
			<form name="form1" method="post" action="updateRbtSetting.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">
				
				<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("corpChangesetting",defLangId)%> <br><br></td></tr>
					  
		 <tr >
            <td width="20%" class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("sTime",defLangId)%></td>
						<td  align="left">
						 <select name="select1">
						 <%for(int i=8;i<=17;i++)
						 {
						 %>
						 <option value="<%=i%>" <%if(i==startTime){%>selected<%} %> ><%=i%></option>
						 <%}%>
						 </select>
						 </td>
     </tr>
		 <tr>
		        <td width="20%" class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("eTime",defLangId)%> </td>
						<td  align="left">
      		 <select name="select2">
						 <%for(int i=8;i<=17;i++)
						 {
						 %>
						 <option value="<%=i%>" <%if(i==endTime){%>selected<%} %> ><%=i%></option>
						 <%}%>
						 </select>
						</td> 

      </tr>
			<tr>
			      <td width="20%" class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("day",defLangId)%> </td>
             <td  valign="top"><table width="100%"  border="0" cellpadding="3" cellspacing="1" >
								<tr  class="rowstyle2 ">
                    <td align="center"><span id="day1" style="display: block">Mon </span></td>
                    <td align="center"><span id="day2" style="display: block">Tue </span></td>
                    <td align="center"><span id="day3" style="display: block">Wed </span></td>
                    <td align="center"><span id="day4" style="display: block">Thu </span></td>
                    <td align="center"><span id="day5" style="display: block">Fri </span></td>
                    <td align="center"><span id="day6" style="display: block">Sat </span></td>
                    <td align="center"><span id="day7" style="display: block">Sun </span></td>
                  </tr>
                  <tr  class="rowstyle1">
									<%
								
for(int m=0; m < 7; m++)
		{
			if(day.charAt(m) == '1')
			{
		%>
       <td align="center"><span id="check<%=m+1%>" style="display: block">
			<input type="checkbox" name="checkbox1" value="<%=m%>"  checked> </span></td>
		<%
		  }
			else
			{
		%>
       <td align="center"><span id="check<%=m+1%>" style="display: block">
		<input type="checkbox" name="checkbox1>" value="<%=m%>" > </span></td>
		<%
		  }
		}
		%>
								   </tr>
                </table></td>
              </tr>
             
			</tr>		

			<tr class="button1">
			  <td colspan="2" align="left"><input name ="submit" type="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">
			  <input name ="clear" type="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>


					<%			
 }
}//else main
%>
