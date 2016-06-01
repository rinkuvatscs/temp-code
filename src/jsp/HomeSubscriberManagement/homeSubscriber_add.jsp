
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(142))
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
  HLRManager hlrManager = new HLRManager();
  hlrManager.setConnectionPool(conPool);
	ArrayList  hlrconfigAl = new ArrayList();
	int hlrId = -1;
	int i = hlrManager.getHLRConfig(hlrconfigAl,hlrId);

%>
<html>
<head>
	<script type="text/javascript">
		function validate()
		{
			return validRange()   // check for validity of mobile numbers entered, in Scripts/SunscriberRange.js

  } //validate
		
	</script>
</head>

<%@ include file = "../pagefile/header.html" %>

   <form name="form" method="post" action="addhomesubscriber.jsp" onsubmit="return validate()">
       <table width="80%" border="0" align="center" cellspacing="2" cellpadding="4">
         <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("Home_Sub_Man_ADD",defLangId)%> <br><br></td></tr>
			<%
			   if ( i < 0 )
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p> <%=TSSJavaUtil.instance().getKeyValue("Data_not_Found",defLangId)%></p> </td>
				 </tr>			
			<%
					}
			   else if ( hlrconfigAl.size() <= 0)
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p><%=TSSJavaUtil.instance().getKeyValue("Neccessary_Data_not_Found",defLangId)%> <a href="../HLRConfig/hlrConfig_add.jsp">Add HLR Configuration</a> First!!!</p> </td>
				 </tr>			
			<%
					}
					else
					{
			%>	
				 <tr class="tfield">				 
              <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("Range",defLangId)%> </td>
              <td >  <input type="text" name="startat" maxLength="12" onkeypress="return numberOnly(event)">&nbsp;
                  to &nbsp; 
									   <input type="text" name="endsat"maxLength="12"  onkeypress="return numberOnly(event)">
              </td>
				 </tr>			
         <tr class="tfield">
              <td > <%=TSSJavaUtil.instance().getKeyValue("Exclusions",defLangId)%></td>
              <td ><textarea name="excludes" cols="39" rows="5" onkeypress="return exclusionRange(event)"></textarea><br><p class="notice"><sup>*</sup><%=TSSJavaUtil.instance().getKeyValue("Write_each_number",defLangId)%> </p></td>
         </tr>
         <tr class="tfield">
               <td width="20%"> <%=TSSJavaUtil.instance().getKeyValue("HLR_Name",defLangId)%></td>
               <td >
										<select name="hlr">
<%
						for (i=0; i<hlrconfigAl.size(); i++)
							{
									HLR hlr = (HLR) hlrconfigAl.get(i);
%>
											<option value="<%=hlr.getHLRId()%>"><%=hlr.getHLRName()%></option>
<%
							}
%>
									</select>
							</td>
          </tr>
          <tr class="button1">
                <td colspan="2"><br> <input type="submit" name="submit" value="ADD"> <input type="reset" name="clear" value="CLEAR"></td>
          </tr>
				<%
					}  //else
				%>	
        </table>
    </form>
        <script language="javascript">
		<!--
		document.form.startat.focus();
		//-->
	</script>

<%@ include file = "../pagefile/footer.html" %>

<%
	
}
%>
