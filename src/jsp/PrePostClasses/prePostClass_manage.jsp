
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2061))
	{
           %>
            <%@ include file ="../logouterror.jsp" %>
              <%
                session.invalidate();
                   request.getSession(true).setAttribute("lang",defLangId);
           }
	else
	{
				 PrePostManager serviceManager	 = new PrePostManager();
                  serviceManager.setConnectionPool(conPool);
					ArrayList serviceDetailAl  = new ArrayList();
				 int i = serviceManager.getPrePost(serviceDetailAl);
	
%>


 <%@ include file = "../pagefile/header.html" %>
  
   <form name="form" method="post" action="prePostClass_modify.jsp" >
			 <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
          <tr class="tableheader" ><td colspan="4">Prepaid Postpaid Service Class - Manage  <br><br></td></tr>
<%
				if ( i < 0 || serviceDetailAl.size() <= 0)
				{
%>
       		 <tr class="notice">
							<td colspan="4" align="center"> <p>No Service Class defined!!! <br> Firstly you <a href="prePostClass_add.jsp"> Add Service Class</a> and then you can Modify Service  Class  </P></td></tr>
<%
				}
        else
				{
%>
          <tr class="tfields" bgcolor="#a5c7d0">
              <td >Range<br> </td>
              <td >Subscriber Type<br> </td>
              <td >Modify<br></td>
<%
  int r=0;
	Iterator ite = serviceDetailAl.iterator();
	while(ite.hasNext())
	{
		PrePost serviceDetail = (PrePost)ite.next();
%>
        <tr class="tabledata_center"
									 		 <%if ( (r % 2) == 0){ %><%} else {%> bgcolor="#a5c7c2"<%} r++;%>   >
          <td><%= serviceDetail.getStartsAt() %> - <%=serviceDetail.getEndsAt() %> </td>
              <td align="centre">		<%=serviceDetail.getsub_type()%> </td>
          <td>   <input type="radio" name="rangeid" value="<%= serviceDetail.getRangeId()%>" checked > </td>
        </tr>
        <%
	}
%>
        <tr class="button1">
          	<td colspan="4"><br> <input type="submit" name="submit" value="MODIFY"> <input type="reset" name="Clear" value="CLEAR"> </TD>
        </tr>
      </table>
    </form>
<%
	}
%>

<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>
