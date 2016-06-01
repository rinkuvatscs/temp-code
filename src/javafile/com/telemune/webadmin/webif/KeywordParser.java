/*
 * KeywordParser.java
 *
 * Created on October 5, 2004, 11:30 AM
 * Modified on Jan 9, 2006, 1700 hrs
 * @author  Jatinder Pal
 */

package com.telemune.webadmin.webif;

public class KeywordParser {
   
    private String requestKeyword ;
    private String processName;
    private String packageName;
    private String createdBy ;
    private String creationDate;
    private String updatedBy ;
    private String updateDate;
    private int min_argument;
    private int max_argument;
    private String syntax_message;
    private String desc;
				
		private int languageId;
    
    public KeywordParser()
		 {
        requestKeyword = "";
        processName = "";
        packageName = "";
        createdBy = "";
        creationDate = "";
        updatedBy = "";
        updateDate = "";
								languageId  =1;
								min_argument=-1;
								max_argument=-1;
								syntax_message="";
								desc="";
    }
    
   /* **   set values */ 
    public void setRequestKeyword(String requestKeyword)
		 {
        this.requestKeyword = requestKeyword;
     }
    public void setProcessName(String processName)
		 {
        this.processName = processName;
     }
    public void setPackageName(String packageName)
		 {
        this.packageName = packageName;
     }
    public void setCreatedBy(String createdBy)
		 {
        this.createdBy = createdBy;
     }
    public void setCreationDate(String creationDate)
		 {
        this.creationDate = creationDate;
     }
    public void setUpdatedBy(String updatedBy)
		 {
        this.updatedBy = updatedBy;
     }
    public void setUpdateDate(String updateDate)
		 {
        this.updateDate = updateDate;
     }
    public void setLanguageId(int languageId)
		 {
        this.languageId = languageId;
     }
			 public void setMinArgument(int minargument)
		 {
        this.min_argument = minargument;
     }
			 public void setMaxArgument(int maxargument)
		 {
        this.max_argument = maxargument;
     }
			 public void setSyntaxMessage(String syntax)
		 {
        this.syntax_message=syntax;
     }
			 public void setDesc(String desc)
		 {
        this.desc = desc;
     }

		 
		/* ** get values */
		public String getRequestKeyword()
		 {
        return requestKeyword;
     }
    public String getProcessName()
		 {
        return processName;
     }
    public String getPackageName()
		 {
        return packageName;
     }
    public String getCreatedBy()
		 {
        return createdBy;
    }
    public String getCreationDate()
		 {
        return creationDate;
    }
    public String getUpdatedBy()
		 {
        return updatedBy;
    }
    public String getUpdateDate()
		 {
        return updateDate;
    }
    public int getLanguageId()
		 {
        return languageId;
    }
			 public int getMinArgument()
		 {
        return min_argument;
     }
			 public int getMaxArgument()
		 {
        return max_argument;
     }
			 public String getSyntaxMessage()
		 {
        return syntax_message;
     }
			 public String getDesc()
		 {
        return desc;
     }
    
} // class KeywordParser
