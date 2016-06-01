<%@ page import = "com.telemune.webadmin.webif.SessionHistory"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "org.apache.commons.fileupload.*"%>
<%@ page import = "org.apache.commons.fileupload.servlet.*"%>
<%@ page import = "org.apache.commons.fileupload.disk.*"%>
<%@ page import = "org.apache.commons.fileupload.FileItem"%>
<%@ page import = "org.apache.commons.fileupload.FileUpload"%>
<%@ page import = "org.apache.commons.fileupload.FileUploadBase.*"%>
<%@ page import = "org.apache.commons.io.*"%>
<%@ page import = "javazoom.upload.*" %>
<%@page import = "org.apache.log4j.*" %>
<jsp:useBean id="upBean1" scope="page" class="javazoom.upload.UploadBean" ></jsp:useBean>

<%
  Logger logger = Logger.getLogger ("add_listfile.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if(sessionHistory == null || !sessionHistory.isAllowed(2000))
{
	session.invalidate();
	%>
		<%@ include file="../logouterror.jsp" %>
		<%
}
else
{
    %>
    <%@ include file="../lang.jsp" %>
    <%

	//String categoryHome = "/home/tomcat/voice/IVR_OUTDIAL";
	String categoryHome = TSSJavaUtil.instance().getAppConfigParam("CATEGORY_FILE_PATH");
	logger.info("categoryHome="+ categoryHome);
	String msisdnfile =""; 
	String filePath ="";
	String[] cmdRun= new String[1];
	String retry_num="";
	String retry_dur="";

	int error = -1;
	int retvalue =-1;
	int exitVal =-1;

	if(ServletFileUpload.isMultipartContent(request))
	{
		MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
		//int retry_num = Integer.parseInt(mrequest.getParameter("retry_num"));
		//int retry_dur = Integer.parseInt(mrequest.getParameter("retry_dur"));
		retry_num = mrequest.getParameter("retry_num");
		retry_dur = mrequest.getParameter("retry_dur");

		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		diskFileItemFactory.setSizeThreshold(512000); /* bytes if size< - file is stored in memory else in temp file in disk*/

		File repositoryPath = new File("/temp");
		diskFileItemFactory.setRepository(repositoryPath);

		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		servletFileUpload.setSizeMax(1024000); /* bytes */
		logger.info("allowed max. size= "+ servletFileUpload.getSizeMax());
		try {
			
			logger.info("allowed max. size= "+ servletFileUpload.getSizeMax());
			List fileItemsList = servletFileUpload.parseRequest(request);
			Iterator iter = fileItemsList.iterator();
			while(iter.hasNext())
			{
				logger.info("Iterator= "+ iter);
				FileItem fileItem = (FileItem)iter.next();
				String itemName = fileItem.getName();
				String contentType = fileItem.getContentType();
				boolean isinMem = fileItem.isInMemory();
				//			long filesize= fileItem.getSize();
				logger.info("itemName ="+itemName+"  contentType="+ contentType+" isinMemory="+ isinMem);
			}
		}//try
		catch (SizeLimitExceededException ex) {
			logger.error("Size limit, Error> "+ex);
		}

	//	filePath = categoryHome+"/";
	filePath =categoryHome+"/IVR_OUTDIAL";
		logger.info("filePath="+ filePath);
		upBean1.setFolderstore(filePath);

		Hashtable files = mrequest.getFiles();
		if ((files != null) || (!files.isEmpty()))
		{
			UploadFile file1 = (UploadFile) files.get("msisdnfile");

			if (file1 != null)
			{
				//msisdnfile = file1.getFileName().replace(' ','_').trim();  
				msisdnfile="msisdn.txt";
				file1.setFileName(msisdnfile);

				upBean1.store(mrequest, "msisdnfile");
				logger.info(msisdnfile+ " uploaded ");
			}
		}
	}//if(ServletFileUpload)
	try
	{            
		/* **NOTE: put add_to_db.sh in /home/tomcat/voice/IVR_OUTDIAL, /home/tomcat and Define '$PATH' path of "add_to_db.sh" script  in .bash_profile  */
		//					cmdRun[0]="add_to_db.sh";
		//cmdRun[1]=retry_num;
		//cmdRun[2]=retry_dur;
		// File fileMsisdn= new File("/home/tomcat/");
		//			logger.info("Preparing to execute script to insert values in DB: filepath="+fileMsisdn+"  "+cmdRun[0]+ "  "+cmdRun[0]);
		Runtime rt = Runtime.getRuntime();
		Process proc = rt.exec("/home/tomcat/voice/IVR_OUTDIAL/add_to_db.sh");
		//Process proc = rt.exec("add_to_db.sh", null, fileMsisdn);
		//									Process proc = rt.exec(cmdRun, null, fileMsisdn);
		exitVal = proc.waitFor();//exitValue();
		logger.info("Process exitValue: " + exitVal);
	} catch (Throwable t)
	{
		t.printStackTrace();
	}
	if(exitVal ==0)
	{
		logger.info("script executed");
		String encodedURL = response.encodeRedirectURL("home.jsp");
		response.sendRedirect(encodedURL);
	}
	else
	{
		%>
			<script language="Javascript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
		window.location="home.jsp"
			</script>
			<%
	}

}

%>
