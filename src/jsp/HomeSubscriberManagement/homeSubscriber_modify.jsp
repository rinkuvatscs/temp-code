
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(143))
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

  HomeSubscriberManager homeManager = new HomeSubscriberManager();
    homeManager.setConnectionPool(conPool);
	HomeSubDetail homeSubDetail = new HomeSubDetail();
	HLRManager hlrManager = new HLRManager();
	hlrManager.setConnectionPool(conPool);

	ArrayList homeSubDetailAl = new ArrayList();
	
		int i = homeManager.getHomeSubscriber(homeSubDetailAl);

	int rangeId = Integer.parseInt(request.getParameter("rangeid"));
	Iterator ite = homeSubDetailAl.iterator();
	String excludes = "";
	
	while(ite.hasNext())
	{
		homeSubDetail = (HomeSubDetail) ite.next();
		if( homeSubDetail.getRangeId() == rangeId )
		{
						break;
		}
	}

	Iterator iteExc = (homeSubDetail.getExcludes()).iterator();
	while(iteExc.hasNext())
	{
		if(excludes.equals(""))
			excludes = (String)iteExc.next();
		else
			excludes = excludes + "  " + (String)iteExc.next();
	}

	ArrayList  hlrConfigAl = new ArrayList();
	int hlrId = -1;
	int j = hlrManager.getHLRConfig(hlrConfigAl,hlrId);
	
%>

<html>
<head>
<script language="javascript">
	function validate()
		{
			return validRange()  // checks for validity of MSISDN, in Scripts/SubscriberRange.js
		}
</script>
</head>

<%@ include file = "../pagefile/header.html" %>

    <form name="form" method="post" action="modifyhomesub.jsp?rangeid=<%=rangeId%>"  onSubmit="return validate()" >
		
       <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
         <tr class="tableheader"><td colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("Subscriber_Management_Modify",defLangId)%><br><br> </td></tr>
         <%
				  if ( j < 0 )
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p> <%=TSSJavaUtil.instance().getKeyValue("Data_not_Found",defLangId)%></p> </td>
				 </tr>			
			<%
					}
			   else if ( hlrConfigAl.size() <= 0)
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p> <%=TSSJavaUtil.instance().getKeyValue("Neccessary_Data_not_Found",defLangId)%> <a href="../HLRConfig/hlrConfig_add.jsp">Add HLR Configuration</a> First!!!</p> </td>
				 </tr>			
			<%
					}
					else
					{
			%>	
				
			 <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("Range",defLangId)%></td>
              <td><input type="text" name="startat" maxlength="12"value="<%= homeSubDetail.getStartAt()%>" onkeypress="return numberOnly(event)" >
											&nbsp;to
                <input type="text" name="endsat"maxlength="12" value="<%= homeSubDetail.getEndsAt()%>">
              </td>
         </tr>
         <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("Exclusions",defLangId)%> </td>
              <td ><textarea name="excludes" cols="39" rows="5" onkeypress="return exclusionRange(event)"><%=excludes%></textarea><br><p class="notice"><sup>*</sup> <%=TSSJavaUtil.instance().getKeyValue("Write_each_number",defLangId)%></p></td>
         </tr>
         <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("HLR_Name",defLangId)%></td>
							<td> <select name=hlr>
						<%
								for (i=0; i<hlrConfigAl.size(); i++)
								{
												HLR hlr = (HLR) hlrConfigAl.get(i);
												if (hlr.getHLRId() == homeSubDetail.getHLRId())
												{
							%>
																				<option value="<%=hlr.getHLRId()%>" selected><%=hlr.getHLRName()%></option>
							<%
												}
												else
												{
							%>
																				<option value="<%=hlr.getHLRId()%>"><%=hlr.getHLRName()%></option>
						  <%
												}
								}
							%>
									</select>
	      			</td>
            </tr>
            <tr class="button1">
              	<td colspan="2" > <input type="submit" name="submit" value="Submit"> <input type="reset" name="Clear" value="Clear"></td>
            </tr>
			<%
			  	} //else
			%>
          </table>
      
			</form>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
