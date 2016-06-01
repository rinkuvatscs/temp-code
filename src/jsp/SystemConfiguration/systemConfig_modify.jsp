
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("systemConfig_modify.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(111))
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

								String param = request.getParameter("param");
								String value = request.getParameter("value");
								String old_value=value;
								ArrayList systemConfigVl = new ArrayList();
								String remark = request.getParameter("remark");
								logger.info("param=="+param+"value=="+value+"remark=="+remark);
								%>
																<HTML>
																<HEAD>
																<script type="text/javascript">
																<!--
																function validate() 
																{
																								var val = document.forms.form.value.value;
																								var rem = document.forms.form.remark.value;
																								val = val.replace(/^\s+/, ''); // trim leading white spaces
																								val = val.replace(/\s+$/, ''); // trim trailing white spaces
																								rem = rem.replace(/^\s+/, ''); // trim leading white spaces
																								rem = rem.replace(/\s+$/, ''); // trim trailing white spaces
																								if(val == "") 
																								{
																																alert("<%=TSSJavaUtil.instance().getKeyValue("alsys1",defLangId)%>")
																																								document.forms.form.value.focus()
																																								return false
																								}
																								if(rem == "") 
																								{
																																alert("<%=TSSJavaUtil.instance().getKeyValue("alsys2",defLangId)%>")
																																								document.forms.form.remark.focus()
																																								return false
																								}
																								return true;
																}
								-->
function validation()
{
return confirm("Are you sure you want to change")	
}
																</script>
																</HEAD>

																<%@ include file = "../pagefile/header.html" %>
																<% int i=0; %>
																<% if((param.equals("DEFAULT_RATE_PLAN"))||(param.equals("IVR_DEFAULT_LANGUAGE")))
																{
																								SystemConfigManager systemConfigManager = new SystemConfigManager();
                             systemConfigManager.setConnectionPool(conPool);
																								i =   systemConfigManager.getSystemConfigParamValue(systemConfigVl,param);
																}
								%> 
																<form name="form" method="post" action="modifySystem.jsp" onSubmit ="return validation()">
															<input type="hidden" id="old_value" name="old_value" value="<%=old_value%>" />
																<table width="80%" border="0" align="center">
																<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("syscTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%><br><br></td></tr>
																<tr class="tfield">
																<input type="hidden" name="param" value="<%=param%>">
																<td width="25%"><%=TSSJavaUtil.instance().getKeyValue("syscCol1",defLangId)%> </td>
																<td ><%=param%> </td>
																</tr>
																<tr class="tfield">
																<td width="25%">OWNER </td>
																<td >OPERATOR </td>
																</tr>

																<tr class="tfield">
																<td ><%=TSSJavaUtil.instance().getKeyValue("syscCol2",defLangId)%> </td>
																<td>
																<% if(param.equals("DEFAULT_RATE_PLAN"))
																																{ 
																																Iterator ite = systemConfigVl.iterator(); %>
																																<select name="value" >
																																<option value="<%=value%>" selected="selected"><%=value%></option>
																																<%	while(ite.hasNext())
																																{
																																SystemConfig systemConfig = (SystemConfig)ite.next();
																																								if(!value.equals(systemConfig.getParamValue()))
																																									{
																																%>
																																<option value="<%=systemConfig.getParamValue()%>" ><%=systemConfig.getParamValue()%></option>
																																<%
																																	}
																																				}%>
																																</select>
																																<% }
																																else if(param.equals("IVR_DEFAULT_LANGUAGE"))
																																{
																																if(i>1)
																																{
																																Iterator ite1 = systemConfigVl.iterator(); 
																																String language_name="";
																															 while(ite1.hasNext())
																																{
																																								SystemConfig systemConfig1 = (SystemConfig)ite1.next();
																																			if(value.equals(systemConfig1.getParamTag()))
																																		{
																																			language_name=systemConfig1.getParamValue();
																																		}
																																}
																																Iterator ite = systemConfigVl.iterator(); 
 %>
																																<select name="value" >
																																<option value="<%=value%>" selected="selected"><%=language_name%></option>
																																<%	while(ite.hasNext())
																																{
																																								SystemConfig systemConfig = (SystemConfig)ite.next();
																																								if(!language_name.equals(systemConfig.getParamValue()))
																																									{
																																								%>
																																																<option value="<%=systemConfig.getParamTag()%>" ><%=systemConfig.getParamValue()%></option>
																																																<%
																																												}
																																																}%>
																																</select>
																																<%
																																}
																																else
																																{%>
																																								<input type="text" name="value" id="value" value="<%=value%>" disabled >

																																																<%	}
																																}
								else if((value.equals("YES"))||(value.equals("yes")))
								{%>
																<select name="value" >
																								<option value="1" selected="selected"><%=value%></option>
																								<option value="0" >NO</option>
																								</select>
																								<%}
								else if((value.equals("NO"))||(value.equals("no")))
								{%>
																<select name="value" >
																								<option value="0" selected="selected"><%=value%></option>
																								<option value="1" >YES</option>
																								</select>
																								<%}

																else
																{
																								//			logger.info("user_name=="+userId+"password=="+password);
																								%>
																																<input type = "text" name="value" maxlength=50 size=20 value="<%=value%>" onkeypress="return numberOnly(event)"> 
																																<%}%></td>
																								</tr>
																								<tr class="tfield">
																								<td ><%=TSSJavaUtil.instance().getKeyValue("syscCol3",defLangId)%> </td>
																								<td ><textarea name="remark" maxlength="100" cols="40" rows="5" onkeypress="return disableReturnKey(event)"><%=remark%></textarea> </td>
																								</tr>
																								<tr class="button1" >
																								<td colspan="2">
																								<input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("save",defLangId)%>" >
																								<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("reset",defLangId)%>">
																								</td>
<tr class="homemenu"><td></td><td><a href="viewModifyConfig.jsp">Go back</a></td></tr>
																								</tr>

																								</table>
																								</form>

																								<%@ include file = "../pagefile/footer.html" %>
																								<%
}

%>
