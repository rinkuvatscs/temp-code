
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;


public class SubStat
{
                                private static Logger logger=Logger.getLogger(SubStat.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con =null;
				private ResultSet rs =null;
				private String query=null;
				private long subGrpId=0;
				private long adId=0;

				public SubStat()
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


				// ******************* Add New SubGroup and Alert Details **********
				// ********* 
				public int getSubStat()
				{
								try
								{
												logger.debug("Get Sub Stat");
												con = conPool.getConnection();
												PreparedStatement pstmt = null;
												ResultSet rs = null;
												String key = "";
												try
												{
															 query = "select LICENCE_KEY from CRBT_APP_TEMP_KEY where KEY_ID = 1";
																pstmt = con.prepareStatement(query);
																rs = pstmt.executeQuery();
																while (rs.next())
																{
																				logger.info(rs.getString(1));
																				key = rs.getString(1);
																}
																if(rs != null) rs.close();
																pstmt.close();
												}
												catch (SQLException exp)
												{
																exp.printStackTrace();
												}

												String temp = key.substring(0, 6);

												char tmp[] = temp.toCharArray();

												int n_param = Integer.parseInt(decode(tmp.length, tmp));
												if (n_param <=0 || n_param > key.length()/8)
												{
																return -1;
												}
												int loc = 6;

												for(int i =0; i< n_param; i++)
												{
																temp = key.substring(loc);
																if ((temp == null) || (temp.length() <6))
																{
																				return -1;
																}
																temp = key.substring(loc,loc+6);
																tmp = temp.toCharArray();
																int len = Integer.parseInt(decode(tmp.length, tmp));
																loc = loc+6;
																if (len <=0 || (2*len) > key.substring(loc).length())
																{
																				return -1;
																}
																temp = key.substring(loc, loc+2*len);
																tmp = temp.toCharArray();
																String data = decode(tmp.length, tmp);
																loc = loc+2*len;
																logger.info(data);
																if (i==1)
																{
																				return(Integer.parseInt(data));
																}
												}
								}
												catch (Exception sqle)
												{
																try {
																				if (rs != null) rs.close();
																				if (pstmt != null) pstmt.close();
																} catch (Exception e) {}
																sqle.printStackTrace();
																return 0;
												}
												finally
												{
																conPool.free(con);
												}

												return -1;
								}//getMaxSubs

				public static String decode(int len, char data[])
				{
								char l_data[] = new char[(len/2) +1];
								for (int i=0; i<len; i++)
								{
												l_data[i/2] = (char) (data[i] - 0x41);
												l_data[i/2] += (char) (data[++i] - 0x41)<<4;
								}
								String s = new String(l_data);
								return s.trim();
				}
}//class
