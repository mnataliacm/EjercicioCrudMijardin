<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%-- 
    Author     : Natalia Castillo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lista Plantas</title>
    <link rel="shortcut icon" href="./imagenes/iconoflor.png" type="image/x-icon">
    <!-- CSS bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
      crossorigin="anonymous">
    <!-- ICONOS bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- CSS mio -->
    <link rel="stylesheet" href="./estilo/style.css">
    <!-- javascript para reutilizar navbar -->
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  </head>
  <body class="bg-malaga">
    <div id="wraper" class="container-flex">

      <!--Barra navegacion-->
      <div id="nav-placeholder"></div>

      <%
         Class.forName("com.mysql.jdbc.Driver");
              Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/mijardin","root", "");        
              Statement n = conexion.createStatement();
              Statement j = conexion.createStatement();
        
              String b = (String) request.getParameter("buscar");
              String busca = b.toUpperCase().charAt(0) + b.substring(1, b.length()).toLowerCase();
        
              ResultSet busqueda = n.executeQuery("SELECT p.codpla, p.nombre, p.cientifico, f.familia, info "
                      + " FROM planta p "
                      + " INNER JOIN familia f ON f.codfam = p.familia"
                      + " WHERE nombre LIKE ('" + busca + "%')");
      %>
      <!-- busqueda de plantas -->
      <div class="container text-center mt-4">
        <div class=" panel">
          <h2 class="panel-heading text-center bg-verde">BASE DE DATOS DE PLANTAS</h2>       
        </div>  
        <table class="table table-striped table-verde">
          <tr class="table-dark">
            <th></th><th>Nº</th><th>Nombre</th><th>Cientifico</th><th>Familia</th><th>Datos de interés</th> 
          </tr>             

          <%              
        while (busqueda.next()) {
              out.println("<tr><td>");
              out.println("<td>" + busqueda.getString("codpla") + "</td>");
              out.println("<td>" + busqueda.getString("nombre") + "</td>");
              out.println("<td>" + busqueda.getString("cientifico") + "</td>");
              out.println("<td>" + busqueda.getString("familia") + "</td>");
              out.println("<td>" + busqueda.getString("info") + "</td>");
            }         
          %>
        </table>
      </div>
    </div> <!-- cierre container lista -->
    </div> <!-- fin wraper -->

<!-- JS bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>  
<!-- JS mio -->
<script src="./js/javascript.js"></script>  
</body>
</html>
    
