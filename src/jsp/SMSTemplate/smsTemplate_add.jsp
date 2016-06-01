
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if (sessionHistory == null || !sessionHistory.isAllowed(302)) 
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else 
{
				// template type is 10 by default				
        
%>
 <%@ include file="../lang.jsp" %>
<HTML>
<HEAD>
<script type="text/javascript">
    function validate()  
		{
						var x = document.forms.form.desc.value = document.forms.form.desc.value.trim();
						if(x == "")
						{
										alert("<%=TSSJavaUtil.instance().getKeyValue("alenttempdesc",defLangId)%>");
										document.forms.form.desc.focus();
										return false;
						}
						if(document.forms.form.mesg.value == "")
						{
										alert("<%=TSSJavaUtil.instance().getKeyValue("alentmsg",defLangId)%>");
										document.forms.form.mesg.focus();
										return false;
						}
						return true;
		}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    
     <form name="form" method="post" action="addSMSTemplate.jsp" onSubmit="return validate()">
		      <table width="70%" border="1" align="center">
				
        		<tr class="tableheader"><td colspan="2">SMS Template Management - Add SMS<br><br> </td></tr>
           
					  <tr class="tfield" >
              <td width="30%" >Template Description  </td>
              <td ><input type="text" name="desc" ></td>
            </tr>
            <tr class="tfield" >
              <td > Template Message </td>
              <td ><textarea name="mesg" cols="50" rows="8" maxlength="400" onkeypress="return disableReturnKey(event)"></textarea></td>
            </tr>  
            <tr class="tfield" >
              <td > Tokens Allowed</td>
              <td ><textarea name="token" cols="50" rows="5" maxlength="200" readonly=1 onkeypress="return disableReturnKey(event)" >NA</textarea></td>
            </tr>  

            <tr class="tfield" >
              <td >Language </td>
              <td >   <select name="languageId">
													<option value="1">English</option>
													<option value="2">Vietnamese</option>
              			  </select>
              </td>
            </tr>
            <tr class="button1">
              <td colspan="2" >
                  <input type="submit" name="submit" value="Add Keyword">
                  <input type="reset" name="Clear" value="Clear">
              </td>
            </tr>

      </table>
   </form>

<%@ include file = "../pagefile/footer.html" %>
<%
    
}
%>

