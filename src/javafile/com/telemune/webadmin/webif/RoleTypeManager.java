/*
 * To get param values.
 *
 *
// modified on Jan 11, 2006
// @ Jatinder Pal
 *
 */

package com.telemune.webadmin.webif;

import com.telemune.dbutilities.*;
import java.text.DateFormat;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
 import org.apache.log4j.*;
public class RoleTypeManager
{
        private static Logger logger=Logger.getLogger(RoleTypeManager.class);
	private ConnectionPool conPool = null;
	private PreparedStatement pstmt = null;
	private Connection con = null;
	private ResultSet rs =null;
	private String query = null;

	public RoleTypeManager ()
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

	public int addRoleData (RoleType roleType, String[] links)
	{
		logger.debug ("in function addRoleData of RoleTypeManager");
		try
		{
			con = conPool.getConnection ();
			query = "select ROLE_NAME from CRBT_ROLES where ROLE_NAME=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString(1, roleType.getRoleName().trim() );
			rs = pstmt.executeQuery();
			while(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2;  // this Role Name aleady exists in the System/
			}

			rs.close ();
			pstmt.close ();
			int roleId = -1;
			query = "select ROLE_ID.NEXTVAL from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				roleId = rs.getInt(1);
				rs.close();
				pstmt.close();
			}
			else
			{
				rs.close();
				pstmt.close();
				logger.info ("RoleTypeManager: roleId not created");
				return -99;
			}
			query = "insert into CRBT_ROLES (ROLE_ID, ROLE_NAME,DESCRIPTION) values (?,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setInt ( 1, roleId);
			pstmt.setString ( 2, roleType.getRoleName().trim() );
			pstmt.setString ( 3, roleType.getRoleDesc().trim() );
			pstmt.executeUpdate();
			pstmt.close();
			if (links != null)
			{			
				query= "insert into CRBT_ACCESS (LINK_ID, ROLE_ID) values (?, ?)";
				pstmt = con.prepareStatement (query);
				for(int i=0; i<links.length; i++)
				{
					pstmt.setInt (1, Integer.parseInt (links[i]));
					pstmt.setInt (2, roleId);
					pstmt.executeUpdate();
				}
				pstmt.close ();
			} //if links

		} //try
		catch (Exception e)
		{//log it
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in addRoleData, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}//catch
		finally
		{	conPool.free(con);	}
		return 99;

	} //addRoleData

	public int  getRoleTypes (ArrayList roleTypeAl)
	{
		logger.debug ("in function getRoleTypes");
		try
		{
			con = conPool.getConnection ();
			query = "select ROLE_ID,ROLE_NAME,DESCRIPTION  from CRBT_ROLES";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				RoleType roleType = new RoleType ();
				roleType.setRoleId (rs.getInt ("ROLE_ID") );
				roleType.setRoleName (rs.getString ("ROLE_NAME") );
				roleType.setRoleDesc (rs.getString ("DESCRIPTION") );
				roleTypeAl.add (roleType);
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
			} catch(SQLException sqle) {
				logger.error ("Exception in getRoleType, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally
		{		conPool.free(con);	}
		return 99;

	} //getRoleTypes

	public int deleteRoleData (String[] links)
	{
		logger.debug("Here in deleteRoleData of RoleTypeManager");
		try
		{
			con = conPool.getConnection ();
			query = "select count(*) total from CRBT_ADMINUSER where ROLE_ID = ?";
			pstmt = con.prepareStatement (query);
			for(int i=0; i<links.length; i++)
			{
				pstmt.setInt (1 , Integer.parseInt (links[i]));
				rs = pstmt.executeQuery ();
				if(rs.next ())
				{
					if(rs.getInt ("total") != 0)
					{
						rs.close ();
						pstmt.close ();
						return -66; //  this Role Type is assigned to some other Role
					}
				}
				rs.close ();
				pstmt.close ();
			} //for

			// Deleting from CRBT_ACCESS table
			query = "delete from CRBT_ACCESS where ROLE_ID= ?";
			pstmt = con.prepareStatement (query);
			for(int i=0; i<links.length; i++)
			{
				pstmt.setInt (1 , Integer.parseInt (links[i]));
				pstmt.executeUpdate();
			}
			pstmt.close ();

			//deleting from CRBT_USER_TYPES TABLE
			query = "delete from CRBT_ROLES where ROLE_ID = ?";
			pstmt = con.prepareStatement (query);
			for(int i=0; i<links.length; i++)
			{
				pstmt.setInt (1 , Integer.parseInt (links[i]));
				pstmt.executeUpdate();
			}
			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			} catch(SQLException sqle) {
				logger.error ("Exception in deleteRoleData, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally
		{		conPool.free(con);	}
		return 99;

	} //deleteRoleData

	public int updateRoleData (int roleId, String[] links)
	{
		logger.debug ("Here in updateRoleData of RoleTypeManager");
		try
		{
			con = conPool.getConnection ();
			query = "delete from CRBT_ACCESS where ROLE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setInt ( 1, roleId);
			pstmt.executeUpdate();
			pstmt.close ();
			if(links != null)
			{
				query = "insert into CRBT_ACCESS (ROLE_ID, LINK_ID) values (?, ?)";
				pstmt = con.prepareStatement (query);
				pstmt.setInt (1,roleId);
				for(int i=0; i<links.length; i++)
				{
					pstmt.setInt (2,Integer.parseInt (links[i]));
					pstmt.executeQuery ();
				}
			}

			pstmt.close ();
		}
		catch (Exception e)
		{//log it
			try
			{
				if(pstmt != null) pstmt.close ();
			} catch(SQLException sqle) {
				logger.error ("Exception in updateRoleData, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally
		{		conPool.free(con);	}
		return 99;

	} //updateRoleData

	public ArrayList getLinks (int id)
	{
		logger.debug ("in function getLinks of RoleTypeManager");
		ArrayList ret = new ArrayList ();
		try
		{
			con = conPool.getConnection ();
			query = "select LINK_ID from CRBT_ACCESS where ROLE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1 , id);
			rs= pstmt.executeQuery ();
			while(rs.next ())
			{
				ret.add (new Integer (rs.getInt ("LINK_ID")));
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
			} catch(SQLException sqle) {
				logger.error ("Exception in getLinks, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
		}
		finally
		{		conPool.free(con);	}
		return ret;
	} //getLinks

	public int  getHttpLinks (ArrayList roleTypeAl)
	{
		logger.debug ("in function getHttpLinks of RoleTypeManager");

		try
		{
			con = conPool.getConnection ();
			query = "select LINK_ID, DESCRIPTION  from CRBT_HTTP_LINKS order by LINK_ID";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				RoleType roleType = new RoleType();
				roleType.setLinkId( rs.getInt ("LINK_ID") );
				roleType.setLinkDesc( rs.getString ("DESCRIPTION") );
				roleTypeAl.add(roleType);
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
			}catch(SQLException sqle) {
				logger.error ("Exception in getHttpLinks, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception Received:" + e);
			return -99;
		}
		finally
		{		conPool.free(con);	}
		return 1;

	}//getHttpLinks

} //class RoleTypeManager
