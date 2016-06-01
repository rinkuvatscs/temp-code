
<%@ page import="com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory ==null || !sessionHistory.isAllowed(143) )
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
						String name = request.getParameter("name");
						String message = request.getParameter("message");
						int language = Integer.parseInt( request.getParameter("language")); 

						GMATManager gmatManager = new GMATManager();
                                  gmatManager.setConnectionPool(conPool);
						GMAT gmat = new GMAT();
 
            gmat.setName(name);
						gmat.setMessage(message);
						gmat.setLanguage(language);
						
						int i = gmatManager.modifyGMAT(gmat);
						if(i == 0)
						{
%>
							<script language="javascript">
										//alert("GMAT modified")
				 alert("<%=TSSJavaUtil.instance().getKeyValue("GMAT_modified",defLangId)%>")
										window.location = "home.jsp" 
							</script>
<% 
						}
						else
						{
%>
							<script language="javascript">
										//alert("Some UNknown Error")
					alert("<%=TSSJavaUtil.instance().getKeyValue("S_UNknown_Error",defLangId)%>")
										window.location = "../home.jsp" 
							</script>

<%
						}
		}
%>
