

package com.telemune.webadmin.webif;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class KeywordParserManager
{ 
                               private static Logger logger=Logger.getLogger(KeywordParserManager.class);
  
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public KeywordParserManager()				 
 {
		//		 conPool = new ConnectionPool();
 }
         public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

 
 public int  getProcesses (ArrayList processAl)
	{
		logger.debug ("KeywordParserManager: in function getProcesses ");
		try
		{
			con = conPool.getConnection();
			query = "select PROCESS_NAME from LBS_PROCESS_MASTER order by PROCESS_NAME";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				processAl.add (rs.getString("PROCESS_NAME"));
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
				logger.error ("Exception in getProcesses, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{ conPool.free(con); } 
		return 99;
	
	} // getProcesses
	
	public int  getPackages (ArrayList packageAl)
	{
		logger.debug ("webadmin getPackages");
		try
		{
     	con = conPool.getConnection();
			query = "select PACKAGE_NAME from LBS_PACKAGE_MASTER order by PACKAGE_NAME";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				packageAl.add (rs.getString("PACKAGE_NAME"));
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
				logger.error ("Exception in getPackages, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally { conPool.free(con); }
		return 99;
	
	} //getPackages

	public int addKeywordParser (KeywordParser keywordParser, String lngID)
	{
		logger.debug ("webadmin addKeywordParser");
		try
		{
			con = conPool.getConnection();
			query = "select REQUEST_KEYWORD from LBS_PARSER_MASTER where REQUEST_KEYWORD = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString(1, keywordParser.getRequestKeyword() );
			rs = pstmt.executeQuery();
			if(rs.next())
			{
			rs.close();
			pstmt.close();
				return -2; // Keyword name already exist
			}
			rs.close();
			pstmt.close();

			query = "insert into LBS_PARSER_MASTER(REQUEST_KEYWORD, PROCESS_NAME, PACKAGE_NAME, CREATED_BY, CREATION_DATE, LANGUAGE_ID) values (?, ?, 'CrbtSms', ?, sysdate, ?)";
			pstmt = con.prepareStatement (query);
			
			pstmt.setString(1, keywordParser.getRequestKeyword() );
			pstmt.setString(2,  keywordParser.getProcessName() );
			pstmt.setString(3, keywordParser.getCreatedBy() );
			pstmt.setString(4, lngID );
			
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
				logger.error ("Exception in addKeywordParser, Exception is : " + sqle.getMessage ());
			}
			logger.error("Exception Received:" + e);
			return -99;
		}
		finally { conPool.free(con) ; }
	
		return 0;
	
	} // addKeywordParser
	
	public int  getKeywordParser (ArrayList keywordParserAl, String keyword, String order)
	{
		logger.debug ("in function getKeywordParser for "+ keyword+"==order=="+order);
		try
		{
			con = conPool.getConnection();
			if(keyword.equalsIgnoreCase("X") )  // show all Keywords
				{
					query = "select REQUEST_KEYWORD, PROCESS_NAME, PACKAGE_NAME, CREATED_BY, CREATION_DATE, UPDATED_BY, UPDATE_DATE from LBS_PARSER_MASTER ORDER BY REQUEST_KEYWORD "+order; //ASC";
					pstmt = con.prepareStatement (query);
				}
			else                    // show keyword given 
				{
					query = "select REQUEST_KEYWORD, PROCESS_NAME, PACKAGE_NAME, CREATED_BY, CREATION_DATE, UPDATED_BY, UPDATE_DATE from LBS_PARSER_MASTER where REQUEST_KEYWORD LIKE ? ORDER BY REQUEST_KEYWORD "+order;  // ASC";
					pstmt = con.prepareStatement (query);
					pstmt.setString(1, "%"+keyword+"%");
			  }
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				KeywordParser keyParser = new KeywordParser ();
				keyParser.setRequestKeyword(rs.getString("REQUEST_KEYWORD"));
				keyParser.setProcessName(rs.getString ("PROCESS_NAME"));
				keyParser.setPackageName(rs.getString ("PACKAGE_NAME"));
				keyParser.setCreatedBy(rs.getString("CREATED_BY"));
				keyParser.setCreationDate(rs.getString("CREATION_DATE"));
				keyParser.setUpdatedBy(rs.getString("UPDATED_BY"));
				keyParser.setUpdateDate(rs.getString("UPDATE_DATE"));

				keywordParserAl.add (keyParser);
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
				logger.error ("Exception in getKeywordParserData, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{ conPool.free(con) ;}
		return 99;
	
	} //getKeywordParserData

	public int deleteKeywordParser (String[] reqKeywords)
	{
		logger.debug ("in function deleteKeywordParser");
		try
		{
			con = conPool.getConnection();
			query = "delete from LBS_PARSER_MASTER where REQUEST_KEYWORD = ?";
			pstmt = con.prepareStatement (query);
			for(int i=0; i<reqKeywords.length; i++)
			{
				pstmt.setString(1, reqKeywords[i]);
				pstmt.executeUpdate();
			}
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in deleteKeywordParser, Exception is : " + sqle.getMessage ());
			}
			return -99;
		}
		finally{ conPool.free(con) ; }

		return 99;
	
	} //deleteKeywordParserData

	public int updateKeywordParser (KeywordParser keyParser,String old_keyword)
	{
		logger.debug ("in function updateKeywordParser for \" "+ keyParser.getRequestKeyword() + "\" & "+ keyParser.getProcessName() );
		try
		{
			con = conPool.getConnection();
   query = "update LBS_PARSER_MASTER set PROCESS_NAME=?, REQUEST_KEYWORD=?, UPDATE_DATE=sysdate where REQUEST_KEYWORD=?";
			//query = "update LBS_PARSER_MASTER set PROCESS_NAME=?, UPDATE_DATE=sysdate where REQUEST_KEYWORD=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString(1, keyParser.getProcessName() );
			pstmt.setString(2, keyParser.getRequestKeyword() );
			pstmt.setString(3, old_keyword );

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
				logger.error ("Exception in updateKeywordParser, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally{conPool.free(con); }
		
		return 99;
		
	} //updateKeywordParserData
public String  getDesc (String process)
{
								logger.debug ("KeywordParserManager: in function getDesc ");
								String desc="";
								String syntax="";
								String result="";
								try
								{
																con = conPool.getConnection();
																query = "select SYNTAX_MESSAGE,DESCRIPTION from LBS_PROCESS_MASTER where PROCESS_NAME=?";
																pstmt = con.prepareStatement (query);
																pstmt.setString(1, process);
																rs = pstmt.executeQuery ();
																while(rs.next ())
																{
																								syntax=rs.getString("SYNTAX_MESSAGE");
																								desc=rs.getString("DESCRIPTION");
																}
																rs.close ();
																pstmt.close ();
								}
								catch (Exception e)
								{//log it
																logger.error ("Exception Received:" + e);
								}
								finally{ conPool.free(con); } 
									result=syntax+"--"+desc;
								return result;

} // getDesc
public int  getKeywordDetail (ArrayList keywordParserAl, String keyword)
{
								logger.info ("in function getKeywordParser for "+ keyword);
								String Request_keyword="";
								try
								{
																con = conPool.getConnection();
																query = "select PROCESS_NAME from LBS_PARSER_MASTER WHERE REQUEST_KEYWORD = ?";
																pstmt = con.prepareStatement (query);
																pstmt.setString(1, keyword);
																rs = pstmt.executeQuery ();
																while(rs.next ())
																{
																								Request_keyword=rs.getString ("PROCESS_NAME");
																}
																rs.close ();
																pstmt.close ();

																query = "select PROCESS_NAME, MIN_ARGUMENTS, MAX_ARGUMENTS, SYNTAX_MESSAGE, DESCRIPTION from LBS_PROCESS_MASTER WHERE PROCESS_NAME = ?";
																pstmt = con.prepareStatement (query);
																pstmt.setString(1, Request_keyword);
																rs = pstmt.executeQuery ();
																while(rs.next ())
																{
																								KeywordParser keyParser = new KeywordParser ();
																							//	keyParser.setRequestKeyword(rs.getString ("REQUEST_KEYWORD"));
																								keyParser.setProcessName(rs.getString ("PROCESS_NAME"));
																								keyParser.setMinArgument(Integer.parseInt(rs.getString ("MIN_ARGUMENTS")));
																								keyParser.setMaxArgument(Integer.parseInt(rs.getString("MAX_ARGUMENTS")));
																								keyParser.setSyntaxMessage(rs.getString("SYNTAX_MESSAGE"));
																								keyParser.setDesc(rs.getString("DESCRIPTION"));

																								keywordParserAl.add (keyParser);
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
																								logger.error ("Exception in getKeywordParserData, Exception is : " + sqle.getMessage ());
																}
																logger.error ("Exception Received:" + e);
																return -99;
								}
								finally{ conPool.free(con) ;}
								return 99;

} //getKeywordDetail


} // class KeywordParserManager
