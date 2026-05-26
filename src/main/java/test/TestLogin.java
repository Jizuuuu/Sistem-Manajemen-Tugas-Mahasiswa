package test;

import dao.UserDAO;
import model.User;

public class TestLogin {
    public static void main(String[] args) {
        System.out.println("Starting login test...");
        try {
            UserDAO dao = new UserDAO();
            User user = dao.login("mahasiswa@gmail.com", "123");
            if (user != null) {
                System.out.println("SUCCESS: Logged in as " + user.getNama() + " (" + user.getClass().getSimpleName() + ")");
            } else {
                System.out.println("FAILED: Login returned null.");
            }
        } catch (Exception e) {
            System.out.println("EXCEPTION: ");
            e.printStackTrace();
        }
    }
}
