<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("modifyPromoPack.jsp");
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
String user_name=sessionHistory.getUser();
	PromotionPackManager 	promoManager = new PromotionPackManager();
       promoManager.setConnectionPool(conPool);
	PromotionPack promo = new PromotionPack();


	promo.setPackName( request.getParameter("packname"));
	promo.setPackSize(Integer.parseInt(request.getParameter("packsize")));
	promo.setPackCost(Long.parseLong(request.getParameter("packcost")));
	promo.setFreeRbt(Integer.parseInt(request.getParameter("freerbtpack")));
	promo.setPackId(Integer.parseInt(request.getParameter("packId")));
	String packnameold= request.getParameter("packnameold");

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
			String old_values="PACK_ID:"+request.getParameter("packId")+";";	
			String new_values="PACK_ID:"+request.getParameter("packId")+";";	
if(!request.getParameter("packnameold").equals(request.getParameter("packname")))
{
old_values=old_values+"PACK_NAME:"+request.getParameter("packnameold")+";";
new_values=new_values+"PACK_NAME:"+request.getParameter("packname")+";";
k=1;
}
if(!request.getParameter("old_packsize").equals(request.getParameter("packsize")))
{
old_values=old_values+"PACK_SIZE:"+request.getParameter("old_packsize")+";";
new_values=new_values+"PACK_SIZE:"+request.getParameter("packsize")+";";
k=1;
}
if(!request.getParameter("old_packcost").equals(request.getParameter("packcost")))
{
old_values=old_values+"PACK_COST:"+request.getParameter("old_packcost")+";";
new_values=new_values+"PACK_COST:"+request.getParameter("packcost")+";";
k=1;
}
if(!request.getParameter("old_freerbtpack").equals(request.getParameter("freerbtpack")))
{
old_values=old_values+"FREE_RBTS:"+request.getParameter("old_freerbtpack")+";";
new_values=new_values+"FREE_RBTS:"+request.getParameter("freerbtpack")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("CRBT_RBT_PACK");
                logobj.setlink("promotionmanagementlog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}

	int i = promoManager.modifyPromotionPack(promo, packnameold);

	if(i < 0)
	{
		if(i == -2 )
		{

			logger.info("webadmin/Promotion: The Promotion Pack already exists");
			%>
				<script language="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("alpropackexi",defLangId)%>")
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
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);

		logger.info("webadmin/Promotion: Promotion pack is modified Successfully");
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alpropackmodi",defLangId)%>!!!")
			window.location="home.jsp"
			</script>
			<%
	}
}
%>

