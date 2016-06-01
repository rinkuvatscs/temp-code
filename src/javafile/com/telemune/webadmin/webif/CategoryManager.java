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
 import org.apache.log4j.*;
public class CategoryManager
{
       private static Logger logger=Logger.getLogger(CategoryManager.class);
	private ConnectionPool conPool=null;
	private Connection con=null;

	/*public CategoryManager()
	{
		conPool = new ConnectionPool();
	}*/	

	public void setConnectionPool(ConnectionPool conPool)
	{
		this.conPool = conPool;			
	}

	public ConnectionPool getConnectionPool()
	{
		return conPool;		
	}

	public int modifyCategory(int catId, String mName, String desc, String ivrFile, String play, String web, String sms)
	{
		try
		{	
			con = conPool.getConnection();
			con.setAutoCommit(false);

			String query = "select CAT_ID, MASKED_NAME from CRBT_CATEGORY_MASTER";
			PreparedStatement pstmt = con.prepareStatement(query);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next())
			{
				if(rs.getInt(1) == catId) continue;
				if(rs.getString(2).equalsIgnoreCase(mName)) return CrbtErrorCodes.CATEGORY_ALREADY_EXISTS;
			}
			pstmt.close();
			rs.close();

			query = "update CRBT_CATEGORY_MASTER set MASKED_NAME = ?, DESCRIPTION = ?, IVR_FILEPATH = ?, PLAYABLE = ?, SHOW_ON_WEB = ?, SHOW_IN_SMS = ? where CAT_ID = ?"; 
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, mName);
			pstmt.setString(2, desc);
			pstmt.setString(3, ivrFile);
			pstmt.setString(4, play);
			pstmt.setString(5, web);
			pstmt.setString(6, sms);
			pstmt.setInt(7, catId);

			pstmt.executeUpdate();
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

	public int addNewCategory(String mName, String desc, String ivrPath, String play, String web, String sms)
	{
		try
		{	
			con = conPool.getConnection();
			con.setAutoCommit(false);

			String query = "select MASKED_NAME from CRBT_CATEGORY_MASTER";
			PreparedStatement pstmt = con.prepareStatement(query);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next())
			{
				if(rs.getString(1).equalsIgnoreCase(mName)) return CrbtErrorCodes.CATEGORY_ALREADY_EXISTS;
			}
			rs.close();
			pstmt.close();

			int catId = 0;
			query = "select CRBT_CAT_ID.NEXTVAL from dual";
			pstmt = con.prepareStatement(query);

			rs = pstmt.executeQuery();

			if (rs.next())
			{
				catId = rs.getInt("NEXTVAL");
			}
			else
			{
				return CrbtErrorCodes.FAILURE;
			}
			rs.close();
			pstmt.close();

			query = "insert into CRBT_CATEGORY_MASTER (CAT_ID, MASKED_NAME, DESCRIPTION, IVR_FILEPATH, PLAYABLE, SHOW_IN_SMS, SHOW_ON_WEB) values (?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(query);

			pstmt.setInt(1, catId);
			pstmt.setString(2, mName.toUpperCase());
			pstmt.setString(3, desc);
			pstmt.setString(4, ivrPath);
			pstmt.setString(5, play);
			pstmt.setString(6, web);
			pstmt.setString(7, sms);
			pstmt.executeUpdate();

			int position = 0;
			query = "select nvl(max(POSITION),0) from CRBT_CATEGORY_ORDERING";
			pstmt = con.prepareStatement(query);

			rs = pstmt.executeQuery();

			if (rs.next())
			{
				position = rs.getInt(1) +1;
			}
			else
			{
				return CrbtErrorCodes.FAILURE;
			}
			rs.close();
			pstmt.close();

			query = "insert into CRBT_CATEGORY_ORDERING (CAT_ID, POSITION) values (?, ?)"; 
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, catId);
			pstmt.setInt(2, position);
			pstmt.executeUpdate();

			pstmt.close();

			int rbtId = 0;
			query = "select CRBT_RBT_CODE.NEXTVAL from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();      
			if (rs.next())
			{
				rbtId = rs.getInt("NEXTVAL");
			}
			else
			{
					pstmt.close();
					rs.close();
				return CrbtErrorCodes.FAILURE;
			}
			rs.close();
			pstmt.close();

			query = "insert into CRBT_RBT_CONTROL (CONTROL_ID, CONTROL_NAME, CAT_ID) values (?, ?, ?)";
			pstmt = con.prepareStatement(query);

			pstmt.setInt(1, rbtId);
			pstmt.setString(2, "TOP");
			pstmt.setInt(3, catId);
			pstmt.executeUpdate();
			pstmt.close();

			rbtId = 0;
			query = "select CRBT_RBT_CODE.NEXTVAL from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();      
			if (rs.next())
			{
				rbtId = rs.getInt("NEXTVAL");
			}
			else
			{
			rs.close();
			pstmt.close();
				return CrbtErrorCodes.FAILURE;
			}
			rs.close();
			pstmt.close();

			query = "insert into CRBT_RBT_CONTROL (CONTROL_ID, CONTROL_NAME, CAT_ID) values (?, ?, ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtId);
			pstmt.setString(2, "SEQ");
			pstmt.setInt(3, catId);
			pstmt.executeUpdate();
			pstmt.close();

			rbtId = 0;
			query = "select CRBT_RBT_CODE.NEXTVAL from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();      
			if (rs.next())
			{
				rbtId = rs.getInt("NEXTVAL");
			}
			else
			{
			rs.close();
			pstmt.close();
				return CrbtErrorCodes.FAILURE;
			}
			rs.close();
			pstmt.close();

			query = "insert into CRBT_RBT_CONTROL (CONTROL_ID, CONTROL_NAME, CAT_ID) values (?, ?, ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtId);
			pstmt.setString(2, "RANDOM");
			pstmt.setInt(3, catId);
			pstmt.executeUpdate();
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

	public int getCategoryDetails(Category cat)
	{
		try
		{	
			con = conPool.getConnection();

			String query = "select MASKED_NAME, DESCRIPTION, IVR_FILEPATH, PLAYABLE, SHOW_ON_WEB, SHOW_IN_SMS from CRBT_CATEGORY_MASTER where CAT_ID = ?";
			PreparedStatement pstmt = con.prepareStatement(query);

			pstmt.setInt(1, cat.getCategoryId());

			ResultSet rs = pstmt.executeQuery();

			if (rs.next())
			{
				cat.setMaskedName(rs.getString("MASKED_NAME"));
				cat.setDescription(rs.getString("DESCRIPTION"));
				cat.setIvrFilePath(rs.getString("IVR_FILEPATH"));
				cat.setPlayable(rs.getString("PLAYABLE"));
				cat.setShowWeb(rs.getString("SHOW_ON_WEB"));
				cat.setShowSms(rs.getString("SHOW_IN_SMS"));
			}

			logger.info(query);
			pstmt.close();	
			rs.close();
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

	public int searchCategory (String catName, ArrayList catList) 
	{		
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		try
		{	
			con = conPool.getConnection();

			String specialCatId   = TSSJavaUtil.instance().getAppConfigParam("SPECIAL_CONTROL_CATID");
			String recordedCatId  = TSSJavaUtil.instance().getAppConfigParam("CRBT_RECORDED_CATEGORY_ID");

			String query = "select CAT_ID, MASKED_NAME from CRBT_CATEGORY_MASTER where UPPER(MASKED_NAME) like ? and not (CAT_ID=?) and not (CAT_ID=?) order by CAT_ID";

			pstmt = con.prepareStatement(query);
			pstmt.setString(1,"%"+catName+"%");
			pstmt.setString(2,specialCatId);
			pstmt.setString(3,recordedCatId);

			rs = pstmt.executeQuery();
			while(rs.next()) 
			{
				Category cat = new Category(rs.getInt("CAT_ID"),rs.getString("MASKED_NAME"));
				catList.add(cat);
			}

			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			return 1;
		}
		catch (Exception e) 
		{
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch(Exception exp) {}                
			e.printStackTrace();
			return -99;
		}
		finally {
			conPool.free(con);
		}
	}

	public int deleteCategory(int catId)
	{
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		try
		{	
			int rbtCode = Integer.parseInt(TSSJavaUtil.instance().getAppConfigParam("DEFAULT_RBT"));
			con = conPool.getConnection();	
			con.setAutoCommit(false);			
			String query = "";

			query = "update CRBT_SUBSCRIBER_MASTER set RBT_CODE = ? where RBT_CODE in (select RBT_CODE from CRBT_RBT where CAT_ID = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "update CRBT_SUBSCRIBER_MASTER set RBT_CODE = ? where RBT_CODE in (select CONTROL_ID from CRBT_RBT_CONTROL where CAT_ID = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "update CRBT_DEFAULT_DETAIL set RBT_CODE = ? where DAY='8' and START_AT='2500' and ENDS_AT='2500' and RBT_CODE in (select RBT_CODE from CRBT_RBT where CAT_ID = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "update CRBT_GROUP_DETAIL set CONTROL_RBT_CODE = ? where CONTROL_RBT_CODE in (select CONTROL_ID from CRBT_RBT_CONTROL where CAT_ID = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "update CRBT_FRIEND_DETAIL set CONTROL_RBT_CODE = ? where CONTROL_RBT_CODE in (select CONTROL_ID from CRBT_RBT_CONTROL where CAT_ID = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rbtCode);
			pstmt.setInt(2, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			int position = -1;
			query = "select POSITION from CRBT_CATEGORY_ORDERING where CAT_ID = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setLong(1, catId);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				position = rs.getInt("POSITION");
			}
			pstmt.close(); 
			rs.close();

			query = "delete from CRBT_CATEGORY_ORDERING where CAT_ID = ?"; 
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "update CRBT_CATEGORY_ORDERING set POSITION = POSITION-1 where POSITION > ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, position);
			pstmt.executeUpdate();
			pstmt.close(); 

			pstmt = con.prepareStatement(query);
			logger.info(query);
			pstmt.setInt(1, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			query = "delete from CRBT_CATEGORY_MASTER cascade where CAT_ID = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, catId);
			pstmt.executeUpdate();
			pstmt.close(); 

			con.commit();
			return CrbtErrorCodes.SUCCESS;
		}
		catch (SQLException sqle)
		{//log it 
			sqle.printStackTrace();
			try {
				con.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			if (sqle.getErrorCode() == 2292)
			{
				return -7;
			}
			return CrbtErrorCodes.FAILURE;
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
	}

	public int orderCategory(int[] order)
	{
		try
		{	
			con = conPool.getConnection();
			con.setAutoCommit(false);

			String query = "delete from CRBT_CATEGORY_ORDERING";
			PreparedStatement pstmt = con.prepareStatement(query);

			pstmt.executeUpdate();
			pstmt.close();

			query = "insert into CRBT_CATEGORY_ORDERING (CAT_ID, POSITION) values (?,?)";	
			pstmt = con.prepareStatement(query);

			for(int i =0; i<order.length; i++)
			{
				pstmt.setInt(1, order[i]);
				pstmt.setInt(2, i+1);
				pstmt.executeUpdate();
			}

			pstmt.close();
			con.commit();
			return CrbtErrorCodes.SUCCESS;
		}
		catch (Exception e)
		{//log it 
			try {
				con.rollback();
			} catch (Exception exp) {
				exp.printStackTrace();
			}
			e.printStackTrace();	
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
	}

	public int  getCategoryOrder(Vector order)
	{
		try
		{	
			con = conPool.getConnection();

			String query = "select CAT_ID from CRBT_CATEGORY_ORDERING order by POSITION";
			PreparedStatement pstmt = con.prepareStatement(query);

			ResultSet rs = pstmt.executeQuery();

			while(rs.next())
				order.add(new Integer(rs.getInt(1)));

			pstmt.close();
			rs.close();
		}
		catch (Exception e)
		{//log it 
			e.printStackTrace();
			return CrbtErrorCodes.FAILURE;
		}
		finally
		{
			conPool.free(con);
		}
		return CrbtErrorCodes.SUCCESS;
	}
}
