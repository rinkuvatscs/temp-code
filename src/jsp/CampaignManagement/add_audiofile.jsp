<%@ page import = "com.telemune.webadmin.webif.SessionHistory"%>
<%@ page import = "com.telemune.webadmin.webif.RbtManager"%>
<%@ page import = "com.telemune.webadmin.webif.TSSJavaUtil"%>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "javax.sound.sampled.*" %>
<%@ page import = "javazoom.upload.*" %>
<%@ page import = "java.io.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<jsp:useBean id="upBean1" scope="page" class="javazoom.upload.UploadBean" ></jsp:useBean>

<%
 Logger logger = Logger.getLogger ("add_audiofile.jsp");
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


//	String categoryHome = "/home/tomcat/voice/IVR_OUTDIAL";
	String categoryHome = TSSJavaUtil.instance().getAppConfigParam("CATEGORY_FILE_PATH");
	logger.debug("categoryHome="+ categoryHome);
	String musicfile =""; 
	String musicPath ="";
	String origin_address="7464";

	int error = -1;
	int retvalue =-1;

	if (MultipartFormDataRequest.isMultipartFormData(request))
	{
		AudioFormat format1 = null;
		// uses multipartformdatarequest to parse the http request.
		MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
		String todo = mrequest.getParameter("todo");

		String startdate = mrequest.getParameter("startDate").trim();
		String enddate = mrequest.getParameter("endDate").trim();

		logger.info("start="+startdate+ " enddate="+enddate);

	//	musicPath = categoryHome+"/";
	musicPath =categoryHome+"/IVR_OUTDIAL";
		logger.info("musicPath="+ musicPath);

		upBean1.setFolderstore(musicPath);

		RbtManager rbtMan = new RbtManager();
           rbtMan.setConnectionPool(conPool);

		if ((todo != null) && (todo.equalsIgnoreCase("upload")))
		{
			Hashtable files = mrequest.getFiles();
			if ((files != null) || (!files.isEmpty()))
			{
				UploadFile file1 = (UploadFile) files.get("musicfile");

				if (file1 != null)
				{
					musicfile = file1.getFileName().replace(' ','_').trim();  
					file1.setFileName(musicfile);

					try 
					{
						AudioFileFormat audioFileFormat1 = AudioSystem.getAudioFileFormat(file1.getInpuStream());
						format1 = audioFileFormat1.getFormat();
					}
					catch (UnsupportedAudioFileException usexp)
					{
						usexp.printStackTrace();
						error = 1;
					}
					catch (IOException ioexp)
					{
						ioexp.printStackTrace();
						error = 2;
					}

					musicfile = musicPath+"/"+musicfile;
					logger.info("musicfile="+ musicfile);

					if (format1 != null)
					{
						if (format1.getEncoding() != AudioFormat.Encoding.ULAW) error = 3;
						else if (format1.getChannels() > 1)		error = 4;
						else if (format1.getSampleRate() != 8000.0)	error = 5;
						else if (format1.getSampleSizeInBits() != 8)	error = 6;
						else if (format1.getFrameRate() != 8000.0)	error = 7;
						else if (format1.getFrameSize() != 1)		error = 8;
									else if (format1.isBigEndian())			error = 9;
									else if( file1.getFileSize() == 0)		error = 10;
									else if( file1.getFileSize() > 512000)	error = 11;
									if ((error > 0) && (error <= 11))
									{
													%>
																	<script language = "Javascript">
																	alert("<%=TSSJavaUtil.instance().getKeyValue("validaud",defLangId)%>");
													history.go(-1)
																	</script>
																	<%
									}
									retvalue = rbtMan.addNewRbt(origin_address, musicfile, startdate, enddate);
								if (retvalue == 0) error = 0;
								if (retvalue == 20 ) error = 20;
						
					}//if format
				if (error == 0) 
				{
					// uses the bean now to store specified by jsp:setproperty at the top.
					upBean1.store(mrequest, "musicfile");
				}
			}
		}
	}
	if (error == 0)
	{
%>
		<script language="Javascript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("rbtadded",defLangId)%>")
			window.location="home.jsp"
		</script>
<%
	}
	else if (error == 20)
	{
%>
		<script language="Javascript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("rbtalready",defLangId)%>")
			history.go(-1)
		</script>
<%
	}
else 
	{
%>
		<script language="Javascript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			history.go(-1)
		</script>
<%
	}

}
}
%>
