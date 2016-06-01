
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class SystemConfigManager
{
                              private static Logger logger=Logger.getLogger(SystemConfigManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public SystemConfigManager()				 
 {
 //				 conPool = new ConnectionPool();
 }


    public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

public int getSystemConfig (ArrayList systemConfigAl)
{
				logger.debug ("in function getSystemConfig" );
				String p_type="BOOL";
				try
				{
								con = conPool.getConnection();
								query = "SELECT PARAM_TAG,PARAM_TYPE, PARAM_VALUE, REMARKS,OWNER FROM CRBT_APP_CONFIG_PARAMS WHERE OWNER='OPERATOR'";
								pstmt = con.prepareStatement (query);
								systemConfigAl.clear ();
								rs = pstmt.executeQuery ();
								while(rs.next ())
								{
												SystemConfig systemConfig = new SystemConfig ();
												systemConfig.setParamTag (rs.getString (1));
												if(p_type.equals(rs.getString (2)))
												{
																if(rs.getString (3).equals("1"))
																				systemConfig.setParamValue ("YES");
																else
																				systemConfig.setParamValue ("NO");

												}
												else
																systemConfig.setParamValue (rs.getString (3));
												systemConfig.setRemarks (rs.getString (4));
												systemConfigAl.add (systemConfig);
								}
								rs.close ();
								pstmt.close ();
				}
				catch (Exception e)
				{
								try
								{
												if(pstmt != null) pstmt.close ();
								}catch(SQLException sqle)
								{
												logger.error ("Exception in listSystemConfig, Exception is : " + sqle.getMessage ());
								}
								e.printStackTrace ();
								return -1;
				}
				finally
				{	conPool.free(con);	}
				return 0;
}//getSystemConfig

 public int updateSystemConfig (SystemConfig systemConfig)
	{
				logger.debug ("in function updateSystemConfig" );
		try
		{
			con = conPool.getConnection();
			query = "UPDATE CRBT_APP_CONFIG_PARAMS SET PARAM_VALUE=?, REMARKS=? WHERE PARAM_TAG=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1,systemConfig.getParamValue ());
			pstmt.setString (2,systemConfig.getRemarks ());
			pstmt.setString (3,systemConfig.getParamTag ());
			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateSystemConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally
		{			conPool.free(con);	}
		return 0;

	}//updateSystemConfigParam
public int getSystemConfigParamValue (ArrayList systemConfigAl,String param)
{ 
								int i=0; 
								logger.debug ("in function getSystemConfigParamValue" );
								if(param.equals("DEFAULT_RATE_PLAN"))
								{
																try
																{
																								con = conPool.getConnection();
																								query = "SELECT PLAN_INDICATOR FROM CRBT_RATE_PLANS";
																								pstmt = con.prepareStatement (query);
																						//		pstmt.setString (1,param);
																								systemConfigAl.clear ();
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																SystemConfig systemConfig = new SystemConfig ();
																																systemConfig.setParamValue (rs.getString (1));
																																systemConfigAl.add (systemConfig);
																								}
																								rs.close ();
																								pstmt.close ();
																}
																catch (Exception e)
																{
																								try
																								{
																																if(pstmt != null) pstmt.close ();
																								}catch(SQLException sqle)
																								{
																																logger.error ("Exception in listSystemConfig, Exception is : " + sqle.getMessage ());
																								}
																								e.printStackTrace ();
																								return -1;
																}
																finally
																{	conPool.free(con);	}
																return 0;
								}
								else
								{
																i=0;
																	String zero="0";
																try
																{
																								con = conPool.getConnection();
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_1'";
																								pstmt = con.prepareStatement (query);
																								systemConfigAl.clear ();
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								i=i+1;
																																								SystemConfig systemConfig = new SystemConfig ();
																																								systemConfig.setParamValue (rs.getString (1));
																																								systemConfig.setParamTag ("1");
																																								systemConfigAl.add (systemConfig);
																																}
																								}
																								rs.close ();
																								pstmt.close ();
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_2'";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								i=i+1;
																																								SystemConfig systemConfig = new SystemConfig ();
																																								systemConfig.setParamValue (rs.getString (1));
																																								systemConfig.setParamTag ("2");
																																								systemConfigAl.add (systemConfig);
																																}
																								}
																								rs.close ();
																								pstmt.close ();
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_3'";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								i++;
																																								SystemConfig systemConfig = new SystemConfig ();
																																								systemConfig.setParamValue (rs.getString (1));
																																								systemConfig.setParamTag ("3");
																																								systemConfigAl.add (systemConfig);
																																}
																								}
																								rs.close ();
																								pstmt.close ();

																}
																catch (Exception e)
																{
																								try
																								{
																																if(pstmt != null) pstmt.close ();
																								}catch(SQLException sqle)
																								{
																																logger.error ("Exception in listSystemConfig, Exception is : " + sqle.getMessage ());
																								}
																								e.printStackTrace ();
																								return -1;
																}
																finally
																{
																					conPool.free(con);	
																}
																return i;

								}
}//getSystemConfigParamValue
 public int updateSystemConfiglogs (SystemConfig systemConfig,String user_name,String old_value)
	{
				logger.debug ("in function updateSystemConfiglogs" );
		try
		{
			con = conPool.getConnection();
			query = "INSERT INTO SYSTEM_CONFIG_CHANGE_LOG (PARAM_TAG,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE) VALUES (?,?,?,?,SYSDATE)";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1,systemConfig.getParamTag ());
			pstmt.setString (2,systemConfig.getParamValue ());
			pstmt.setString (3,old_value);
			pstmt.setString (4,user_name);
			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateSystemConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally
		{			conPool.free(con);	}
		return 0;

	}//updateSystemConfigParam

public int getSystemConfiglog (ArrayList systemConfigAl,String sdate,String edate,String page)
{
								logger.info ("in function getSystemConfig start date = "+sdate+"end date = "+edate);
int count=0;
int pageno=Integer.parseInt(page);
pageno=pageno*5;
int pagend=pageno+5;
								try
								{
																con = conPool.getConnection();

																if(sdate.equalsIgnoreCase("1")||edate.equalsIgnoreCase("1"))
																{
																								logger.info("start date and end date === 1");
																								query = "SELECT count(PARAM_TAG) FROM SYSTEM_CONFIG_CHANGE_LOG ";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								if (rs.next())
																								{
																																count = rs.getInt(1);
																								}
																								if(count>pageno)
																								query="SELECT PARAM_TAG, CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE FROM (select PARAM_TAG, CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE ,ROWNUM rm FROM SYSTEM_CONFIG_CHANGE_LOG ORDER BY UPDATED_DATE) where rm>="+pageno+" and rm < "+pagend;
																								pstmt = con.prepareStatement (query);
																}
																else
																{
																								query = "SELECT count(PARAM_TAG) FROM SYSTEM_CONFIG_CHANGE_LOG where UPDATED_DATE >= ? AND UPDATED_DATE <= ?";
																								pstmt = con.prepareStatement (query);
																								pstmt.setString (1, sdate);
																								pstmt.setString (2, edate);
																								rs = pstmt.executeQuery ();
																								if (rs.next())
																								{
																																count = rs.getInt(1);
																								}
																								logger.info("count== "+count+"pageno== "+pageno+"pagend=="+pagend);
																								if(count > pageno)	
query="SELECT PARAM_TAG, CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE FROM (select PARAM_TAG,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE ,ROWNUM rm FROM SYSTEM_CONFIG_CHANGE_LOG where UPDATED_DATE >=? AND UPDATED_DATE <=? ORDER BY UPDATED_DATE) where rm>="+pageno+" and rm < "+pagend;																													
																								pstmt = con.prepareStatement (query);
																								pstmt.setString (1, sdate);
																								pstmt.setString (2, edate);

																}

																systemConfigAl.clear ();
																rs = pstmt.executeQuery ();
																while(rs.next ())
																{
																								SystemConfig systemConfig = new SystemConfig ();
																								systemConfig.setParamTag (rs.getString (1));
																								systemConfig.setParamValue (rs.getString (2));
																								systemConfig.setPrevalue (rs.getString (3));
																								systemConfig.setOwner (rs.getString (4));
																								systemConfig.setUpDated (rs.getString (5));
																								systemConfigAl.add (systemConfig);
																}
																rs.close ();
																pstmt.close ();
								}
								catch (Exception e)
								{
																try
																{
																								if(pstmt != null) pstmt.close ();
																}catch(SQLException sqle)
																{
																								logger.error ("Exception in listSystemConfig, Exception is : " + sqle.getMessage ());
																}
																e.printStackTrace ();
																return -1;
								}
								finally
								{	conPool.free(con);	}
								int temp=count%5;
								if(temp==0)
								temp=count/5;
								else
								temp=(count/5)+1;
							logger.info("page no=="+temp);
								return temp;
}//getSystemConfiglog
public String IVR_Language (String param)
{ 
								String language="";
								String	zero="0";
								try
								{
																con = conPool.getConnection();
																if(param.equals("1"))
																{
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_1'";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								language=rs.getString (1);
																																}
																								}
																								rs.close ();
																								pstmt.close ();
																							//	conPool.free(con);	
																							//	return language;
																}
																if(param.equals("2"))
																{
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_2'";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								language=rs.getString (1);
																																}
																								}
																								rs.close ();
																								pstmt.close ();
																								//conPool.free(con);	
																								//return language;
																}
																if(param.equals("3"))
																{
																								query = "SELECT PARAM_VALUE FROM CRBT_APP_CONFIG_PARAMS WHERE PARAM_TAG='IVR_LANGUAGE_3'";
																								pstmt = con.prepareStatement (query);
																								rs = pstmt.executeQuery ();
																								while(rs.next ())
																								{
																																if(!(zero.equals(rs.getString (1))))
																																{
																																								language=rs.getString (1);
																																}
																								}
																								rs.close ();
																								pstmt.close ();
																								//conPool.free(con);	
																}

								}
								catch (Exception e)
								{
																try
																{
																								if(pstmt != null) pstmt.close ();
																}catch(SQLException sqle)
																{
																								logger.error ("Exception in listSystemConfig, Exception is : " + sqle.getMessage ());
																}
																e.printStackTrace ();
								}
								finally
								{
																conPool.free(con);	
								}
																								return language;
							
}//IVR_Language


 
} //class SystemConfigManager
