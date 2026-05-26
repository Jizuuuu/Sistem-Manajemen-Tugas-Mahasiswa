package servlet;

import model.Dosen;
import service.TugasManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/HapusTugasServlet")
public class HapusTugasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Dosen)) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idTugas = Integer.parseInt(request.getParameter("id"));

        TugasManager manager = new TugasManager();
        manager.hapusTugas(idTugas);

        response.sendRedirect("dashboardDosen.jsp");
    }
}
