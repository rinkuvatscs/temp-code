<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
 SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
 if(sessionHistory == null || !sessionHistory.isAllowed(2072) )
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
								WebAdminLogManager webadminlogs= new WebAdminLogManager();\
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

								if(!request.getParameter("old_crbtchg").equals(request.getParameter("crbtchg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_crbtchg"));
																logobj.setCurrentvalue(request.getParameter("crbtchg"));
																logobj.setColName("RBT_CHARGE_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;
								}
								if(!request.getParameter("old_giftchg").equals(request.getParameter("giftchg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_giftchg"));
																logobj.setCurrentvalue(request.getParameter("giftchg"));
																logobj.setColName("GIFT_CHARGE_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;
								}

								if(!request.getParameter("old_normalchg").equals(request.getParameter("normalchg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_normalchg"));
																logobj.setCurrentvalue(request.getParameter("normalchg"));
																logobj.setColName("RBT_NORMAL_CHARGE_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								if(!request.getParameter("old_subchg").equals(request.getParameter("subchg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_subchg"));
																logobj.setCurrentvalue(request.getParameter("subchg"));
																logobj.setColName("SUBSCRIPTION_CHARGE_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								if(!request.getParameter("old_remark").equals(request.getParameter("remark")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_remark"));
																logobj.setCurrentvalue(request.getParameter("remark"));
																logobj.setColName("REMARKS");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								if(!request.getParameter("old_monthlychg").equals(request.getParameter("monthlychg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_monthlychg"));
																logobj.setCurrentvalue(request.getParameter("monthlychg"));
																logobj.setColName("MONTHLY_RENT_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;
								}

								if(!request.getParameter("old_threechg").equals(request.getParameter("threechg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_threechg"));
																logobj.setCurrentvalue(request.getParameter("threechg"));
																logobj.setColName("THREE_WEEK_RENT_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								if(!request.getParameter("old_twochg").equals(request.getParameter("twochg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_twochg"));
																logobj.setCurrentvalue(request.getParameter("twochg"));
																logobj.setColName("TWO_WEEK_RENT_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								if(!request.getParameter("old_onechg").equals(request.getParameter("onechg")))
								{
																WebAdminLog logobj=new WebAdminLog();
																logobj.setTableName("CRBT_RATE_PLANS");
																logobj.setlink("RatePlanModify");
																logobj.setuser(user_name);
																logobj.setPreviousvalue(request.getParameter("old_onechg"));
																logobj.setCurrentvalue(request.getParameter("onechg"));
																logobj.setColName("ONE_WEEK_RENT_CODE");
																logobj.setIndicator(request.getParameter("pid"));
																logarray.add(logobj);
																i=1;

								}

								int res=rbtrateManager.saveEditRatePlan(rbtrateplan,pid);
								if(i==1)
								{
																int rest=webadminlogs.createLog(logarray);
																System.out.println("logs return =="+rest);
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
