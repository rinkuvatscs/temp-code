
/*@Jatinder Pal */

package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
  import org.apache.log4j.*;
public class SMSTemplateManager

{
       private static Logger logger=Logger.getLogger(SMSTemplateManager.class);
	private ConnectionPool conPool = null;
	private PreparedStatement pstmt = null;
	private Connection con = null;
	private ResultSet rs =null;
	private String query = null;

	public SMSTemplateManager()				 
	{
	//	conPool = new ConnectionPool();
	}


        public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }


	public int addTemplateSMS ( TemplateSMS templateSms)
	{
		logger.debug ("in function addTemplateSMS");

		long templateId = 0;	
		try
		{
			con = conPool.getConnection();
			query = "select TEMPLATE_DESCRIPTION from LBS_TEMPLATES where TEMPLATE_DESCRIPTION=? and LANGUAGE_ID=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, templateSms.getTemplateDescription() );
			pstmt.setInt(2, templateSms.getLanguage() );
			rs = pstmt.executeQuery();
			if (rs.next() )
			{
				rs.close();
				pstmt.close();
				return -2 ; // TEMPLATE_DESCRIPTION exists in DB
			}
			rs.close();
			pstmt.close();

			query = "select crbt.lbs_templates_id.nextval from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if (rs.next() )
			{
				templateId = rs.getLong(1);
				rs.close();
				pstmt.close();
			}
			else
			{
				logger.info("SMSTemplateManager: templateId not created");		
				rs.close();
				pstmt.close();
				return -99;
			}

			query = "insert into LBS_TEMPLATES (TEMPLATE_ID, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED,TEMPLATE_DESCRIPTION, LANGUAGE_ID) values( ?,?,?,?,?,?) ";
			pstmt = con.prepareStatement(query);
			pstmt.setLong(1, templateId);
			pstmt.setString(2, templateSms.getTemplateType() );
			pstmt.setString(3, templateSms.getTemplateMessage().trim() );
			pstmt.setString(4, templateSms.getTokensAllowed().trim() );
			pstmt.setString(5, templateSms.getTemplateDescription().trim() );
			pstmt.setInt(6, templateSms.getLanguage() );

			pstmt.executeUpdate();
			pstmt.close();
		} //try
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in addTemplateSms, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		return 0;

	} //addTemplateSMS


	public int getTemplateSMS (ArrayList templateSmsAl, int language, String templateType, long templateId, String[] str)
	{
		logger.debug ("in function getTemplateSMS");
		try
		{
			con = conPool.getConnection();
			if(templateId == 0 && str.length!=0 && str != null )  // show all available templates for langauge
			{
				logger.debug ("getting all TemplateSMS  ");
				//query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? order by upper(TEMPLATE_DESCRIPTION)";

				// follwoing query is to get only some specific SMS
				//query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and TEMPLATE_ID in (64,7,213,9,14,11,10,61,60,62,15,40,37,36,42,16,17,18,21,80,82,83,84,92,81,87,93,25,94,95,96,115,89,91,90,104,103,105,106,151,152,150,145,300,201,202,203,204) order by upper(TEMPLATE_DESCRIPTION)";
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and TEMPLATE_ID =? order by TEMPLATE_ID";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1,language);
				for(int i=0;i<str.length;i++)
				{
					logger.info("templateId= "+ str[i]);
					pstmt.setLong(2,Long.parseLong(str[i]));
					rs = pstmt.executeQuery ();
					while(rs.next ())
					{
						TemplateSMS templateSms = new TemplateSMS ();
						templateSms.setTemplateId(rs.getLong("TEMPLATE_ID"));
						templateSms.setTemplateDescription(rs.getString("TEMPLATE_DESCRIPTION").trim() );
						templateSms.setTemplateType(rs.getString("TEMPLATE_TYPE"));
						templateSms.setTemplateMessage(rs.getString("TEMPLATE_MESSAGE").trim() );
						templateSms.setTokensAllowed(rs.getString("TOKENS_ALLOWED").trim());
						templateSmsAl.add (templateSms);
					}

				}	
			}
			else   // show a template SMS for templateType and templateId, with language
			{
				logger.info ("getting TemplateSMS for "+ templateId );
				query = "select TEMPLATE_ID, TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where TEMPLATE_ID=? and  LANGUAGE_ID = ? order by TEMPLATE_ID";
				pstmt = con.prepareStatement(query);
				pstmt.setLong(1,templateId);
				pstmt.setInt(2,language);
				rs = pstmt.executeQuery ();
				while(rs.next ())
				{
					TemplateSMS templateSms = new TemplateSMS ();
					templateSms.setTemplateId(rs.getLong("TEMPLATE_ID"));
					templateSms.setTemplateDescription(rs.getString("TEMPLATE_DESCRIPTION").trim() );
					templateSms.setTemplateType(rs.getString("TEMPLATE_TYPE"));
					templateSms.setTemplateMessage(rs.getString("TEMPLATE_MESSAGE").trim() );
					templateSms.setTokensAllowed(rs.getString("TOKENS_ALLOWED").trim());
					templateSmsAl.add (templateSms);
				}
			}
			rs.close ();
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in getTemplateSms, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		return 99;

	}// getTemplateSms
public int getHelpTemplateSMS (ArrayList templateSmsAl, int language, String templateDesc)
	{
		logger.debug ("in function getHelpTemplateSMS");
		try
		{
			con = conPool.getConnection();
				logger.info ("getting TemplateSMS for "+ templateDesc );
																								query = "select PROCESS_NAME,HELP_MESSAGE from gmat_help_master where LANGUAGE_ID = ? and PROCESS_NAME=? ";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1,language);
				pstmt.setString(2,templateDesc);
				rs = pstmt.executeQuery ();
				while(rs.next ())
				{
					TemplateSMS templateSms = new TemplateSMS ();
																								templateSms.setTemplateDescription(rs.getString("PROCESS_NAME").trim() );
																								templateSms.setTemplateMessage(rs.getString("HELP_MESSAGE").trim() );
					templateSmsAl.add (templateSms);
				}
			rs.close ();
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in getTemplateSms, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		return 99;

	}// getHelpTemplateSms
public int getHelpTemplateSMS (ArrayList templateSmsAl, int language, String searchtext, int inOrder,int searchby)
{
								logger.debug ("in function getHelpTemplateSMS");
								String Order="PROCESS_NAME";
								switch(inOrder)
								{
																case 0:
																								Order="PROCESS_NAME";
																								break;
																case 1:
																								Order="HELP_MESSAGE";
																								break;
								}
								try
								{
																con = conPool.getConnection();
																logger.debug ("getting all TemplateSMS  ");
																if(searchby==0)
																								query = "select PROCESS_NAME,HELP_MESSAGE from gmat_help_master where LANGUAGE_ID = ? order by "+Order;
																else if(searchby==1)
																								query = "select PROCESS_NAME,HELP_MESSAGE from gmat_help_master where LANGUAGE_ID = ? and upper(PROCESS_NAME) like ? order by "+Order;
																else if(searchby==2)
																								query = "select PROCESS_NAME,HELP_MESSAGE from gmat_help_master where LANGUAGE_ID = ? and upper(HELP_MESSAGE) like ? order by "+Order;

																pstmt = con.prepareStatement(query);
																pstmt.setInt(1,language);
																if(searchby>0)
																{
																								searchtext=searchtext.toUpperCase();
																								pstmt.setString(2,"%"+searchtext+"%");
																}
																rs = pstmt.executeQuery ();
																while(rs.next ())
																{
																								TemplateSMS templateSms = new TemplateSMS ();
																								templateSms.setTemplateDescription(rs.getString("PROCESS_NAME").trim() );
																								templateSms.setTemplateMessage(rs.getString("HELP_MESSAGE").trim() );
																								templateSmsAl.add (templateSms);
																}

								}
								catch (Exception e)
								{//log it
																try
																{
																								if(rs != null) rs.close ();
																								if(pstmt != null) pstmt.close ();
																}catch(SQLException sqle)
																{
																								logger.error ("Exception in getTemplateSms, Exception is : " + sqle.getMessage ());
																}
																logger.error ("Exception Received:" + e);
																return -99;
								}
								finally{conPool.free(con); }
								return 99;

}// getTemplateSms

	public int getTemplateSMS (ArrayList templateSmsAl, int language, String searchtext, int tempId,int inOrder,int searchby)
	{
		logger.debug ("in function getTemplateSMS");
String Order="TEMPLATE_ID";
switch(inOrder)
{
								case 0:
																Order="TEMPLATE_ID";
																break;
								case 1:
																Order="TEMPLATE_MESSAGE";
																break;
								case 2:
																Order="TEMPLATE_DESCRIPTION";
																break;
								case 3:
																Order="TEMPLATE_TYPE";
																break;
								default:
																Order="TEMPLATE_ID";
																break;
}
		try
		{
			con = conPool.getConnection();
				logger.debug ("getting all TemplateSMS  ");
if(searchby==0)
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? order by "+Order;
else if(searchby==1)
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and upper(TEMPLATE_MESSAGE) like ? order by "+Order;
else if(searchby==2)
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and upper(TEMPLATE_DESCRIPTION) like ? order by "+Order;
else if(searchby==3)
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and upper(TEMPLATE_TYPE) like ? order by "+Order;
else if(searchby==4)
				query = "select TEMPLATE_ID,TEMPLATE_DESCRIPTION, TEMPLATE_TYPE, TEMPLATE_MESSAGE, TOKENS_ALLOWED from LBS_TEMPLATES where LANGUAGE_ID = ? and TEMPLATE_ID like ? order by "+Order;

				pstmt = con.prepareStatement(query);
				pstmt.setInt(1,language);
if(searchby==4)
{
				pstmt.setInt(2,tempId);
}
else if(searchby>0)
{
searchtext=searchtext.toUpperCase();
				pstmt.setString(2,"%"+searchtext+"%");
}
				rs = pstmt.executeQuery ();
				while(rs.next ())
				{
try
{
					TemplateSMS templateSms = new TemplateSMS ();
					templateSms.setTemplateId(rs.getLong("TEMPLATE_ID"));
					templateSms.setTemplateDescription(rs.getString("TEMPLATE_DESCRIPTION").trim() );
					templateSms.setTemplateType(rs.getString("TEMPLATE_TYPE"));
					templateSms.setTemplateMessage(rs.getString("TEMPLATE_MESSAGE").trim() );
					templateSms.setTokensAllowed(rs.getString("TOKENS_ALLOWED").trim());
					templateSmsAl.add (templateSms);
}
catch(Exception es)
{
es.printStackTrace();
}
				}

		}
		catch (Exception e)
		{//log it
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in getTemplateSms, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
                            e.printStackTrace();
			return -99;
		}
		finally{conPool.free(con); }
		return 99;

	}// getTemplateSms

	public int deleteTemplateSMS (TemplateSMS templateSms)
	{
		logger.debug ("in function deleteTemplateSMS");
		try
		{
			con = conPool.getConnection();
			query = "delete from LBS_TEMPLATES where TEMPLATE_ID = ? and TEMPLATE_TYPE = ? and LANGUAGE_ID=?";
			pstmt = con.prepareStatement (query);
			pstmt.setLong(1, templateSms.getTemplateId() );
			pstmt.setString(2, templateSms.getTemplateType() );
			pstmt.setInt(3, templateSms.getLanguage() );
			pstmt.executeUpdate();
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in deleteTemplateSMSData, Exception is : " + sqle.getMessage ());
			}
			return -99;
		}
		finally{conPool.free(con); }
		return 99;
	}
public int updateHelpTemplateSMS (TemplateSMS templateSms)
	{
		logger.debug ("in function updateHelpTemplateSMS");
		try
		{
			con = conPool.getConnection();
			query = "update GMAT_HELP_MASTER set HELP_MESSAGE=? where PROCESS_NAME=? and LANGUAGE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, templateSms.getTemplateMessage().trim()  );
			pstmt.setString (2, templateSms.getTemplateDescription() );
			pstmt.setInt (3, templateSms.getLanguage());

			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateHelpTemplateSMS, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		return 99;

	}// updateHelpTemplateSMS

	public int updateTemplateSMS (TemplateSMS templateSms)
	{
		logger.debug ("in function updateTemplateSMS");
		try
		{
			con = conPool.getConnection();
			query = "update LBS_TEMPLATES set TEMPLATE_MESSAGE=? where TEMPLATE_ID=? and TEMPLATE_TYPE=? and LANGUAGE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, templateSms.getTemplateMessage().trim()  );
			pstmt.setLong (2, templateSms.getTemplateId() );
			pstmt.setString (3, templateSms.getTemplateType() );
			pstmt.setInt (4, templateSms.getLanguage() );

			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateTemplateSMS, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		return 99;

	}// updateTemplateSMS

} //class SMSTemplateManager
