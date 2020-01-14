/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import db.Dbconn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author manas
 */
public class mkMod extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        HttpSession session = request.getSession(true);
        
        try{
            String sigid = request.getParameter("sigid");
            String uid = request.getParameter("uid");
            
            if(sigid != null && uid != null){
                //connct db
                Dbconn db = new Dbconn();
                Connection con = db.connect();
                
                Statement st = con.createStatement();
                
                int rs = st.executeUpdate("update `group_members` set designation='moderator' where group_id = '"+sigid+"' && user_id = '"+uid+"' ");
                
                if(rs>0){
                    session.setAttribute("alert_message", "User is promoted to moderator");
                    session.setAttribute("alert_type","success");
                    response.sendRedirect("manageUsers.jsp");
                }else{
                    session.setAttribute("alert_message", "Cant promote user to moderator");
                    session.setAttribute("alert_type","danger");
                    response.sendRedirect("manageUsers.jsp");
                }
                
            }else{
                session.setAttribute("alert_message", "Something went wrong");
                session.setAttribute("alert_type","danger");
                response.sendRedirect("manageUsers.jsp");
            }
            
            
        }catch(Exception ex){
            System.out.println("Exception while making someone moderator! "+ex);
            session.setAttribute("alert_message", "Exception on mkmod!");
            session.setAttribute("alert_type","danger");
            response.sendRedirect("manageUsers.jsp");
        }
        
    }


    @Override
    public String getServletInfo() {
        return "Makes someone a moderator od a group";
    }// </editor-fold>

}
