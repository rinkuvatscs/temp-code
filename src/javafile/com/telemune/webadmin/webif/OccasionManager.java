
// modified on 12-01-2006
//@author Jatinder Pal

package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class OccasionManager
{
       private static Logger logger=Logger.getLogger(OccasionManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;

	public OccasionManager()
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


	public int addOccasion (Occasion ocobj)
	{
		logger.debug("webadmin: addOccasion");
		try
		{
			con = conPool.getConnection();
			query = "SELECT OCCASION_NAME, OCCASION_DATE FROM CRBT_OCCASION_LIST WHERE OCCASION_NAME LIKE ? ";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1,"%"+ ocobj.getOccasionName ()+"%");
			rs = pstmt.executeQuery ();
			if(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2; //Record already exists
			}
			rs.close ();
			pstmt.close ();
			query = "INSERT INTO CRBT_OCCASION_LIST (OCCASION_NAME,OCCASION_DATE, IS_CONSTANT,UPDATE_TIME, DESCRIPTION) VALUES (?,to_date(to_char(to_date(?,'dd-mm-yyyy'),'dd-mon-yyyy'),'dd-mon-yyyy'), ?,sysdate,?)";
			//query = "INSERT INTO CRBT_OCCASION_LIST (OCCASION_NAME,OCCASION_DATE, IS_CONSTANT,UPDATE_TIME, DESCRIPTION) VALUES (?,to_date(?), ?,sysdate,?)";
//			query = "INSERT INTO CRBT_OCCASION_LIST (OCCASION_NAME,OCCASION_DATE, IS_CONSTANT,UPDATE_TIME, DESCRIPTION) VALUES (?,?, ?,sysdate,?)";
			pstmt = con.prepareStatement (query);

			logger.info(query);
			pstmt.setString (1, ocobj.getOccasionName ());
			pstmt.setString (2, ocobj.getOccasionDate ());
			pstmt.setString (3, ocobj.getIsConstant());
			pstmt.setString (4, ocobj.getDescription ());

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
				logger.error ("webadmin-addOccassion: Exception in addOccassion, Exception is : " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; //  added susccessfully

	}// add()

	public int getOccasions (ArrayList ocAl)
	{
					logger.debug("getOccasions() ");
					try
					{
							con = conPool.getConnection();
							query = "select OCCASION_NAME,to_char(OCCASION_DATE, 'DD-MM-YYYY')OCCASION_DATE,IS_CONSTANT from CRBT_OCCASION_LIST ";
								pstmt = con.prepareStatement (query);
								rs = pstmt.executeQuery ();
								while(rs.next ())
									{
													Occasion ocob = new Occasion ();
													ocob.setOccasionName (rs.getString ("OCCASION_NAME"));
													ocob.setOccasionDate (rs.getString ("OCCASION_DATE"));
													ocob.setIsConstant (rs.getString ("IS_CONSTANT"));
													ocAl.add (ocob);
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
													logger.error ("Exception in listUser, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;
	}//get

public int getOccasions (ArrayList ocAl,String ocName)
	{
		logger.debug("getOccasions() ");
		try
		{
			con = conPool.getConnection();
			
			
			{
				query = "select OCCASION_NAME,to_char(OCCASION_DATE, 'DD-MM-YYYY')OCCASION_DATE,IS_CONSTANT,DESCRIPTION from CRBT_OCCASION_LIST WHERE OCCASION_NAME=?";
				pstmt = con.prepareStatement (query);
				pstmt.setString(1,ocName);
			}
			rs = pstmt.executeQuery ();

			while(rs.next ())
			{
				Occasion ocob = new Occasion ();
				ocob.setOccasionName (rs.getString ("OCCASION_NAME"));
				ocob.setOccasionDate (rs.getString ("OCCASION_DATE"));
				ocob.setIsConstant (rs.getString ("IS_CONSTANT"));
				ocob.setDescription(rs.getString("DESCRIPTION"));
				ocAl.add (ocob);
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
				logger.error ("Exception in listUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;

	}//get

	public int updateOccasion (Occasion ocobj, String oldName)
	{
		logger.debug("in function updateOccasion() "+oldName);

		try
		{
			con = conPool.getConnection();
			if(ocobj.getOccasionName().equalsIgnoreCase(oldName))
			{}
			else
			{
							query = "SELECT OCCASION_NAME, OCCASION_DATE FROM CRBT_OCCASION_LIST WHERE OCCASION_NAME LIKE ? ";
							pstmt = con.prepareStatement (query);
							pstmt.setString (1,"%"+ ocobj.getOccasionName ()+"%");
							rs = pstmt.executeQuery ();
							if(rs.next ())
							{
											rs.close ();
											pstmt.close ();
											return -2; //Record already exists
							}
							rs.close ();
							pstmt.close ();
			}
			query = "UPDATE CRBT_OCCASION_LIST SET OCCASION_NAME=?, OCCASION_DATE=to_date(to_char(to_date(?,'dd-mm-yyyy'),'dd-mon-yyyy'),'dd-mon-yyyy'), IS_CONSTANT=? , UPDATE_TIME=sysdate , DESCRIPTION=? where OCCASION_NAME=?";
			//query = "UPDATE CRBT_OCCASION_LIST SET OCCASION_NAME=?, OCCASION_DATE=to_date(?), IS_CONSTANT=? , UPDATE_TIME=sysdate , DESCRIPTION=? where OCCASION_NAME=?";
			pstmt = con.prepareStatement (query);
			logger.info(query);
			pstmt.setString (1, ocobj.getOccasionName ());
			pstmt.setString (2, ocobj.getOccasionDate ());
			pstmt.setString (3, ocobj.getIsConstant());
			pstmt.setString (4, ocobj.getDescription ());
			pstmt.setString (5, oldName);

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

	public int deleteOccasion (ArrayList ocAl)
	{
					logger.debug("deleteOccasion()");
					try
					{
									con = conPool.getConnection();
								 query = "delete from CRBT_OCCASION_LIST WHERE OCCASION_NAME=?";
										 pstmt = con.prepareStatement(query);
										 Iterator ite1 = ocAl.iterator();
										 while (ite1.hasNext())
										 {
										 pstmt.setString (1,(String)ite1.next());
										 pstmt.executeUpdate();
//										 logger.info(query);
										 }
										 pstmt.close();
									 		

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
	}//delete
	
} //class CorpManager
