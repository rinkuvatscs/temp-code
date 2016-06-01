package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class PromotionPackManager
{
                                private static Logger logger=Logger.getLogger(PromotionPackManager.class);
				private ConnectionPool conPool = null;
				private ResultSet rs = null;
				private PreparedStatement pstmt = null;
				private PreparedStatement pstmt1 = null;
				private Connection con = null;
				private String query = null;
				private String query1 = null;

				public PromotionPackManager()
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


				public int addPromotionPack (PromotionPack promo)
				{
								logger.debug("webadmin: addPromotionPack");
								int packid=0;
								try
								{
												con = conPool.getConnection();

												query = "SELECT PACK_NAME FROM CRBT_RBT_PACK WHERE PACK_NAME=?";
												pstmt = con.prepareStatement (query);
												pstmt.setString(1,promo.getPackName());
												rs = pstmt.executeQuery ();
												if(rs.next ())
												{
																rs.close ();
																pstmt.close ();
																return -2; //Record already exists
												}
												rs.close ();
												pstmt.close ();

												query = "SELECT PACK_NAME FROM CRBT_RBT_PACK WHERE PACK_SIZE=? and FREE_RBTS=?";
												pstmt = con.prepareStatement (query);
												pstmt.setInt (1,promo.getPackSize());
												pstmt.setInt (2,promo.getFreeRbt());
												rs = pstmt.executeQuery ();
												if(rs.next ())
												{
																rs.close ();
																pstmt.close ();
																return -2; //Record already exists
												}
												rs.close ();
												pstmt.close ();

												query="select rbt_pack_id.nextval from dual";
												pstmt=con.prepareStatement(query);
												rs = pstmt.executeQuery();
												if(rs.next())
												{
																packid = rs.getInt(1);
												}
												rs.close ();
												pstmt.close ();

												query = "INSERT INTO CRBT_RBT_PACK (PACK_ID,PACK_NAME, PACK_SIZE, PACK_COST, FREE_RBTS) VALUES (?,?,?,?,?)";
												pstmt = con.prepareStatement (query);

												pstmt.setInt (1, packid);
												pstmt.setString (2, promo.getPackName());
												pstmt.setInt (3, promo.getPackSize());
												pstmt.setLong (4, promo.getPackCost());
												pstmt.setInt (5, promo.getFreeRbt());

												pstmt.executeUpdate ();
												pstmt.close ();
								}//try
								catch (Exception e)
								{
												try
												{
																if(pstmt != null) pstmt.close ();
																if(rs != null) rs.close ();
												}catch(SQLException sqle)
												{
																logger.error ("webadmin-addPromotionPack: Exception is: " + sqle.getMessage ());
												}

												e.printStackTrace ();
												return -1;
								}
								finally  { conPool.free(con); } 
								return 1; //  added susccessfully

				}// addPromotionPack()

				public int getPromotionPacks (ArrayList packAl)
				{
								logger.debug("getPromotionPacks() ");
								try
								{
												con = conPool.getConnection();
												query = "select a.PACK_ID, a.PACK_NAME, a.PACK_SIZE, a.PACK_COST, a.FREE_RBTS, b.DESCRIPTION from CRBT_RBT_PACK A, CRBT_CHARGING_CODE b where a.PACK_COST=b.CHARGING_CODE";
												pstmt = con.prepareStatement (query);
												rs = pstmt.executeQuery ();
												while(rs.next ())
												{
																PromotionPack promo = new PromotionPack ();
																promo.setPackName (rs.getString ("PACK_NAME"));
																promo.setPackId (rs.getInt ("PACK_ID"));
																promo.setPackSize (rs.getInt ("PACK_SIZE"));
																promo.setPackCost (rs.getLong("PACK_COST"));
																promo.setChgRule (rs.getString("DESCRIPTION"));
																promo.setFreeRbt (rs.getInt("FREE_RBTS"));
																packAl.add (promo);
												}
												rs.close ();
												pstmt.close ();
								} //try
								catch (Exception e)
								{
												try
												{
																if(rs != null) rs.close ();
																if(pstmt != null) pstmt.close ();
												}catch(SQLException sqle)
												{
																logger.error ("Exception in getPromotionPacks: " + sqle.getMessage ());
												}
												e.printStackTrace ();
												return -1;
								}
								finally{ conPool.free(con); }
								return 1;
				}//getPromotionPacks

				public int getPromotionPack (ArrayList packAl, int packId)
				{
								logger.debug("getPromotionPack() "+packId);
								try
								{
												con = conPool.getConnection();
												query = "select PACK_ID, PACK_NAME, PACK_SIZE, PACK_COST, FREE_RBTS from CRBT_RBT_PACK where PACK_ID=?";
												pstmt = con.prepareStatement (query);
												pstmt.setInt(1, packId);
												rs = pstmt.executeQuery ();
												while(rs.next ())
												{
																PromotionPack promo = new PromotionPack ();
																promo.setPackName (rs.getString ("PACK_NAME"));
																promo.setPackId (rs.getInt ("PACK_ID"));
																promo.setPackSize (rs.getInt ("PACK_SIZE"));
																promo.setPackCost (rs.getLong("PACK_COST"));
																promo.setFreeRbt (rs.getInt("FREE_RBTS"));
																packAl.add (promo);
												}
												rs.close ();
												pstmt.close ();
								} //try
								catch (Exception e)
								{
												try
												{
																if(rs != null) rs.close ();
																if(pstmt != null) pstmt.close ();
												}catch(SQLException sqle)
												{
																logger.error ("Exception in getPromotionPacks: " + sqle.getMessage ());
												}
												e.printStackTrace ();
												return -1;
								}
								finally{ conPool.free(con); }
								return 1;
				}//getPromotionPack


				public int modifyPromotionPack (PromotionPack promo, String packnameold)
				{
								logger.debug("webadmin: modifyPromotionPack");
								logger.info(promo.getPackName()+ "  "+promo.getPackId());
								try
								{
												con = conPool.getConnection();

												/*query = "SELECT PACK_NAME FROM CRBT_RBT_PACK WHERE PACK_NAME=?";
														pstmt = con.prepareStatement (query);
														pstmt.setString(1,packnameold);
														logger.info(query);
														rs = pstmt.executeQuery ();
														if(rs.next ())
														{
														rs.close ();
														pstmt.close ();
														return -2; //Record already exists
														}
														rs.close ();
														pstmt.close ();
													*/
												query = "SELECT PACK_NAME FROM CRBT_RBT_PACK WHERE PACK_SIZE=? and FREE_RBTS=? and PACK_COST=?";
												pstmt = con.prepareStatement (query);
												pstmt.setInt (1,promo.getPackSize());
												pstmt.setInt (2,promo.getFreeRbt());
												pstmt.setLong(3,promo.getPackCost());
												logger.info(query);
												rs = pstmt.executeQuery ();
												if(rs.next ())
												{
																rs.close ();
																pstmt.close ();
																return -2; //Record already exists
												}
												rs.close ();
												pstmt.close ();


												query = "UPDATE CRBT_RBT_PACK set PACK_NAME=?, PACK_SIZE=?, PACK_COST=?, FREE_RBTS=? where PACK_ID=?";
												pstmt = con.prepareStatement (query);

												pstmt.setString (1, promo.getPackName());
												pstmt.setInt (2, promo.getPackSize());
												pstmt.setLong (3, promo.getPackCost());
												pstmt.setInt (4, promo.getFreeRbt());
												pstmt.setInt (5, promo.getPackId());
												logger.info(query);

												pstmt.executeUpdate ();
												pstmt.close ();
								}//try
								catch (Exception e)
								{
												try
												{
																if(pstmt != null) pstmt.close ();
																if(rs != null) rs.close ();
												}catch(SQLException sqle)
												{
																logger.error ("webadmin-modifyPromotionPack: Exception is: " + sqle.getMessage ());
												}

												e.printStackTrace ();
												return -1;
								}
								finally  { conPool.free(con); } 
								return 1; //  added susccessfully

				}//modifyPromotionPack

				public int definePromotionOffer (PromotionPack promo)
				{
								logger.info("webadmin: definePromotionOffer "+promo.getStartDate()+"   "+promo.getEndDate());
								int promoid=0;
								try
								{
												con = conPool.getConnection();

												query = "SELECT START_DATE, PACK_ID, FREE_RBTS, SUBS_OFFER FROM CRBT_PROMOTION where START_DATE=to_date(?,'dd-mm-yyyy') and PACK_ID=? and FREE_RBTS=? and SUBS_OFFER=?";
												pstmt = con.prepareStatement (query);
												pstmt.setString(1, promo.getStartDate());
												pstmt.setInt(2, promo.getPackId());
												pstmt.setInt(3, promo.getFreeRbt());
												pstmt.setString(4, promo.getSubsOffer());
												rs = pstmt.executeQuery ();
												if(rs.next ())
												{
																logger.info("Startdate, packid, free rbt, subsoffer combination is already defined");
																rs.close ();
																pstmt.close ();
																return -2; //Record already exists
												}
												rs.close ();
												pstmt.close ();

												query = "SELECT START_DATE, END_DATE, PACK_ID from CRBT_PROMOTION WHERE START_DATE=to_date(?,'dd-mm-yyyy') and END_DATE=to_date(?,'dd-mm-yyyy') and PACK_ID=?";
												pstmt = con.prepareStatement (query);
												pstmt.setString(1,promo.getStartDate());
												pstmt.setString (2,promo.getEndDate());
												pstmt.setInt(3, promo.getPackId());
												rs = pstmt.executeQuery ();
												if(rs.next ())
												{
																logger.debug("Startdate, enddate and packid combination is already defined");
																rs.close ();
																pstmt.close ();
																return -21; //Record already exists
												}
												rs.close ();
												pstmt.close ();

												query="select promo_id.nextval from dual";
												pstmt=con.prepareStatement(query);
												rs = pstmt.executeQuery();
												if(rs.next())
												{
																promoid = rs.getInt(1);
												}
												rs.close ();
												pstmt.close ();
            int chgcode=0; 
												query="select PACK_COST from CRBT_RBT_PACK where PACK_ID=?";
												pstmt = con.prepareStatement (query);
												pstmt.setInt (1, promo.getPackId());
												rs = pstmt.executeQuery();
												if(rs.next())
												{
																chgcode = rs.getInt(1);
												}
												rs.close ();
												pstmt.close ();

												 
												//query = "INSERT INTO CRBT_PROMOTION (PROMO_ID,START_DATE, END_DATE, PACK_ID, FREE_RBTS, SUBS_OFFER) VALUES (?,to_date(?,'dd-mm-yyyy'),to_date(?,'dd-mm-yyyy'),?,?,?)";
												//query = "INSERT INTO CRBT_PROMOTION (PROMO_ID,START_DATE, END_DATE, PACK_ID, FREE_RBTS, SUBS_OFFER) VALUES (?,to_date(to_char(to_date(?,'dd-mm-yyyy hh24'),'dd-mon-yyyy hh24'),'dd-mon-yyyy hh24'),to_date(to_char(to_date(?,'dd-mm-yyyy hh24'),'dd-mon-yyyy hh24'),'dd-mon-yyyy hh24') ,?,?,?)";
												//query="INSERT INTO CRBT_PROMOTION (PROMO_ID,START_DATE, END_DATE, PACK_ID, FREE_RBTS, SUBS_OFFER) VALUES (?,to_date(to_char(to_date(?,'dd-mm-yyyy hh24'),'dd-mon-yyyy hh24'),'dd-mon-yyyy hh24'),to_date(to_char(to_date(?,'dd-mm-yyyy hh24'),'dd-mon-yyyy hh24'),'dd-mon-yyyy hh24') ,?,?,?)";

												query = "INSERT INTO CRBT_PROMOTION (PROMO_ID,START_DATE,END_DATE,PACK_ID,CHARGING_CODE, SUBS_OFFER) VALUES (?,to_date(?,'dd-mm-yyyy'),to_date(?,'dd-mm-yyyy'),?,?,?)";
												logger.info(query);
												pstmt = con.prepareStatement (query);
												pstmt.setInt (1, promoid);
												pstmt.setString (2, promo.getStartDate());
												pstmt.setString (3, promo.getEndDate());
												pstmt.setInt (4, promo.getPackId());
												//pstmt.setInt (5, promo.getFreeRbt());
												pstmt.setInt (5, chgcode);
												pstmt.setString (6, promo.getSubsOffer());

												pstmt.executeUpdate ();
												pstmt.close ();
								}//try
								catch (Exception e)
								{
												try
												{
																if(pstmt != null) pstmt.close ();
																if(rs != null) rs.close ();
												}catch(SQLException sqle)
												{
																logger.error ("webadmin-definePromotionOffer:Exception is: " + sqle.getMessage ());
												}

												e.printStackTrace ();
												return -1;
								}
								finally  { conPool.free(con); } 
								return 1; //  added susccessfully

				}//definePromotionOffer

				public int deletePromoPack(ArrayList ocAl)
				{
					logger.debug("deletePromoPack()");
					try
					{
						con = conPool.getConnection();
						query = "delete from CRBT_RBT_PACK  WHERE PACK_ID=?";
						pstmt = con.prepareStatement(query);
						Iterator ite1 = ocAl.iterator();
						while (ite1.hasNext())
						{
							//pstmt.setInt (1,(Integer.parseInt(ite1.next())));
							pstmt.setInt (1,Integer.parseInt((String)ite1.next()));
							pstmt.executeUpdate();
						}
						pstmt.close();


					}//try
					catch (Exception e)
					{
						try
						{
							if(pstmt != null) pstmt.close ();
						}catch(SQLException sqle)
						{
							logger.error ("Exception in deletePromoPack(), Exception is : " + sqle.getMessage ());
						}
						e.printStackTrace ();
						return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
				}//delete
				public int getPromotionOffers (ArrayList promooffer)
				{
								logger.debug("webadmin: getPromotionOffer");
								int promoid=0;
								try
								{
												con = conPool.getConnection();

												//query = "SELECT PROMO_ID,START_DATE,END_DATE, PACK_ID, FREE_RBTS, SUBS_OFFER FROM CRBT_PROMOTION ";
												query = "SELECT a.PROMO_ID,b.PACK_NAME,START_DATE,END_DATE, a.PACK_ID,a.CHARGING_CODE, a.SUBS_OFFER FROM CRBT_PROMOTION a, CRBT_RBT_PACK b where a.PACK_ID=b.PACK_ID ";
												pstmt = con.prepareStatement (query);
												rs = pstmt.executeQuery ();
												while(rs.next ())
												{
																PromotionPack promo = new PromotionPack ();
																promo.setPromoId (rs.getInt ("PROMO_ID"));
																promo.setPackName (rs.getString ("PACK_NAME"));
																promo.setStartDate (rs.getString ("START_DATE"));
																promo.setEndDate (rs.getString("END_DATE"));
																//promo.setFreeRbt (rs.getInt("FREE_RBTS"));
															//	promo.setChgCode (rs.getInt("CHARGING_CODE"));
																promo.setSubsOffer (rs.getString("SUBS_OFFER"));
																promooffer.add (promo);
												}
												rs.close ();
												pstmt.close ();
								} //try
								catch (Exception e)
								{
												try
												{
																if(rs != null) rs.close ();
																if(pstmt != null) pstmt.close ();
												}catch(SQLException sqle)
												{
																logger.error ("Exception in getPromotionPacks: " + sqle.getMessage ());
												}
												e.printStackTrace ();
												return -1;
								}
								finally{ conPool.free(con); }
								return 1;
				}//getPromotionPack

				public int deletePromoOffer(ArrayList ocAl)
				{
					logger.debug("deletePromoOffer()");
					try
					{
						con = conPool.getConnection();
						query = "delete from CRBT_PROMOTION WHERE PROMO_ID=?";
						pstmt = con.prepareStatement(query);
						Iterator ite1 = ocAl.iterator();
						while (ite1.hasNext())
						{
							//pstmt.setInt (1,(Integer.parseInt(ite1.next())));
							pstmt.setInt (1,Integer.parseInt((String)ite1.next()));
							pstmt.executeUpdate();
						}
						pstmt.close();


					}//try
					catch (Exception e)
					{
						try
						{
							if(pstmt != null) pstmt.close ();
						}catch(SQLException sqle)
						{
							logger.error ("Exception in deletePromoPack(), Exception is : " + sqle.getMessage ());
						}
						e.printStackTrace ();
						return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
				}//deleteoffer

				public int modifyPromotionOffer (PromotionPack promo)
				{
					logger.debug("webadmin: modifyPromotionOffer");
					logger.info(promo.getPackId());
					try
					{
						con = conPool.getConnection();

						//query = "UPDATE CRBT_PROMOTION set START_DATE=to_date(?,'dd-mm-yyyy hh24'), END_DATE=to_date(?,'dd-mm-yyyy hh24') where PROMO_ID=?";
						query = "UPDATE CRBT_PROMOTION set START_DATE=to_date(?,'dd-mm-yyyy'), END_DATE=to_date(?,'dd-mm-yyyy') where PROMO_ID=?";
						pstmt = con.prepareStatement (query);

						pstmt.setString (1, promo.getStartDate());
						pstmt.setString (2, promo.getEndDate());
						pstmt.setInt (3, promo.getPackId());
						logger.info(query);

						pstmt.executeUpdate();
						pstmt.close ();
						con.close();
					}//try
					catch (Exception e)
					{
						try
						{
							if(pstmt != null) pstmt.close ();
							if(rs != null) rs.close ();
						}catch(SQLException sqle)
						{
							logger.error ("webadmin-modifyPromotionOffer: Exception is: " + sqle.getMessage ());
						}

						e.printStackTrace ();
						return -1;
					}
					finally  { conPool.free(con); } 
					return 1; //  added susccessfully

				}//modifyPromotionPack


}//class
