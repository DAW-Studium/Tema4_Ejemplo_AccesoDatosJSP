<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Consulta de Libros</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
	// Paso 1: Cargamos el driver 
	Class.forName("com.mysql.cj.jdbc.Driver");
	// Paso 2: Conectarse a la base de datos utilizando un objeto de la clase Connection 
	String userName = "servletUser";
	String password = "Studium2022;";
	// URL de la base de datos 
	String url = "jdbc:mysql://localhost:3306/daw_tiendalibros?serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(url, userName, password);
	// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement 
	Statement stmt = conn.createStatement();
	
	// Paso 4: Ejecutar las sentencias 
	String sqlStr = "SELECT * FROM libros";
	System.out.println(sqlStr);
	ResultSet rs = stmt.executeQuery(sqlStr);
	%>
	<h1>Consulta de Libros</h1>
	<h3>Elige libro(s) a consultar:</h3>
	<form method="get">
	<%
		// Paso 5: Recoger los resultados y procesarlos 
		while (rs.next()) {
		%>
		<input type="checkbox" name="libro" value="<%=rs.getString("idLibro")%>" /><%=rs.getString("tituloLibro")%>
		<%
		}
		%>
		<input type="submit" value="Buscar..." />
	</form>
	<%
	String[] libros = request.getParameterValues("libro");
	if (libros != null) {
	%>
	<%@ page import="java.sql.*"%>
	<%
	// Paso 4: Ejecutar las sentencias 
	sqlStr = "SELECT * FROM libros WHERE ";
	for (int i = 0; i < libros.length; i++) {
		sqlStr = sqlStr + "idlibro = " + libros[i] + " ";
		if (i != libros.length - 1) {
			sqlStr += "OR ";
		}
	}
	sqlStr += "ORDER by precioLibro DESC";
	System.out.println(sqlStr);
	rs = stmt.executeQuery(sqlStr);
	%>
	<hr />
	<table border=1>
		<tr>
			<th>Autor</th>
			<th>Título</th>
			<th>Precio</th>
			<th>Cantidad</th>
		</tr>
		<%
		// Paso 5: Recoger los resultados y procesarlos 
		while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("autorLibro")%></td>
			<td><%=rs.getString("tituloLibro")%></td>
			<td><%=rs.getString("precioLibro")%></td>
			<td><%=rs.getString("cantidadLibro")%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	// Cierre de recursos 
	rs.close();
	stmt.close();
	conn.close();
	}
	%>
</body>
</html>