package com.telemune.dbutilities;
// Copyright (c) Telemune Software Solutions Pvt. Ltd.
//File: PreparedStatement.java 
/**
 * @Author                            Kalpesh Balar
 * @Version                           $Revision: 1.1.1.1 $
 * Creation-Date                       Thu May 05 17:25:36 IST 2005
 * Classes
 *
 */
/*
 * Development History
 * ####################
 * Date                                 Author                        Description
 * ------------------------------------------------------------------------------
 * Thu May 05 17:25:36 IST 2005        Kalpesh Balar                       Created.
 *
 */

import java.sql.*;

public class PreparedStatement 
{
	private String query = null;
	private QueryParser queryParser = null;
	private java.sql.PreparedStatement pstmt = null;
	private com.telemune.dbutilities.Connection tcon = null;

	public PreparedStatement(com.telemune.dbutilities.Connection tcon, java.sql.PreparedStatement pstmt, String query)
	{
		this.tcon = tcon;
		this.pstmt = pstmt;
		this.query = query.toLowerCase();
		if ((!this.query.startsWith("select")) && (tcon.isReplicate()))
	  	this.queryParser = new QueryParser(query);
	}

	public void clearParameters() throws SQLException
	{
		pstmt.clearParameters();
	}

	public boolean execute() throws SQLException
	{
		return pstmt.execute();
	}

	public ResultSet executeQuery() throws SQLException
	{
		return pstmt.executeQuery();
	}

	public int executeUpdate() throws SQLException
	{
		int ret = pstmt.executeUpdate();
		if ((queryParser != null) && (ret > 0))
			tcon.replicate(queryParser.getSql());	
		return ret;
	}

	public void close() throws SQLException
	{
		pstmt.close();
	}

	public void setFloat(int parameterIndex, float x) throws SQLException
	{		
		if (queryParser !=null)
			queryParser.setFloat(parameterIndex, x);
		pstmt.setFloat(parameterIndex, x);
	}

	public void setInt(int parameterIndex, int x) throws SQLException
	{
		if (queryParser !=null)
			queryParser.setInt(parameterIndex, x);
		pstmt.setInt(parameterIndex, x);
	}

	public void setLong(int parameterIndex, long x) throws SQLException
	{
		if (queryParser !=null)
			queryParser.setLong(parameterIndex, x);
		pstmt.setLong(parameterIndex, x);
	}
	public void setDouble(int parameterIndex, double x) throws SQLException
	{
		if (queryParser !=null)
			queryParser.setDouble(parameterIndex, x);
		pstmt.setDouble(parameterIndex, x);
	}
	public void setString(int parameterIndex, String x) throws SQLException
	{
		if (queryParser !=null)
			queryParser.setString(parameterIndex, x);
		pstmt.setString(parameterIndex, x);
	}
}
