package main.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.dao.OrderDAO;
import main.dao.impl.OrderDAOImpl;
import main.model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet("/Order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        try {
            List<Order> orderList = orderDAO.findAll();

            request.setAttribute("orders", orderList);
            request.getRequestDispatcher("order.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in OrderServlet: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error loading orders: " + e.getMessage());
        }
    }
}