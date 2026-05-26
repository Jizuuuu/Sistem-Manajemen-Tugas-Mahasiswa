package servlet;

import model.Tugas;
import model.Mahasiswa;
import service.TugasManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TugasPersonalServlet")
public class TugasPersonalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Mahasiswa)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Mahasiswa student = (Mahasiswa) session.getAttribute("user");

        String judul = request.getParameter("judul");
        String deskripsi = request.getParameter("deskripsi");
        String deadline = request.getParameter("deadline");
        int idMk = Integer.parseInt(request.getParameter("id_mk"));

        Tugas tugas = new Tugas(judul, deskripsi, deadline);
        tugas.setIdMk(idMk);

        TugasManager manager = new TugasManager();
        manager.tambahTugasPersonal(tugas, student.getIdMahasiswa());

        response.sendRedirect("dashboardMahasiswa.jsp");
    }
}
