
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class VLRManager
{
  private static Logger logger=Logger.getLogger(VLRManager.class);
  private ConnectionPool conPool = null;
  private PreparedStatement pstmt = null;
  private Connection con = null;
  private ResultSet rs = null;
  private String query = null;

  public VLRManager ()
  {
    conPool = new ConnectionPool ();
  }

  public int addVLRConfig (VLR vlr)
  {
    try
    {
      con = conPool.getConnection ();
      query = "select VLR_NUMBER from VLR_MASTER where VLR_NUMBER = ?";
      pstmt = con.prepareStatement (query);
      pstmt.setString (1, vlr.getVlrId ());
      rs = pstmt.executeQuery ();
      if (rs.next ())
			{
	  		rs.close();
				pstmt.close ();
			  return -2;
			}
      query = "insert into VLR_MASTER (VLR_NUMBER, DESCRIPTION, OUTROAM_FLAG) values (?, ?, ?)";
      pstmt = con.prepareStatement (query);
      pstmt.setString (1, vlr.getVlrId ());
      pstmt.setString (2, vlr.getDescription ());
      pstmt.setString (3, vlr.getEnabled ());
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
  }//addVLRConfig

  public int viewVLRConfig(ArrayList vlrConfigAl)
	{
		try
		{
			con  = conPool.getConnection();
			query = "select VLR_NUMBER,DESCRIPTION,OUTROAM_FLAG from VLR_MASTER";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			while( rs.next() )
			{
				VLR vlr = new VLR();
				vlr.setVlrId (rs.getString("VLR_NUMBER" ) );
				vlr.setDescription(rs.getString("DESCRIPTION") );
				vlr.setEnabled(rs.getString("OUTROAM_FLAG") );
				vlrConfigAl.add(vlr);
			}//while
			pstmt.close();
			rs.close();		
		}
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
	}// viewVLRConfig

  public int modifyVLRConfig (VLR vlr)
  {
			logger.debug("modify VLR Config");
    try
    {
      con = conPool.getConnection ();
      query = "update VLR_MASTER set DESCRIPTION = ? , OUTROAM_FLAG = ? where VLR_NUMBER=?";
      pstmt = con.prepareStatement (query);
		  pstmt.setString (1, vlr.getDescription ());
      pstmt.setString (2, vlr.getEnabled ());
      pstmt.setString (3, vlr.getVlrId ());
      
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
		{	conPool.free(con);	}
    return 0;
  }//modifyVLRConfig

   public int delVLRConfig (VLR vlr)
  {
    try
    {
      con = conPool.getConnection ();
      query = "delete from VLR_MASTER where VLR_NUMBER = ? ";
      pstmt = con.prepareStatement (query);
      pstmt.setString (1, vlr.getVlrId ());
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
		{		conPool.free(con);}
    return 2;
  }//delVLRConfig
	
} // class VLRManager
