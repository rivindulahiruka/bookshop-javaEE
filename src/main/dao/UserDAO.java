package main.dao;
import main.model.User;

public interface UserDAO {
    boolean registerUser(User user);
    User authenticateUser(String userName,String password);
    boolean registerWithValidation(User user);
}
