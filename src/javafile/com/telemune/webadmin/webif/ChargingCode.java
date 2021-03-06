package com.telemune.webadmin.webif;
import java.util.*;
public class ChargingCode
{

				private String desc;
				private long  amount;
				private double  amtP;
				private double  amtO;
				private long  chgCode;

				private String colName;
				private int planId;
				private int rbtFree;
				private String rbtChgCode;
				private String rbtGiftChgCode;
				private String rbtMonoChgCode;
				private String rbtNoChgCode;
				private String rbtNormalChgCode;
				private String subChgCode;
				private String rbtRecChgCode;
				private int validity;
				private String remarks;
				private String subTag;
				private String unsubTag;
				private String fileExt;

								public void ChargingCode ()
								{
												desc = "";
												amount = 0;
												amtP = 0.0;
												amtO = 0.0;
												chgCode=0;

												colName="";
												planId=0;
												rbtFree=0;
												rbtChgCode="";
												rbtGiftChgCode="";
												rbtMonoChgCode="";
												rbtNoChgCode="";
												rbtNormalChgCode="";
												subChgCode="";
												rbtRecChgCode="";
												validity=0;
												remarks="";
												subTag="S";
												unsubTag="U";
												fileExt="cdr";

								}

				/* set Values */	
				public void setDesc (String desc)
				{
								this.desc = desc.trim().toUpperCase();
				}
				public void setColName (String colName)
				{
								this.colName= colName.trim();
				}
				public void setAmount (long amt)
				{
								this.amount = amt;
				}
				public void setAmountP (double amt)
				{
								this.amtP = amt;
				}
				public void setAmountO (double amt)
				{
								this.amtO = amt;
				}
				public void setChgCode(long chgCode)
				{
								this.chgCode= chgCode;
				}


				public void setPlanId(int planId)
				{
								this.planId = planId;
				}
				public void setRbtFree(int rbtFree)
				{
								this.rbtFree = rbtFree;
				}
				public void setRbtChgCode(String rbtChgCode)
				{
								this.rbtChgCode = rbtChgCode;
				}
				public void setRbtGiftChgCode(String rbtGiftChgCode)
				{
								this.rbtGiftChgCode = rbtGiftChgCode;
				}
				public void setRbtMonoChgCode(String rbtMonoChgCode)				{
								this.rbtMonoChgCode = rbtMonoChgCode;
				}
				public void setRbtNoChgCode(String rbtNoChgCode)
				{
								this.rbtNoChgCode = rbtNoChgCode;
				}
				public void setRbtNormalChgCode(String rbtNormalChgCode)
				{
								this.rbtNormalChgCode = rbtNormalChgCode;
				}

				public void setSubChgCode(String subChgCode)
				{
								this.subChgCode = subChgCode;
				}

				public void setRbtRecChgCode(String rbtRecChgCode)
				{
								this.rbtRecChgCode = rbtRecChgCode;
				}
				public void setValidity(int validity)
				{
								this.validity= validity;
				}
				public void setRemarks(String remarks)
				{
								this.remarks= remarks;
				}

				/* get Values */	


				public String getDesc ()
				{
								return this.desc.toUpperCase();
				}

				public String getColName ()
				{
								return this.colName;
				}
				public long getAmount ()
				{
								return this.amount;
				}

				public double getAmountP ()
				{
								return this.amtP;
				}
				public double getAmountO ()
				{
								return this.amtO;
				}
				public long getChgCode()
				{
								return this.chgCode;
				}

				public int getPlanId()
				{
								return this.planId;
				}
				public int getRbtFree()
				{
								return this.rbtFree;
				}
				public String getRbtChgCode()
				{
								return this.rbtChgCode;
				}
				public String getRbtGiftChgCode()
				{
								return 		 this.rbtGiftChgCode;
				}
				public String getRbtMonoChgCode()
				{
								return  this.rbtMonoChgCode;
				}
				public String getRbtNoChgCode()
				{
								return 	 this.rbtNoChgCode;
				}
				public String getRbtNormalChgCode()
				{
								return 	 this.rbtNormalChgCode;
				}
				public String getSubChgCode()
				{
								return this.subChgCode;
				}

				public String getRbtRecChgCode()
				{
								return 	 this.rbtRecChgCode;
				}
				public int getValidity()
				{
								return  this.validity;
				}
				public String getRemarks()
				{
								return 	 this.remarks;
				}
				public String getSubTag()
				{
								return 	 this.subTag;
				}
				public String getUnsubTag()
				{
								return 	 this.unsubTag;
				}
				public String getFileExt()
				{
								return 	 this.fileExt;
				}
}
