package com.telemune.webadmin.webif;
import java.util.*;
public class PromotionPack
{

				private String packname;
				private String chgrule;
				private long  packcost;
				private int   packsize;
				private int   freerbt;
				private int packId;
				private int promoId;
				private int chgcode;
				private String subsOffer;
				private String startDate;
				private String endDate;
			

								public void PromotionPack()
								{
												packname = "";
												chgrule="";
												packcost = 0;
												packsize=0;
												freerbt=0;
												packId=0;
												promoId=0;
												chgcode=0;
												subsOffer="N";
												startDate="";
												endDate="";
									}

				/* set Values */	
				public void setPackName (String packname)
				{
								this.packname = packname.trim().toUpperCase();
				}
				public void setChgRule (String chgrule)
				{
								this.chgrule = chgrule.trim().toUpperCase();
				}
				public void setPackCost (long packcost)
				{
								this.packcost= packcost;
				}
				public void setPackSize (int packsize)
				{
								this.packsize = packsize;
								}
				public void setFreeRbt(int freerbt)
				{
								this.freerbt= freerbt;
				}
				public void setPackId(int packId)
				{
								this.packId = packId;
				}
				
				public void setPromoId(int promoId)
				{
								this.promoId = promoId;
				}
				public void setChgCode (int chgcode)
				{
								this.chgcode = chgcode;
								}
				public void setSubsOffer(String subsOffer)
				{
								this.subsOffer = subsOffer.trim().toUpperCase();
				}
				
				public void setStartDate(String startDate)
				{
								this.startDate = startDate.trim();
				}
				public void setEndDate(String endDate)
				{
								this.endDate = endDate.trim();
				}

				/* get Values */	


				public String getPackName ()
				{
								return this.packname.toUpperCase();
				}

				public String getChgRule ()
				{
								return this.chgrule.toUpperCase();
				}
				public int getPackSize ()
				{
								return this.packsize;
				}
				public long getPackCost()
				{
								return this.packcost;
				}

				public int getFreeRbt()
				{
								return this.freerbt;
				}

				public int getPackId()
				{
								return this.packId;
				}
				
				public int getPromoId()
				{
								return this.promoId;
				}
				public int getChgCode()
				{
								return this.chgcode;
				}
				public String getSubsOffer ()
				{
								return this.subsOffer;
				}
				public String getStartDate ()
				{
				  return this.startDate;
					}
				public String getEndDate ()
				{
				  return this.endDate;
					}
}
