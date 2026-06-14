<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="model.Dosen"%>
<%@page import="model.MataKuliah"%>
<%@page import="model.Tugas"%>
<%@page import="dao.MataKuliahDAO"%>
<%@page import="service.TugasManager"%>

<%
User u = (User) session.getAttribute("user");
if (u == null || !(u instanceof Dosen)) {
    response.sendRedirect("login.jsp");
    return;
}

int idTugas = Integer.parseInt(request.getParameter("id"));
TugasManager manager = new TugasManager();
Tugas tugas = manager.getTugasById(idTugas);

if (tugas == null) {
    response.sendRedirect("dashboardDosen.jsp");
    return;
}

Dosen dosen = (Dosen) u;
// Fetch only courses taught by this lecturer
MataKuliahDAO mkDao = new MataKuliahDAO();
ArrayList<MataKuliah> listMK = mkDao.getByDosen(dosen.getIdDosen());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Tugas - TaskMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="app-layout" style="max-width: 600px;">
    
    <header style="margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between;">
        <span class="brand">TaskMan</span>
        <a href="dashboardDosen.jsp" class="btn btn-secondary btn-sm">&larr; Kembali ke Dashboard</a>
    </header>

    <div class="glass-container">
        <h2 style="font-size: 1.6rem; font-weight: 700; margin-bottom: 1.5rem; background: linear-gradient(135deg, var(--primary), #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            Ubah Data Tugas
        </h2>
        
        <form action="EditTugasServlet" method="post">
            <!-- Hidden Input for ID -->
            <input type="hidden" name="id_tugas" value="<%= tugas.getIdTugas() %>">
            
            <div class="form-group">
                <label>Mata Kuliah</label>
                <% if (listMK.isEmpty()) { %>
                    <p style="color: var(--danger); font-weight: bold;">Anda tidak mengampu mata kuliah apa pun. Hubungi admin.</p>
                <% } else if (listMK.size() == 1) { 
                    MataKuliah mk = listMK.get(0);
                %>
                    <div class="form-control" style="background: rgba(255, 255, 255, 0.05); padding: 0.75rem 1rem; border-radius: 8px; border: 1px solid var(--border-color); font-weight: 600; color: var(--text-color); display: flex; align-items: center;">
                        [Sem <%= mk.getSemester() %>] <%= mk.getKodeMK() %> - <%= mk.getNamaMK() %>
                    </div>
                    <input type="hidden" name="id_mk" value="<%= mk.getIdMk() %>">
                <% } else { %>
                    <select id="id_mk" name="id_mk" class="form-control" required style="cursor: pointer;">
                        <% for (MataKuliah mk : listMK) { %>
                            <option value="<%= mk.getIdMk() %>" <%= (mk.getIdMk() == tugas.getIdMk()) ? "selected" : "" %>>
                                [Sem <%= mk.getSemester() %>] <%= mk.getKodeMK() %> - <%= mk.getNamaMK() %>
                            </option>
                        <% } %>
                    </select>
                <% } %>
            </div>
            
            <div class="form-group">
                <label for="judul">Judul Tugas</label>
                <input type="text" id="judul" name="judul" class="form-control" value="<%= tugas.getJudul() %>" required>
            </div>
            
            <div class="form-group">
                <label for="deskripsi">Deskripsi Tugas</label>
                <textarea id="deskripsi" name="deskripsi" class="form-control" rows="5" required style="resize: vertical;"><%= tugas.getDeskripsi() %></textarea>
            </div>
            
            <div class="form-group" style="margin-bottom: 2rem;">
                <label for="deadline">Tanggal Deadline</label>
                <input type="date" id="deadline" name="deadline" class="form-control" value="<%= tugas.getDeadline() %>" required style="cursor: pointer;">
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                Simpan Perubahan Tugas
            </button>
            
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
