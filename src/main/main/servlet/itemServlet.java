package main.servlet;

import main.dao.impl.ItemDAOImpl;
import main.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/Item")
public class itemServlet extends HttpServlet {

    private final ItemDAOImpl itemDAO = new ItemDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> itemList = itemDAO.findAll();
        request.setAttribute("items", itemList);
        request.getRequestDispatcher("items.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("delete".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr.trim());
                        itemDAO.deleteById(id);  // This must delete the item
                        response.sendRedirect(request.getContextPath() + "/Item?success=deleted");
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid item id for deletion.");
                        forwardWithItems(request, response);
                    }
                } else {
                    request.setAttribute("error", "Item id missing for deletion.");
                    forwardWithItems(request, response);
                }
                return;
            }


            String itemCode = request.getParameter("itemCode");
            String name = request.getParameter("itemName");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");

            if (itemCode == null || itemCode.trim().isEmpty() ||
                    name == null || name.trim().isEmpty() ||
                    priceStr == null || priceStr.trim().isEmpty() ||
                    stockStr == null || stockStr.trim().isEmpty()) {

                request.setAttribute("error", "All fields are required.");
                forwardWithItems(request, response);
                return;
            }

            double price;
            int stock;
            try {
                price = Double.parseDouble(priceStr.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format.");
                forwardWithItems(request, response);
                return;
            }

            try {
                stock = Integer.parseInt(stockStr.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid stock quantity.");
                forwardWithItems(request, response);
                return;
            }

            Item item = new Item();
            item.setItemCode(itemCode.trim());
            item.setName(name.trim());
            item.setPrice(price);
            item.setStock(stock);

            if ("update".equalsIgnoreCase(action)) {
                if (itemDAO.findByCode(item.getItemCode()) == null) {
                    request.setAttribute("error", "Item not found for update.");
                    forwardWithItems(request, response);
                    return;
                }
                itemDAO.update(item);
                response.sendRedirect(request.getContextPath() + "/Item?success=updated");
            } else {
                if (itemDAO.findByCode(item.getItemCode()) != null) {
                    request.setAttribute("error", "Item code already exists. Use edit to update.");
                    forwardWithItems(request, response);
                    return;
                }
                itemDAO.save(item);
                response.sendRedirect(request.getContextPath() + "/Item?success=created");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error occurred.");
            forwardWithItems(request, response);
        }
    }

    private void forwardWithItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> items = itemDAO.findAll();
        request.setAttribute("items", items);
        request.getRequestDispatcher("items.jsp").forward(request, response);
    }
}

