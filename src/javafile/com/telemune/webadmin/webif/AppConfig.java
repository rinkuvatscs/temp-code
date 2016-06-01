/*
 * This class is used for system app config for the admin web interface for CRBT.
 *
 *
 *
 */
package com.telemune.webadmin.webif;
import	java.util.*;
public class AppConfig
{
    private int paramId;
    private String paramTag;
    private String paramValue;
    private String remarks;
    public void AppConfig ()
    {
        this.paramId = -1;
        this.paramTag = "0";
        this.paramValue = "0";
        this.remarks = "none";
    }
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

} // AppConfig class
