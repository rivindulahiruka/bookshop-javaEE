package main.dao.impl;

import main.dao.UserDAO;
import main.model.User;
import main.util.DBConnection;
import main.util.PasswordHasher;
import main.util.Validator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAOImpl implements UserDAO {
    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, phone, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String hashPassword = PasswordHasher.hashPassword(user.getPassword());

            stmt.setString(1, user.getUserName());
            stmt.setString(2, hashPassword);
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhoneNum());
            stmt.setString(5, user.getRole());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error registering user", e);
        }
    }


    @Override
    public User authenticateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                String inputHash = PasswordHasher.hashPassword(password);

                if (inputHash.equals(storedHash)) {
                    User user = new User();
                    user.setId(String.valueOf(rs.getInt("id")));
                    user.setUserName(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNum(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));  // If you want timestamp too
                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean registerWithValidation(User user) {
        if (!Validator.isNotEmpty(user.getUserName())){
            System.err.println("Error: User name cannot be empty!");
            return false;
        }
        if (!Validator.isValidEmail(user.getEmail())) {
            System.err.println("Error: Invalid email address!");
            return false;
        }
        if (!Validator.isValidPhone(user.getPhoneNum())) {
            System.err.println("Error: Invalid phone number! (Must be 10 digits)");
            return false;
        }
        registerUser(user);
        System.out.println("User registered successfully.");

        return true;

    }
}


