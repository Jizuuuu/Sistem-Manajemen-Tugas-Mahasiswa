<%@page import="model.User"%>
<%@page import="model.Mahasiswa"%>
<%@page import="model.Dosen"%>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
} else if (user instanceof Mahasiswa) {
    response.sendRedirect("dashboardMahasiswa.jsp");
} else if (user instanceof Dosen) {
    response.sendRedirect("dashboardDosen.jsp");
} else {
    response.sendRedirect("login.jsp");
}
%>