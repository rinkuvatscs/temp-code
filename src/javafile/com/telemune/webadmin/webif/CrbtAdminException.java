/*
 * CrbtAdminException.java
 *
 * Created on October 14, 2004, 4:53 PM
 */

package com.telemune.webadmin.webif;
/**
 *
 * @author  jaipal
 */
public class CrbtAdminException extends java.lang.Exception
{
    
    private int exceptionCode = 0;
    /**
     * Constructs an instance of <code>CrbtAdminException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public CrbtAdminException(int exceptionCode, String msg) {
        super(msg);
        this.exceptionCode = exceptionCode;
    }
    
    public int getExceptionCode() {
        return exceptionCode;
    }
}
