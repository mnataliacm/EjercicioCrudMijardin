<%--buscador.jsp--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%-- 
    Document   : buscador
    Author     : Natalia Castillo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Mi Jardin - Base de datos</title>
    <link rel="shortcut icon" href="./imagenes/iconoflor.png" type="image/x-icon">
    <!-- CSS bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
      crossorigin="anonymous">
    <!-- ICONOS font-awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- CSS materialize 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
    -->
    <!-- ICONOS materialize
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    -->
    <!-- CSS mio -->
    <link rel="stylesheet" href="./estilo/style.css">
  </head>
  <body class="bg-success">
    <div id="wraper" class="container-flex">

      <!-- barra de navegación -->
      <nav class="navbar navbar-expand-md navbar-light bg-warning sticky-top mb-3">
        <div class="container-fluid fs-5">
          <a class="navbar-brand" href="index.jsp"><i
              class="fa fa-tree" aria-hidden="true"></i></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                  data-bs-target="#navbarSupportedContent"
                  aria-controls="navbarSupportedContent" aria-expanded="false"
                  aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>

              <li class="nav-item"><a class="nav-link" href="formularioAcceso.jsp">Acceder</a>
              </li>
              <li class="nav-item"><a class="nav-link"
                                      aria-current="page" href="formularioRegistro.jsp">Registro</a></li>
              <li class="nav-item"><a class="nav-link" href="tuJardin.jsp">Mi
                  Jardin</a></li>
              <li class="nav-item"><a class="nav-link active" href="buscador.jsp">Buscar
                  Plantas</a></li>        
            </ul>
          </div>
        </div> 
      </nav>  

      <%-- enlace con la base de datos --%>
      <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/mijardin","root", "");
        Statement s = conexion.createStatement();
              
        ResultSet listado = s.executeQuery("SELECT * FROM planta ORDER BY plantaID");            
      %> 

      <!-- listado de plantas     table-responsive-stack table  table-success table-striped -->
      <div class="container">
        <div class=" panel panel-light">
          <h2 class="panel-heading text-center bg-verde">BASE DE DATOS DE PLANTAS</h2> 
          <table class="table table-striped table-verde">  
            <form method="post" action="grabarPlanta.jsp">
              <tr class="table-warning"><td><input type="text" name="plantaID" size="5" requiered></td>
                <td><input type="text" name="familia" size="30" required></td>
                <td><input type="text" name="nombre" size="30" required></td>
                <td><input type="text" name="cientifico" size="30"required></td>
                <td><button type="submit" value="Añadir" class="btn btn-primary"><span class="bi bi-plus-circle"></span>Añadir </button></td></tr>

              <tr class="table-dark"><th>Nº de planta</th><th>Familia</th><th>Nombre</th><th>Cientifico</th></tr>
            </form>

            <%
              while (listado.next()) {
                out.println("<tr><td>");
                out.println(listado.getString("plantaID") + "</td>");
                out.println("<td>" + listado.getString("familia") + "</td>");
                out.println("<td>" + listado.getString("nombre") + "</td>");
                out.println("<td>" + listado.getString("cientifico") + "</td>");
            %>
            <!-- modificar -->
            <td>
              <form method="post" action="modificarPlanta.jsp">
                <input type="hidden" name="plantaID" value="<%=listado.getString("plantaID") %>">
                <input type="hidden" name="familia" value="<%=listado.getString("familia") %>">
                <input type="hidden" name="nombre" value="<%=listado.getString("nombre") %>">
                <input type="hidden" name="cientifico" value="<%=listado.getString("cientifico") %>">
                <button type="submit"  class="btn btn-info"><span class="bi bi-pencil-fill"> </span> Editar</button>
              </form>
            </td>
            <%--borrar--%>
            <td>
              <form method="post" action="borrarPlanta.jsp">
                <input type="hidden" name="plantaID" value="<%=listado.getString("plantaID") %>"/>
                <button type="submit" class="btn btn-danger"><span class="bi bi-trash-fill"></span> Borrar</button>
              </form>
            </td></tr>
            <%
              }   
              conexion.close();
            %>

          </table>
        </div>
      </div> <!-- cierre container lista -->
    </div> <!-- fin wraper -->


    <!-- JS bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
    crossorigin="anonymous"></script>  
    <!-- JS materialize 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
    -->
    <!-- JS mio -->
    <script src="./js/javascript.js"></script>  
  </body>
</html>