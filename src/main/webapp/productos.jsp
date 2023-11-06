<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario de Productos</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        
        .separator {
            border-bottom: 3px solid black;
            width: 100%;
        }

        .bottom-box {
            border: 3px solid #000000;
            padding: 20px;
            width: 80%;
            overflow: hidden;
        }

        .title {
            font-size: 15px;
            margin: 0;
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
        }

        .form-row select,
        .form-row input[type="text"] {
            padding: 5px;
            margin-bottom: 10px;
        }

        .button-container {
            display: flex;
            justify-content: flex-end;
        }

        input[type="button"] {
            background-color: transparent;
            color: #000000;
            border: 3px solid #000000;
            padding: 10px 20px;
            cursor: pointer;
            margin-left: 10px;
            box-shadow: 3px 3px 5px #000000;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
            border-top: 2px solid #000000;
            border-bottom: 2px solid #000000;
        }
        
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:nth-child(odd) {
            background-color: #ffffff; 
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-right: 2px solid #000000;
            border-left: 2px solid #000000;
        }
        th{
            background-color: gray;
        }
        td.center-row {
            text-align: center;
        }
        select {
            border: 3px solid black;
        }

        select option[disabled] {
            color: gray; 
        }
        
        input[type="text"] {
            padding-right: 3px;
        }
        input#producto {
            border: 3px solid #000;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="top-box">
            <h2 class="title">Productos</h2>
        </div>
        <div class="middle-box">
            <form id="search-form" method="post">
                <div class="form-row">
                    <label for="categoria">Categoría:</label>
                    <select id="categoria" name="categoria">
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
                    <label for="subcategoria">Subcategoría:</label>
                    <select id="subcategoria" name="subcategoria">
                    <option disabled selected hidden>-Seleccione-</option>
                        <% 
                            String sqlSub = "SELECT idSubcategoria, NomSubCategoria FROM Subcategoria ORDER BY NomSubCategoria";
                            Statement stSub = cn.createStatement();
                            ResultSet rsSub = stSub.executeQuery(sqlSub);
                            while (rsSub.next()) {
                        %>
                        <option value="<%=rsSub.getInt(1)%>"><%=rsSub.getString(2)%></option>
                        <% } %>
                    </select>
                    <label for="producto">Producto:</label>
                    <input type="text" id="producto" name="producto">
                </div>
                <div class="button-container">
                    <input type="button" value="Buscar" id="btn-buscar">
                    <input type="button" value="Nuevo" id="btn-nuevo">
                </div>
                <div id="resultados"></div>
            </form>
            <br>            
            <div class="separator"></div>
            <table>
                <tr>
                    <th>Id Producto</th>
                    <th>Producto</th>
                    <th>Categoría</th>
                    <th>Subcategoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                </tr>
                <%
                    StringBuilder sqlProd = new StringBuilder("SELECT ");
                    sqlProd.append("Producto.idProducto, Producto.Nombre, Categoria.NomCategoria, Subcategoria.NomSubCategoria, Producto.PrecioUnitario, Producto.Stock ");
                    sqlProd.append("FROM Producto ");
                    sqlProd.append("INNER JOIN Subcategoria ON Producto.idSubcategoria = Subcategoria.idSubcategoria ");
                    sqlProd.append("INNER JOIN Categoria ON Subcategoria.idCategoria = Categoria.idCategoria ");
                    sqlProd.append("ORDER BY NomCategoria, NomSubCategoria, Nombre");

                    Statement stProd = cn.createStatement();
                    ResultSet rsProd = stProd.executeQuery(sqlProd.toString());

                    while (rsProd.next()) {
                %>
                <tr>
                    <td class="center-row"><a href="productosmod.jsp?id=<%=rsProd.getInt(1)%>"><%=rsProd.getInt(1)%></a></td>
                    <td><%=rsProd.getString(2)%></td>
                    <td><%=rsProd.getString(3)%></td>
                    <td><%=rsProd.getString(4)%></td>
                    <td><%=rsProd.getDouble(5)%></td>
                    <td><%=rsProd.getInt(6)%></td>
                </tr>
                <%
                    }

                    rsProd.close();
                    stProd.close();
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </table>
        </div>
        <div class="bottom-box">
        </div>
    </div>
    <script>
        $(document).ready(function() {
            $('#btn-buscar').click(function(e) {
                e.preventDefault();
                var categoria = $('#categoria option:selected').text();
                var subcategoria = $('#subcategoria option:selected').text();
                var producto = $('#producto').val().toLowerCase();

                $('table tr:gt(0)').each(function() {
                    var row = $(this);
                    var categoriaColumn = row.find('td:eq(2)').text(); 
                    var subcategoriaColumn = row.find('td:eq(3)').text();
                    var productoColumn = row.find('td:eq(1)').text().toLowerCase();

                    if ((categoria === 'Todas' || categoriaColumn === categoria) &&
                        (subcategoria === 'Todas' || subcategoriaColumn === subcategoria) &&
                        (productoColumn.includes(producto))) {
                        row.show();
                    } else {
                        row.hide();
                    }
                });
            });
        });
        
        document.getElementById("btn-nuevo").addEventListener("click", function() {
           window.location.href = "addproductos.jsp";
        });
    </script>
</body>
</html>