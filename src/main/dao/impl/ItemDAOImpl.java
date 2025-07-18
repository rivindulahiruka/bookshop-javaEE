package main.dao.impl;

import main.dao.ItemDAO;
import main.model.Item;
import main.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl implements ItemDAO {

    @Override
    public void addItem(Item item) {
        String sql = "INSERT INTO items (itemCode, itemName, price, stock, is_deleted) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getItemCode());
            stmt.setString(2, item.getName());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStock());
            stmt.setBoolean(5, false); // is_deleted default to false
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateItem(Item item) {
        String sql = "UPDATE items SET itemName = ?, price = ?, stock = ? WHERE itemCode = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getName());
            stmt.setDouble(2, item.getPrice());
            stmt.setInt(3, item.getStock());
            stmt.setString(4, item.getItemCode());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteItem(String itemCode) {
        // Soft delete
        String sql = "UPDATE items SET is_deleted = TRUE WHERE itemCode = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, itemCode);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE is_deleted = FALSE ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Item item = new Item();
                item.setItemCode(rs.getString("itemCode"));
                item.setName(rs.getString("itemName"));
                item.setPrice(rs.getDouble("price"));
                item.setStock(rs.getInt("stock"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                item.setDeleted(rs.getBoolean("is_deleted"));
                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public Item getItemByCode(String itemCode) {
        String sql = "SELECT * FROM items WHERE itemCode = ? AND is_deleted = FALSE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, itemCode);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Item item = new Item();
                    item.setItemCode(rs.getString("itemCode"));
                    item.setName(rs.getString("itemName"));
                    item.setPrice(rs.getDouble("price"));
                    item.setStock(rs.getInt("stock"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    item.setDeleted(rs.getBoolean("is_deleted"));
                    return item;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
