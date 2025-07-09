package main.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.dao.UserDAO;
import main.dao.impl.UserDAOImpl;
import main.model.User;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user=new User();
        user.setUserName(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNum(request.getParameter("phoneNum"));
        user.setRole(request.getParameter("role"));

        UserDAO userDAO = new UserDAOImpl();
        boolean success = userDAO.registerWithValidation(user);

        if (success) {
            HttpSession session = request.getSession();
            session.setAttribute("successMsg", "Registration Successful! Welcome " + user.getUserName());
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMsg", "Registration Failed! Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

    }
}
