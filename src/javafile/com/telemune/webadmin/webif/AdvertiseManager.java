/*@Jatinder */

package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class AdvertiseManager
{
                               private static Logger logger=Logger.getLogger(AdvertiseManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con =null;
				private ResultSet rs =null;
				private String query=null;
				private long catId=0;
				private long adId=0;

				public AdvertiseManager()
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


 // *******************  New Category Details **********
 // ********* 
	public int addAdCategory(Advertise advertise)
	{
					logger.debug("webadmin: Advertisement Category");
			try
			{
							con = conPool.getConnection();

							query="select CATEGORY_ID,NAME from AD_CATEGORY_DETAILS where NAME=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, advertise.getCatName() );
							rs= pstmt.executeQuery();

							if(rs.next() )
							{
                logger.info("webadmin; this name exists= "+rs.getString("CATEGORY_ID")+":"+rs.getString("NAME"));
								 pstmt.close();
								 rs.close();
								 return -2;
							}
								 pstmt.close();
								 rs.close();

							query = "select adCat_id.nextval from dual";
							pstmt = con.prepareStatement(query);

							rs= pstmt.executeQuery();
              if(rs.next() )
							{
									catId = rs.getLong("NEXTVAL");
								 pstmt.close();
								 rs.close();
							}
							else
							{
								 pstmt.close();
								 rs.close();
									return -1;
							}

							query="insert into AD_CATEGORY_DETAILS (CATEGORY_ID, NAME,FREQUENCY) values(?,?,?)";

							pstmt = con.prepareStatement(query);

						  pstmt.setLong(1,catId);
							pstmt.setString(2, advertise.getCatName() );
							pstmt.setInt(3, advertise.getCatFrequency() );	
             						
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
		{
						conPool.free(con);
		}
 
			return 0;
	} // addAdCategory()

  public int viewAdCategory(ArrayList adCategoryAl,long catId)
	{
					logger.debug("webadmin; viewAdCategory()");
		try
		{
					con = conPool.getConnection();
					
					if(catId==0)
					{
							query="select * from AD_CATEGORY_DETAILS order by NAME";
							pstmt=con.prepareStatement(query);
					}
					else
					{
									query="select * from AD_CATEGORY_DETAILS where CATEGORY_ID=? order by NAME";
									pstmt =con.prepareStatement(query);
									pstmt.setLong(1,catId);
					}
					 rs = pstmt.executeQuery();
					 while(rs.next() )
					 {
                   Advertise advertise = new Advertise();
									 advertise.setCatId( rs.getLong("CATEGORY_ID") );
									 advertise.setCatName( rs.getString("NAME") );
									 advertise.setCatFrequency ( rs.getInt("FREQUENCY") );
									 adCategoryAl.add(advertise);
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
		{
						conPool.free(con);
		}
		return 99;


 } //viewAdCategory()

  public int delAdCategory(Advertise advertise)
	{

					try
					{
									con = conPool.getConnection();
									
									query="delete from SUBSCRIBER_AD_CATEGORY where CATEGORY_ID=?";
									pstmt = con.prepareStatement(query);
									pstmt.setLong(1, advertise.getCatId() );

									pstmt.executeUpdate();
									pstmt.close();

									query="delete from AD_DETAILS where CATEGORY_ID=?";
									pstmt = con.prepareStatement(query);
									pstmt.setLong(1, advertise.getCatId() );

									pstmt.executeUpdate();
									pstmt.close();
									
									query="delete from AD_CATEGORY_DETAILS where CATEGORY_ID=?";
									pstmt = con.prepareStatement(query);
									pstmt.setLong(1, advertise.getCatId() );

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
						{
								conPool.free(con);
						}
				    return 2;
					
	}//delAdCategory

	public int modifyAdCategory(Advertise advertise)
	{
				 logger.debug("webadmin: modifyAdCategory()");
		try
		{
				con = conPool.getConnection();
				query="update AD_CATEGORY_DETAILS set NAME=?, FREQUENCY=? where CATEGORY_ID=?";
				pstmt = con.prepareStatement(query);

				pstmt.setString(1, advertise.getCatName() );
				pstmt.setInt(2, advertise.getCatFrequency() );
				pstmt.setLong(3,advertise.getCatId() );

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
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{
						conPool.free(con);
		}
    return 0;
	
						
	}//modifyAdCategory
 // ********* 
 // *******************  New Ad Details ********** 

 public int addAdDetail(Advertise advertise)
 {
			logger.debug("webadmin: addAdDetail()");
			try
			{
							con = conPool.getConnection();

							query="select AD_ID,NAME from AD_DETAILS where NAME=?";
							pstmt=con.prepareStatement(query);
							pstmt.setString(1, advertise.getAdName() );
							rs= pstmt.executeQuery();

							if(rs.next() )
							{
                logger.info(" this name exists= "+rs.getString("AD_ID")+":"+rs.getString("NAME"));
								 rs.close();
								 pstmt.close();
								 return -2;
							}
								 rs.close();
								 pstmt.close();

							query = "select adDetail_id.nextval from dual";
							pstmt = con.prepareStatement(query);

							rs= pstmt.executeQuery();
              if(rs.next() )
							{
									adId = rs.getLong("NEXTVAL");
								 rs.close();
								 pstmt.close();
							}
							else
							{
								 rs.close();
								 pstmt.close();
								 return -1;
							}			

							query="insert into AD_DETAILS (AD_ID, NAME,CATEGORY_ID,FREQUENCY,START_DATE,END_DATE,MAX_ADS,ADDS_SENT) values(?,?,?,?,to_date(?,'DD-MM-YYYY'),to_date(?,'DD-MM-YYYY'),?,?)";

							pstmt = con.prepareStatement(query);

						  pstmt.setLong(1,adId);
							pstmt.setString(2, advertise.getAdName() );
							pstmt.setLong(3, advertise.getAdCat() );	
							pstmt.setInt(4, advertise.getAdFrequency() );	
							pstmt.setString(5, advertise.getStartDate() );
							pstmt.setString(6, advertise.getEndDate() );
							pstmt.setInt(7, advertise.getAdMax() );	
							pstmt.setInt(8, advertise.getAdSent() );	
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
		{
						conPool.free(con);
		}
 
			return 0;
			
 } //addAdDetail()

  public int viewAdDetail(ArrayList adDetailAl,long adId)
  {
					logger.debug("webadmin; viewAdDetail");
		try
		{
					con = conPool.getConnection();
					
					if(adId==0)
					{
							query="select AD_ID,NAME,CATEGORY_ID,FREQUENCY,to_char(START_DATE,'DD-MM-YYYY')START_DATE,to_char(END_DATE,'DD-MM-YYYY')END_DATE,MAX_ADS,ADDS_SENT from AD_DETAILS order by NAME";
							pstmt=con.prepareStatement(query);
					}
					else
					{
							query="select AD_ID,NAME,CATEGORY_ID,FREQUENCY,to_char(START_DATE,'DD-MM-YYYY')START_DATE,to_char(END_DATE,'DD-MM-YYYY')END_DATE,MAX_ADS,ADDS_SENT from AD_DETAILS where AD_ID=? order by NAME";
									pstmt =con.prepareStatement(query);
									pstmt.setLong(1,adId);
					}
					 rs = pstmt.executeQuery();
					 while(rs.next() )
					 {
                   Advertise advertise = new Advertise();
									 advertise.setAdId( rs.getLong("AD_ID") );
									 advertise.setAdName( rs.getString("NAME") );
									 advertise.setAdCategory( rs.getLong("CATEGORY_ID") );
									 advertise.setAdFrequency ( rs.getInt("FREQUENCY") );
									 advertise.setStartDate( rs.getString("START_DATE"));
									 advertise.setEndDate( rs.getString("END_DATE"));
									 advertise.setAdMax( rs.getInt("MAX_ADS") );
									 advertise.setAdSent( rs.getInt("ADDS_SENT") );

									 adDetailAl.add(advertise);
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
		{
						conPool.free(con);
		}
		return 99;


  }  //viewAdDetail()

 public int modifyAdDetail(Advertise advertise)
 {
			logger.debug("webadmin: modifyAdDetail");
			try
			{
							con = conPool.getConnection();

							query="update AD_DETAILS set  NAME=?,CATEGORY_ID=?,FREQUENCY=?,START_DATE=to_date(?,'DD-MM-YYYY'),END_DATE=to_date(?,'DD-MM-YYYY'),MAX_ADS=?,ADDS_SENT=? where AD_ID=?";

							pstmt = con.prepareStatement(query);

						  pstmt.setLong(8, advertise.getAdId() );
							pstmt.setString(1, advertise.getAdName() );
							pstmt.setLong(2, advertise.getAdCat() );	
							pstmt.setInt(3, advertise.getAdFrequency() );	
							pstmt.setString(4, advertise.getStartDate() );
							pstmt.setString(5, advertise.getEndDate() );
							pstmt.setInt(6, advertise.getAdMax() );	
							pstmt.setInt(7, advertise.getAdSent() );	
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
		{
						conPool.free(con);
		}
 
			return 0;
			
 } //modifyAddDetail
         
  public int delAdDetail(Advertise advertise)
	{
				logger.debug("webadmin: delAdDetail()");
				try
				{
           con = conPool.getConnection();
					 query = "delete from AD_DETAILS where AD_ID=? and NAME=?";
					 pstmt = con.prepareStatement(query);

					 pstmt.setLong(1, advertise.getAdId() );
					 pstmt.setString(2, advertise.getAdName() );

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
						{
								conPool.free(con);
						}
				    return 2;


	}//delAdDetail
				 
} //class AdvertiseManager
