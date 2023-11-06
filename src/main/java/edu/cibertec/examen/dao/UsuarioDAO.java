package edu.cibertec.examen.dao;

import edu.cibertec.examen.dto.Usuario;

public interface UsuarioDAO {
    
    public Usuario autentica(String usuario, String password);
    
}
