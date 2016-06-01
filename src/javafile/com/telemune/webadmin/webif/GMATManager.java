
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class GMATManager

{
                                 private static Logger logger=Logger.getLogger(GMATManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public GMATManager()				 
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

 public int addGMAT(GMAT gmat)
 {
		 logger.debug("webadmin: addGMAT()");
		try
		{
				con = conPool.getConnection();
				query= "select * from GMAT_HELP_MASTER where PROCESS_NAME=? and LANGUAGE_ID=?" ;
				pstmt = con.prepareStatement(query);

				pstmt.setString(1, gmat.getName());
				pstmt.setInt(2, gmat.getLanguage() );
				rs = pstmt.executeQuery();

				if(rs.next() )
				{
						logger.debug("webadmin-addGMAT() this GMAT Name and Language Id Already Exists");
						pstmt.close();		
						rs.close();
						return -1;
								
				}
				pstmt.close();
				rs.close();
				
				query = "insert into GMAT_HELP_MASTER (PROCESS_NAME,HELP_MESSAGE,LANGUAGE_ID) values(?,?,?)";
				pstmt = con.prepareStatement(query);

				pstmt.setString(1, gmat.getName());
				pstmt.setString(2, gmat.getMessage());
				pstmt.setInt(3, gmat.getLanguage());
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
		{		conPool.free(con);	}
    return 0;
 
	} //addGMAT
 
  public int getGMAT(ArrayList gmatConfigAl, String name, int languageId)
	{
				logger.debug("webadmin: getGMAT() for name= "+name);
		try
		{
			con = conPool.getConnection();
			if(name.equals("X") && languageId == -1)
			{
				query="select * from  GMAT_HELP_MASTER order by PROCESS_NAME";
				pstmt = con.prepareStatement(query);
      }   
			else
			{
				query="select * from  GMAT_HELP_MASTER where PROCESS_NAME=? and LANGUAGE_ID=? order by PROCESS_NAME";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, name);
				pstmt.setInt(2,languageId);
			}
			rs = pstmt.executeQuery();
		  while(rs.next() )
				{
						GMAT gmat = new GMAT();
						gmat.setName( rs.getString("PROCESS_NAME"));
						gmat.setMessage( rs.getString("HELP_MESSAGE") );
						gmat.setLanguage(  rs.getInt("LANGUAGE_ID"));
	 					gmatConfigAl.add(gmat);
				}
			  rs.close();
				pstmt.close();
		}//try
   catch (Exception e)
		{
						try
						{
										if (rs != null)
														rs.close ();
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
		{		conPool.free(con);	}
    return 0;

	}//getGMAT
	
	public int modifyGMAT(GMAT gmat)
	{
				logger.debug("webadmin: modifyGMAT() ");
		try
		{
				con = conPool.getConnection();
				query="update GMAT_HELP_MASTER set HELP_MESSAGE=? where LANGUAGE_ID=? and PROCESS_NAME=?";
				pstmt = con.prepareStatement(query);

				pstmt.setString(1, gmat.getMessage());
				pstmt.setInt(2, gmat.getLanguage());
				pstmt.setString(3, gmat.getName());
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
		{	conPool.free(con); }
    return 0;
 
	} //modifyGMAT




} //class GMATManager
