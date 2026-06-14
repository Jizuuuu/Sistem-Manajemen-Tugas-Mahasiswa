<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="model.Mahasiswa"%>
<%@page import="model.MataKuliah"%>
<%@page import="model.Tugas"%>
<%@page import="dao.MataKuliahDAO"%>
<%@page import="service.TugasManager"%>

<%
User u = (User) session.getAttribute("user");
if (u == null || !(u instanceof Mahasiswa)) {
    response.sendRedirect("login.jsp");
    return;
}

Mahasiswa student = (Mahasiswa) u;

// Instantiate managers and DAOs
MataKuliahDAO mkDao = new MataKuliahDAO();
TugasManager manager = new TugasManager();

ArrayList<MataKuliah> courses = mkDao.getBySemester(student.getSemester());
ArrayList<Tugas> tasks = manager.getByMahasiswa(student.getIdMahasiswa());
ArrayList<Tugas> deadlineAlerts = manager.getDeadlineDekat(student.getIdMahasiswa());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Mahasiswa - TaskMan</title>
    <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    
<div class="app-layout">
    
    <!-- Navbar -->
    <header class="glass-container navbar">
        <div class="brand">TaskMan</div>
        <div style="display: flex; gap: 1.5rem; align-items: center;">
            <a href="tambahTugasPersonal.jsp" class="btn btn-primary btn-sm">+ Tugas Mandiri</a>
            <a href="matakuliah.jsp" class="btn btn-secondary btn-sm">Lihat Mata Kuliah</a>
            <a href="LogoutServlet" class="btn btn-danger btn-sm">Keluar</a>
        </div>
    </header>

    <!-- Content Grid -->
    <div class="grid-2">
        
        <!-- Sidebar: Info Profile & Alerts -->
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            
            <!-- Student Profile Card -->
            <div class="glass-container" style="padding: 1.75rem;">
                <h2 style="font-size: 1.4rem; margin-bottom: 1.25rem; font-weight: 600;">Profil Mahasiswa</h2>
                <div class="profile-card">
                    <div class="profile-avatar">
                        <%= student.getNama().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="profile-info">
                        <h3><%= student.getNama() %></h3>
                        <p>NIM: <%= student.getNim() %></p>
                        <p>Semester: <%= student.getSemester() %></p>
                    </div>
                </div>
            </div>

            <!-- Deadlines Notifications Panel -->
            <div class="glass-container" style="padding: 1.75rem;">
                <h2 style="font-size: 1.4rem; margin-bottom: 1.25rem; font-weight: 600;">⚠ Pengingat Deadline</h2>
                <% if (deadlineAlerts.isEmpty()) { %>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">Tidak ada deadline tugas terdekat (H-3).</p>
                <% } else { %>
                    <% for (Tugas alert : deadlineAlerts) {
                        // Calculate days remaining
                        long daysBetween = 0;
                        try {
                            LocalDate dl = LocalDate.parse(alert.getDeadline());
                            daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), dl);
                        } catch (Exception ex) {}
                    %>
                        <div class="alert-card <%= (daysBetween <= 1) ? "alert-danger" : "alert-warning" %>">
                            <div class="alert-title">
                                ⚠ Deadline H-<%= daysBetween %>
                            </div>
                            <div class="alert-desc">
                                <strong><%= alert.getJudul() %></strong> (<%= alert.getNamaMk() %>)<br>
                                Batas: <%= alert.getDeadline() %>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
            
        </div>
        
        <!-- Main Panel: Tasks & Active Courses -->
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            
            <!-- Tasks List -->
            <div class="glass-container" style="padding: 2rem;">
                <h2 style="font-size: 1.5rem; margin-bottom: 1.25rem; font-weight: 600; display: flex; justify-content: space-between; align-items: center;">
                    <span>Daftar Semua Tugas</span>
                    <span style="font-size: 0.9rem; color: var(--text-muted); font-weight: normal;"><%= tasks.size() %> total tugas</span>
                </h2>
                
                <% if (tasks.isEmpty()) { %>
                    <div style="text-align: center; padding: 3rem 0; color: var(--text-muted);">
                        <p style="font-size: 1.1rem; margin-bottom: 0.5rem;">Belum ada tugas yang diberikan.</p>
                        <p style="font-size: 0.9rem;">Nikmati waktu luang Anda!</p>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Mata Kuliah</th>
                                    <th>Judul Tugas</th>
                                    <th>Deskripsi</th>
                                    <th>Batas Waktu</th>
                                    <th>Status</th>
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
                                        <td style="font-weight: 500;">
                                            <%= t.getJudul() %>
                                            <br>
                                            <% if (t.getIdTugas() < 0) { %>
                                                <span class="badge badge-warning" style="font-size: 0.7rem; padding: 0.15rem 0.5rem; margin-top: 0.35rem; box-shadow: 1px 1px 0px #000000;">Mandiri</span>
                                            <% } else { %>
                                                <span class="badge badge-primary" style="font-size: 0.7rem; padding: 0.15rem 0.5rem; margin-top: 0.35rem; box-shadow: 1px 1px 0px #000000;">Dosen</span>
                                            <% } %>
                                        </td>
                                        <td style="font-size: 0.9rem; color: var(--text-muted); max-width: 250px;">
                                            <% 
                                                String desc = t.getDeskripsi();
                                                if (desc == null) desc = "";
                                                String truncated = desc;
                                                boolean isLong = false;
                                                if (desc.length() > 60) {
                                                    truncated = desc.substring(0, 60) + "...";
                                                    isLong = true;
                                                }
                                                String escapedJudul = t.getJudul().replace("\"", "&quot;");
                                            %>
                                            <span class="desc-text"><%= truncated %></span>
                                            <% if (isLong) { %>
                                                <div class="hidden-desc" style="display: none;"><%= desc %></div>
                                                <br>
                                                <button type="button" class="btn-link btn-lihat-semua" 
                                                    data-judul="<%= escapedJudul %>"
                                                    data-mk="<%= t.getKodeMk() %> - <%= t.getNamaMk() %>"
                                                    data-deadline="<%= t.getDeadline() %>"
                                                    data-tipe="<%= (t.getIdTugas() < 0) ? "Mandiri" : "Dosen" %>">
                                                    Lihat Semua
                                                </button>
                                            <% } %>
                                        </td>
                                        <td style="font-weight: 600; font-size: 0.9rem;"><%= t.getDeadline() %></td>
                                        <td>
                                            <% if ("SELESAI".equalsIgnoreCase(t.getStatus())) { %>
                                                <span class="badge badge-success">Selesai</span>
                                                <% if (t.getTanggalSelesai() != null) { %>
                                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.25rem;"><%= t.getTanggalSelesai() %></div>
                                                <% } %>
                                            <% } else { %>
                                                <span class="badge badge-danger">Belum</span>
                                            <% } %>
                                        </td>
                                        <td style="text-align: center;">
                                            <% if ("SELESAI".equalsIgnoreCase(t.getStatus())) { %>
                                                <a href="StatusTugasServlet?id=<%= t.getIdTugas() %>&status=BELUM" class="btn btn-secondary btn-sm" style="font-size: 0.75rem; padding: 0.35rem 0.75rem;">Tandai Belum</a>
                                            <% } else { %>
                                                <a href="StatusTugasServlet?id=<%= t.getIdTugas() %>&status=SELESAI" class="btn btn-success btn-sm" style="font-size: 0.75rem; padding: 0.35rem 0.75rem;">Tandai Selesai</a>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

            <!-- Active Courses Cards -->
            <div class="glass-container" style="padding: 2rem;">
                <h2 style="font-size: 1.5rem; margin-bottom: 1.25rem; font-weight: 600;">Mata Kuliah Semester Aktif</h2>
                <div class="grid-3">
                    <% for (MataKuliah c : courses) { %>
                        <div class="course-card">
                            <div>
                                <div class="course-code"><%= c.getKodeMK() %></div>
                                <div class="course-name"><%= c.getNamaMK() %></div>
                            </div>
                            <div class="course-sem">Semester <%= c.getSemester() %></div>
                        </div>
                    <% } %>
                </div>
            </div>
            
        </div>
        
    </div>
</div>

<!-- Modal Detail Tugas -->
<div id="taskModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <div class="modal-header-left">
                <span class="modal-header-icon">📋</span>
                <h3 class="modal-title">Detail Tugas</h3>
            </div>
            <button class="modal-close" type="button">&times;</button>
        </div>
        <div class="modal-body">
            <h2 id="modalTitle" class="modal-task-title"></h2>
            
            <div class="modal-meta-grid">
                <div class="modal-meta-card meta-course">
                    <span class="modal-meta-label">Mata Kuliah</span>
                    <span id="modalMk" class="modal-meta-value"></span>
                </div>
                
                <div class="modal-meta-card meta-type">
                    <span class="modal-meta-label">Tipe Tugas</span>
                    <span id="modalTipe" class="modal-meta-value"></span>
                </div>
                
                <div class="modal-meta-card meta-deadline" style="grid-column: span 2;">
                    <span class="modal-meta-label">Batas Waktu (Deadline)</span>
                    <span id="modalDeadline" class="modal-meta-value"></span>
                </div>
            </div>
            
            <div class="modal-desc-container">
                <div class="modal-desc-header">
                    <span>📝</span> Deskripsi Tugas
                </div>
                <div id="modalDesc" class="modal-description"></div>
            </div>
        </div>
    </div>
</div>

<script src="js/script.js?v=<%= System.currentTimeMillis() %>"></script>
</body>
</html>
