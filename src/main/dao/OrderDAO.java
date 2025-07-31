package main.dao;

import main.model.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    boolean placeOrder(Order order) throws SQLException;
    List<Order> findAll();
}