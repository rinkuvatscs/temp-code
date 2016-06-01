/* * This class is used for Admin user info for the admin web interface .   */
/* @Jatinder */
package com.telemune.webadmin.webif;
import	java.util.*;
public class Occasion 
	{
	    private	String occasionName;
	    private	String occasionDate;
	    private	String description;
			private String isconst;
																								
	    public void Occasion ()
	    {
	        occasionName = "";
	        occasionDate = "";
	        description = "";
					isconst="";
	    }
	    public void setOccasionName (String ocName)
	    {
	        this.occasionName = ocName.trim();
	    }
	    public void setOccasionDate (String ocDate)
	    {
			 this.occasionDate = ocDate.trim();
			 }
	    public void setDescription (String desc)
	    {
	        this.description = desc;
	    }
	    public void setIsConstant (String cons)
	    {
	        this.isconst = cons;
	    }


	    

/* *********    get Values         ******  */
	    public String getOccasionName ()
	    {
	        return occasionName;
	    }
	    public String getOccasionDate ()
	    {
	        return occasionDate;
	    }
	    public String getDescription ()
	    {
	        return description;
	    }
	    public String getIsConstant ()
	    {
	        return isconst;
	    }
	   
 } // class
