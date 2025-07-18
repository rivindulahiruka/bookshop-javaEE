package main.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.dao.ItemDAO;
import main.dao.impl.ItemDAOImpl;
import main.model.Item;

import java.io.IOException;
import java.util.List;
@WebServlet("/ItemServlet")
public class ItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item item = new Item();
        item.setItemCode(itemCode);
        item.setName(itemName);
        item.setPrice(price);
        item.setStock(stock);

        if ("update".equals(action)) {
            itemDAO.addItem(item);
        } else {
            itemDAO.addItem(item);
        }

        response.sendRedirect("items.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String code = request.getParameter("code");
            new ItemDAOImpl().deleteItem(code);
        }

        List<Item> itemList = new ItemDAOImpl().getAllItems();
        request.setAttribute("items", itemList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("items.jsp");
        dispatcher.forward(request, response);
    }
}
