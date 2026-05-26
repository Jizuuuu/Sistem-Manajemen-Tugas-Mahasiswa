package servlet;

import model.Tugas;
import model.Dosen;
import service.TugasManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditTugasServlet")
public class EditTugasServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Dosen)) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idTugas = Integer.parseInt(request.getParameter("id_tugas"));
        String judul = request.getParameter("judul");
        String deskripsi = request.getParameter("deskripsi");
        String deadline = request.getParameter("deadline");
        int idMk = Integer.parseInt(request.getParameter("id_mk"));

        TugasManager manager = new TugasManager();
        Tugas tugas = manager.getTugasById(idTugas);
        if (tugas != null) {
            tugas.setJudul(judul);
            tugas.setDeskripsi(deskripsi);
            tugas.setDeadline(deadline);
            tugas.setIdMk(idMk);
            manager.updateTugas(tugas);
        }

        response.sendRedirect("dashboardDosen.jsp");
    }
}
