
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %> 
 <%@ include file = "../conPool.jsp" %>
<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory == null || !sessionHistory.isAllowed(192) )
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
		RoleTypeManager roleManager = new RoleTypeManager();
         roleManager.setConnectionPool(conPool);
		ArrayList roleAl =new ArrayList();
  
	  String roleName = request.getParameter("name");
  
	  int id = Integer.parseInt(request.getParameter("id") );
  
	  ArrayList validlinksAl = roleManager.getLinks(id);
    int links = roleManager.getHttpLinks(roleAl);

%>

<HTML>
<HEAD>
<script type="text/javascript">
    function validate()
    {
                 return true
   }
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
        
    <form name="form" method="post" action="modifyRole.jsp?id=<%=id%>" onSubmit="return validate()">
       <table width="80%" border="0" align="center" cellpadding="3" cellspacing="2">
				
	<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("rtTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("rtModify",defLangId)%> <br><br></td></tr>
        <tr class="tfields">
            	<td width="75%"	><%=TSSJavaUtil.instance().getKeyValue("rtName",defLangId)%> - <%=roleName%></td>
		<td > <%=TSSJavaUtil.instance().getKeyValue("rtAccess",defLangId)%></td>
        </tr>
<%
					for(int x = 0;x< roleAl.size(); x++)
					{
						RoleType roleType = (RoleType) roleAl.get(x);
             					int role = roleType.getLinkId();

	      if(role==121|| role==120 || role ==122|| role==123 || role==140|| role==141|| role==142|| role==143|| role==160|| role==170|| role==180|| role==280|| role==281|| role==282|| role==283|| role==310||role==311||role==312||role==313||role==320||role==321||role==322|| role==323|| role==560 || role==540 || role==290 || role==291 || role==292 || role==293)
	      {}//if
	      else
	      {
%>
        <tr class="tfield1">
             <td ><%=roleType.getLinkDesc()%> </td>
            <td align="center"> <input type="checkbox" name="links"
<%
		        if( validlinksAl.contains(new Integer ( roleType.getLinkId() ) ))
        			{
%>
        				    checked
<%
        			}
%>
								value="<%=roleType.getLinkId() %>">
           </td>
        </tr>
<%
             }//else
    }//for
%>
        <tr class="button1">
              <td colspan="2"><br>
                  <input type="submit" name="submit"	value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">
                  <input type="reset" name="Clear"		value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
              </td>
         </tr>
				 
     </table>
  </form>
	
<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>

