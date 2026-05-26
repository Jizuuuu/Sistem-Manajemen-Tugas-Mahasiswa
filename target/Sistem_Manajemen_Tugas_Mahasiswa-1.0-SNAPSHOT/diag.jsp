<%@page import="java.sql.*"%>
<%@page import="database.Koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Database Diagnostic Page</title>
</head>
<body style="font-family: sans-serif; background: #0f172a; color: #f8fafc; padding: 2rem;">
    <h2>Database Connection Diagnostics</h2>
    <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin-bottom: 2rem;">
    
    <%
    Connection conn = null;
    try {
        out.println("<p style='color: #38bdf8;'>1. Attempting Class.forName(\"com.mysql.cj.jdbc.Driver\")...</p>");
        Class.forName("com.mysql.cj.jdbc.Driver");
        out.println("<p style='color: #4ade80;'>SUCCESS: Driver class found!</p>");
        
        out.println("<p style='color: #38bdf8; margin-top: 1rem;'>2. Attempting to get database connection...</p>");
        conn = Koneksi.getConnection();
        if (conn != null) {
            out.println("<p style='color: #4ade80;'>SUCCESS: Connected to database successfully!</p>");
            
            out.println("<p style='color: #38bdf8; margin-top: 1rem;'>3. Testing query on 'user' table...</p>");
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT count(*) as count FROM user");
            if (rs.next()) {
                out.println("<p style='color: #4ade80;'>SUCCESS: Query executed! Total users in database: " + rs.getInt("count") + "</p>");
            }
            rs.close();
            st.close();
        } else {
            out.println("<p style='color: #ef4444;'>FAILED: Koneksi.getConnection() returned null.</p>");
        }
    } catch (Throwable e) {
        out.println("<p style='color: #ef4444; margin-top: 1rem;'><strong>EXCEPTION ENCOUNTERED:</strong></p>");
        out.println("<pre style='background: #1e293b; padding: 1rem; border-radius: 8px; border: 1px solid rgba(255,255,255,0.08); color: #f43f5e; overflow-x: auto;'>");
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.print(sw.toString());
        out.println("</pre>");
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (Exception ex) {}
        }
    }
    %>
</body>
</html>
