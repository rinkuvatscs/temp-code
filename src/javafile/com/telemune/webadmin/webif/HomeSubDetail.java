/* * This class is used for home subscriber management for the admin web interface for CRBT. * * * */
/* @Jatinder Pal */


package com.telemune.webadmin.webif;
import	java.util.*;

public class HomeSubDetail
{
				private int rangeId;   
				private String startAt; 
				private String endsAt;  
				private ArrayList excludeAL; 

				private String hlrName;
				private int hlrId;
				public void HomeSubDetail ()
				{  
								rangeId = 0; 
								startAt = ""; 
								endsAt = "";
								excludeAL = new ArrayList (); 
				}  
        /* set Values */ 
				public void setRangeId (int rangeId)
				{  
								this.rangeId = rangeId;
				}  
				public void setStartAt (String startAt)
				{
								this.startAt = startAt; 
				}
				public void setEndsAt (String endsAt) 
				{ 
								this.endsAt = endsAt;  
				}
				public void setExcludes (ArrayList excludeAL)
				{  
								this.excludeAL = excludeAL; 
				}    
				public void setHLRName (String hlrName)  
				{
								this.hlrName = hlrName;
				}
				public void setHLRId (int hlrId)  
				{
								this.hlrId = hlrId;
				}
				/* get Values */
				public int getRangeId ()
				{
								return rangeId;
				}
				public String getStartAt ()
				{
								return startAt;
				}
				public String getEndsAt ()
				{
								return endsAt;
				}
				public ArrayList getExcludes ()  
				{
								return excludeAL;
				}
				public String getHLRName ()  
				{
								return hlrName;
				}
				public int getHLRId ()  
				{
								return hlrId;
				}
} // class HomeSubDetail
