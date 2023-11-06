package edu.cibertec.examen.servlet;

import edu.cibertec.examen.dto.Usuario;
import edu.cibertec.examen.dao.UsuarioDAO;
import edu.cibertec.examen.dao.impl.UsuarioDAOImpl;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/Productos"})
public class UsuarioServlet extends HttpServlet {
    
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String accion = request.getParameter("accion");
    String result = null;
    String page = "/index.html"; 

    if (accion == null) {
        result = "Solicitud no recibida";

    } else if (accion.equals("LOGIN")) {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        if ((usuario == null) || (usuario.trim().length() == 0)) {
            result = "Usuario Incorrecto";
        }

        if (result == null) {
            if ((password == null) || (password.trim().length() == 0)) {
                result = "Password Incorrecto";
            }
        }

        if (result == null) {
            UsuarioDAO daoUsuarios = new UsuarioDAOImpl();
            Usuario u = daoUsuarios.autentica(usuario, password);

            if (u == null) {
                result = "Usuario no Registrado";
                page = "/datainvalid.jsp";
            } else {
                result = "Logueo Exitoso !!!!";
                page = "/productos.jsp";
            }
        }

    }
    request.setAttribute("msg", result);
    RequestDispatcher rp = getServletContext().getRequestDispatcher(page);
    rp.forward(request, response);

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
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
