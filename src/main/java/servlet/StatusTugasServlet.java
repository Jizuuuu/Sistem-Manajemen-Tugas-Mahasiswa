package servlet;

import model.Mahasiswa;
import service.TugasManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StatusTugasServlet")
public class StatusTugasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Mahasiswa)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Mahasiswa mhs = (Mahasiswa) session.getAttribute("user");
        int idTugas = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        TugasManager manager = new TugasManager();
        manager.ubahStatus(idTugas, mhs.getIdMahasiswa(), status);

        response.sendRedirect("dashboardMahasiswa.jsp");
    }
}
