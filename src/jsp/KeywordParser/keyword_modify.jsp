
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(291))
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
        
        KeywordParserManager keywordManager = new KeywordParserManager();
     keywordManager.setConnectionPool(conPool);
        KeywordParser keywordParser = new KeywordParser();

				
     //   ArrayList packageAl = new ArrayList();
        ArrayList processAl = new ArrayList();
    		ArrayList keywordParserAl = new ArrayList();
        
				String keyword = request.getParameter("keyword");
		    
				int i = keywordManager.getKeywordParser (keywordParserAl,keyword,"ASC");
        int n = keywordManager.getProcesses(processAl);
        
%>

<%@ include file = "../pagefile/header.html" %>

   <form method="post" action="modifyKeyword.jsp" name="form">
				
          <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
            <tr class="tableheader"><td colspan="2">Keyword Parser Management - Modify Keyword<br><br> </td></tr>
						<%
						if(i<0 || n < 0 )
						{
						%>
						<tr class="notice"><td colspan="2"> There is some ERROR, Please Try Later.</td></tr>
						<%
						}
						else if( processAl.size() <=0 )
						{
						%>
						<tr class="notice"><td colspan="2"> No KeyWord Process is Defined. Please Try Later.</td></tr>
						<%
						}
					  else
						{
										for( int l = 0;l< keywordParserAl.size();l++)
														keywordParser = (KeywordParser) keywordParserAl.get(l);
						%>
            <tr class="tfield">
						     <td width="35%" >Keyword </td>
                 <td > <input type="text" name="keyword" value="<%=keywordParser.getRequestKeyword()%>" > </td>
																	<input type="hidden" name="old_keyword" id="old_keyword" value="<%=keywordParser.getRequestKeyword()%>">
            </tr>
            <tr class="tfield">
                 <td >Process </td>
<input type="hidden" name="old_proc" value="<%=keywordParser.getProcessName()%>">
                 <td >  <select name="proc" onchange="getDesc(this.value);">
            <option value="Select">Select Process</option>
<%            
		        for(int j=0; j<processAl.size(); j++)
    		    {
        	    String procName = (String) processAl.get(j);
          	  if(procName.equals(keywordParser.getProcessName()))
            	{
%>
              	 <option value="<%=procName%>" selected><%=procName%></option>
<%
            }
            else
            {
%>
                <option value="<%=procName%>" ><%=procName%></option>
<%
            }
        }
%>                
                    </select>
               </td>
             </tr>
													<tr class="tfield">
              <td >Syntax Message</td>
              <td >
                <TEXTAREA NAME="syntax" id="syntax" COLS=40 ROWS=1 READONLY ></TEXTAREA>
              </td>
            </tr>

            <tr class="tfield">
              <td >Description </td>
              <td >
                <TEXTAREA NAME="desc" id="desc" COLS=40 ROWS=4 READONLY ></TEXTAREA>
              </td>
            </tr>


             <tr class="button1">
                  <td colspan="2"><br>
                      <input type="submit" name="submit" value="Save Changes">
                      <input type="reset" name="Clear" value="Reset">
                  </td>
              </tr>
				<%
						}  //else
				%>	
<tr class="homemenu"><td></td><td><a href="keyword_manage.jsp?pid=0&srchtext=X&order=ASC&searchId=0">Back</a></td></tr>	
          </table>
       </form>

<%@ include file = "../pagefile/footer.html" %>
<%
}

%>
			<script type="text/javascript">
//document.getElementById("syntax").innerHTML=document.form.proc.options[document.form.proc.selectedIndex].value;
//alert(cat);
//var cat=document.getElementById("sel").value;


								var url = "getdesc.jsp?process=";
								var http = getHTTPObject(); 
var cat=document.form.proc.options[document.form.proc.selectedIndex].value;
			getDesc(cat);
								function handleHttpResponse() 
								{
								    if (http.readyState == 4) 
												{
																if (http.status == 200) 
																{
																				results = http.responseText.split("--");
																								document.getElementById("syntax").innerHTML=results[0];
																								document.getElementById("desc").innerHTML=results[1];
																}
												}
								}
								function getDesc(catname) 
								{
//alert(catname);
												http.open("GET", url+catname , true);
												http.onreadystatechange = handleHttpResponse;
												http.send(null);
								}
					 
								function getHTTPObject() 
								{																																																																																																																												    var xmlhttp;																																																																																																												    	if (window.XMLHttpRequest) 
												{																																																																																																																					        		xmlhttp = new XMLHttpRequest();																																																																																							    } 
												else if (window.ActiveXObject) 
												{																																																																																																																									        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");																																																																			    }																																																																																																																								    return xmlhttp;																																																																																																										}				
				
			</script>
