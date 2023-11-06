/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package edu.cibertec.examen.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
public class ProductoServlet extends HttpServlet {


protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String accion = request.getParameter("accion");
    
    if (accion.equals("INS")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/examenfinal?serverTimezone=UTC", "root", "root");

            StringBuilder sql = new StringBuilder("INSERT INTO Producto(");
            sql.append("idSubcategoria, Nombre, PrecioUnitario, Stock) ");
            sql.append("values(?,?,?,?)");

            PreparedStatement ps = cn.prepareStatement(sql.toString());
            ps.setInt(1, Integer.parseInt(request.getParameter("subcategory")));
            ps.setString(2, request.getParameter("product"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setInt(4, Integer.parseInt(request.getParameter("stock")));

            boolean graboOk = false;
            int ctos = ps.executeUpdate();
            if (ctos > 0) {
                graboOk = true;
            }

            if (graboOk) {
                response.sendRedirect("productos.jsp");
            } else {
                request.setAttribute("msnError", "No se pudo grabar ... ver el log!");
                RequestDispatcher view = request.getRequestDispatcher("addproductos.jsp");
                view.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msnError", "No se pudo grabar ... ver el log!");
            RequestDispatcher view = request.getRequestDispatcher("addproductos.jsp");
            view.forward(request, response);
        }
    } else if (accion.equals("Eliminar")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/examenfinal?serverTimezone=UTC", "root", "root");
            String ids = request.getParameter("id");
            String sql = "DELETE FROM Producto WHERE idProducto in (" + ids + ")";
            Statement st = cn.createStatement();
            st.executeUpdate(sql);

            cn.close();
            response.sendRedirect("productos.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productos.jsp");
        }
    } else if (accion.equals("Actualizar")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/examenfinal?serverTimezone=UTC", "root", "root");

            StringBuilder sql = new StringBuilder("UPDATE Producto ");
            sql.append("SET idSubcategoria=?, Nombre=?, PrecioUnitario=?, Stock=?");
            sql.append(" where idProducto=?");

            PreparedStatement ps = cn.prepareStatement(sql.toString());
            ps.setInt(1, Integer.parseInt(request.getParameter("subcategory")));
            ps.setString(2, request.getParameter("product"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setInt(4, Integer.parseInt(request.getParameter("stock")));
            ps.setInt(5, Integer.parseInt(request.getParameter("id")));

            boolean graboOk = false;
            int ctos = ps.executeUpdate();
            if (ctos > 0) {
                graboOk = true;
            }

            if (graboOk) {
                response.sendRedirect("productos.jsp");
            } else {
                request.setAttribute("msnError", "No se pudo grabar ... ver el log!");
                RequestDispatcher view = request.getRequestDispatcher("productosmod.jsp");
                view.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msnError", "No se pudo grabar ... ver el log!");
            RequestDispatcher view = request.getRequestDispatcher("productosmod.jsp");
            view.forward(request, response);
        }
    }
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
