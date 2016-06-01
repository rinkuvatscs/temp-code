package com.telemune.dbutilities;
// Copyright (c) Telemune Software Solutions Pvt. Ltd.
//File: QueryParser.java 
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

import java.sql.Date;
import java.util.Hashtable;
 import org.apache.log4j.*;
public class QueryParser 
{
            private static Logger logger=Logger.getLogger(QueryParser.class);
	private String query = null;
	Hashtable vars = new Hashtable();

	public QueryParser(String query)
	{
		this.query = query;
	}

	public void setInt(int parameterIndex, int x)
	{
		vars.put(new Integer(parameterIndex), new Integer(x));
	}

	public void setLong(int parameterIndex, long x)
	{
		vars.put(new Integer(parameterIndex), new Long(x));
	}
	public void setDouble(int parameterIndex, double x)
	{
		vars.put(new Integer(parameterIndex), new Double(x));
	}
	public void setString(int parameterIndex, String x)
	{
		vars.put(new Integer(parameterIndex), x);
	}

	public void setFloat(int parameterIndex, float x)
	{
		vars.put(new Integer(parameterIndex), new Float(x));
	}
	
	public String getSql()
	{
		StringBuffer strBuff = new StringBuffer();
		int index = -1;
		int count = 0;
		while(true)
		{
			int newIndex = query.indexOf('?', index+1);
			if (newIndex == -1)
			{
				strBuff.append(query.substring(index+1));
				break;
			}
			else
			{
				count++;
				strBuff.append(query.substring(index+1, newIndex));
				Object obj = vars.get(new Integer(count));
				if (obj instanceof String)
				{
					strBuff.append("'");
					strBuff.append((String) (obj));
					strBuff.append("'");
				}
				else if (obj instanceof Long)
				{
					strBuff.append(((Long) obj).longValue());
				}
				else if (obj instanceof Integer)
				{
					strBuff.append(((Integer) obj).intValue());
				}
				else if (obj instanceof Float)
				{
					strBuff.append(((Float) obj).floatValue());
				}
				else
				{
					strBuff.append("'");
					strBuff.append(obj);
					strBuff.append("'");
				}
			}
			index = newIndex;
		}		
		return strBuff.toString().replace('\n', ' ');
	}

	public static void main(String args[])
	{
		QueryParser qp = new QueryParser("select from crbt_rbt where rbt_code = ? and masked_name = ? and and date = ? Status = 'Y'");
		qp.setInt(1, 223);
		qp.setString(2, "Kalpesh");
//		qp.setDate(3, new Date(2004, 05, 05));
		logger.info(qp.getSql());
	}
}
