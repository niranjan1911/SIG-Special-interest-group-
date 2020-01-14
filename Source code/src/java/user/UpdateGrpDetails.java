/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import db.Dbconn;
import java.io.IOException;
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
public class UpdateGrpDetails extends HttpServlet {

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
        
            HttpSession session  = request.getSession(true);
        try{
            String gnme = request.getParameter("gnme");
            String gid = request.getParameter("gid");
            String desc = request.getParameter("desc");
 
            //connect db
            Dbconn db  = new Dbconn();
            Connection con = db.connect();
            
            Statement st = con.createStatement();
            
            int rs = st.executeUpdate("update `group_details` set group_name = '"+gnme+"', description = '"+desc+"' where group_id = '"+gid+"' ");
            
            if(rs>0){
                session.setAttribute("alert_message","Group details updated successfully!");
                session.setAttribute("alert_type","success");
                response.sendRedirect("manageGroups.jsp");
            }else{
                session.setAttribute("alert_message","Group details updation failed!");
                session.setAttribute("alert_type","dangegt");
                response.sendRedirect("manageGroups.jsp");
            }
            
        }catch(Exception ex){
            System.out.println("Exception while updating group description! "+ex);
            session.setAttribute("alert_message","Unavoidable error occured! Group details updation failed!");
            session.setAttribute("alert_type","danger");
            response.sendRedirect("manageGroups.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Updates grp details";
    }// </editor-fold>

}
