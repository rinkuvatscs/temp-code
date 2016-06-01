
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%--
		Modified by Jatinder Pal
		on Jan. 11, 2006.
--%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if (sessionHistory == null || !sessionHistory.isAllowed(194) ) 
	{
%>
		<%@ include file="../logouterror.jsp" %>
<%
	}
	else
	 {
       %>
                        <%@ include file="../lang.jsp" %>
            <%
			RoleTypeManager roleManager = new RoleTypeManager();
                 roleManager.setConnectionPool(conPool);
			RoleType roleType = new RoleType();

			ArrayList roleTypeAl = new ArrayList();

			int x = roleManager.getHttpLinks(roleTypeAl);
			
%>
<HTML>
<HEAD>
<script type="text/javascript">
    function validate()  
		{
						var x = document.form.roleName.value = document.form.roleName.value.trim();
						if(x == "")
						{
										alert("<%=TSSJavaUtil.instance().getKeyValue("alentrolename",defLangId)%>");
										document.form.roleName.focus();
										return false;
						}
						return true
		}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

   <form name="form" method="post" action="addRole.jsp" onSubmit="return validate()">
        <table width="90%" border="0" align="center" cellpadding="4" cellspacing="3">
        		<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("rtTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("rtAddrole",defLangId)%> <br><br></td></tr>
				<%
						if( x < 0 )	
						{
				%>	
            <tr class="notice"> <td colspan=2 ><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%> </td>
				<%
						}
						else if( roleTypeAl.size() <= 0 || roleTypeAl == null ) 	
						{
				%>	
            <tr class="notice"> <td colspan=2 ><%=TSSJavaUtil.instance().getKeyValue("rtNoPriv",defLangId)%> </td>
				<%
						}
						else
						{
				%>				
					
            <tr class="tfield">
            	 <td	width="40%"><%=TSSJavaUtil.instance().getKeyValue("rtName",defLangId)%> </td>
               <td ><input type="text" name="roleName" maxlength=15>         </td>
            </tr>
						<tr class="tfield">
								<td width="30%"><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%></td>
								<td><textarea name="roleDesc" cols="35" rows="5" onkeypress="return disableReturnKey(event)" maxlength="50"></textarea></td>
						</tr>		
            <%
		for(int q=0;q<roleTypeAl.size();q++)
		{
			roleType = (RoleType) roleTypeAl.get(q);
			int role = roleType.getLinkId();
	      if(role==121|| role==120 || role ==122|| role==123 || role==140|| role==141|| role==142|| role==143|| role==160|| role==170|| role==180|| role==280|| role==281|| role==282|| role==283|| role==310||role==311||role==312||role==313||role==320||role==321||role==322|| role==323|| role==560 || role==530 || role==540)
	      {}
	      else{
 	%>
            <tr class="tfield">
              <td width="30%"><%=roleType.getLinkDesc()%></td>
              <td ><input type="checkbox" name="links" value="<%=roleType.getLinkId() %>">       </td>
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
		<%
					}
		%>							
        </table>
    </form>

<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>

