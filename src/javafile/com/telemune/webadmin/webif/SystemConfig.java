/*
 * This class is used for system app config for the admin web interface for CRBT.
 *  @Jatinder Pal
 *
 *
 */
package com.telemune.webadmin.webif;
import	java.util.*;

public class SystemConfig
{
    private int paramId;
    private String paramTag;
    private String paramValue;
    private String owner;
    private String update;
    private String prevalue;
    private String remarks;
		
   public SystemConfig ()
    {
       paramId = -1;
       paramTag = "0";
       paramValue = "0";
       remarks = "none";
   }
	 
/* ******* set values  ********** */
    public void setParamId (int paramId)
    {
        this.paramId = paramId;
    }
    public void setParamTag (String paramTag)
    {
        this.paramTag = paramTag;
    }
    public void setParamValue (String paramValue)
    {
        this.paramValue = paramValue;
    }
    public void setRemarks (String remarks)
    {
        this.remarks = remarks;
    }
				public void setOwner (String owner)
    {
        this.owner = owner;
    }
				public void setPrevalue (String prevalue)
    {
        this.prevalue = prevalue;
    }
				public void setUpDated (String update)
    {
        this.update = update;
    }
/* ******* get values  ********** */
    public int getParamId ()
    {
        return paramId;
    }
    public String getParamTag ()
    {
        return paramTag;
    }
    public String getParamValue ()
    {
        return paramValue;
    }
    public String getRemarks ()
    {
        return remarks;
    }
				public String getOwner ()
    {
        return owner;
    }
				public String getPrevalue ()
    {
        return prevalue;
    }
				public String getUpDated ()
    {
        return update;
    }
}  // class SystemConfig
