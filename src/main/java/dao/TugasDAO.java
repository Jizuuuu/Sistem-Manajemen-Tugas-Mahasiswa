package dao;

import database.Koneksi;
import java.sql.*;
import java.util.ArrayList;
import model.Tugas;

public class TugasDAO {

    public void insert(Tugas tugas) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "INSERT INTO tugas (judul, deskripsi, deadline, id_mk, id_dosen) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, tugas.getJudul());
            ps.setString(2, tugas.getDeskripsi());
            ps.setString(3, tugas.getDeadline());
            ps.setInt(4, tugas.getIdMk());
            ps.setInt(5, tugas.getIdDosen());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int idTugas = rs.getInt(1);
                
                // Automatically assign this task to all students taking the same semester as the course
                String assignSql = "INSERT INTO tugas_mahasiswa (id_tugas, id_mahasiswa, status) "
                                 + "SELECT ?, id_mahasiswa, 'BELUM' FROM mahasiswa "
                                 + "WHERE semester = (SELECT semester FROM mata_kuliah WHERE id_mk = ?)";
                
                PreparedStatement assignPs = conn.prepareStatement(assignSql);
                assignPs.setInt(1, idTugas);
                assignPs.setInt(2, tugas.getIdMk());
                assignPs.executeUpdate();
                assignPs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    public void update(Tugas tugas) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "UPDATE tugas SET judul = ?, deskripsi = ?, deadline = ?, id_mk = ? WHERE id_tugas = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, tugas.getJudul());
            ps.setString(2, tugas.getDeskripsi());
            ps.setString(3, tugas.getDeadline());
            ps.setInt(4, tugas.getIdMk());
            ps.setInt(5, tugas.getIdTugas());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    public void delete(int idTugas) {
        Connection conn = null;
        PreparedStatement psTm = null;
        PreparedStatement psT = null;
        try {
            conn = Koneksi.getConnection();
            
            // Delete from tugas_mahasiswa first due to foreign keys
            String sqlTm = "DELETE FROM tugas_mahasiswa WHERE id_tugas = ?";
            psTm = conn.prepareStatement(sqlTm);
            psTm.setInt(1, idTugas);
            psTm.executeUpdate();

            // Delete from tugas
            String sqlT = "DELETE FROM tugas WHERE id_tugas = ?";
            psT = conn.prepareStatement(sqlT);
            psT.setInt(1, idTugas);
            psT.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (psTm != null) psTm.close(); } catch (SQLException e) {}
            try { if (psT != null) psT.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    public ArrayList<Tugas> getAll() {
        ArrayList<Tugas> list = new ArrayList<>();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            st = conn.createStatement();
            String sql = "SELECT t.*, mk.nama_mk, mk.kode_mk FROM tugas t "
                       + "JOIN mata_kuliah mk ON t.id_mk = mk.id_mk "
                       + "ORDER BY t.tanggal_dibuat DESC";
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Tugas tugas = new Tugas(
                        rs.getInt("id_tugas"),
                        rs.getString("judul"),
                        rs.getString("deskripsi"),
                        rs.getString("deadline"),
                        "BELUM",
                        rs.getInt("id_mk"),
                        rs.getInt("id_dosen"),
                        rs.getString("tanggal_dibuat")
                );
                tugas.setNamaMk(rs.getString("nama_mk"));
                tugas.setKodeMk(rs.getString("kode_mk"));
                list.add(tugas);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (st != null) st.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        return list;
    }

    public ArrayList<Tugas> getByDosen(int idDosen) {
        ArrayList<Tugas> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT t.*, mk.nama_mk, mk.kode_mk FROM tugas t "
                       + "JOIN mata_kuliah mk ON t.id_mk = mk.id_mk "
                       + "JOIN dosen_mk dmk ON t.id_mk = dmk.id_mk "
                       + "WHERE dmk.id_dosen = ? "
                       + "ORDER BY t.tanggal_dibuat DESC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idDosen);
            rs = ps.executeQuery();
            while (rs.next()) {
                Tugas tugas = new Tugas(
                        rs.getInt("id_tugas"),
                        rs.getString("judul"),
                        rs.getString("deskripsi"),
                        rs.getString("deadline"),
                        "BELUM",
                        rs.getInt("id_mk"),
                        rs.getInt("id_dosen"),
                        rs.getString("tanggal_dibuat")
                );
                tugas.setNamaMk(rs.getString("nama_mk"));
                tugas.setKodeMk(rs.getString("kode_mk"));
                list.add(tugas);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        return list;
    }

    public Tugas getById(int idTugas) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT t.*, mk.nama_mk, mk.kode_mk FROM tugas t "
                       + "JOIN mata_kuliah mk ON t.id_mk = mk.id_mk "
                       + "WHERE t.id_tugas = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idTugas);
            rs = ps.executeQuery();
            if (rs.next()) {
                Tugas tugas = new Tugas(
                        rs.getInt("id_tugas"),
                        rs.getString("judul"),
                        rs.getString("deskripsi"),
                        rs.getString("deadline"),
                        "BELUM",
                        rs.getInt("id_mk"),
                        rs.getInt("id_dosen"),
                        rs.getString("tanggal_dibuat")
                );
                tugas.setNamaMk(rs.getString("nama_mk"));
                tugas.setKodeMk(rs.getString("kode_mk"));
                return tugas;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        return null;
    }

    public void insertPersonal(Tugas tugas, int idMahasiswa) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "INSERT INTO tugas_pribadi (id_mahasiswa, id_mk, judul, deskripsi, deadline, status) VALUES (?, ?, ?, ?, ?, 'BELUM')";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idMahasiswa);
            ps.setInt(2, tugas.getIdMk());
            ps.setString(3, tugas.getJudul());
            ps.setString(4, tugas.getDeskripsi());
            ps.setString(5, tugas.getDeadline());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}