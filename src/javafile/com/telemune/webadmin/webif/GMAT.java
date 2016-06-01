/*
 * This class is used for GMAT config .
 *
 *@Jatinder Pal
 * 
 */
package com.telemune.webadmin.webif;

public class GMAT
{
	private String processName;
	private String helpMessage;
	private int language;

 public GMAT()
 {
				 processName="";
				 helpMessage="";
				 language=-1;
				 
 }

 /* set Values */

  public void setName(String processName)
	{
					this.processName=processName;
	}
  public void setMessage(String helpMessage)
	{
					this.helpMessage=helpMessage;
	}
  public void setLanguage(int language)
	{
					this.language=language;
	}

	
 /* get Values */

 public String getName()
 {
				 return processName;
 }
 public String getMessage()
 {
				 return helpMessage;
 }
 public int getLanguage()
 {
				 return language;
 }


} //class GMAT
 
 
	
