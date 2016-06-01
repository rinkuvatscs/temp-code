
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
				AdvertiseManager adManager = new AdvertiseManager();
                         adManager.setConnectionPool(conPool);

				ArrayList advertiseAl = new ArrayList();

				int i = adManager.viewAdCategory(advertiseAl,0);

 %>
<HTML>
<HEAD>
<TITLE><%=TSSJavaUtil.instance().getKeyValue("advManage")%> </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript">
		function confirmDelete()
		{
				var z = confirm("<%=TSSJavaUtil.instance().getKeyValue("confdelad")%> ")
				if (z == true){return true;}
				else if (z == false){return false;}
		}

</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
     
		 <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="5"><%=TSSJavaUtil.instance().getKeyValue("adconfig")%>  </td></tr>
			<tr class="tfields">
			  <td width="30%"><%=TSSJavaUtil.instance().getKeyValue("catName")%> </td>
	<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("catFreq")%> </td>
				<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("modify")%> </td>
				<td width="10%"><%=TSSJavaUtil.instance().getKeyValue("delete")%> </td>
			</tr>
			<%
						if(i<=0 || advertiseAl.size()<=0)
						{
			%>
			<tr class="notice"<td colspan="4" align="center"><%=TSSJavaUtil.instance().getKeyValue("noadcatpres")%> !!!</td></tr>
			<%
						}
		      	else
      			{
										for(int x=0;x<advertiseAl.size();x++)
										{
														Advertise advertise = (Advertise) advertiseAl.get(x);
														String catFre  = "";
														int  Frequency = advertise.getCatFrequency();
													  switch(Frequency)
														{
																		case 1:
																		  catFre = TSSJavaUtil.instance().getKeyValue("low") ;
																			break;
																		case 2:
																		  catFre =  TSSJavaUtil.instance().getKeyValue("medium") ;
																			break;	
																		case 3:
																		  catFre =  TSSJavaUtil.instance().getKeyValue("high") ;
																			break;	
														}
			%>       				
			<tr class="tabledata_center">
			  <td align="left"><%=advertise.getCatName()%>   </td>
			  <td><%=catFre%>   </td>
			  <td><a href="modify_category.jsp?catId=<%=advertise.getCatId()%>"><%=TSSJavaUtil.instance().getKeyValue("modify")%> </a> </td>
			  <td><a href="modifyCategory.jsp?id=del&catId=<%=advertise.getCatId()%>" onclick="return confirmDelete()"><%=TSSJavaUtil.instance().getKeyValue("delete")%> </a> </td>
			</tr>
		  <%
			            }
						}
			%>	
	 	</table>

		<%@ include file="../pagefile/footer.html"%>
<%
}
%>
