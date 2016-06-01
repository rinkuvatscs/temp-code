
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("updateRbtSetting.jsp");
 
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if (sessionHistory == null || !(sessionHistory.isAllowed(158)))
{
	%>
		<%@ include file="../logouterror.jsp" %>
		<%		
}
else {
				String starttime = request.getParameter("select1");
				String endtime = request.getParameter("select2");
				String days[] = (String [])request.getParameterValues("checkbox1");
				int startTime = 100*Integer.parseInt(starttime);
				int endTime = 100*Integer.parseInt(endtime);
				String toneDays = "0000000";
				logger.info("days= "+days.length+" startime="+startTime+" endtime="+endTime);
				for(int j=0;j<days.length;j++)
				{
								logger.info(j+ "- "+days[j]+ "--- "+ Integer.parseInt(days[j],10)+1 + "**"+toneDays.charAt(j));
				//				toneDays = .replace(toneDays.charAt(j), '1');
				}
				
					  logger.info( "**** tone day string "+ toneDays);
			/*	if(days.length==7)
				{
								ToneSetting ts= new ToneSetting();
								ts.setDay(8);
								ts.setStartTime(startTime);
								ts.setEndTime(endTime);
								toneSettings.add(ts);
				}

				else
				{
								for(int j=0; j<days.length; j++)
								{
												ToneSetting ts= new ToneSetting();
												ts.setDay(Integer.parseInt(days[j],10)+1);
												ts.setStartTime(startTime);
												ts.setEndTime(endTime);
												toneSettings.add(ts);
								}
				}
*/
				CorpManager corpManager = new CorpManager();
                     corpManager.setConnectionPool(conPool);  
//				corpManager.updateParams(startTime,endTime, );

}//else main	
	%>


