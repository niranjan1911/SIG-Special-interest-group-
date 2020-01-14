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
public class DelElement extends HttpServlet {

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
        
        try{
            HttpSession session = request.getSession(true);
            String type = request.getParameter("type");
            String id = request.getParameter("id");
            
            Dbconn db = new Dbconn();
            Connection con = db.connect();
            
            Statement st = con.createStatement();
            
            String query = null;
            String page = null;
            
            if(type.equals("post")){
                //delete post
                query = "delete from `post` where post_id = '"+id+"' ";
                page = "Post";
            }else{
                //delete question
                query = "delete from `questions` where question_id = '"+id+"' ";
                page = "Question";
            }
            
            int rs = st.executeUpdate(query);
            
            if(rs > 0){
                session.setAttribute("alert_type","success");
                session.setAttribute("alert_message", page+" deleted successfully!");
                response.sendRedirect("groupContent"+page+"s.jsp");
            }else{
                
            }
            
        }catch(Exception ex){
            System.out.println("Exceprion while deleting element "+ex);
        }
        
        
    }

    @Override
    public String getServletInfo() {
        return "Deletes a post or questiuon from a group";
    }// </editor-fold>

}
