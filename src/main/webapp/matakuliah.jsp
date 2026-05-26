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
MataKuliahDAO mkDao = new MataKuliahDAO();
ArrayList<MataKuliah> courses = mkDao.getBySemester(student.getSemester());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mata Kuliah Semester Aktif - TaskMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="app-layout" style="max-width: 800px;">
    
    <header style="margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between;">
        <span class="brand">TaskMan</span>
        <a href="dashboardMahasiswa.jsp" class="btn btn-secondary btn-sm">&larr; Kembali ke Dashboard</a>
    </header>

    <div class="glass-container">
        <h2 style="font-size: 1.6rem; font-weight: 700; margin-bottom: 1rem; background: linear-gradient(135deg, var(--primary), #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            Mata Kuliah Semester Aktif
        </h2>
        <p style="color: var(--text-muted); margin-bottom: 2rem; font-size: 0.95rem;">
            Daftar mata kuliah yang Anda ambil di Semester <%= student.getSemester() %> saat ini.
        </p>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 25%;">Kode MK</th>
                        <th style="width: 50%;">Nama Mata Kuliah</th>
                        <th style="width: 25%;">Semester</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (MataKuliah mk : courses) { %>
                        <tr>
                            <td style="font-weight: 700; color: var(--primary);"><%= mk.getKodeMK() %></td>
                            <td style="font-weight: 500;"><%= mk.getNamaMK() %></td>
                            <td style="color: var(--text-muted);">Semester <%= mk.getSemester() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
