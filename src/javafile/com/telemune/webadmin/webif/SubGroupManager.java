
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;


public class SubGroupManager
{
	        private static Logger logger=Logger.getLogger(SubGroupManager.class);		       
         	private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con =null;
				private ResultSet rs =null;
				private String query=null;
				private long subGrpId=0;
				private long adId=0;

				public SubGroupManager()
				{
						//		conPool = new ConnectionPool();
				}



                 public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }


 // ******************* Add New SubGroup and Alert Details **********
 // ********* 
public int addSubGroupAlert(SubGroup subGroup)
	{
			logger.debug("adding SubGroup Alerts ");
			try
			{
							con = conPool.getConnection();
							query="select GROUP_ID, GROUP_NAME from GROUP_MASTER where GROUP_NAME=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, subGroup.getGrpName() );
							rs= pstmt.executeQuery();
							if(rs.next() )
							{
                logger.info(" this name exists= "+rs.getString("GROUP_ID")+":"+rs.getString("GROUP_NAME"));
								 pstmt.close();
								 rs.close();
								 return -2;
							}
							 pstmt.close();
							 rs.close();
							query = "select subGrp_id.nextval from dual";
							pstmt = con.prepareStatement(query);
							rs= pstmt.executeQuery();
              if(rs.next() )
							{
							 subGrpId = rs.getLong("NEXTVAL");
							 pstmt.close();
							 rs.close();
							}
							else
							{
							 pstmt.close();
							 rs.close() ;
							 return -1;
							}

							query="insert into GROUP_MASTER (GROUP_ID, GROUP_NAME,INSTANT_ALERT,DESCRIPTION,CHARGING_STATUS,CALLS_ALERT,PERIODIC_ALERT) values(?,?,?,?,?,?,?)";

							pstmt = con.prepareStatement(query);
						  pstmt.setLong(1,subGrpId);
							pstmt.setString(2, subGroup.getGrpName() );
							pstmt.setInt(3, subGroup.getInstantAlert() );
							pstmt.setString(4, subGroup.getDesc() );
							pstmt.setInt(5, subGroup.getCharging() );
							pstmt.setInt(6, subGroup.getCallAlert() );
							pstmt.setInt(7, subGroup.getPeriodicAlert() );
             						
							pstmt.executeUpdate();
   						pstmt.close();	
			}//try
    catch (Exception e)
    {
      try
      {
					if (pstmt != null)
				  pstmt.close ();
      }
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{		conPool.free(con);	}
 
			return 0;
	} // addSubGroup()

  public int viewSubGroupAlert(ArrayList subGroupAl,long subGrpId)
	{
					logger.debug("getting SubGroup Alert values");
		try
		{
					con = conPool.getConnection();
					if(subGrpId==0)
					{
							query="select * from GROUP_MASTER order by GROUP_NAME";
							pstmt=con.prepareStatement(query);
					}
					else
					{
							query="select * from GROUP_MASTER where GROUP_ID=? order by GROUP_NAME";
							pstmt =con.prepareStatement(query);
							pstmt.setLong(1,subGrpId);
					}
					rs = pstmt.executeQuery();
					while(rs.next() )
					 {
                   SubGroup subGroup = new SubGroup();
									 subGroup.setGrpId( rs.getLong("GROUP_ID") );
									 subGroup.setGrpName( rs.getString("GROUP_NAME") );
									 subGroup.setInstantAlert( rs.getInt("INSTANT_ALERT") );
									 subGroup.setDesc( rs.getString("DESCRIPTION") );
									 subGroup.setCharging(rs.getInt("CHARGING_STATUS") );
									 subGroup.setCallAlert(rs.getInt("CALLS_ALERT") );
									 subGroup.setPeriodicAlert(rs.getInt("PERIODIC_ALERT") );
									 subGroupAl.add(subGroup);
					 }//while
					 pstmt.close();
					 rs.close();
		}//try
	catch(Exception e)
		{
			try
			{
				if( pstmt != null || rs != null ) 
				{
									pstmt.close();
									rs.close();
				}//if
   		}//try
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
		}//catch
		finally
		{		conPool.free(con);	}
		return 99;


 } //viewSubGroupAlert()

  public int delSubGroupAlert(SubGroup subGroup)
	{
			logger.debug("now deleting SubGroup Alert");
				try
					{
									con = conPool.getConnection();
									query="delete from GROUP_DETAILS where GROUP_ID=?";
									pstmt = con.prepareStatement(query);
									pstmt.setLong(1, subGroup.getGrpId() );
									pstmt.executeUpdate();
									pstmt.close();
									
									query="delete from GROUP_MASTER where GROUP_ID=?";
									pstmt = con.prepareStatement(query);
									pstmt.setLong(1, subGroup.getGrpId() );
									pstmt.executeUpdate();
									pstmt.close();
					}//try
					catch (Exception e)
    			{
			     		try
						      {
										if (pstmt != null)
													  pstmt.close ();
							     }
							   catch (SQLException sqle)
							     {
							      }
							      e.printStackTrace ();
							      return -1;
				   }//catch
						finally
						{		conPool.free(con);			}
				    return 2;
					
	}//delSubGroup

	public int modifySubGroupAlert(SubGroup subGroup)
	{
				 logger.debug("Modifying SubGroup Alert");
		try
		{
				con = conPool.getConnection();
				query="update GROUP_MASTER set INSTANT_ALERT=?,DESCRIPTION=?,CHARGING_STATUS=?,CALLS_ALERT=?,PERIODIC_ALERT=? where GROUP_ID=? and GROUP_NAME=?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, subGroup.getInstantAlert() );
				pstmt.setString(2, subGroup.getDesc() );
				pstmt.setInt(3, subGroup.getCharging() );
				pstmt.setInt(4, subGroup.getCallAlert() );
				pstmt.setInt(5, subGroup.getPeriodicAlert() );
				pstmt.setLong(6,subGroup.getGrpId() );
				pstmt.setString(7, subGroup.getGrpName() );

				pstmt.executeUpdate();
				pstmt.close();
		}//try
  catch (Exception e)
    {
      try
      {
				if (pstmt != null)
				  pstmt.close ();
      }
      catch (SQLException sqle)
      {
					logger.error("SQl Error");
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{	conPool.free(con);	}
    return 0;
	
						
	}//modifySubGroupAlert()



 // ******************* Add New SubGroup Details **********
 // ********* 
	public int addSubGroup(SubGroup subGroup)
	{
			logger.debug("adding SubGroup ");
			try
			{
							con = conPool.getConnection();
              long subGrpId=0;
							/* **** to be  removed later on ************ */
							query="select GROUP_ID, GROUP_NAME from GROUP_DETAILS where GROUP_NAME=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, subGroup.getGrpName() );
							rs= pstmt.executeQuery();
							if(rs.next() )
							{
                logger.info("ERROR: this name exists= "+rs.getString("GROUP_ID")+":"+rs.getString("GROUP_NAME"));
								 pstmt.close();
								 return -2;
							}
			/*		*****************	*/
		   /*	******** to be used later *********** 
			  			query="select unique STARTS_AT from GROUP_DETAILS where STARTS_AT=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, subGroup.getStartMsisdn() );
							rs= pstmt.executeQuery();
							if(rs.next() )
							{
               	logger.info( "This Start MSISDN exists " + subGroup.getStartMsisdn() );
								pstmt.close();
								 rs.close();
								return -2;
							}
               	logger.info( "Start MSISDN " + subGroup.getStartMsisdn()	+" ok" );
							
								 
							query="select unique  ENDS_AT from GROUP_DETAILS where ENDS_AT=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, subGroup.getEndMsisdn() );
							rs= pstmt.executeQuery();
							if(rs.next() )
							{
               	logger.info( "This End MSISDN exists " + subGroup.getEndMsisdn() );
								pstmt.close();
								 rs.close();
								return -3;
							}
               	logger.info( "End MSISDN " + subGroup.getEndMsisdn()+ " ok" );
			****************	*/		
							query="select unique GROUP_ID from GROUP_MASTER where GROUP_NAME=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, subGroup.getGrpName() );
							rs= pstmt.executeQuery();
							if(rs.next() )
							{
									subGrpId = rs.getLong("GROUP_ID");
							}
								 pstmt.close();
								 rs.close();

							query="insert into GROUP_DETAILS (GROUP_ID, GROUP_NAME,STARTS_AT,ENDS_AT) values(?,?,?,?)";

							pstmt = con.prepareStatement(query);
						  pstmt.setLong(1,subGrpId);
							pstmt.setString(2, subGroup.getGrpName() );
							pstmt.setString(3, subGroup.getStartMsisdn() );
							pstmt.setString(4, subGroup.getEndMsisdn() );
  						pstmt.executeUpdate();
							pstmt.close();	
			}//try
    catch (Exception e)
    {
      try
      {
					if (pstmt != null)
				  pstmt.close ();
      }
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{		conPool.free(con);	}
 
			return 0;
	} // addSubGroup()

  public int viewSubGroup(ArrayList subGroupAl,long subGrpId)
	{
					logger.debug("getting SubGroup values");
		try
		{
					con = conPool.getConnection();
					if(subGrpId==0)
					{
							query="select * from GROUP_DETAILS order by GROUP_NAME";
							pstmt=con.prepareStatement(query);
					}
					else
					{
							query="select * from GROUP_DETAILS where GROUP_ID=? order by GROUP_NAME";
							pstmt =con.prepareStatement(query);
							pstmt.setLong(1,subGrpId);
					}
				 rs = pstmt.executeQuery();
				 while(rs.next() )
					 {
                   SubGroup subGroup = new SubGroup();
									 subGroup.setGrpId( rs.getLong("GROUP_ID") );
									 subGroup.setGrpName( rs.getString("GROUP_NAME") );
									 subGroup.setStartMsisdn( rs.getString("STARTS_AT") );
									 subGroup.setEndMsisdn( rs.getString("ENDS_AT") );

									 subGroupAl.add(subGroup);
					 }//while
					 pstmt.close();
					 rs.close();
		}//try
	catch(Exception e)
		{
			try
			{
				if( pstmt != null || rs != null ) 
				{
									pstmt.close();
									rs.close();
				}//if
   		}//try
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
		}//catch
		finally
		{	conPool.free(con);	}
		return 99;
 } //viewSubGroup()

  public int delSubGroup(SubGroup subGroup)
	{
			logger.debug("now deleting SubGroup");
				try
					{
							con = conPool.getConnection();
							query="delete from GROUP_DETAILS where GROUP_ID=?";
							pstmt = con.prepareStatement(query);
							pstmt.setLong(1, subGroup.getGrpId() );
							pstmt.executeUpdate();
							pstmt.close();
					}//try
					catch (Exception e)
    			{
			     		try
						      {
										if (pstmt != null)
													  pstmt.close ();
							     }
							   catch (SQLException sqle)
							     {
							      }
							      e.printStackTrace ();
							      return -1;
				   }//catch
						finally
						{	conPool.free(con);		}
				    return 2;
					
	}//delSubGroup

	public int modifySubGroup(SubGroup subGroup)
	{
	 logger.debug("Modifying SubGroup");
		try
		{
				con = conPool.getConnection();
				query="update GROUP_DETAILS set GROUP_NAME=?, STARTS_AT=?,ENDS_AT=? where GROUP_ID=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, subGroup.getGrpName() );
				pstmt.setString(2, subGroup.getStartMsisdn() );
				pstmt.setString(3, subGroup.getEndMsisdn() );
				pstmt.setLong(4,subGroup.getGrpId() );
				pstmt.executeUpdate();
				pstmt.close();
		}//try
  catch (Exception e)
    {
      try
      {
				if (pstmt != null)
					  pstmt.close ();
      }
      catch (SQLException sqle)
      {
					logger.error("SQl Error");
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{	conPool.free(con);	}
    return 0;
				
}//modifySubGroup


}//class
