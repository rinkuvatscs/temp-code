
// modified on 12-01-2006
//@author Jatinder Pal

package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class CorpManager
{
        private static Logger logger=Logger.getLogger(CorpManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;
	private long corpId = 0;

	public CorpManager()
	{
		//conPool = new ConnectionPool();
		corpId = 0;
	}

         public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }


	public int addCorporate (CorpUser corpUser)
	{
		logger.debug("webadmin: addCorporate");
		try
		{
			con = conPool.getConnection();
			query = "SELECT USERNAME, CORP_NAME FROM CRBT_CORP_DETAIL WHERE USERNAME = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, corpUser.getUserName ());
			rs = pstmt.executeQuery ();
			if(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2; //Record already exists
			}
			rs.close ();
			pstmt.close ();
                 logger.debug(query+" === Executed");
			query = "SELECT USERNAME, CORP_NAME FROM CRBT_CORP_DETAIL WHERE CORP_NAME like ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, "%"+corpUser.getCorpName ()+"%");
			rs = pstmt.executeQuery ();
			if(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2; //Record already exists
			}
			rs.close ();
			pstmt.close ();
				 logger.debug(query+" === Executed");
				query = "select * from OPERATOR_SUBSCRIBER where (to_number(STARTS_AT) <=to_number(?) and to_number(ENDS_AT) >=to_number(?) and to_number(?) not in (select to_number(EXCLUDE_NUM) from OPERATOR_SUBSCRIBER_EXCLUDE)) or to_number(?) in(select to_number(INCLUDE_NUM) from OPERATOR_SUBSCRIBER_INCLUDE)";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, corpUser.getChargingMsisdn());
			   pstmt.setString(2, corpUser.getChargingMsisdn());
			   pstmt.setString(3, corpUser.getChargingMsisdn());
			   pstmt.setString(4, corpUser.getChargingMsisdn());

			   rs = pstmt.executeQuery();
                          logger.debug(query+" === Executed");
			   if (!rs.next())
			   {
			   rs.close();
			   pstmt.close();
			   return -12; //charging number not in range
			   }
			   rs.close();
			   pstmt.close();


			query = "SELECT USERNAME, CORP_NAME, CHARGING_MSISDN FROM CRBT_CORP_DETAIL WHERE CHARGING_MSISDN=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, corpUser.getChargingMsisdn());
			rs = pstmt.executeQuery ();
                logger.debug(query+" === Executed");
			if(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -3; //this msisdn is already being billed for some corporate
			}
			rs.close ();
			pstmt.close ();

			query="select crbt_corp_seq.nextval from dual";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			if(rs.next ())
			{
				corpId = rs.getLong(1);
				rs.close ();
				pstmt.close ();
			}
			else
			{
				rs.close();
				pstmt.close();
				logger.info ("RoleTypeManager: roleId not created");
				return -99;
			}
                       logger.debug("Inserting into CRBT_CORP_DETAIL ");
			query = "INSERT INTO CRBT_CORP_DETAIL (CORP_ID,CORP_NAME,USERNAME, PASSWORD,DATE_REGISTERED, CHARGING_MSISDN, PLAN_INDICATOR) VALUES (?, ?, ?, ?, sysdate,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setLong (1, corpId);
			pstmt.setString (2, corpUser.getCorpName ());
			pstmt.setString (3, corpUser.getUserName ());
			pstmt.setString (4, corpUser.getPassword ());
			pstmt.setString (5, corpUser.getChargingMsisdn ());
			pstmt.setInt (6, corpUser.getPlanIndicator ());
		//	pstmt.setInt (6, 1); // default for this time, to be changed //changeDONE

			pstmt.executeUpdate ();
			pstmt.close ();


		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("webadmin-AddUser: Exception in addUser, Exception is : " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; // corp added susccessfully

	}// addCorporate()

	public int getCorporateData (ArrayList corpAl, long corpid, String corpName)
	{
		logger.debug("getCorporateData() ");
		try
		{
			con = conPool.getConnection();
			if(corpid == 0 && corpName.equalsIgnoreCase("all"))
			{
				query = "select USERNAME,PLAN_INDICATOR,CHARGING_MSISDN, CORP_NAME, PASSWORD, CORP_ID from CRBT_CORP_DETAIL order by CORP_NAME";
				pstmt = con.prepareStatement (query);
			}
			else
			{
				query = "select USERNAME,PLAN_INDICATOR,CHARGING_MSISDN, CORP_NAME, PASSWORD, CORP_ID from CRBT_CORP_DETAIL where CORP_ID=?";
				pstmt = con.prepareStatement (query);
				pstmt.setLong(1,corpid);
			}
			rs = pstmt.executeQuery ();

			while(rs.next ())
			{
				CorpUser corpUser = new CorpUser ();
				corpUser.setUserName (rs.getString ("USERNAME"));
				corpUser.setCorpName (rs.getString ("CORP_NAME"));
				corpUser.setPassword (rs.getString ("PASSWORD"));
				corpUser.setCorpId (rs.getLong ("CORP_ID"));
				corpUser.setPlanIndicator(rs.getInt("PLAN_INDICATOR"));
				corpUser.setChargingMsisdn(rs.getString("CHARGING_MSISDN"));
				corpAl.add (corpUser);
			}
			rs.close ();
			pstmt.close ();
		} //try
		catch (Exception e)
		{
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error("Exception in listUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;

	}//getCorporateData

	public int updateCorp (CorpUser corpUser)
	{
		logger.debug("in function updateCorp()");

		try
		{
			con = conPool.getConnection();
					
					query = "select * from OPERATOR_SUBSCRIBER where (to_number(STARTS_AT) <=to_number(?) and to_number(ENDS_AT) >=to_number(?) and to_number(?) not in (select to_number(EXCLUDE_NUM) from OPERATOR_SUBSCRIBER_EXCLUDE)) or to_number(?) in(select to_number(INCLUDE_NUM) from OPERATOR_SUBSCRIBER_INCLUDE)";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, corpUser.getChargingMsisdn());
			   pstmt.setString(2, corpUser.getChargingMsisdn());
			   pstmt.setString(3, corpUser.getChargingMsisdn());
			   pstmt.setString(4, corpUser.getChargingMsisdn());

			   rs = pstmt.executeQuery();

			   if (!rs.next())
			   {
			   rs.close();
			   pstmt.close();
			   return -12; //charging number not in range
			   }
			   rs.close();
			   pstmt.close();

			//query="select CHARGING_MSISDN from CRBT_CORP_DETAIL where CORP_ID=? and CHARGING_MSISDN=?";
			query="select CHARGING_MSISDN, CORP_ID from CRBT_CORP_DETAIL where CORP_ID !=?";
			pstmt=con.prepareStatement(query);

			pstmt.setLong(1,corpUser.getCorpId());
			//					pstmt.setString (2, corpUser.getChargingMsisdn());

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				if(corpUser.getChargingMsisdn().equalsIgnoreCase(rs.getString("CHARGING_MSISDN")))
				{
					rs.close();
					pstmt.close();
					return -3;
				}
			}
			rs.close();
			pstmt.close();
			if (corpUser.getPassword() == null || corpUser.getPassword().equals("")) 
			{

				query = "UPDATE CRBT_CORP_DETAIL SET CHARGING_MSISDN = ?, PLAN_INDICATOR=? WHERE CORP_ID = ?";
				pstmt = con.prepareStatement (query);

				pstmt.setString (1, corpUser.getChargingMsisdn());
				pstmt.setInt (2, corpUser.getPlanIndicator());
				pstmt.setLong (3, corpUser.getCorpId ());
				pstmt.executeUpdate ();
				pstmt.close ();
			}
			else
			{

				query = "UPDATE CRBT_CORP_DETAIL SET PASSWORD = ?,CHARGING_MSISDN= ?, PLAN_INDICATOR = ? WHERE CORP_ID = ?";
				pstmt = con.prepareStatement (query);

				pstmt.setString (1, corpUser.getPassword ());
				pstmt.setString (2, corpUser.getChargingMsisdn());
				pstmt.setInt (3, corpUser.getPlanIndicator());
				pstmt.setLong (4, corpUser.getCorpId ());
				pstmt.executeUpdate ();
				pstmt.close ();
			}

        query = "UPDATE CRBT_SUBSCRIBER_MASTER SET PLAN_INDICATOR=? WHERE CORP_ID = ?";
				pstmt = con.prepareStatement (query);

				pstmt.setInt (1, corpUser.getPlanIndicator());
				pstmt.setLong (2, corpUser.getCorpId ());
				pstmt.executeUpdate ();
				pstmt.close ();


		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateCorp, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{conPool.free(con); }
		return 1;
	} // updateCorp

	public int deleteCorpData (ArrayList corpAl)
	{
		logger.debug("deleteCorpData()");
		try
		{
			con = conPool.getConnection();
			long corpid=0;

			query = "update CRBT_SUBSCRIBER_MASTER set RBT_CODE=0, CORP_ID=0 where CORP_ID=?";
			pstmt = con.prepareStatement(query);
			Iterator ite = corpAl.iterator();
			while (ite.hasNext())
			{
				corpid = Long.parseLong((String)ite.next()); 
				pstmt.setLong(1, corpid);
				pstmt.executeUpdate();
			}
			pstmt.close();

			Iterator ite1 = corpAl.iterator();
			query = "delete from CRBT_CORP_DETAIL WHERE CORP_ID=?";
			pstmt = con.prepareStatement(query);
			while (ite1.hasNext())
			{
				corpid = Long.parseLong((String)ite1.next()); 
				pstmt.setLong(1, corpid);
				pstmt.executeUpdate();
			}
			pstmt.close();

			/*TODO: if all users of corp should be removed when corp is deleted?? */
			//delete all corpId users 
			/* ***	
			   query = "delete from CRBT_SUBSCRIBER_MASTER WHERE CORP_ID=?";
			   pstmt = con.prepareStatement(query);
			   Iterator ite1 = corpAl.iterator();
			   while (ite1.hasNext())
			   {
			   corpid = Long.parseLong((String)ite1.next()); 
			   pstmt.setLong (1, corpid);
			   pstmt.executeUpdate();
			   logger.info(query+" DONE");
			   }
			   pstmt.close();
			 */		

		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in deleteCorpData(), Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con);  }
		return 1;
	}//deleteCorpData

	public int getCorpRbtSettings(CorpUser corpUser)
	{
		logger.debug("getCorpRbtSettings() ");
		try
		{
			con = conPool.getConnection();
		
		query = "select param_id, param_value from CRBT_APP_CONFIG_PARAMS where param_tag =	'CORP_RBT_DAYS'";
		
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();

			if(rs.next ())
			{
				corpUser.setDays (rs.getString ("param_value"));
				corpUser.setDayParamId (rs.getInt ("param_id"));
			}
			rs.close ();
			pstmt.close ();
			
			query = "select param_id, param_value from CRBT_APP_CONFIG_PARAMS where param_tag='CORP_RBT_START_TIME'";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();

			if(rs.next ())
			{
				corpUser.setStartTime (rs.getString ("param_value"));
				corpUser.setStParamId (rs.getInt ("param_id"));
			}
			rs.close ();
			pstmt.close ();

			query = "select param_id, param_value from CRBT_APP_CONFIG_PARAMS where param_tag='CORP_RBT_END_TIME'";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();

			if(rs.next ())
			{
				corpUser.setEndTime (rs.getString ("param_value"));
				corpUser.setEndParamId (rs.getInt ("param_id"));
			}
				
	//		corpAl.add (corpUser); //add values to the arraylist
			
			rs.close ();
			pstmt.close ();


		} //try
		catch (Exception e)
		{
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in listUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
	return 1;
  }

	public int getCorpPlanId(ArrayList corpAl)
	{
					logger.debug("getCorpPlanId() ");
					try
					{
									con = conPool.getConnection();

									query = "select PLAN_INDICATOR,REMARKS from CRBT_RATE_PLANS";

									pstmt = con.prepareStatement (query);
									rs = pstmt.executeQuery ();

									while(rs.next ())
									{
													CorpUser corpUser =  new CorpUser();
													corpUser.setPlanIndicator(rs.getInt("PLAN_INDICATOR"));
													corpUser.setPlanRemarks(rs.getString("REMARKS"));
													corpAl.add(corpUser);
									}
									rs.close ();
									pstmt.close ();
					} //try
					catch (Exception e)
					{
									try
									{
													if(rs != null) rs.close ();
													if(pstmt != null) pstmt.close ();
									}catch(SQLException sqle)
									{
													logger.error("Exception in listUser, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;
	}//getCorpPlanId
 
} //class CorpManager
