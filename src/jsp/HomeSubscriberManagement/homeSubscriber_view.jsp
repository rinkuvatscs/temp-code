
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(140))
{
   %>
    <%@ include file ="../logouterror.jsp" %>
      <%
        session.invalidate();
           request.getSession(true).setAttribute("lang",defLangId);
   }
else
{
		HomeSubscriberManager homeManager = new HomeSubscriberManager();
          homeManager.setConnectionPool(conPool);

    ArrayList homeSubDetailAl  = new ArrayList();
    
		int i = homeManager.getHomeSubscriber(homeSubDetailAl);
    
%>
 <%@ include file="../lang.jsp" %>
<html>
<head>
<Script Language="JavaScript">
        function ConfirmChoice()
				{
								answer = confirm("Are you sure you want to delete the selected Range?")
												if (answer !=0)
												{
																return true;
												}
												else
												{
																return false;
												}
				}
        function validate()
				{
								var checkBoxSelected = document.forms.form.rangeid
												var count = 0
												var isSelected = "false"
												if(checkBoxSelected.length != undefined)
												{
																while(count<checkBoxSelected.length)
																{
																				if(checkBoxSelected[count].checked==false)
																				{
																								isSelected  = "false"
																				}
																				else
																				{
																								isSelected ="true"
																												break
																				}
																				count +=1
																}
												}
												else
												{
																if(document.forms.form.rangeid.checked==true)
																				isSelected = "true"
												}
								if(isSelected=="true")
								{
												return ConfirmChoice()
								}
								else
								{
												alert("Please select at least one record to delete.")
																return false
								}
				}
	
        </script>
</head>

<%@ include file = "../pagefile/header.html" %>
   
	  <form name="form" method="post" action="deletehomesub.jsp" onSubmit="return validate()">
      
			 <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
          <tr class="tableheader" ><td colspan="4">Home Subscriber Management - View / Delete <br><br></td></tr>
<%
				if ( i < 0 || homeSubDetailAl.size() <= 0)
				{
%>
       		 <tr class="notice">
							<td colspan="4" align="center"> <p>No Subscriber Range defined!!! <br> Firstly you <a href="homeSubscriber_add.jsp"> Add Subscriber Range</a> and then View / Delete Subscriber Range  </P></td></tr>
<%
				}
        else
				{
%>
            <tr class="tfields" bgcolor="#a5c7d0">
              <td > <%=TSSJavaUtil.instance().getKeyValue("Range",defLangId)%> </td>
              <td ><%=TSSJavaUtil.instance().getKeyValue("Exclusions",defLangId)%> </td>
              <td > <%=TSSJavaUtil.instance().getKeyValue("HLR_Name",defLangId)%></td>
<%
            if(sessionHistory.isAllowed(141))
            {
%>
              <td ><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%> </td>
<%
            }
%>
            </tr>
<%
           int r=0;
            Iterator ite = homeSubDetailAl.iterator();
            while(ite.hasNext())
            {
                HomeSubDetail homeSubDetail = (HomeSubDetail)ite.next();
                Iterator iteExc = (homeSubDetail.getExcludes()).iterator();
                String excludes = "";
                while(iteExc.hasNext())
                {
                    if(excludes.equals(""))
                    {
                        excludes = excludes + (String) iteExc.next();
                    }
                    else
                    {
                        excludes = excludes + ", " +(String) iteExc.next();
                    }
                }
%>
            <tr class="tabledata_center"
									 		 <%if ( (r % 2) == 0){ %><%} else {%> bgcolor="#a5c7c2"<%} r++ ;%>  >
              <td ><%= homeSubDetail.getStartAt() %> - <%=homeSubDetail.getEndsAt() %> </td>
              <td align="left">		<%if(excludes.equals("") || excludes == null){%><img src="../images/cross.jpg" border="0"><%}else{%> <%=excludes %><%}%>  </td>
              <td align="left"><%=homeSubDetail.getHLRName() %> </td>
<%
                if(sessionHistory.isAllowed(141))
                {
%>
              <td>   <input type="checkbox" name="rangeid" value="<%= homeSubDetail.getRangeId()%>"> </td>
<%
                }
%>
            </tr>
<%
            }
            if(sessionHistory.isAllowed(141))
            {
%>
            <tr class="button1">
            	  <td colspan="4"> <br> <input type="submit" name="submit" value="Delete Record(s)"> <input type="reset" name="Clear" value="Clear"></td>
            </tr>
<%
            }
%>
<%
        }
%>
       </table>
    </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 }
%>
