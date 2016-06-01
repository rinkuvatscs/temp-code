
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if (sessionHistory == null || !sessionHistory.isAllowed(292)) 
		{
     %>
      <%@ include file ="../logouterror.jsp" %>
        <%
          session.invalidate();
             request.getSession(true).setAttribute("lang",defLangId);
     }
    else
    {   
				KeywordParserManager keywordManager  = new KeywordParserManager();
        keywordManager.setConnectionPool(conPool);		 
        ArrayList processAl = new ArrayList();
        ArrayList packageAl = new ArrayList();
				
				int m = keywordManager.getProcesses(processAl);
//        int n = keywordManager.getPackages(packageAl);
        
%>
<HTML>
<HEAD>
<script type="text/javascript">
    function validate() 
		{
						var x = document.form.keyword.value = document.form.keyword.value.trim();
						if(x == "")
						{
										alert("The Keyword Name is Missing");
										document.form.keyword.focus();
										return false;
						}
						if(document.form.proc.value == "Select")
						{
										alert("Please select the process");
										document.form.proc.focus();
										return false;
						}
						if(document.form.packg.value == "Select")
						{
										alert("Please select the package");
										document.form.packg.focus();
										return false;
						}
						return true
		}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

     <form name="form" method="post" action="addKeyword.jsp" onSubmit="return validate()">
         <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
				    <tr class="tableheader"><td colspan="2"> Keyword Parser Management - Add Keyword <br><br> </td></tr>
<%
            if(m <= 0 ) //Process or package not in existence
            {
%>  
	          <tr class="notice"> <td colspan="2">There is Some Error. Please try Later</td></tr>
<%
						}
					  else if( processAl.size() <= 0 )
		 				{
%>
	          <tr class="notice"> <td colspan="2">Neccessary Data Not found. Please try Later</td></tr>
<%			    
						} 
						else
						{
%>
					  <tr class="tfield">
              <td >Keyword </td>
              <td ><input type="text" name="keyword" ></td>
            </tr>
            <tr class="tfield">
              <td >Process </td>
              <td >  <select name="proc" onchange="getDesc(this.value);">
<%
        if(processAl.size() > 0)
        {
%>           
            <option value="Select">Select Process</option>
<%            
            for(int j	=	0;	j	<	processAl.size()	;	j++)
            {
                String procName = (String) processAl.get(j);
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
              <td >Select Language </td>
              <td >
																	<select name="lngID" >
            <option value="1" selected >English</option>
            <option value="2">Spanish</option>
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
              <td colspan="2" align="left"><br> <input type="submit" name="submit" value="Add Keyword"> <input type="reset" name="Clear" value="Clear"> </td>
            </tr>

			<% 			} %>			
        </table>
<tr class="homemenu"><td></td><td><a href="home.jsp">Back</a></td></tr>
    </form>

<%@ include file = "../pagefile/footer.html" %>
<%
    }

%>
			<script type="text/javascript">
								var url = "getdesc.jsp?process=";
								var http = getHTTPObject(); 
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
