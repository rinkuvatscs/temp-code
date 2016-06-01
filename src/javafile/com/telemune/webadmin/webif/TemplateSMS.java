/*
 * TemplateSMS.java
 *
 * Created on October 8, 2004, 5:29 PM
 */

package com.telemune.webadmin.webif;

/**
 *
 * @author  jaipal
 */
public class TemplateSMS implements java.io.Serializable
 {
    
    private long templateId ;
    private String templateDescription = null;
    private String templateType;
    private String templateMessage = null;
    private String tokensAllowed = null;
		private int language;
    
   /** Creates a new instance of TemplateSMS */
    public TemplateSMS()
		 {
        templateId = 0;
        templateDescription = "";
        templateType ="";
        templateMessage = "";
        tokensAllowed = "";
				language=1;
    }
    
    
    public void setTemplateId(long templateId)
		 {
        this.templateId = templateId;
    }

    
    public void setTemplateDescription(String templateDescription)
		 {
        this.templateDescription = templateDescription;
    }
    
    
    public void setTemplateType(String templateType)
		 {
        this.templateType = templateType;
    }
    
    
    public void setTemplateMessage(String templateMessage)
		 {
        this.templateMessage = templateMessage;
    }
    
    public void setTokensAllowed(String tokensAllowed)
		 {
        this.tokensAllowed = tokensAllowed;
    }
   public void setLanguage(int language)
	 {
					 this.language=language;
	 }
/*   **** get values ******            */
    public long  getTemplateId()
		 {
        return templateId;
    }
    public String getTemplateDescription()
		 {
        return templateDescription;
    }
    public String getTemplateType()
		 {
        return templateType;
    }
    public String getTemplateMessage()
		 {
        return templateMessage;
    }
    public String getTokensAllowed()
		 {
        return tokensAllowed;
    }
	 public int getLanguage()
	 {
					 return language;
	 }

} //class TemplateSMS
