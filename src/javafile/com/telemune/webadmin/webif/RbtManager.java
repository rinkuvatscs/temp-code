/*
 * Maintains every user's session history
 *
 *
 *
 */
package com.telemune.webadmin.webif;

import com.telemune.dbutilities.*;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.*;
import java.io.*;
 import org.apache.log4j.*;
public class RbtManager
{
        private static Logger logger=Logger.getLogger(RbtManager.class);
	private ConnectionPool conPool=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private String query=null;

	public RbtManager()
	{
		//conPool = new ConnectionPool();
	}	

       
	public void setConnectionPool(ConnectionPool conPool)
	{
		this.conPool = conPool;			
	}

	public ConnectionPool getConnectionPool()
	{
		return conPool;		
	}

	public int addNewRbt(String origin_address, String filepath, String startdate, String enddate)
	{
		try
		{	
			con = conPool.getConnection();
			con.setAutoCommit(false);

					query = "insert into OUT_DIAL_DATA  (ORIGINATION_ADDRESS,FILE_PATH, OUTDIAL_START_TIME, OUTDIAL_END_TIME, CREATION_DATE)  values (?, ?, to_date(?,'DD-MM-YYYY HH24'),to_date(?,'DD-MM-YYYY HH24'), sysdate)";
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, origin_address);
			pstmt.setString(2, filepath);
			pstmt.setString(3, startdate);
			pstmt.setString(4, enddate);
			
			pstmt.executeUpdate();
			pstmt.close();
			
				con.commit();
			return 0;
		}
		catch (Exception exp)
		{//log it 
			try {
				con.rollback();
			}	catch (Exception e) {
				e.printStackTrace();
			}
			exp.printStackTrace();
			return -1;
		}
		finally
		{
			conPool.free(con);
		}
	}

	public int modifyRbt(String mname, int rbtId, String ivrPath, String musicpath, String nick, String nokia, String others, int score, String play, int cpCode, String web, String sms,int catId)
	{
		try
		{	
			con = conPool.getConnection();
			con.setAutoCommit(false);

			String query = "select MASKED_NAME, RBT_CODE from CRBT_RBT where MASKED_NAME = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1,mname);

			ResultSet rs = pstmt.executeQuery();

			if(rs.next())
			{
				if (!(rs.getInt(2) == rbtId))
					return CrbtErrorCodes.RBT_ALREADY_EXISTS;
			}
			rs.close();
			pstmt.close();

			query = "update CRBT_RBT set MASKED_NAME = ?, FILE_PATH = ?, CREATE_DATE = sysdate, RBT_SCORE = ?, IVR_FILEPATH = ?, RBT_NICK = ?, PLAYABLE = ?, SHOW_ON_WEB = ?, SHOW_IN_SMS = ?, CONTENT_PROVIDER_CODE = ?, CAT_ID = ? where RBT_CODE = ?";
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, mname.trim());
			pstmt.setString(2, musicpath);
			pstmt.setInt(3, score);
			pstmt.setString(4, ivrPath);
			pstmt.setString(5, nick);
			pstmt.setString(6, play);
			pstmt.setString(7, web);
			pstmt.setString(8, sms);
			pstmt.setInt(9, cpCode);
			pstmt.setInt(10, catId);
			pstmt.setInt(11, rbtId);

			pstmt.executeUpdate();
			pstmt.close();

			query = "update CRBT_MONOTONE_MASTER set RINGTONE_DATA = ? where RBT_CODE = ? and RINGTONE_TYPE = ?";
			pstmt = con.prepareStatement(query);

			String queryInsert = "insert into CRBT_MONOTONE_MASTER(RBT_CODE, RINGTONE_TYPE, RINGTONE_DATA) values(?, ?, ?)";
			nokia = nokia.trim();
			others = others.trim();
			int isnokia = 0;
			int isother = 0;

			if ((nokia != null) && !(nokia.equals("")))
			{
				pstmt.setString(1, nokia);
				pstmt.setInt(2, rbtId);
				pstmt.setString(3, "nokia");

				if (pstmt.executeUpdate() >= 1)
				{
				}
				else
				{
					PreparedStatement pstmtInsert = con.prepareStatement(queryInsert);
					pstmtInsert.setInt(1, rbtId);
					pstmtInsert.setString(2, "nokia");					
					pstmtInsert.setString(3, nokia);
					pstmtInsert.executeUpdate();	
					pstmtInsert.close();
					isnokia = 1;	
				}
			}

			if ((others != null) && !(others.equals("")))
			{
				pstmt.setString(1, others);
				pstmt.setInt(2, rbtId);
				pstmt.setString(3, "others");

				if (pstmt.executeUpdate() >= 1)
				{
				}
				else
				{
					PreparedStatement pstmtInsert = con.prepareStatement(queryInsert);
					pstmtInsert.setInt(1, rbtId);
					pstmtInsert.setString(2, "others");	
					pstmtInsert.setString(3, others);
					pstmtInsert.executeUpdate();	
					pstmtInsert.close();
					isother = 1;
				}
			}

			pstmt.close();

			if (isnokia == 1)
			{
				query = "update CRBT_RBT set NOKIA = 1 where RBT_CODE = ?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, rbtId);
				pstmt.executeUpdate();
			}
			if (isother == 1)
			{
				query = "update CRBT_RBT set OTHER = 1 where RBT_CODE = ?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, rbtId);
				pstmt.executeUpdate();
			}
			pstmt.close();				
			con.commit();			
			return CrbtErrorCodes.SUCCESS;
		}
		catch (Exception exp)
		{//log it 
			try {
				con.rollback();
			}	catch (Exception e) {
				e.printStackTrace();
			}
			exp.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
	}

	public int deleteRbt(int rbtId)
	{
		try
		{
			int rbtCode = Integer.parseInt(TSSJavaUtil.instance().getAppConfigParam("DEFAULT_RBT"));
			con = conPool.getConnection();
			con.setAutoCommit(false);
			PreparedStatement pstmt = null;
			String query = null;

			query = "update CRBT_SUBSCRIBER_MASTER set RBT_CODE = ? where RBT_CODE = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, rbtId);
			pstmt.executeUpdate();
			pstmt.close();

			query = "update CRBT_DEFAULT_DETAIL set RBT_CODE = ? where DAY='8' and START_AT='2500' and ENDS_AT='2500' and RBT_CODE = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, rbtId);
			pstmt.executeUpdate();
			pstmt.close();

			query = "delete from CRBT_MONOTONE_MASTER cascade where RBT_CODE = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtId);
			pstmt.executeUpdate();
			pstmt.close();

			query = "delete from CRBT_RBT cascade where RBT_CODE = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtId);
			pstmt.executeUpdate();

			pstmt.close();	
			con.commit();			
			return CrbtErrorCodes.SUCCESS;
		}
		catch (Exception exp)
		{//log it 
			try {
				con.rollback();
			}	catch (Exception e) {
				e.printStackTrace();
			}
			exp.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
	}

	public int playRbt(String musicPath, Writer out)
	{
		try
		{
			logger.info("in playRbt() "+musicPath);
			File filename = new File(musicPath);
			FileInputStream fis = new FileInputStream(filename);
			int i = fis.read();
			logger.info("fis.read() i="+i);
			while(i != -1)
			{
				out.write(i);
				i = fis.read();
			}
			fis.close();
		}
		catch(FileNotFoundException fne )
		{
			fne.printStackTrace();
			return CrbtErrorCodes.FILE_NOT_FOUND;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		return CrbtErrorCodes.SUCCESS;	
	}

	public int getRbtDetails(Rbt rbt)
	{
		try
		{	
			con = conPool.getConnection();

			String query = "select MASKED_NAME, FILE_PATH, RBT_SCORE, IVR_FILEPATH, RBT_NICK, PLAYABLE, SHOW_ON_WEB, SHOW_IN_SMS, CONTENT_PROVIDER_CODE, CAT_ID from CRBT_RBT where RBT_CODE = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbt.getRbtId());
			ResultSet rs = pstmt.executeQuery();

			if (rs.next())
			{
				rbt.setRbtMaskedName(rs.getString("MASKED_NAME"));
				rbt.setMusicPath(rs.getString("FILE_PATH"));
				rbt.setScore(rs.getInt("RBT_SCORE"));
				rbt.setIvrFileName(rs.getString("IVR_FILEPATH"));
				rbt.setNickName(rs.getString("RBT_NICK"));
				rbt.setPlayable(rs.getString("PLAYABLE"));
				rbt.setShowWeb(rs.getString("SHOW_ON_WEB"));
				rbt.setShowSms(rs.getString("SHOW_IN_SMS"));
				rbt.setContentProviderCode(rs.getInt("CONTENT_PROVIDER_CODE"));
				rbt.setCategoryId(rs.getInt("CAT_ID"));
			}
			rs.close();
			pstmt.close();

			query = "select RINGTONE_DATA from CRBT_MONOTONE_MASTER where RBT_CODE = ? and RINGTONE_TYPE = ?";
			pstmt = con.prepareStatement(query);

			pstmt.setInt(1, rbt.getRbtId());
			pstmt.setString(2, "nokia");

			rs = pstmt.executeQuery();

			if (rs.next())
			{
				rbt.setNokia(rs.getString("RINGTONE_DATA"));
			}

		  rs.close();	
			pstmt.close();	
			con.commit();			
			return CrbtErrorCodes.SUCCESS;
		}
		catch (Exception exp)
		{//log it 
			exp.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
	}

  
	public int searchRbtCP(int catId, int cpId, ArrayList rbtList) 
	{
					logger.debug("searchRbtCP(): search rbt per category");
					Connection con = null;
					PreparedStatement pstmt1=null;
					PreparedStatement pstmt2=null;
					ResultSet rs = null;
					String query = null;
					String cquery = null;
					String specialCatId ="998";
					String recordedCatId="999";
					int ret = -1;
					try
					{	
									con = conPool.getConnection();
									specialCatId   = TSSJavaUtil.instance().getAppConfigParam("SPECIAL_CONTROL_CATID");
									recordedCatId  = TSSJavaUtil.instance().getAppConfigParam("CRBT_RECORDED_CATEGORY_ID");

									query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID = ?) and not(CAT_ID = ?) and CONTENT_PROVIDER_CODE = ? and CAT_ID=? order by MASKED_NAME) )"; 
													pstmt1 = con.prepareStatement(query);
													pstmt1.setString(1, recordedCatId);
													pstmt1.setString(2, specialCatId);
													pstmt1.setInt(3,cpId);
													pstmt1.setInt(4,catId);

													rs = pstmt1.executeQuery();
													while(rs.next()) 
													{
																	Rbt rbt = new Rbt(rs.getInt("RBT_CODE"),rs.getString("MASKED_NAME"),rs.getInt("CAT_ID"));
																	rbtList.add(rbt);
													}
													if(rs != null) rs.close();
													if(pstmt1 != null) pstmt1.close();
									return 1;
					}//try
					catch (SQLException e) 
					{
									logger.error("searchRbtCP(), SQLException :"+e.getMessage());
									try {
													if(rs != null) rs.close();
													if(pstmt1 != null) pstmt1.close();
												//	if(pstmt2 != null) pstmt2.close();
									} catch(Exception exp) {}
									e.printStackTrace();
									return -99;
					}
					catch (Exception e) 
					{
									try {
													if(rs != null) rs.close();
													if(pstmt1 != null) pstmt1.close();
													if(pstmt2 != null) pstmt2.close();
									} catch(Exception exp) {}                
									e.printStackTrace();
									return -99;
					}
					finally {
									conPool.free(con);
					}

	}//searchRbtCP()

	public int searchRbtCP(int catId, int cpId, ArrayList rbtList,String rbtName, int pageno) 
	{
					logger.debug("searchRbtCP()");
					int srow = pageno*10;
					int erow = srow+11;
					Connection con = null;
					PreparedStatement pstmt1=null;
					PreparedStatement pstmt2=null;
					ResultSet rs = null;
					String query = null;
					String cquery = null;
					String specialCatId ="998";
					String recordedCatId="999";
					int ret = -1;
					try
					{	
									con = conPool.getConnection();
									specialCatId   = TSSJavaUtil.instance().getAppConfigParam("SPECIAL_CONTROL_CATID");
									recordedCatId  = TSSJavaUtil.instance().getAppConfigParam("CRBT_RECORDED_CATEGORY_ID");

									if(catId ==-1 && !rbtName.equalsIgnoreCase(""))
									{
										logger.info("search for matching RBTNAME= " +rbtName);
										query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID = ?) and not(CAT_ID = ?) and CONTENT_PROVIDER_CODE = ? and MASKED_NAME like '"+rbtName+"%' order by MASKED_NAME))"; 
									pstmt1 = con.prepareStatement(query);
									pstmt1.setString(1, recordedCatId);
									pstmt1.setString(2, specialCatId);
									pstmt1.setInt(3,cpId);
									//pstmt1.setString(4,rbtName);
									
									rs = pstmt1.executeQuery();
										while(rs.next()) 
										{
												Rbt rbt = new Rbt(rs.getInt("RBT_CODE"),rs.getString("MASKED_NAME"),rs.getInt("CAT_ID"));
												logger.info("RBTNAME= " +rs.getString("MASKED_NAME")+" cat_id= "+rs.getInt("CAT_ID")+" rbt_code="+rs.getInt("rbt_code"));
												rbtList.add(rbt);
  									}
										ret = 2;
		  							if(rs != null) rs.close();
										if(pstmt1 != null) pstmt1.close();

									}//if
									else
									{
									logger.info("get rbt list for given category and content provider");
									query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID = ?) and not(CAT_ID = ?) and CONTENT_PROVIDER_CODE = ? and CAT_ID=? order by MASKED_NAME) where ROWNUM < ?) where ROW_NUMBER > ?"; 
									pstmt1 = con.prepareStatement(query);
									pstmt1.setString(1, recordedCatId);
									pstmt1.setString(2, specialCatId);
									pstmt1.setInt(3,cpId);
									pstmt1.setInt(4,catId);
									pstmt1.setInt(5,erow);
									pstmt1.setInt(6,srow);

									cquery = "select count(RBT_CODE) TOTAL from CRBT_RBT where RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID=?) and not(CAT_ID=?) and CONTENT_PROVIDER_CODE = ? and CAT_ID=?";
									pstmt2 = con.prepareStatement(cquery);
									pstmt2.setString(1, recordedCatId);
									pstmt2.setString(2, specialCatId);
									pstmt2.setInt(3, cpId);
									pstmt2.setInt(4, catId);

									rs = pstmt1.executeQuery();
									while(rs.next()) 
									{
													Rbt rbt = new Rbt(rs.getInt("RBT_CODE"),rs.getString("MASKED_NAME"),rs.getInt("CAT_ID"));
													rbtList.add(rbt);
									}

									rs = pstmt2.executeQuery();
									if (rs.next())
													ret = rs.getInt("TOTAL");

		  							 if(rs != null) rs.close();
  									if(pstmt1 != null) pstmt1.close();
	  								if(pstmt2 != null) pstmt2.close();
									}//else
									return ret;
					}//try
					catch (SQLException e) 
					{
									logger.error("searchRbtCP(), SQLException :"+e.getMessage());
									try {
													if(rs != null) rs.close();
													if(pstmt1 != null) pstmt1.close();
													if(pstmt2 != null) pstmt2.close();
									} catch(Exception exp) {}
									e.printStackTrace();
									return -99;
					}
					catch (Exception e) 
					{
									try {
													if(rs != null) rs.close();
													if(pstmt1 != null) pstmt1.close();
													if(pstmt2 != null) pstmt2.close();
									} catch(Exception exp) {}                
									e.printStackTrace();
									return -99;
					}
					finally {
									conPool.free(con);
					}

	}//searchRbtCP()
	
	
	public int searchRbt(String rbtName, int catId, int cpId, ArrayList rbtList, int pageno) 
	{	
		logger.debug("searchRbt()");	
		int srow = pageno*10;
		int erow = srow+11;
		Connection con = null;
		PreparedStatement pstmt1=null;
		PreparedStatement pstmt2=null;
		ResultSet rs = null;
		String query = null;
		String cquery = null;
		String specialCatId ="998";
		String recordedCatId="999";
		int ret = -1;
		try
		{	
			con = conPool.getConnection();

			specialCatId   = TSSJavaUtil.instance().getAppConfigParam("SPECIAL_CONTROL_CATID");
			recordedCatId  = TSSJavaUtil.instance().getAppConfigParam("CRBT_RECORDED_CATEGORY_ID");

			if (catId == -1 && cpId == -1) 
			{
					logger.debug("searchRbt if 1");
				query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID = ?) and not(CAT_ID = ?) order by MASKED_NAME) where ROWNUM < ?) where ROW_NUMBER > ?";
				pstmt1 = con.prepareStatement(query);
				pstmt1.setString(1,"%"+rbtName+"%");
				pstmt1.setString(2, recordedCatId);
				pstmt1.setString(3, specialCatId);
				pstmt1.setInt(4,erow);
				pstmt1.setInt(5,srow);

				cquery = "select count(RBT_CODE) TOTAL from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID=?) and not(CAT_ID=?)";
				pstmt2 = con.prepareStatement(cquery);
				pstmt2.setString(1,"%"+rbtName+"%");
				pstmt2.setString(2, recordedCatId);
				pstmt2.setString(3, specialCatId);
			}//1

			else if (cpId == -1) 
			{
					logger.debug("searchRbt if 2");
				query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and CAT_ID = ? order by MASKED_NAME) where ROWNUM < ?) where ROW_NUMBER > ?"; 
				pstmt1 = con.prepareStatement(query);
				pstmt1.setString(1,"%"+rbtName+"%");
				pstmt1.setInt(2, catId);
				pstmt1.setInt(3,erow);
				pstmt1.setInt(4,srow);

				cquery = "select count(RBT_CODE) TOTAL from CRBT_RBT where UPPER(MASKED_NAME) like ?  and RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and CAT_ID=?";
				pstmt2 = con.prepareStatement(cquery);
				pstmt2.setString(1,"%"+rbtName+"%");
				pstmt2.setInt(2, catId);
			}//2

			else if (catId == -1) 
			{
					logger.debug("searchRbt if 3");
				query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID = ?) and not(CAT_ID = ?) and CONTENT_PROVIDER_CODE = ? order by MASKED_NAME) where ROWNUM < ?) where ROW_NUMBER > ?"; 
				pstmt1 = con.prepareStatement(query);
				pstmt1.setString(1,"%"+rbtName+"%");
				pstmt1.setString(2, recordedCatId);
				pstmt1.setString(3, specialCatId);
				pstmt1.setInt(4,cpId);
				pstmt1.setInt(5,erow);
				pstmt1.setInt(6,srow);

				cquery = "select count(RBT_CODE) TOTAL from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID=?) and not(CAT_ID=?) and CONTENT_PROVIDER_CODE = ?";
				pstmt2 = con.prepareStatement(cquery);
				pstmt2.setString(1,"%"+rbtName+"%");
				pstmt2.setString(2, recordedCatId);
				pstmt2.setString(3, specialCatId);
				pstmt2.setInt(4, cpId);
			}//3

			else  
			{
					logger.debug("searchRbt if 4");
				query = "select * from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID, ROWNUM ROW_NUMBER from (select RBT_CODE, MASKED_NAME, RBT_NICK, CAT_ID from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and CAT_ID = ? and CONTENT_PROVIDER_CODE = ? order by MASKED_NAME) where ROWNUM < ?) where ROW_NUMBER > ?";
				pstmt1 = con.prepareStatement(query);
				pstmt1.setString(1,"%"+rbtName+"%");
				pstmt1.setInt(2, catId);
				pstmt1.setInt(3, cpId);
				pstmt1.setInt(4, erow);
				pstmt1.setInt(5, srow);

				cquery = "select count(RBT_CODE) TOTAL from CRBT_RBT where UPPER(MASKED_NAME) like ? and RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and CAT_ID = ? and CONTENT_PROVIDER_CODE = ?";
				pstmt2 = con.prepareStatement(cquery);
				pstmt2.setString(1,"%"+rbtName+"%");
				pstmt2.setInt(2, catId);
				pstmt2.setInt(3, cpId);
			}//4

	rs = pstmt1.executeQuery();
			while(rs.next()) {
				Rbt rbt = new Rbt(rs.getInt("RBT_CODE"),rs.getString("MASKED_NAME"),rs.getInt("CAT_ID"));
				rbtList.add(rbt);
			}

			rs = pstmt2.executeQuery();
			if (rs.next())
				ret = rs.getInt("TOTAL");

			if(rs != null) rs.close();
			if(pstmt1 != null) pstmt1.close();
			if(pstmt2 != null) pstmt2.close();
			return ret;
		}
		catch (SQLException e) 
		{
			logger.error("searchRbt(), SQLException :"+e.getMessage());
			try {
				if(rs != null) rs.close();
				if(pstmt1 != null) pstmt1.close();
				if(pstmt2 != null) pstmt2.close();
			} catch(Exception exp) {}
			e.printStackTrace();
			return -99;
		}
		catch (Exception e) 
		{
			try {
				if(rs != null) rs.close();
				if(pstmt1 != null) pstmt1.close();
				if(pstmt2 != null) pstmt2.close();
			} catch(Exception exp) {}                
			e.printStackTrace();
			return -99;
		}
		finally {
			conPool.free(con);
		}
	}

/* New code.. sendPromotionSMS() *******/
	public int sendPromotionSMS(int rbtCode, String mname)
	{
		logger.debug("sendPromotionSMS()");
		String query="";
		String query1="";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs1 = null;

	//	String dest = "1111";

		try 
		{
			String MESSAGE_TEXT= "More blingback tunes are available";
			query = "select TEMPLATE_MESSAGE from LBS_TEMPLATES where TEMPLATE_ID = ? and TEMPLATE_TYPE = ? and language_id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, 210);
			pstmt.setInt(2, 10);
			pstmt.setInt(3, 1);
            		rs = pstmt.executeQuery();
			if(rs.next()) 
			{
				MESSAGE_TEXT = rs.getString(1);
			} 
			rs.close();
			pstmt.close();

			query="select param_value from CRBT_APP_CONFIG_PARAMS where PARAM_TAG=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,"SMS_ORIGINATION_NUMBER");
			
            		rs = pstmt.executeQuery();
			String sms_origin_number="4444288";
			if(rs.next()) 
			{
				sms_origin_number  = rs.getString(1);
			}
			rs.close();
			pstmt.close();
			
		        query="select msisdn from crbt_subscriber_master";
			
			query1= "insert into GMAT_MESSAGE_STORE (RESPONSE_ID, REQUEST_ID, ORIGINATING_NUMBER, DESTINATION_NUMBER, MESSAGE_TEXT, SUBMIT_TIME, STATUS) values (GMAT_RESPONSE_ID_SEQ.nextval, 0, ?, ?, ?, sysdate, ?)";
			
			pstmt = con.prepareStatement(query);
			pstmt1 = con.prepareStatement(query1);
			
            		rs = pstmt.executeQuery();
			while (rs.next())
			{
				pstmt1.setString(1, sms_origin_number);
				pstmt1.setString(3, MESSAGE_TEXT);
				pstmt1.setString(4, "R");
				pstmt1.setString(2, rs.getString(1));
				pstmt1.executeUpdate();           
				logger.debug("***sending Promotional  sms = "+MESSAGE_TEXT + " - " +rs.getString(1));
			}
			pstmt1.close(); 
			rs.close();
			pstmt.close();
			return 1;
		}
		catch (SQLException sqle) 
		{//log it
			sqle.printStackTrace();
			return 0;
		}
	}//sendPromotionSMS() 

/* old code.. sendPromotionSMS() ******* 
public int sendPromotionSMS(int rbtCode, String mname)
	{
		String query="";
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dest = "1111";
		//String message = "A new blingback tune "+mname+"("+rbtCode+") has been added to the System";

		try 
		{
			String Message_Text= "hi! new blingback tune "+mname+" with code "+rbtCode+ "has been added to crbt system";
			query = "select TEMPLATE_MESSAGE from LBS_TEMPLATES where TEMPLATE_ID = ? and TEMPLATE_TYPE = ? and language_id=?";
			logger.info(query);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, 210);
			pstmt.setInt(2, 10);
			pstmt.setInt(3, 1);
            		rs = pstmt.executeQuery();
			if(rs.next()) 
			{
				String message_string = rs.getString(1);
				int tempPos = 0;
				tempPos = message_string.indexOf("$(rbt_name)");
				if(tempPos !=-1) 
				{
					Message_Text = message_string.substring(0,tempPos);
					Message_Text = Message_Text + mname;
				}
                
				int tempPos2 = message_string.indexOf("$(rbt_code)");
				if(tempPos2 !=-1) 
				{
					Message_Text = Message_Text + message_string.substring(tempPos+11, tempPos2);
					Message_Text = Message_Text + rbtCode;
					Message_Text = Message_Text + message_string.substring(tempPos2+11, message_string.length());
				}
			} 
			rs.close();

			query="select param_value from CRBT_APP_CONFIG_PARAMS where PARAM_TAG=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,"SMS_ORIGINATION_NUMBER");
			
            		rs = pstmt.executeQuery();
			logger.info(query);
			String sms_origin_number="4444288";
			if(rs.next()) 
			{
				sms_origin_number  = rs.getString(1);
			}
			rs.close();
			logger.info(sms_origin_number);
			
			query= "insert into GMAT_MESSAGE_STORE (RESPONSE_ID, REQUEST_ID, ORIGINATING_NUMBER, DESTINATION_NUMBER, MESSAGE_TEXT, SUBMIT_TIME, STATUS) values (GMAT_RESPONSE_ID_SEQ.nextval, 0, ?, ?, ?, sysdate, ?)";
			logger.info(query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, sms_origin_number);
			pstmt.setString(2, dest);
			pstmt.setString(3, Message_Text);
			pstmt.setString(4, "R");
			pstmt.executeUpdate();           
			pstmt.close(); 
			return 1;
		}
		catch (SQLException sqle) 
		{//log it
			sqle.printStackTrace();
			return 0;
		}
	}//sendPromotionSMS()
	*/
}

