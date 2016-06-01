
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("config_ad.jsp");
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
				ArrayList advertiseArr = new ArrayList();
       
			  long catId=0;
				String catName="";

        int i = adManager.viewAdDetail(advertiseAl,0);


 %>
<HTML>
<HEAD>
<TITLE><%=TSSJavaUtil.instance().getKeyValue("advManage")%> </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<%--<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">--%>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
     
		 <table border="1" width="80%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="11"><%=TSSJavaUtil.instance().getKeyValue("confaddet")%>  </td></tr>
			<tr class="tfields">
			  <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("adName")%> </td>
			  <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("adCat")%> </td>
			  <td width="8%"><%=TSSJavaUtil.instance().getKeyValue("adFreq")%> </td>
			  <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("stdate")%> </td>
			  <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("endDate")%> </td>
			  <td width="8%"><%=TSSJavaUtil.instance().getKeyValue("maxAd")%> </td>
			  <td width="8%"><%=TSSJavaUtil.instance().getKeyValue("adsent")%> </td>
				<td ><%=TSSJavaUtil.instance().getKeyValue("modify")%> </td>
				<td ><%=TSSJavaUtil.instance().getKeyValue("delete")%></td>
			</tr>
			<%
						if( i<=0 || advertiseAl.size()<=0 ) 
						{
			%>
			<tr class="notice"><td colspan="11" align="center"><%=TSSJavaUtil.instance().getKeyValue("noadpres")%> !!!</td></tr>
			<%
						}
		      	else
      			{
			%>							
			<%
						
							for(int x=0;x<advertiseAl.size();x++)
							{
						Advertise advertise = (Advertise) advertiseAl.get(x);
                                          advertise.setConnectionPool(conPool);
														String catFre  = "";
														int  frequency = advertise.getAdFrequency();
													  switch(frequency)
														{
																		case 1:
																		  catFre = TSSJavaUtil.instance().getKeyValue("low");
																			break;
																		case 2:
																		  catFre = TSSJavaUtil.instance().getKeyValue("medium");
																			break;	
																		case 3:
																		  catFre = TSSJavaUtil.instance().getKeyValue("high");
																			break;	
														}
			%>
			<tr class="tabledata_center">
			  <td align="left"><%=advertise.getAdName()%></td>		
			  <%
				          catId=advertise.getAdCat();
									int j = adManager.viewAdCategory(advertiseArr,catId);
									  for(int w=0;w<advertiseArr.size();w++)
										{
														Advertise adCat = (Advertise) advertiseArr.get(w);
														if(adCat.getCatId() == catId)
														{
																		catName = adCat.getCatName();
														}
														else
														{
																		 catName="x";
																 		System.out.println("Category "+adCat.getCatId()+"  not found");
														}
										}

				  
				%>
				<td align="left"><%=catName%>   </td>
			  <td align="left"><%=catFre%></td>		
				<td><%=advertise.getStartDate()%></td>
				<td><%=advertise.getEndDate()%></td>
				<td><%=advertise.getAdMax()%></td>
				<td><%=advertise.getAdSent()%></td>
			  <td><a href="modify_ad.jsp?adId=<%=advertise.getAdId()%>"><%=TSSJavaUtil.instance().getKeyValue("modify")%> </a> </td>
			  <td><a href="modifyAd.jsp?id=del&adId=<%=advertise.getAdId()%>&adName=<%=advertise.getAdName()%>"><%=TSSJavaUtil.instance().getKeyValue("delete")%> </a> </td>
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
