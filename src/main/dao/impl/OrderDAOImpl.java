package main.dao.impl;

import main.dao.OrderDAO;
import main.model.Order;
import main.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public boolean placeOrder(Order order) {
        String sql = "INSERT INTO orders (customer_id, items_json, total) VALUES (?, ?, ?)";
        System.out.println("Save method called with: " + order.getCustomerId() + ", " + order.getItemsJson() + ", " + order.getTotal());

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, order.getCustomerId());
            stmt.setString(2, order.getItemsJson());
            stmt.setDouble(3, order.getTotal());

            int rows = stmt.executeUpdate();
            System.out.println("Rows affected: " + rows); // Debug log
            return rows > 0;

        } catch (Exception e) {
            System.err.println("Error in placeOrder: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Order> findAll() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Order order = extractOrder(rs);
                orders.add(order);

            }
            System.out.println("Total orders found: " + orders.size()); // Debug log

        } catch (SQLException e) {
            System.err.println("SQL Error in findAll: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database error while fetching orders", e);
        }

        return orders;
    }
    private Order extractOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setItemsJson(rs.getString("items_json"));
        order.setTotal(rs.getDouble("total"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        return order;
    }
}