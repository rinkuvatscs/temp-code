
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(120) )
	{
	   %>
	    <%@ include file ="../logouterror.jsp" %>
	      <%
	        session.invalidate();
	           request.getSession(true).setAttribute("lang",defLangId);
	            }

	else
	{
			SmscConfigManager smscConfigManager = new SmscConfigManager();
    smscConfigManager.setConnectionPool(conPool);
			SmscConfig smscConfig = new SmscConfig();
			ArrayList  smscConfigAl = new ArrayList();
			
			int smscId = -1;

			int i = smscConfigManager.getSmscConfig(smscConfigAl, smscId);

%>
<HTML>
<HEAD>
<script language="JavaScript">
	function validate()
	{
		var chk = document.forms.form.delid
		if( <%=smscConfigAl.size()%> >1)
		{
			for(i=0;i< <%=smscConfigAl.size()%>;i++ )
			{
				if(chk[i].checked==true)
					return confirm("Are you sure you want to delete the record(s)")
			}
			alert("Error!!! No record selected for deletion")
			return false
		}
		else
		{
			if(document.forms.form.delid.checked==false)
			{
				alert("Error!!! No record selected for deletion")
				return false
			}
		}
        return confirm("Are you sure you want to delete the record(s)")
	}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
      
	  <table width="90%"  border="0" cellspacing="3" cellpadding="2" align="center">
			<tr><td class="tableheader"colspan="7">SMSC Configuration<br><br></td></tr>

      <%
			if( i< 0)
			{
			%>
		    <tr> <td class="notice"> There is Some Error.Please Try Later.</td></tr>
     <%
			}
			else if (smscConfigAl.size() <=0)
			{
			%>
		    <tr> <td class="notice"> No SMSC Configuration available!!! Firstly you<a href="smsc_configuration_add.jsp"> Add SMSC Configuration</a> and then Manage SMSC Configuration </td></tr>
     <%
			}
			else
			{
		 %>
      <form name="form" method="post" action="delsmsc.jsp" onSubmit="return  validate()">
			
          <tr class="tfields" bgcolor="#a5c7d0">
            <td width="20%" >User Name</td>
            <td width="15%">Server IP</td>
            <td width="15%">Server Port</td>
            <td width="15%">SMSC Protocol</td>
            <td >View</td>
            <%
if( sessionHistory.isAllowed(122) )
{
%>
            <td >Modify </td>
            <%
}
if( sessionHistory.isAllowed(123) )
{
%>
            <td >Delete </td>
            <%
}
%>
          </tr>
				<%
							for(int w =0;w < smscConfigAl.size(); w++)
							{
											smscConfig = (SmscConfig) smscConfigAl.get(w);
        %>
				<tr class="tabledata_center"
									 		 <%if ( (w % 2) == 0){ %> <%} else {%>bgcolor="#a5c7c2"<%}%>   >
            <td align="left"><%=smscConfig.getUserId() %> </td>
            <td><%=smscConfig.getSmscIp()%></td>
            <td ><%=smscConfig.getSmscPort()%></td>
            <td ><%=smscConfig.getSystemType()%></td>
            <td ><a href="smscConfig_view.jsp?id=<%=smscConfig.getSmscId()%>"><img src="../images/view.gif" height="20" border="0"></a></td>
            <%
if( sessionHistory.isAllowed(122) )
{
%>
            <td><a href="smscConfig_modify.jsp?id=<%=smscConfig.getSmscId()%>"><img src="../images/modify.gif" height="20" border="0"></a></td>
            <%
}
if( sessionHistory.isAllowed(123) )
{
%>
            <td>   <input type="checkbox" name="delid" value="<%=smscConfig.getSmscId()%>"></td>
            <%
}
%>
          </tr>
      <%
						}//for
			} //else
			%>
          <%
	
if(sessionHistory.isAllowed(123))
{
%>
          <tr class="button1">
            <td coLSPAN="7"><br>
						  <INPUT TYPE="submit" NAME="submit" VALUE="Delete Record(s)"> <INPUT TYPE="reset" NAME="Clear" VALUE="Clear">
						</TD>
          </TR>
          <%
}
%>
     </table>
      </form>
		 
<%@ include file = "../pagefile/footer.html" %>
<%
	
  }
%>
