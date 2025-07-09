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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO=new UserDAOImpl();

    protected void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

            String username= request.getParameter("username");
            String password= request.getParameter("password");

            User user = userDAO.authenticateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            response.sendRedirect("dashboard.jsp"); // After successful login
        } else {
            request.setAttribute("errorMsg", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }

}
