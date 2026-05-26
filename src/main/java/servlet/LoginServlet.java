package servlet;

import controller.AuthController;
import model.User;
import model.Mahasiswa;
import model.Dosen;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AuthController auth = new AuthController();
        User user = auth.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user instanceof Mahasiswa) {
                response.sendRedirect("dashboardMahasiswa.jsp");
            } else if (user instanceof Dosen) {
                response.sendRedirect("dashboardDosen.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}