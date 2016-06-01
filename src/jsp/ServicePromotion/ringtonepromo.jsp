
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*"%>
<%@ page import = "com.telemune.webadmin.webif.*"%>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(160))
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

	ServicePromotionManager serviceManager = new ServicePromotionManager();			
      serviceManager.setConnectionPool(conPool);
	int ret = -1;
	ret = serviceManager.isRingtoneEnabled();

%>
<HTML>
<HEAD>
<script type="text/javascript">
	function validate()
	{
					var calls = document.forms.form1.calls.value
					if (calls == "")
					{
									alert("Please enter a number of calls")
									return false
					}
					if (calls < 50)
					{
									alert("Minimum number of calls should be 50")
									return false
					}
	}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

      <form name="form1" method="post" action="ringtonepromo_execute.jsp" onSubmit="return validate()">
        <table width="70%" border="0" cellspacing="2" align="center">
          <tr class="tableheader"> <td colspan="2">Send Ringtone Promotion SMS<br><BR> </td>      </tr>
<%
				if(ret < 0 )
				{
%>			
          <tr class="notice">
		          <td colspan="2" >There is some problem in Data fecthing. Please Try againn Later!!!  </td>
					</tr>
		
<%     }

				else if (ret == 0)
				{
%>
          <tr class="tfield1">
		          <td colspan="2" >  <input type="radio"  name="subs" value="1" size="1" checked> Enable Ringtone Promotion </td>
					</tr>
          <tr class="tfield1">
            	<td >Send SMS after calls &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
							  <input type="text" name="calls" onkeypress="return numberOnly(event)"></td>
          </tr>
<%
			}
			else if (ret == 1)
			{
%>
          <tr class="tfield1">
         		 <td >  <input type="radio"  name="subs" value ="0" size="1" checked> Disable Ringtone Promotion </td>
          </tr>
<%
			}
%>
          <tr class="button1">
        		  <td colspan="2"><br> <input type="submit" name="Submit" value="Submit"> <input type="reset" name="Submit2" value="Clear"> </td>
          </tr>
        </table>
      </form>
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
