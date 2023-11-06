<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Acme');
        
        body {
            font-family: Acme, sans-serif;
        }

        .main-container {
            margin: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .top-box {
            border: 3px solid #000000;
            padding: 20px;
            width: 80%;
            overflow: hidden;
        }

        .middle-box {
            border: 3px solid #000000;
            padding: 20px;
            width: 80%;
            margin-top: -3px;
            margin-bottom: -3px;
        }
        .bottom-box {
            border: 3px solid #000000;
            padding: 20px;
            width: 80%;
            overflow: hidden;
        }

        .title {
            font-size: 16px;
            text-align: left;
        }

        h1 {
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 10px;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .form-row label {
            width: 40%;
        }

        .form-row select, .form-row input[type="text"], .form-row input[type="number"] {
            width: 55%;
            padding: 5px;
            margin-bottom: 10px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px; 
        }

        .button-container input[type="button"] {
            background-color: transparent;
            color: #000000;
            border: 3px solid #000000;
            padding: 10px 20px;
            cursor: pointer;
            margin: 0 5px;
            box-shadow: 3px 3px 5px #000000;
        }
        
        .button-container input[type="submit"] {
            background-color: transparent;
            color: #000000;
            border: 3px solid #000000;
            padding: 10px 20px;
            cursor: pointer;
            margin: 0 5px;
            box-shadow: 3px 3px 5px #000000;
        }
        
        .form-row input[type="text"],
        .form-row input[type="number"] {
            width: 55%;
            padding: 5px;
            margin-bottom: 10px;
            border: 3px solid #000000;
        }
        
        .form-row select {
            width: 55%;
            padding: 5px;
            margin-bottom: 10px;
            border: 3px solid #000000;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="top-box">
            <h1 class="title">Producto Nuevo</h1>
        </div>
        <div class="middle-box">
            <form id="product-form" action="ProductoServlet" method="post">
                <input type="hidden" name="accion" value="INS"/>
                <div class="form-row">
                    <label for="product">Producto:</label>
                    <input type="text" id="product" name="product" required>
                </div>
                <div class="form-row">
                    <label for="category">Categoría:</label>
                    <select id="category" name="category">
                       <option disabled selected hidden>-Seleccione-</option>
                       <% 
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection cn = DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/examenfinal?serverTimezone=UTC", "root", "root");

                                String sqlCat = "SELECT idCategoria, NomCategoria FROM Categoria ORDER BY NomCategoria";
                                Statement stCat = cn.createStatement();
                                ResultSet rsCat = stCat.executeQuery(sqlCat);
                                while (rsCat.next()) {
                        %>
                        <option value="<%=rsCat.getInt(1)%>"><%=rsCat.getString(2)%></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-row">
                    <label for="subcategory">Subcategoría:</label>
                    <select id="subcategory" name="subcategory">
                        <option disabled selected hidden>-Seleccione-</option>
                        <% 
                            String sqlSub = "SELECT idSubcategoria, NomSubCategoria FROM Subcategoria ORDER BY NomSubCategoria";
                            Statement stSub = cn.createStatement();
                            ResultSet rsSub = stSub.executeQuery(sqlSub);
                            while (rsSub.next()) {
                        %>
                        <option value="<%=rsSub.getInt(1)%>"><%=rsSub.getString(2)%></option>
                        <% }} catch (Exception e) {
                    e.printStackTrace();
                } %>
                    </select>
                </div>
                <div class="form-row">
                    <label for="price">Precio:</label>
                    <input type="number" id="price" name="price" required>
                </div>
                <div class="form-row">
                    <label for="stock">Stock:</label>
                    <input type="number" id="stock" name="stock" required>
                </div>
                <div class="button-container">
                    <input type="submit" value="Enviar Datos"/>
                    <input type="button" value="Cancelar" id="btn-cancelar">
                </div>
            </form>
        </div>
        <div class="bottom-box">
        </div>
        <% if (request.getAttribute("msnError") != null)
            out.print(request.getAttribute("msnError"));
        %>            
    </div>
    <script>
        document.getElementById("btn-cancelar").addEventListener("click", function() {
           window.location.href = "productos.jsp";
        });          
    </script>
</body>
</html>
