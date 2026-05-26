<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="model.Mahasiswa"%>
<%@page import="model.MataKuliah"%>
<%@page import="dao.MataKuliahDAO"%>

<%
User u = (User) session.getAttribute("user");
if (u == null || !(u instanceof Mahasiswa)) {
    response.sendRedirect("login.jsp");
    return;
}

Mahasiswa student = (Mahasiswa) u;

// Fetch student's active semester courses for dropdown selector
MataKuliahDAO mkDao = new MataKuliahDAO();
ArrayList<MataKuliah> listMK = mkDao.getBySemester(student.getSemester());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Tugas Mandiri - TaskMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="app-layout" style="max-width: 600px;">
    
    <header style="margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between;">
        <span class="brand">TaskMan</span>
        <a href="dashboardMahasiswa.jsp" class="btn btn-secondary btn-sm">&larr; Dashboard</a>
    </header>

    <div class="glass-container">
        <h2 style="font-size: 1.6rem; font-weight: 900; margin-bottom: 1rem; text-transform: uppercase;">
            Buat Tugas Mandiri
        </h2>
        <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 2rem; font-weight: 600;">
            Buat tugas personal/mandiri untuk rencana belajar Anda sendiri (misal: Latihan UTS, Rencana Belajar, Tugas Tambahan).
        </p>
        
        <form action="TugasPersonalServlet" method="post">
            
            <div class="form-group">
                <label for="id_mk">Hubungkan ke Mata Kuliah</label>
                <select id="id_mk" name="id_mk" class="form-control" required style="cursor: pointer;">
                    <option value="" disabled selected>Pilih mata kuliah Anda...</option>
                    <% for (MataKuliah mk : listMK) { %>
                        <option value="<%= mk.getIdMk() %>"><%= mk.getKodeMK() %> - <%= mk.getNamaMK() %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="judul">Judul Rencana / Tugas</label>
                <input type="text" id="judul" name="judul" class="form-control" placeholder="Contoh: Belajar UTS PBO / Latihan Soal IMK" required>
            </div>
            
            <div class="form-group">
                <label for="deskripsi">Catatan / Deskripsi</label>
                <textarea id="deskripsi" name="deskripsi" class="form-control" rows="5" placeholder="Tulis rencana aktivitas belajar Anda di sini..." required style="resize: vertical;"></textarea>
            </div>
            
            <div class="form-group" style="margin-bottom: 2rem;">
                <label for="deadline">Target Selesai (Deadline)</label>
                <input type="date" id="deadline" name="deadline" class="form-control" required style="cursor: pointer;">
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                Simpan Rencana Mandiri
            </button>
            
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
