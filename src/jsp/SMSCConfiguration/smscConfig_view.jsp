
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(120))
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
		  int smscId=Integer.parseInt(request.getParameter("id"));
			
			int i = smscConfigManager.getSmscConfig(smscConfigAl, smscId);
		
		String smscstatus = new String("");
		String clienttype = new String("");
		
%>

<%@ include file = "../pagefile/header.html" %>

    <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">

		 <tr ><td class="tableheader" colspan="2">SMSC Configuration - View Configuration<br><br> </td></tr>
      <%
			if( i< 0)
			{
			%>
		    <tr> <td class="notice" colspan="2"> There is Some Error.Please Try Later.</td></tr>
     <%
			}
			else if (smscConfigAl.size() <=0)
			{
			%>
		    <tr> <td class="notice" colspan="2"> No SMSC Configuration available!!! Firstly you<a href="smsc_configuration_add.jsp"> Add SMSC Configuration</a> and then Manage SMSC Configuration </td></tr>
     <%
			}
			else
			{
							for(int w =0;w < smscConfigAl.size(); w++)
							{
											smscConfig = (SmscConfig) smscConfigAl.get(w);
										if(smscConfig.getSmscStatus().equals("A"))
												smscstatus = "ACTIVATED";
										if(smscConfig.getSmscStatus().equals("D"))
												smscstatus = "DEACTIVATED";
										if(smscConfig.getClientType().equals("T"))
												clienttype = "TRANSMITTER";
										if(smscConfig.getClientType().equals("R"))
												clienttype = "RECIEVER";
										if(smscConfig.getClientType().equals("TR"))
												clienttype = "TRANSRECIEVER";
		 %>
      <tr>
            <td  class="tfield1"width="60%" >User Name </td>
            <td class="tfield"> <%= smscConfig.getUserId()%></td>
          </tr>
          <tr >
            <td  class="tfield1" >Password </td>
            <td class="tfield"><%= smscConfig.getPassword()%> </td>
          </tr>
          <tr> 
            <td  class="tfield1">Server IP </td>
            <td class="tfield"><%=smscConfig.getSmscIp() %> </td>
          </tr>
          <tr >
            <td  class="tfield1">Server Port </td>
            <td class="tfield"><%=smscConfig.getSmscPort() %></td>
          </tr>
          <tr>
            <td  class="tfield1">Status </td>
            <td class="tfield"> <%= smscstatus%></td>
          </tr>
          <tr>
            <td class="tfield1">SMSC Protocol </td>
            <td class="tfield"> <%= smscConfig.getSystemType()%> </td>
          </tr>
          <tr>
            <td class="tfield1">Client Type </td>
            <td class="tfield"> <%= clienttype%></td>
          </tr>
          <tr >
            <td  class="tfield1">Address TON </td>
            <td class="tfield"> <%= smscConfig.getTon()%></td>
          </tr>
          <tr >
            <td  class="tfield1">Address NPI </td>
            <td class="tfield"> <%= smscConfig.getNpi()%> </td>
          </tr>
          <tr >
            <td  class="tfield1">Address Range </td>
            <td class="tfield"> <%= smscConfig.getAddressRange()%>  </td>
          </tr>
          <tr >
            <td  class="tfield1">Number of Simultaneous Connections Allowed</td>
            <td class="tfield"> <%= smscConfig.getNumOfConAllow()%> </td>
          </tr>
          <tr >
            <td class="tfield1">Window Size </td>
            <td class="tfield"> <%= smscConfig.getSpeed()%> &nbsp;msgs/sec </td>
          </tr>
      <%
							} //for
			} //else
			%>
			
			  </table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
