package main.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.dao.CustomerDAO;
import main.dao.impl.CustomerDAOImpl;
import main.model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet("/Customer")
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Customer> customerList = customerDAO.findAll();
        request.setAttribute("customers", customerList);
        request.getRequestDispatcher("customer.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
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

        customerDAO.saveWithValidation(customer);
        response.sendRedirect("Customer");
    }
}
