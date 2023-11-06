package edu.cibertec.examen.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class SqlConecta {

    public Connection connection() {
        Connection cn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/examenfinal?serverTimezone=UTC", "root", "root");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cn;
    }

}
