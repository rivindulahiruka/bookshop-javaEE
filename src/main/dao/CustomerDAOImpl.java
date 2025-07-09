package main.dao;

import main.model.Customer;
import main.util.DBConnection;
import main.util.Validator;

import java.sql.*;
import java.util.*;

public class CustomerDAOImpl implements CustomerDAO {

    @Override
    public void save(Customer customer) {
        String query= "INSERT INTO customers (name, address, phone, units, email) VALUES (?, ?, ?, ?, ?)";

        try(Connection conn=DBConnection.getConnection();
            PreparedStatement stmt=conn.prepareStatement(query);) {

            stmt.setString(1,customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhone());
            stmt.setInt(4, customer.getUnits());
            stmt.setString(5, customer.getEmail());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Customer> findAll() {
        List<Customer> customers=new ArrayList<>();
        String query = "SELECT * FROM customers";

        try (Connection conn= DBConnection.getConnection();
             Statement stmt=conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)){

            while (rs.next()) {
                customers.add(extractCustomer(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return customers;
    }

    @Override
    public Customer findById(int id) {
        return null;
    }

    @Override
    public void update(Customer customer) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public boolean saveWithValidation(Customer customer) {
        if (!Validator.isNotEmpty(customer.getName())){
            System.err.println("Error: Customer name cannot be empty!");
            return false;
        }
        if (!Validator.isValidEmail(customer.getEmail())) {
            System.err.println("Error: Invalid email address!");
            return false;
        }
        if (!Validator.isValidPhone(customer.getPhone())) {
            System.err.println("Error: Invalid phone number! (Must be 10 digits)");
            return false;
        }
        saveWithValidation(customer);
        System.out.println("Customer saved successfully.");
        return true;
    }
    private Customer extractCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setName(rs.getString("name"));
        customer.setAddress(rs.getString("address"));
        customer.setPhone(rs.getString("phone"));
        customer.setUnits(rs.getInt("units"));
        customer.setEmail(rs.getString("email"));
        return customer;
    }
}
