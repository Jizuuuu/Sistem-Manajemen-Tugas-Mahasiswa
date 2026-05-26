<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="model.Dosen"%>
<%@page import="model.Tugas"%>
<%@page import="service.TugasManager"%>

<%
User u = (User) session.getAttribute("user");
if (u == null || !(u instanceof Dosen)) {
    response.sendRedirect("login.jsp");
    return;
}

Dosen dosen = (Dosen) u;

// Instantiate manager to fetch lecturer tasks
TugasManager manager = new TugasManager();
ArrayList<Tugas> tasks = manager.getByDosen(dosen.getIdDosen());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Dosen - TaskMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="app-layout">
    
    <!-- Navbar -->
    <header class="glass-container navbar">
        <div class="brand">TaskMan</div>
        <div style="display: flex; gap: 1.5rem; align-items: center;">
            <a href="tambahtugas.jsp" class="btn btn-primary btn-sm">+ Tambah Tugas</a>
            <a href="LogoutServlet" class="btn btn-danger btn-sm">Keluar</a>
        </div>
    </header>

    <!-- Content Grid -->
    <div class="grid-2" style="grid-template-columns: 1fr 3fr;">
        
        <!-- Sidebar: Profile Info -->
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            
            <div class="glass-container" style="padding: 1.75rem;">
                <h2 style="font-size: 1.4rem; margin-bottom: 1.25rem; font-weight: 600;">Profil Dosen</h2>
                <div class="profile-card">
                    <div class="profile-avatar">
                        <%= dosen.getNama().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="profile-info">
                        <h3><%= dosen.getNama() %></h3>
                        <p>NIDN: <%= dosen.getNidn() %></p>
                        <p>Akses: Dosen Pengajar</p>
                    </div>
                </div>
                
                <div style="margin-top: 2rem; border-top: 1px solid var(--border-color); padding-top: 1.5rem;">
                    <p style="font-size: 0.85rem; color: var(--text-muted); line-height: 1.6;">
                        Sebagai dosen pengajar, Anda memiliki otorisasi penuh untuk menambah, mengubah, dan menghapus tugas mata kuliah yang Anda ampu.
                    </p>
                </div>
            </div>
            
        </div>
        
        <!-- Main: Manage Tasks List -->
        <div class="glass-container" style="padding: 2rem;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                <h2 style="font-size: 1.5rem; font-weight: 600;">Kelola Daftar Tugas</h2>
                <span style="font-size: 0.9rem; color: var(--text-muted);"><%= tasks.size() %> tugas dibuat</span>
            </div>

            <% if (tasks.isEmpty()) { %>
                <div style="text-align: center; padding: 4rem 0; color: var(--text-muted);">
                    <p style="font-size: 1.15rem; margin-bottom: 0.75rem;">Anda belum memublikasikan tugas apa pun.</p>
                    <a href="tambahtugas.jsp" class="btn btn-primary">+ Buat Tugas Pertama</a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Mata Kuliah</th>
                                <th>Judul Tugas</th>
                                <th>Deskripsi</th>
                                <th>Tanggal Dibuat</th>
                                <th>Deadline</th>
                                <th style="text-align: center;">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Tugas t : tasks) { %>
                                <tr>
                                    <td>
                                        <span style="font-weight: 600; color: var(--primary);"><%= t.getKodeMk() %></span><br>
                                        <span style="font-size: 0.8rem; color: var(--text-muted);"><%= t.getNamaMk() %></span>
                                    </td>
                                    <td style="font-weight: 500;"><%= t.getJudul() %></td>
                                    <td style="font-size: 0.9rem; color: var(--text-muted); max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <%= t.getDeskripsi() %>
                                    </td>
                                    <td style="font-size: 0.85rem; color: var(--text-muted);"><%= t.getTanggalDibuat() %></td>
                                    <td style="font-weight: 600; font-size: 0.9rem; color: var(--warning);"><%= t.getDeadline() %></td>
                                    <td style="text-align: center;">
                                        <div style="display: inline-flex; gap: 0.5rem;">
                                            <a href="editTugas.jsp?id=<%= t.getIdTugas() %>" class="btn btn-secondary btn-sm" style="font-size: 0.75rem; padding: 0.35rem 0.65rem;">Edit</a>
                                            <a href="HapusTugasServlet?id=<%= t.getIdTugas() %>" class="btn btn-danger btn-sm btn-delete-confirm" data-confirm="Apakah Anda yakin ingin menghapus tugas '<%= t.getJudul() %>'?" style="font-size: 0.75rem; padding: 0.35rem 0.65rem;">Hapus</a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
        
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
