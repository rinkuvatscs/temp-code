
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
        Logger logger = Logger.getLogger ("add_map.jsp");
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory ==null || !sessionHistory.isAllowed(100) )
		{
                %>
                  <%@ include file ="../logouterror.jsp" %>
                     <%
                         session.invalidate();
                            request.getSession(true).setAttribute("lang",defLangId);
               }
		else
		{
		MessageMapManager mesgMapManager = new MessageMapManager();
         mesgMapManager.setConnectionPool(conPool);
		MessageMap mesgMap = new MessageMap();

	  mesgMap.setMesgType( Integer.parseInt( request.getParameter("mesg_type") ) );
	  mesgMap.setEventType( Integer.parseInt( request.getParameter("event_type") ) );
	  mesgMap.setVisitType( Integer.parseInt( request.getParameter("visit_type") ) );
	  mesgMap.setMapType( Integer.parseInt( request.getParameter("map_type") ) );
	  mesgMap.setMapValue( Long.parseLong( request.getParameter("map_value") ) );
	  mesgMap.setMesgOrder( Integer.parseInt( request.getParameter("mesg_order") ) );
	  mesgMap.setDeliveryOrder( request.getParameter("delivery_order")  );
	
	  
		String sub_Type = request.getParameter("sub_type") ;
		int subType=-1;
		String deliveryCriteria =  request.getParameter("delivery_criteria") ;
		
		if(sub_Type == null)
	    			 subType = 0;		
		else
						subType = Integer.parseInt(sub_Type);
		mesgMap.setSubType(subType );
		logger.info("webadmin/MessageManagement: subType= " + subType);
						 
	  if(deliveryCriteria == null)
					deliveryCriteria = "NA";
	  mesgMap.setDeliveryCriteria(deliveryCriteria);
		
		String startDate= request.getParameter("start_date");
		String endDate= request.getParameter("end_date");

         mesgMap.setStartDate(startDate);
         mesgMap.setEndDate(endDate);

				 	
    int i = mesgMapManager.addMap(mesgMap);
		
		if ( i == -2)	
	   {
	%>
	 <script language="JavaScript">
	 	 alert("This Mapping already Exists, please select another")
		 history.go(-1)
		</script> 
	<%
	   }
	 else if(i ==0)
			{
	%>
	 <script language="JavaScript">
	 	 alert("The Mapping added successfully")
		 window.location="../home.jsp"
		</script> 
	<%
	   }
		else
		 {
	%>					 
		<script language="JavaScript">
			alert("Error!!! Please try again")
			history.go(-1)
		</script>
	<%
		}
	 						
	}	
%>
