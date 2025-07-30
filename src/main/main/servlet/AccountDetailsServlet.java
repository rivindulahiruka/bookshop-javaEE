package main.servlet;

import main.dao.impl.CustomerDAOImpl;
import main.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AccountDetails")
public class AccountDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accNo = request.getParameter("accountNumber");
        String name = request.getParameter("name");

        Customer customer = null;
        CustomerDAOImpl dao = new CustomerDAOImpl();

        if (accNo != null && !accNo.trim().isEmpty()) {
            customer = dao.findByAccountNumber(accNo.trim());
        } else if (name != null && !name.trim().isEmpty()) {
            customer = dao.findByName(name.trim());
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("accountDetails.jsp").forward(request, response);
    }
}

