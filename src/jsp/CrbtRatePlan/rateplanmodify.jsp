<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("rateplanmodify.jsp");
 SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
 if(sessionHistory == null || !sessionHistory.isAllowed(111) )
 {
  %>
     <%@ include file ="../logouterror.jsp" %>
          <%
          session.invalidate();
           request.getSession(true).setAttribute("lang",defLangId);
  }
else
{

								//String process=request.getParameter("process");
								RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();
                                      rbtrateManager.setConnectionPool(conPool);		
								WebAdminLogManager webadminlogs= new WebAdminLogManager();
                               webadminlogs.setConnectionPool(conPool);
								ArrayList logarray= new ArrayList();

								RbtRatePlan rbtrateplan  = new RbtRatePlan();		
								RbtRatePlan old_rbtrateplan  = new RbtRatePlan();		
								String result="";
								//			rbtrateplan.setRbtMonoChgCode(request.getParameter("monotonechg"));
								//		rbtrateplan.setRbtNoChgCode(request.getParameter("nochg"));
								//		rbtrateplan.setRbtRecChgCode(request.getParameter("recordedchg"));

								int pid=Integer.parseInt(request.getParameter("pid"));
								rbtrateplan.setRbtChgCode(request.getParameter("crbtchg"));
								rbtrateplan.setRbtGiftChgCode(request.getParameter("giftchg"));
								rbtrateplan.setRbtNormalChgCode(request.getParameter("normalchg"));
								rbtrateplan.setSubChgCode(request.getParameter("subchg"));
								rbtrateplan.setRemarks(request.getParameter("remark"));
								rbtrateplan.setMRentCode(request.getParameter("monthlychg"));
								rbtrateplan.setThreeWeek(request.getParameter("threechg"));
								rbtrateplan.setTwoWeek(request.getParameter("twochg"));
								rbtrateplan.setOneWeek(request.getParameter("onechg"));
								int i=0;
								String user_name=sessionHistory.getUser();
			String old_values="PLAN_INDICATOR:"+pid+";";
   String new_values="PLAN_INDICATOR:"+pid+";";

								if(!request.getParameter("old_crbtchg").equals(request.getParameter("crbtchg")))
								{
															old_values=old_values+"RBT_CHARGE_CODE:"+request.getParameter("old_crbtchg")+";";
   													new_values=new_values+"RBT_CHARGE_CODE:"+request.getParameter("crbtchg")+";";
																i=1;
								}
								if(!request.getParameter("old_giftchg").equals(request.getParameter("giftchg")))
								{
															old_values=old_values+"GIFT_CHARGE_CODE:"+request.getParameter("old_giftchg")+";";
                new_values=new_values+"GIFT_CHARGE_CODE:"+request.getParameter("giftchg")+";";
                i=1;
								}

								if(!request.getParameter("old_normalchg").equals(request.getParameter("normalchg")))
								{
																old_values=old_values+"RBT_NORMAL_CHARGE_CODE:"+request.getParameter("old_normalchg")+";";
                new_values=new_values+"RBT_NORMAL_CHARGE_CODE:"+request.getParameter("normalchg")+";";
                i=1;
								}

								if(!request.getParameter("old_subchg").equals(request.getParameter("subchg")))
								{
																old_values=old_values+"SUBSCRIPTION_CHARGE_CODE:"+request.getParameter("old_subchg")+";";
                new_values=new_values+"SUBSCRIPTION_CHARGE_CODE:"+request.getParameter("subchg")+";";
                i=1;
								}

								if(!request.getParameter("old_remark").equals(request.getParameter("remark")))
								{
																old_values=old_values+"REMARKS:"+request.getParameter("old_remark")+";";
                new_values=new_values+"REMARKS:"+request.getParameter("remark")+";";
                i=1;
								}

								if(!request.getParameter("old_monthlychg").equals(request.getParameter("monthlychg")))
								{
																old_values=old_values+"MONTHLY_RENT_CODE:"+request.getParameter("old_monthlychg")+";";
                new_values=new_values+"MONTHLY_RENT_CODE:"+request.getParameter("monthlychg")+";";
                i=1;
								}

								if(!request.getParameter("old_threechg").equals(request.getParameter("threechg")))
								{
																old_values=old_values+"THREE_WEEK_RENT_CODE:"+request.getParameter("old_threechg")+";";
                new_values=new_values+"THREE_WEEK_RENT_CODE:"+request.getParameter("threechg")+";";
                i=1;
								}

								if(!request.getParameter("old_twochg").equals(request.getParameter("twochg")))
								{
																old_values=old_values+"TWO_WEEK_RENT_CODE:"+request.getParameter("old_twochg")+";";
                new_values=new_values+"TWO_WEEK_RENT_CODE:"+request.getParameter("twochg")+";";
                i=1;
								}

								if(!request.getParameter("old_onechg").equals(request.getParameter("onechg")))
								{
																old_values=old_values+"ONE_WEEK_RENT_CODE:"+request.getParameter("old_onechg")+";";
                new_values=new_values+"ONE_WEEK_RENT_CODE:"+request.getParameter("onechg")+";";
                i=1;

								}

								int res=rbtrateManager.saveEditRatePlan(rbtrateplan,pid);
								if(res==0 && i==1)
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("rbtrateplanlogs");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(old_values);
																logobj.setCurrentvalue(new_values);
																i=1;

																int rest=webadminlogs.createLog(logobj);
																logger.info("logs return =="+rest);
								}
								if(res == 0 )
								{
																%>
																								<script language="JavaScript">
																								alert("Rate Plan Modify successfully!!!")
																								window.location="home.jsp"
																								</script>
																								<%
								}
								else
								{
																%>
																								<script language="JavaScript">
																								alert("Error!!! Try Again");
																window.location="home.jsp";
																</script>
																								<%
								}

}

%>
