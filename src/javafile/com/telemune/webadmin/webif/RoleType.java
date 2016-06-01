
// modified on Jan 11, 2006
// @ Jatinder Pal
package com.telemune.webadmin.webif;

public class RoleType
{

    private String roleName;
    private String roleDesc;
    private int roleId;
    private String linkDesc;
    private int linkId;
		
    public  RoleType ()
    {
        roleName = "";
				roleDesc =" ";
        roleId = -1;
				linkDesc =" ";
        linkId = -1;
    }
    
    public void setRoleName (String roleName)
    {
        this.roleName = roleName;
    }
    public void setRoleDesc (String roleDesc)
    {
        this.roleDesc = roleDesc;
    }
    public void setRoleId (int roleId)
    {
        this.roleId = roleId;
    }
    public void setLinkDesc (String linkDesc)
    {
        this.linkDesc = linkDesc;
    }
    public void setLinkId (int linkId)
    {
        this.linkId = linkId;
    }
		
   /* ****   get Values  */ 
    public String getRoleName ()
    {
        return roleName;
    }
    public String getRoleDesc ()
    {
        return roleDesc;
    }
public int getRoleId()
    {
        return roleId;
    }
    public String getLinkDesc ()
    {
        return linkDesc;
    }
public int getLinkId()
    {
        return linkId;
    }

}// class RoleType
