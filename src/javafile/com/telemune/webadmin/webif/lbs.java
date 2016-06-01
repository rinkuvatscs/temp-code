/*
 * This class is used for LBS config .
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class lbs
{
	private String processName;
	private String packageName;
	private int minArg;
	private int maxArg;
	private String createdBy;
	private String creationDate;
	private String updatedBy;
	private String syntax;
	private String updatedDate;
	private int processId;


	public lbs()
	{
					
	}

	public void setProcessName(String processName)
	{
		this.processName = processName;
	}

	public void setPackageName (String packageName)
	{
		this.packageName = packageName;
	}

	public void setMinArg(int minArg)
	{
		this.minArg = minArg;
	}

	public void setMaxArg (int maxArg)
	{
		this.maxArg = maxArg;
	}

	public void setCreatedBy (String createdBy)
	{
		this.createdBy = createdBy;
	}

	public void setCreationDate (String creationDate)
	{
		this.creationDate = creationDate;
	}

	public void setUpdatedBy (String updatedBy)
	{
		this.updatedBy = updatedBy;
	}

	public void setSyntax (String syntax)
	{
		this.syntax = syntax;
	}

	public void  setUpdateDate (String UpdateDate)
	{
		this.updatedDate = updatedDate;
	}
	public void setProcessId(int processId)
	{
		this.processId = processId;
	}


 /* *******get Values******** */
 
	public String getProcessName()
	{
		return processName;
	}

	public String getPackageName()
	{
		return packageName;
	}

	public int getMinArg ()
	{
		return minArg;
	}
	public int getMaxArg ()
	{
		return maxArg;
	}

	public String getCreatedBy()
	{
		return createdBy;
	}

	public String getCreationDate()
	{
		return creationDate;
	}

	public String getUpdatedBy ()
	{
		return updatedBy;
	}
	public String getSyntax ()
	{
		return syntax;
	}
	public String getUpdatedDate()
	{
		return updatedDate;
	}

	public int getProcessId ()
	{
		return processId;
	}

} // lbs
