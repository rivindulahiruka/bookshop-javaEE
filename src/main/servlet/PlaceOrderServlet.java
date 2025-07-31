package main.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.dao.OrderDAO;
import main.dao.impl.OrderDAOImpl;
import main.model.Order;

import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String itemsJson = request.getParameter("itemsJson");
        double total = Double.parseDouble(request.getParameter("total"));
        System.out.println("Received Order - Customer ID: " + customerId + ", Items: " + itemsJson + ", Total: " + total);
        Order order = new Order(customerId, itemsJson, total);
        OrderDAO orderDAO = new OrderDAOImpl();

        boolean success = false;
        try {
            success = orderDAO.placeOrder(order);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.setContentType("text/plain");
        if (success) {
            response.getWriter().write("✅ Order placed successfully.");
        } else {
            response.setStatus(500);
            response.getWriter().write("❌ Order failed.");
        }
    }
}