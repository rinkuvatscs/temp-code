/* * Maintains every user's session history * * * */
package com.telemune.webadmin.webif;

import com.telemune.dbutilities.*;
import java.util.*;
import java.sql.SQLException;
import java.sql.ResultSet;

public class SessionHistory_WSMS
{
  private String userId;
  private Connection con;
  private ArrayList links = null;

  public SessionHistory_WSMS ()
  {
    this.userId = "0";
  }

  public void setUser (String user)
  {
    this.userId = user;
  }

  public String getUser ()
  {
    return userId;
  }
  public void setConnection (Connection con)
  {
    this.con = con;
  }
  public Connection getConnection ()
  {
    return con;
  }

  public boolean isAllowed (int linkId)
  {
    return links.contains (new Integer (linkId));
  }

  public void getLinks (int userType)
  {
    links = new ArrayList ();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try
    {
      String query = "select LINK_ID from HTTP_ACCESS where ROLE_ID = ?";
      pstmt = con.prepareStatement (query);
      pstmt.setInt (1, userType);
      rs = pstmt.executeQuery ();
      while (rs.next ())

	{
	  links.add (new Integer (rs.getInt ("LINK_ID")));
	}
      rs.close ();
      pstmt.close ();
    }
    catch (Exception exp)
    {
      exp.printStackTrace ();
    }
  }
}
