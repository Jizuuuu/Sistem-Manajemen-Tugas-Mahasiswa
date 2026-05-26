<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistem Manajemen Tugas</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="login-wrapper">
    <div class="glass-container login-card">
        <div class="login-logo">TaskMan</div>
        
        <h2 style="margin-bottom: 1.5rem; font-weight: 600;">Sistem Manajemen Tugas</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #ef4444; padding: 0.75rem; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.9rem;">
                Email atau password salah. Silakan coba lagi.
            </div>
        <% } %>
        
        <form action="LoginServlet" method="post">
            <div class="form-group" style="text-align: left;">
                <label for="email">Alamat Email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="nama@email.com" required autocomplete="email">
            </div>
            
            <div class="form-group" style="text-align: left; margin-bottom: 2rem;">
                <label for="password">Kata Sandi</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                Masuk ke Akun
            </button>
        </form>
        
        <div style="margin-top: 2rem; font-size: 0.85rem; color: var(--text-muted);">
            Sistem Manajemen Tugas Mahasiswa &copy; 2026
        </div>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>