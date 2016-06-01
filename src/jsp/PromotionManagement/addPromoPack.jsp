<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("addPromoPack.jsp"); 
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(190) )
{
	%>
		<%@ include file ="../logouterror.jsp" %>
		<%
}
else
{
  %>
  <%@ include file="../lang.jsp" %>
  <%
	PromotionPackManager 	promoManager = new PromotionPackManager();
          promoManager.setConnectionPool(conPool);
	PromotionPack promo = new PromotionPack();


	promo.setPackName( request.getParameter("packname"));
	promo.setPackSize(Integer.parseInt(request.getParameter("packsize")));
	promo.setPackCost(Long.parseLong(request.getParameter("packcost")));
	promo.setFreeRbt(Integer.parseInt(request.getParameter("freerbtpack")));

	int i = promoManager.addPromotionPack(promo);

	if(i < 0)
	{
		if(i == -2 )
		{

			logger.info("webadmin/Promotion: The Promotion Pack already exists");
			%>
				<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("alpromoexi",defLangId)%>")
				history.go(-1)
				</script>
				<%
		}
		else
			%>
				<script language="JavaScript">
				alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
				window.location="home.jsp"
				</script>
				<%
	}
	else if(i > 0)
	{
		logger.info("webadmin/Promotion: Promotion pack is added Successfully");
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alpromoadded",defLangId)%>!!!")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>

