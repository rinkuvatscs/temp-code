<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2012))
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

				PromotionPackManager promoManager = new PromotionPackManager() ;
             promoManager.setConnectionPool(conPool);

				ArrayList packAl =  new ArrayList();
				int val = promoManager.getPromotionPacks(packAl);     
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
																alert("<%=TSSJavaUtil.instance().getKeyValue("alselone",defLangId)%>")
																				return false
												}
								}
				</script>
								</HEAD>

								<%@ include file = "../pagefile/header.html" %>

								<form name="form" method="post" action="deletePack.jsp" onSubmit="return validate()">
								<table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">

								<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("pmTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%> <br><br></td></tr>
								<%
								if( val < 0 )
								{
												%>			 
																<tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%>.<br><a href="home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
																<%
								}
								else if( packAl == null)
								{
												%>			 
																<tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%><br><a href="home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
																<%
								}
								else
								{
												%>
																<tr class="tfields" bgcolor="#a5c7d0">
																<td width="30%"><%=TSSJavaUtil.instance().getKeyValue("pmpackName",defLangId)%></td>
																<td width="30%"><%=TSSJavaUtil.instance().getKeyValue("pmpackSize",defLangId)%></td>
																<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("pmpackcost",defLangId)%></td>
																<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("pmpackFreerbt",defLangId)%></td>
																<%
																if(sessionHistory.isAllowed(2012) )
																{
																				%>		
																								<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
																								<%
																}
												if(sessionHistory.isAllowed(2013) )
												{
																%>
																				<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%> </td>
																				<%
												}
												%>
																</tr>
																<%
																for (int j=0; j<packAl.size(); j++) 
																{
																				PromotionPack promo = (PromotionPack) packAl.get(j);
																				%>
																								<tr <%if ( (j % 2) == 0){ %>class="rowcolor1"<%} else {%> class="rowcolor2"<%}%>   >
																								
																								<td ><%=promo.getPackName()%> </td>
																								<td  align="left"><%=promo.getPackSize()%> </td>
																								<td ><%=promo.getChgRule()%> (<%=promo.getPackCost()%>) </td>
																								<td ><%=promo.getFreeRbt()%></td>
																								<%
																								if(sessionHistory.isAllowed(2012) )
																								{
																												%>		
																																<td ><a href="promopack_modify.jsp?packId=<%=promo.getPackId()%>"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%></a> </td>
																																<%}
																												if(sessionHistory.isAllowed(2013) )
																												{
																																%>

																																				<td >  <input type="checkbox" name="delOcc" value="<%=promo.getPackId()%>"> </td>
																																				<%}
																}%>	
												</tr>
																<%
								} // for loop
				%>
								<%
								if(sessionHistory.isAllowed(2013) )
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
