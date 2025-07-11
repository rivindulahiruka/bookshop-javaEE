package main.dao;

import main.model.Customer;

import java.sql.SQLException;
import java.util.List;

public interface CustomerDAO {
    void save(Customer customer);
    List<Customer> findAll();
    Customer findById(int id);
    void update(Customer customer);
    void delete(int id) throws SQLException;
    boolean saveWithValidation(Customer customer);


}
