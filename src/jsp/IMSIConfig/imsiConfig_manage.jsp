
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(280) )
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
 
		IMSIManager imsiManager = new IMSIManager();		
		ArrayList  imsiConfigAl = new ArrayList();
		String imsiId = "x";
		int i = imsiManager.getIMSIConfig(imsiConfigAl,imsiId);
		if(i < 0)
		{
		%>
			<script language="JavaScript">
				//alert("Error!!! Please try again")
		alert("<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>")
				history.go(-1)
			</script>
<%
		}
%>
<HTML>
<HEAD>
<script language="JavaScript">
	function validate()
	{
		var chk = document.forms.form.delid
		if( <%=imsiConfigAl.size()%> >1)
		{
			for(i=0;i< <%=imsiConfigAl.size()%>;i++ )
			{
				if(chk[i].checked==true)
					return confirm("Are you sure you want to delete the record(s)")
			}
			//alert("Error!!! No record selected for deletion")
			alert("<%=TSSJavaUtil.instance().getKeyValue("No_record_sel_deletion",defLangId)%>")
			return false
		}
		else
		{
			if(document.forms.form.delid.checked==false)
			{
				//alert("Error!!! No record selected for deletion")
				alert("<%=TSSJavaUtil.instance().getKeyValue("No_record_sel_deletion",defLangId)%>")
				return false
			}
		}
        return confirm("Are you sure you want to delete the record(s)")
	}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

  <form name="form" method="post" action="delIMSI.jsp" onSubmit="return  validate()">
    	 <table width="80%" border="0" align="center" cellpadding="3" cellspacing="3">
        <tr class="tableheader"><td colspan="5"><%=TSSJavaUtil.instance().getKeyValue("IMSI_Config_Mgt",defLangId)%><br><br></td></tr>
<%
			if (imsiConfigAl.size()==0)
			{
%>
      <tr class="notice">
				<td colspan="5"> No IMSI Configuration available! First you <a href="imsiConfig_add.jsp"> Add IMSI Configuration </a> and then Manage IMSI Configuration</b> </td>
			</tr>
				
 <%
			}
			else
			{
 %>
          <tr class="tfields">
            <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("Id",defLangId)%></td>
            <td width="50%"><%=TSSJavaUtil.instance().getKeyValue("Range",defLangId)%></td>
            <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("curSubType",defLangId)%></td>
            <%
if( sessionHistory.isAllowed(313) )
{
%>
            <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("Modify",defLangId)%></td>
            <%
}
if( sessionHistory.isAllowed(312) )
{
%>
            <td width="10%"> <%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%></td>
            <%
}
%>
          </tr>
          <%
	Iterator ite = imsiConfigAl.iterator();
	while(ite.hasNext())
	{
		IMSI imsi = (IMSI)ite.next();
		String sub = "";
		if (imsi.getSubscriberType().equalsIgnoreCase("P"))
		{
			sub = "Prepaid";
		}
		else if (imsi.getSubscriberType().equalsIgnoreCase("O"))
		{
			sub = "PostPaid";
		}
		
%>
      <tr class="tabledata_center">
			    <td ><%=imsi.getRangeId()%></td>
          <td ><%=imsi.getStartAt()+"-"+imsi.getEndsAt()%></td>
          <td ><%=sub%></td>
            <%
if( sessionHistory.isAllowed(313) )
{
%>
          <td ><a href="imsiConfig_modify.jsp?id=<%=imsi.getRangeId()%>"><img src="../images/modify.gif"  border="0"></a></td>
            <%
}
if( sessionHistory.isAllowed(312) )
{
%>
            <td>  <input type="checkbox" name="delid" value="<%=imsi.getRangeId()%>">     </td>
            <%
}
%>
          </tr>
          <%
	}
if(sessionHistory.isAllowed(312))
{
%>
          <tr class="button1">
            <td colspan="5"><input type="submit" name="submit" value="Delete Record(s)"> <input type="reset" name="Clear" value="Clear"></td>
          </tr>
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
