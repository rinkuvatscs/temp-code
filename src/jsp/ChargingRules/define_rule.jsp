<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("define_rule.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2051))
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
	ChargingCodeManager chgManager = new ChargingCodeManager() ;
         chgManager.setConnectionPool(conPool);
	ChargingCode chgCode;
	ChargingCode chgCode1;
	ArrayList colAl = new ArrayList();
	int colVal = chgManager.getTableCol(colAl);
	ArrayList chgAl =  new ArrayList();
	int val = chgManager.getChargingCode(chgAl);
	if(val < 0)
	{
	 logger.info("Charging Rules not defined");
		%>
			<script language="javascript">
			//alert("Please define charging rules");
                         alert(<%=TSSJavaUtil.instance().getKeyValue("charging_rules",defLangId)%>)

		window.location="home.jsp";
		</script>
			<%
	}
	else
	{
		%>	
			<%@ include file = "../pagefile/header.html" %>

			<form name="form" method="post" action="defineChargingRule.jsp" onSubmit="return validate()">
			<table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">

			<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("Charging_Rule_ManagementDefine_Rule",defLangId)%><br><br></td></tr>
			<tr class="tfields" bgcolor="#a5c7d0">
			<td width="45%"><%=TSSJavaUtil.instance().getKeyValue("Charging_Event",defLangId)%></td>
			<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("crname",defLangId)%></td>
			</tr>
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Subscription_Charge_Code",defLangId)%></tD>
			<td>
			<select name="subCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		

			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("RBT_Charge_Code",defLangId)%></tD>
			<td>
			<select name="rbtCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Normal_RBT_Charge_Code",defLangId)%></tD>
			<td>
			<select name="rbtNormalCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("RBT_No_Charge_Code",defLangId)%></tD>
			<td>
			<select name="rbtNoCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Recodered_RBT_Charge_Code",defLangId)%></tD>
			<td>
			<select name="rbtRecCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Gift_RBT_Charge_Code",defLangId)%></tD>
			<td>
			<select name="rbtGiftCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		

			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("rbtmonochg",defLangId)%></tD>
			<td>
			<select name="rbtMonoCharge">
			<%
			for(int k = 0;k<chgAl.size();k++)
			{ 
				chgCode = (ChargingCode) chgAl.get(k);
				%>	 
					<option value="<%=chgCode.getChgCode()%>"><%=chgCode.getDesc()%> (Amt=$ <%=chgCode.getAmount()%>)</option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		

			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Free_RBTs",defLangId)%></tD>
			<td>
			<select name="rbtFree">
			<%
			for(int k = 0;k<10;k++)
			{ 
				%>	 
					<option value="<%=k%>"><%=k%></option>
					<%
			}
		%>		
			</select>
			</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue(" Validity_Period",defLangId)%></tD>
			<td><input type="text" name="validity" maxlength="3" onkeypress="return numberOnly(event)">	</td>
			</tr>		
			<tr class="tfield1"> 
			<td><%=TSSJavaUtil.instance().getKeyValue("Remarks",defLangId)%></tD>
			<td><input type="text" name="remarks">	</td>
			</tr>		

			<tr class="button1">
			<td colspan="2"><br><input type="submit" name="submit" value="Submit"> <input type="reset" name="Clear" value="Clear"></td>
			</tr>

			</table>

			</form>

			<%@ include file = "../pagefile/footer.html" %>

			<%
	}   
}//main else
%>
