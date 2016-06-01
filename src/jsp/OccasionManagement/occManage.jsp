<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(1021))
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

				OccasionManager 	ocManager = new OccasionManager();
                ocManager.setConnectionPool(conPool);
				ArrayList ocAl =  new ArrayList();
				int val = ocManager.getOccasions(ocAl);     
				%>
								<HTML>
								<HEAD>
								<script language="JavaScript">
								function validate()
								{
												var chkbox = document.forms.form.delOcc
																var allunchecked = true
																for (i=0 ;i<chkbox.length;i++)
																{
																				if(chkbox[i].checked == true)
																				{
																								allunchecked = false
																												break
																				}
																}
												if (chkbox.length == undefined)
												{
																if(chkbox.checked == true)
																				allunchecked = false
												}
												if( allunchecked == true) {
																alert("<%=TSSJavaUtil.instance().getKeyValue("alselat",defLangId)%>")
																				return false
												}
								}
				</script>
								</HEAD>

								<%@ include file = "../pagefile/header.html" %>

								<form name="form" method="post" action="deleteOcc.jsp" onSubmit="return validate()">
								<table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">

								<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("omTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%> <br><br></td></tr>
								<%
								if( val < 0 )
								{
												%>			 
																<tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%>.<br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
																<%
								}
								else if( ocAl == null)
								{
												%>			 
																<tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%>.<br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
																<%
								}
								else
								{
												%>
																<tr class="tfields" bgcolor="#a5c7d0">
																<td width="45%"><%=TSSJavaUtil.instance().getKeyValue("omName",defLangId)%></td>
																<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("omDate",defLangId)%></td>
																<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("omPermanent",defLangId)%></td>
																<%
																if(sessionHistory.isAllowed(1022) )
																{
																				%>		
																								<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
																								<%
																}
												if(sessionHistory.isAllowed(1023) )
												{
																%>
																				<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%> </td>
																				<%
												}
												%>
																</tr>
																<%
																for (int j=0; j<ocAl.size(); j++) 
																{
																				Occasion oc = (Occasion) ocAl.get(j);
																				%>
																								<tr <%if ( (j % 2) == 0){ %>class="rowcolor1"<%} else {%> class="rowcolor2"<%}%>   >
																								<td  align="left"><%=oc.getOccasionName().trim()%> </td>
																								<td ><%=oc.getOccasionDate().trim()%> </td>
																								<td ><%=oc.getIsConstant().trim()%> </td>
																								<%
																								if(sessionHistory.isAllowed(1022) )
																								{
																												%>		
																																<td ><a href="occ_modify.jsp?ocname=<%=oc.getOccasionName().trim()%>"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%></a> </td>
																																<%}
																												if(sessionHistory.isAllowed(1023) )
																												{
																																%>

																																				<td >  <input type="checkbox" name="delOcc" value="<%=oc.getOccasionName()%>"> </td>
																																				<%}
																}%>	
												</tr>
																<%
								} // for loop
				%>
								<%
								if(sessionHistory.isAllowed(1023) )
								{
												%>		
																<tr class="button1">
																<td colspan="6"><br>   <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%>">
																<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
																</td>
																</tr>		
																<%
								}

				%>

								</table>

								</form>
								<%@ include file = "../pagefile/footer.html" %>

								<%
}
%>
