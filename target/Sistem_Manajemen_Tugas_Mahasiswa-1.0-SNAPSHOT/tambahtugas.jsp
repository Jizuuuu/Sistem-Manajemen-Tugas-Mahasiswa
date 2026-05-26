<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="model.Dosen"%>
<%@page import="model.MataKuliah"%>
<%@page import="dao.MataKuliahDAO"%>

<%
User u = (User) session.getAttribute("user");
if (u == null || !(u instanceof Dosen)) {
    response.sendRedirect("login.jsp");
    return;
}

Dosen dosen = (Dosen) u;

// Fetch all courses for dropdown selector
MataKuliahDAO mkDao = new MataKuliahDAO();
ArrayList<MataKuliah> listMK = mkDao.getAll();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Tugas Baru - TaskMan</title>
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
            Buat Tugas Baru
        </h2>
        
        <form action="TugasServlet" method="post">
            
            <div class="form-group">
                <label for="id_mk">Mata Kuliah</label>
                <select id="id_mk" name="id_mk" class="form-control" required style="cursor: pointer;">
                    <option value="" disabled selected>Pilih mata kuliah...</option>
                    <% for (MataKuliah mk : listMK) { %>
                        <option value="<%= mk.getIdMk() %>">[Sem <%= mk.getSemester() %>] <%= mk.getKodeMK() %> - <%= mk.getNamaMK() %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="judul">Judul Tugas</label>
                <input type="text" id="judul" name="judul" class="form-control" placeholder="Contoh: Tugas Individu 1 - Membuat Interface" required>
            </div>
            
            <div class="form-group">
                <label for="deskripsi">Deskripsi Tugas</label>
                <textarea id="deskripsi" name="deskripsi" class="form-control" rows="5" placeholder="Tulis instruksi lengkap tugas di sini..." required style="resize: vertical;"></textarea>
            </div>
            
            <div class="form-group" style="margin-bottom: 2rem;">
                <label for="deadline">Tanggal Deadline</label>
                <input type="date" id="deadline" name="deadline" class="form-control" required style="cursor: pointer;">
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                Simpan dan Publikasikan Tugas
            </button>
            
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
