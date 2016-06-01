<%@ page import="com.telemune.webadmin.webif.TSSJavaUtil"%>
  <%@page import = "org.apache.log4j.*" %>
<%
      Logger logger = Logger.getLogger ("index.jsp");
	int defLangId=TSSJavaUtil.instance().getDefaultLang();

		logger.info("0. language="+request.getParameter("lang"));
 	if(request.getParameter("lang") == null || request.getParameter("lang")=="" || request.getParameter("lang").equalsIgnoreCase(""))
		{
				//TSSJavaUtil.instance().setLanguageFile("webadmin_en.properties");
		defLangId=TSSJavaUtil.instance().getDefaultLang();
	 if(session.getAttribute("lang")!=null)
		{
		 try{
                defLangId=Integer.parseInt(session.getAttribute("lang")+"");
                        }
                catch(Exception ex)
                        {
                        ex.printStackTrace();
                        defLangId=TSSJavaUtil.instance().getDefaultLang();
                        }
		logger.info("language set from session ");
		}
		else
		{
		session.setAttribute("lang",TSSJavaUtil.instance().getDefaultLang());
		}
		}
		else
		{
//		 TSSJavaUtil.instance().setLanguageFile(request.getParameter("lang"));
		try{
		defLangId=Integer.parseInt(request.getParameter("lang"));
			}
		catch(Exception ex)
			{
			ex.printStackTrace();
			defLangId=TSSJavaUtil.instance().getDefaultLang();
			}
		session.setAttribute("lang",defLangId);
		}	

%>



<%@ include file = "pagefile/header1.html" %>


	<table width="70%" border="0" cellspacing="1" align="center">
			<tr class="bluetext">
						<td colspan="2" align="center"><%=TSSJavaUtil.instance().getKeyValue("indexnote1",defLangId)%> </td>
			</tr>
			<tr class="bluetext">
						<td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("indexnote2",defLangId)%> </td>
			</tr>

	</table>
</form>
<script language="JavaScript" type="text/javascript">
                <!--
                document.form1.msisdn.focus();
                //-->
</script><%@ include file = "pagefile/footer.html" %>
</body>
</html>
