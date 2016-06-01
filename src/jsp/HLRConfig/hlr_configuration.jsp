
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	ArrayList  hlrConfigAl = new ArrayList();
	if(sessionHistory == null || !sessionHistory.isAllowed(280) )
	{
         %>
           <%@ include file ="logouterror.jsp" %>
              <%
                  session.invalidate();
                    request.getSession(true).setAttribute("lang",defLangId);
         }
	else
	{
		HLRManager hlrManager = new HLRManager();
          hlrManager.setConnectionPool(conPool);
		int hlrId = -1;
		int i = hlrManager.getHLRConfig(hlrConfigAl, hlrId);
		
%>
<HTML>
<HEAD>

<script language="JavaScript">
	function validate()
	{
		var chk = document.forms.form.delid
		if( <%=hlrConfigAl.size()%> >1)
		{
			for(i=0;i< <%=hlrConfigAl.size()%>;i++ )
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

  <form name="form" method="post" action="delHLR.jsp" onSubmit="return  validate()">
    <table border="0" width="90%" align="center" cellpadding=2 cellspacing=4>
			 <tr><td class="tableheader" colspan="6">HLR Configuration<br><br></td></tr>
      <%
	if (i < 0  || hlrConfigAl.size() <= 0)
	{
%>
      <tr class="notice"><td> No HLR Configuration available! <a href="hlrConfig_add.jsp">Add HLR Configuration</a> and then Manage HLR Configuration</td></tr>
      <%
	}
else
	{
%>
       <tr class="tfields" bgcolor="#a5c7d0">
            <td width="20%">Name<br></td>
            <td width="20%">Server IP<br></td>
            <td width="20%">Server Port<br></td>
            <td >View</td>
            <%
if( sessionHistory.isAllowed(281) )
{
%>
            <td >Modify<br></td>
            <%
}
if( sessionHistory.isAllowed(283) )
{
%>
            <td >Delete<br></td>
            <%
}
%>
          </tr>
          <%
					int r =0;
	Iterator ite = hlrConfigAl.iterator();
	while(ite.hasNext())
	{
		HLR hlr = (HLR)ite.next();
%>
          <tr class="tabledata_center"
									 		 <%if ( (r % 2) == 0){ %><%} else {%> bgcolor="#a5c7c2"<%} r++;%>   >
            <td ALIGN="left"><%=hlr.getHLRName() %> </td>
            <td ><%=hlr.getHLRIp()%></td>
            <td ><%=hlr.getHLRPort()%></td>
            <td ><a href="hlrConfig_view.jsp?id=<%=hlr.getHLRId()%>"><img src="../images/view.gif" height="20" border="0"></a></td>
            <%
if( sessionHistory.isAllowed(281) )
{
%>
            <td> <a href="hlrConfig_modify.jsp?id=<%=hlr.getHLRId()%>"><img src="../images/modify.gif" height="20" border="0"></a></td>
<%
}
if( sessionHistory.isAllowed(283) )
{
%>
            <td >    <input type="checkbox" name="delid" value="<%=hlr.getHLRId()%>"></td>
<%
}
%>
          </tr>
  <%
	}
if(sessionHistory.isAllowed(283))
{
%>
          <TR class="button1">
            <TD COLSPAN="6"><br> 
								<INPUT TYPE="submit" NAME="submit" VALUE="Delete Record(s)"> <INPUT TYPE="reset" NAME="Clear" VALUE="Clear">
						</TD>
          </TR>
<%
}
%>
        </table>
      </form>
  <%
	}
%>

<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
