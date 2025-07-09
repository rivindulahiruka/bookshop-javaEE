<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="main.model.User" %>

<form action="CustomerServlet" method="post">
    Name: <input type="text" name="name"><br/>
    Address: <input type="text" name="address"><br/>
    Phone: <input type="text" name="phone"><br/>
    Units: <input type="number" name="units"><br/>
    Email: <input type="text" name="email"><br/>
    <input type="submit" value="Add Customer">
</form>
