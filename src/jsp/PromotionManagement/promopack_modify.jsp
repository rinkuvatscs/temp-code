<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2012))
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
	int packId = Integer.parseInt(request.getParameter("packId"));
	PromotionPackManager promoManager = new PromotionPackManager() ;
      promoManager.setConnectionPool(conPool);

	ArrayList packAl =  new ArrayList();
	int val = promoManager.getPromotionPack(packAl, packId);     

	ChargingCodeManager chgManager = new ChargingCodeManager() ;
         chgManager.setConnectionPool(conPool);

	ArrayList chgAl =  new ArrayList();
	 val = chgManager.getChargingCode(chgAl);     
	%>
		<html>
		<head>
		<script language="javascript">
		function validate()
		{
			packname = document.forms.form1.packname.value;
			packcost = document.forms.form1.packcost.value;
			if(packname=="")
			{
				alter("<%=TSSJavaUtil.instance().getKeyValue("alentpack",defLangId)%>");
				document.forms.form1.packname.focus();
				return false;
			}
			if(packcost=="")
			{
				alter("<%=TSSJavaUtil.instance().getKeyValue("alentpackcost",defLangId)%>");
				document.forms.form1.packcost.focus();
				return false;
			}

			return true;
		}//validate
	</script>
		</head>
		</html>

		<%@ include file = "../pagefile/header.html" %>
		<form name="form" method="post" action="modifyPromoPack.jsp?packId=<%=packId%>" onSubmit="return validate()">
		<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
		<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("pmModify",defLangId)%><br><br> </td></tr>
				<%

             for(int z =0;z<packAl.size();z++)
						 {
						  PromotionPack promo = (PromotionPack) packAl.get(z);
				%>

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackName",defLangId)%> </td>
             <td ><input type="text" name="packname" maxlength=25 value="<%=promo.getPackName()%>">    </td>
             <input type="hidden" name="packnameold"  value="<%=promo.getPackName()%>">
          </tr>

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackSize",defLangId)%> </td>
<input type="hidden" name="old_packsize" value="<%=promo.getPackSize()%>">
             <td ><select  name="packsize"  >
							<%
						     for (int x=1;x<5;x++)
									{
									  int y = x*5;
								%>
								<option value="<%=y%>" <%if(y == promo.getPackSize()){%>selected<%}%> ><%=y%></option>
								<%
								}
								%>
							</select>
							</tr>
							<tr class="tfield">
							<td ><%=TSSJavaUtil.instance().getKeyValue("pmpackcost",defLangId)%></td>
<input type="hidden" name="old_packcost" value="<%=promo.getPackCost()%>">
							<td ><select  name="packcost">
							<%
							for (int j=0; j<chgAl.size(); j++)
							{
											ChargingCode oc = (ChargingCode) chgAl.get(j);
if(oc.getChgCode()>7)
                                        {

											%>
															<option value="<%=oc.getChgCode()%>" <%if(promo.getPackCost()==oc.getChgCode()){%> selected<%}%> ><%=oc.getDesc()%></option>
															<%
}
							}
								%>
												</select>
												</td>
												</tr>

												<tr class="tfield">
												<td ><%=TSSJavaUtil.instance().getKeyValue("pmpackFreerbt",defLangId)%></td>
<input type="hidden" name="old_freerbtpack" value="<%=promo.getFreeRbt()%>">
												<td ><select  name="freerbtpack"> (in $US)
						 <%
						      for (int x=0;x<10;x++)
									{
								%>
								<option value="<%=x%>" <%if(x == promo.getFreeRbt()){%>selected<%}%> ><%=x%></option>
								<%
								}
								%>
			 </td>
          </tr>

						<%
				     }
						%> 

							  <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
%>
