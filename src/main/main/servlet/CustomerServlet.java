package main.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.dao.impl.CustomerDAOImpl;
import main.model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet("/Customer")
public class CustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, ServletException {
        // Customer List Display
        List<Customer> customerList = new CustomerDAOImpl().findAll();
        request.setAttribute("customers", customerList);
        request.getRequestDispatcher("customer.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Customer Save
        String accNo = request.getParameter("accNo");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setAccNo(accNo);
        customer.setName(name);
        customer.setAddress(address);
        customer.setPhone(phone);
        customer.setEmail(email);

        new CustomerDAOImpl().saveWithValidation(customer);
        response.sendRedirect("Customer");  // Reload after save
    }
}
