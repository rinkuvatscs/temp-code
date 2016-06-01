<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2011) )
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

	ChargingCodeManager chgManager = new ChargingCodeManager() ;
   chgManager.setConnectionPool(conPool);
	ArrayList chgAl =  new ArrayList();
	int val = chgManager.getChargingCode(chgAl);     
%>
<html>
<head>
<script language="javascript">
function validate()
{
if(document.forms.form.packname.value=="")
{
alert("<%=TSSJavaUtil.instance().getKeyValue("alentprname",defLangId)%>");
return false;
}
return true;
}
</script>
</head>
 
<%@ include file = "../pagefile/header.html" %>
   <form name="form" method="post" action="addPromoPack.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
          <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("pmdefine",defLangId)%><br><br> </td></tr>
					

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackName",defLangId)%> </td>
             <td ><input type="text" name="packname" maxlength=25 >    </td>
          </tr>

          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackSize",defLangId)%> </td>
             <td ><select  name="packsize"  >
							<%
						     for (int x=1;x<=10;x++)
									{
								%>
								<option value="<%=(x*1)%>"><%=(x*1)%></option>
								<%
								}
								%>
								<option value="15">15</option>
								<option value="20">20</option>
							</select>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackcost",defLangId)%></td>
													<td ><select  name="packcost"> 
             <%
				for (int j=0; j<chgAl.size(); j++) 
				{
					ChargingCode oc = (ChargingCode) chgAl.get(j);
if(oc.getChgCode()>7)
                                        {

					%>
						<option value="<%=oc.getChgCode()%>"><%=oc.getDesc()%></option>
		<%
}}
%>
</select>
</td>
</tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("pmpackFreerbt",defLangId)%></td>
             <td ><select  name="freerbtpack"> 
						 <%
						      for (int x=0;x<11;x++)
									{
								%>
								<option value="<%=x%>"><%=x%></option>
								<%
								}
								%>
								
						 </td>
          </tr>
				  <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
%>
