
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%

SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(150))
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

    RoleTypeManager roleManager = new RoleTypeManager();
     roleManager.setConnectionPool(conPool);
    ArrayList roletypesAl = new ArrayList();
    int i = roleManager.getRoleTypes(roletypesAl);
%>
<HTML>
<HEAD>
<script type="text/javascript">
  function validate()
  {
      var userName = document.forms.form.userName.value = document.forms.form.userName.value.trim()
      if(userName=="")
      {
          return confirm("<%=TSSJavaUtil.instance().getKeyValue("alconfusps",defLangId)%>?"); 
      }
  return true
  }
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

   <form name="form" method="post" action="userManagement.jsp?pid=0" onSubmit="return validate()">
       <table width="70%" border="0" align="center">
         <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("umTop",defLangId)%> <br> <br></td></tr>
         <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("umUser",defLangId)%></td>
              <td ><input type="text" name="userName"></td>
         </tr>
         <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%></td>
              <td>   <select name="roleId" >
<%
    if(roletypesAl.size() > 0)
    {
%>           
            <option value="0" > All </option>
<%            
        for(int j = 0 ;j < roletypesAl.size(); j++)
        {
            RoleType roleType = (RoleType) roletypesAl.get(j);
%>
           <option value="<%=roleType.getRoleId()%>" > <%=roleType.getRoleName()%> </option>
<%
        }
    }
%>
                </select>
             </td>
         </tr>
         <tr class="button1">
             <td colspan="2"> <br> <br> <input type="submit" name="Search" value="<%=TSSJavaUtil.instance().getKeyValue("search",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"> </td>
         </tr>
        
		  </table>
   </form>
  
	      <p align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>
<% 
    if( sessionHistory.isAllowed(153))
    {
%>
        .  <a href="userManagement_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("umAddUser",defLangId)%></a>
<%
    }
%>
          </b></font></p>

<%@ include file = "../pagefile/footer.html" %>

<%
}
%>
