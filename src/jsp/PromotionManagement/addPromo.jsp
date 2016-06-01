<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("addPromo.jsp");
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


	promo.setStartDate( request.getParameter("startDate"));
	promo.setEndDate( request.getParameter("endDate"));
	promo.setPackId(Integer.parseInt(request.getParameter("packname")));
 //promo.setChgCode(Integer.parseInt(request.getParameter("packname")));
//	promo.setFreeRbt(Integer.parseInt(request.getParameter("freerbtpack")));

	String subs_offer = request.getParameter("subs_offer");
	if(subs_offer==null) subs_offer="N";

	promo.setSubsOffer(subs_offer);

	int i = promoManager.definePromotionOffer(promo);

	if(i < 0)
	{
		if(i == -2 || i== -21)
		{

			logger.info("webadmin/Promotion: The Promotion offer already exists for given parameters");
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
		logger.info("webadmin/Promotion: Promotion offer is added Successfully");
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alpromoadded",defLangId)%>!!!")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>

