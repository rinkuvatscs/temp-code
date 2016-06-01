
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("deleteOffer.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null ||  !sessionHistory.isAllowed(2016) )
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
  
				PromotionPackManager promoManager = new PromotionPackManager() ;
                 promoManager.setConnectionPool(conPool);	
	String Arr[] = (String []) request.getParameterValues("delOcc");
	ArrayList promoArr = new ArrayList(); 
	if(Arr!=null &&Arr.length>0)
	{
	for(int x=0;x<Arr.length;x++)
	{
		promoArr.add(Arr[x]);
	}
	int i = promoManager.deletePromoOffer(promoArr);

	if(i <0)
	{
		logger.info("webadmin/PromotionPack: promopack cannot be deleted");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
	else if(i==1)
	{
		logger.info("webadmin/PromotionPack: promopack deleted successfully");	
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("alpromodel",defLangId)%>")
			window.location="home.jsp"
			</script>
			<%
	}
	}
	else
	{
	  logger.info("webadmin/PromotionPack: No available pack to delete");
                %>
                      <script language="JavaScript">
                        alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
                        window.location="home.jsp"
                        </script>
                        <%

	}
}
%>
