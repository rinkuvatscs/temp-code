
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2060))
{
   %>
    <%@ include file ="../logouterror.jsp" %>
      <%
        session.invalidate();
           request.getSession(true).setAttribute("lang",defLangId);
   }
else
{
  
	int hlrId = -1;

%>
 <%@ include file="../lang.jsp" %>

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

   <form name="form" method="post" action="addprepost.jsp" onsubmit="return validate()">
       <table width="80%" border="0" align="center" cellspacing="2" cellpadding="4">
         <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("addprepost",defLangId)%><br><br></td></tr>
				 <tr class="tfield">				 
              <td width="10%">Range </td>
              <td >  <input type="text" name="startat" maxLength="10" onkeypress="return numberOnly(event)">&nbsp;
                  to &nbsp; 
									   <input type="text" name="endsat"maxLength="10"  onkeypress="return numberOnly(event)">
              </td>
				 </tr>			
         <tr class="tfield">
               <td width="20%">Sub Type</td>
               <td >
										<select name="plan">
											<option value="N">None</option>
											<option value="P">Prepaid</option>
											<option value="O">Postpaid</option>
											<option value="H">Hybrid Postpaid</option>
									</select>
							</td>
          </tr>
										
          <tr class="button1">
                <td colspan="2"><br> <input type="submit" name="submit" value="ADD"> <input type="reset" name="clear" value="CLEAR"></td>
          </tr>
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
