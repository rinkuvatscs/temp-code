
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class CountryManager

{
                                 private static Logger logger=Logger.getLogger(CountryManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public CountryManager()				 
 {
				// conPool = new ConnectionPool();
 }


  public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

 public int addCountry(Country country)
 {
		logger.debug("webadmin: addCountry()");
		try
		{
			con = conPool.getConnection();

			query = "select COUNTRY_NAME from ROME_COUNTRY_MASTER where MCC=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,country.getMcc() );
			rs = pstmt.executeQuery();
			if (rs.next())
			{
					pstmt.close();
					rs.close();
					return -2;  // this COUNTRY_NAME name exists
			}
			pstmt.close();
			rs.close();

			query = "insert into ROME_COUNTRY_MASTER (COUNTRY_CODE, COUNTRY_NAME, CC, MCC, INROAM_FLAG, OUTROAM_FLAG) values (?,?,?,?,?,?)";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, country.getCode() );
			pstmt.setString(2, country.getName() );
			pstmt.setInt(3, country.getCc() );
			pstmt.setInt(4, country.getMcc() );
			pstmt.setString(5, country.getInbound() );
			pstmt.setString(6, country.getOutbound() );

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
		{		conPool.free(con); }
    return 0;
 
 }//addCountry

public int viewCountryConfig(ArrayList countryConfigAl )
{
		logger.debug("webadmin: viewCountryConfig");
		
	try
		{
			con = conPool.getConnection();

			query = "select * from ROME_COUNTRY_MASTER order by COUNTRY_CODE";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			while( rs.next() )
			{
				Country country = new Country();
				country.setCode (rs.getString("COUNTRY_CODE" ) );
				country.setName (rs.getString("COUNTRY_Name" ) );
				country.setCc (rs.getInt("CC" ) );
				country.setMcc (rs.getInt("MCC" ) );
				country.setInbound (rs.getString("INROAM_FLAG" ) );
				country.setOutbound (rs.getString("OUTROAM_FLAG" ) );
				countryConfigAl.add(country);
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
		finally	{	conPool.free(con);	}
		return 99;
			
}//viewCountryConfig

  public int modifyCountryConfig (Country country)
  {
					logger.debug("webadmin:modifyCountryConfig()");
    try
    {
      con = conPool.getConnection ();
      query = "update ROME_COUNTRY_MASTER set INROAM_FLAG = ? , OUTROAM_FLAG = ? where MCC=?";
      pstmt = con.prepareStatement (query);
			
      pstmt.setString (1, country.getInbound() );
      pstmt.setString (2, country.getOutbound() );
      pstmt.setInt (3, country.getMcc() );
      
			pstmt.executeUpdate ();
      pstmt.close ();
    }
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
    }
		finally
		{		conPool.free(con);	}
    return 0;
  }//modifyCountryConfig

 public int delCountryConfig (Country country)
  {
    try
    {
      con = conPool.getConnection ();
      query = "delete from ROME_COUNTRY_MASTER where MCC = ?";
      pstmt = con.prepareStatement (query);
      pstmt.setInt (1, country.getMcc() );
      pstmt.executeUpdate ();
      pstmt.close ();
    }
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
    }
		finally
		{	conPool.free(con); }
  return 2;
  }//delCountryConfig
	
}//class
