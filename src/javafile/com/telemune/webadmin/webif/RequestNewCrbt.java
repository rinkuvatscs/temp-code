//package com.telemune.crbtcallcenter.webif;
package com.telemune.webadmin.webif;
import com.telemune.dbutilities.*;
import java.text.DateFormat;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.*;
 import org.apache.log4j.*;
public class RequestNewCrbt
{
    private static Logger logger=Logger.getLogger(RequestNewCrbt.class);
    private Connection con = null;
    private ConnectionPool conpool = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private String query=null;
 private String msisdn="";
    private String rbt="";
    private String rbtart="";
    private String rbtalb="";
    private String reqdate="";

    public RequestNewCrbt()
    {
   //     conpool = new ConnectionPool();
    }

   /*  public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

*/
    public RequestNewCrbt(Connection con)
    {
        setConnection(con);
    }

    public ConnectionPool getConnectionPool()
    {
        return conpool;
    }

    public void setConnectionPool(ConnectionPool conpool)
    {
        this.conpool = conpool;
    }
    public Connection getConnection()
    {
        return con;
    }

    public void setConnection(Connection con)
    {
        this.con = con;
    }

 public void setMsisdn(String msisdn)
    {
        this.msisdn=msisdn;
    }
    public void setRbtName(String rbt)
    {
        this.rbt=rbt;
    }
    public void setRbtArt(String rbtart)
    {
        this.rbtart=rbtart;
    }
    public void setRbtAlb(String rbtalb)
    {
        this.rbtalb=rbtalb;
    }
    public void setReqdate(String reqdate)
    {
        this.reqdate=reqdate;
    }

    public String getMsisdn()
    {
       return this.msisdn;
    }
    public String getRbtName()
    {
       return this.rbt;
    }
    public String getRbtArt()
    {
       return this.rbtart;
    }
    public String getRbtAlb()
    {
       return this.rbtalb;
    }
    public String getReqdate()
    {
       return this.reqdate;
    }



    public int addRequest(String Msisdn,String rbt_name,String rbt_artist,String rbt_album)
    {
        long reqid=0;
        String msisdn= TSSJavaUtil.instance().getInternationalNumber(Msisdn);
        con=conpool.getConnection();
        if (con == null)
        {
            logger.debug("CON NULL");
            return 0;
        }
        try
        {
            query = "select REQUEST_CRBT_SEQ.nextval from dual";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                reqid = rs.getLong("NEXTVAL");
            }
            rs.close();
            pstmt.close();

           query = "insert into REQUEST_NEW_CRBT (MSISDN, REQ_ID, RBT_NAME, RBT_ARTIST, RBT_ALBUM, REQ_DATE) values (?, ?, ?, ?, ?, sysdate)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1,msisdn);
            pstmt.setLong(2,reqid);
            pstmt.setString(3,rbt_name);
            pstmt.setString(4,rbt_artist);
            pstmt.setString(5,rbt_album);
            pstmt.executeUpdate();

            rs.close();
            pstmt.close();
        }
 catch (Exception e)
        {
        try{
               if(rs !=null) rs.close();
            if(pstmt !=null) pstmt.close();
        }catch(Exception exp){}
            e.printStackTrace();
            return -1;
        }
        finally
        {
            conpool.free(con);
        }
        return 1;
  }//addRequest

 public int viewRequest(ArrayList viewList)
 {
     con=conpool.getConnection();
     if (con == null)
     {
         logger.debug("CON NULL");
         return 0;
     }
     try
     {
         query = "select MSISDN, REQ_ID, RBT_NAME, RBT_ARTIST, RBT_ALBUM, REQ_DATE from Request_New_Crbt";
         pstmt = con.prepareStatement(query);
         rs = pstmt.executeQuery();
         while(rs.next())
         {
             RequestNewCrbt rnc = new RequestNewCrbt();
              rnc.setMsisdn(rs.getString("MSISDN"));
              rnc.setRbtName(rs.getString("RBT_NAME"));
              rnc.setRbtArt(rs.getString("RBT_ARTIST"));
              rnc.setRbtAlb(rs.getString("RBT_ALBUM"));
              rnc.setReqdate(rs.getString("REQ_DATE"));
              viewList.add(rnc);
         }
         rs.close();
         pstmt.close();
     }
     catch (Exception e)
     {
         e.printStackTrace();
         return -1;
     }
     finally
     {
         conpool.free(con);
     }
     return 1;
 }//viewRequest
 

}//class

