package controller;

import dao.UserDAO;
import model.User;

public class AuthController {

    public User login(String email, String password) {
        UserDAO dao = new UserDAO();
        return dao.login(email, password);
    }
}