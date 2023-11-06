package edu.cibertec.examen.dao.impl;

import edu.cibertec.examen.dao.SqlConecta;
import edu.cibertec.examen.dto.Usuario;
import edu.cibertec.examen.dao.UsuarioDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAOImpl implements UsuarioDAO {

    @Override
    public Usuario autentica(String usuario, String password) {
        
        StringBuilder s = new StringBuilder("SELECT idusuario, usuario, password ");
        s.append("FROM usuarios ");
        s.append("WHERE (usuario = ?) ");
        s.append("AND (AES_DECRYPT(password, 'cibertec') = ?)");
        Usuario u = null;

        try(Connection cn = new SqlConecta().connection();
            PreparedStatement ps = cn.prepareStatement(s.toString())) {
            
            ps.setString(1, usuario);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setIdusuario(rs.getInt(1));
                u.setUsuario(rs.getString(2));
            }
            cn.close();

        } catch (Exception ex) { ex.printStackTrace(); }

        return u;
    }
   
}
