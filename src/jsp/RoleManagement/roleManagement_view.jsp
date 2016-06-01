
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%--
		modified on Jan. 11, 2006
		@author Jatinder Pal 
--%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null  || !sessionHistory.isAllowed(190))
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
	{
%>                  <%@ include file="../lang.jsp" %>
 <%
				RoleTypeManager roleManager = new RoleTypeManager();
                     roleManager.setConnectionPool(conPool);
				ArrayList roleTypeAl = new ArrayList();
    
				String roleName = request.getParameter("name");
		    int roleId = Integer.parseInt( request.getParameter("id") ) ;
		    
				ArrayList validlinksAl = roleManager.getLinks(roleId);
		    int  links = roleManager.getHttpLinks(roleTypeAl);
%>

<%@ include file = "../pagefile/header.html" %>
           
       <table width="80%" border="0" align="center" cellpadding="2" cellspacing="2">
            <tr class="tableheader"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("rtTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("rtDetail",defLangId)%><br><br></td></tr>
            <tr class="tfields"  >
            	<td width="75%"	><%=TSSJavaUtil.instance().getKeyValue("rtName",defLangId)%> - <%=roleName%></td>
		<td ><%=TSSJavaUtil.instance().getKeyValue("rtAccess",defLangId)%></td>
            </tr>
<%
					for(int x = 0;x< roleTypeAl.size(); x++)
					{
						RoleType roleType = (RoleType) roleTypeAl.get(x);
             					int role = roleType.getLinkId();
						
									
%>
	      <%if(role==121|| role==120 || role ==122|| role==123 || role==140|| role==141|| role==142|| role==143|| role==160|| role==170|| role==180|| role==280|| role==281|| role==282|| role==283|| role==310||role==311||role==312||role==313||role==320||role==321||role==322|| role==323|| role==560 ||  role==540 || role==290 || role==291 || role==292 || role==293)
	      {}
	      else{
	      %>
           <tr class="tfield1" >
             <td ><%=roleType.getLinkDesc()%> </td>
             <td align="center">
<%
	   	  if( validlinksAl.contains(new Integer ( roleType.getLinkId() ) ))
    	    		{
	      	%>
                    <img src="../images/tick.jpg" width="10" height="10" border="0">
<%
        		}
		        else
		        {
%>
                    <img src="../images/cross.jpg" width="10" height="10" border="0">
<%
    			  }
		}//else
%>
                 </td>
								 
          </tr>
					
<%
    			}
%>
        </table>

<%@ include file = "../pagefile/footer.html" %>
<%
 }
%>
