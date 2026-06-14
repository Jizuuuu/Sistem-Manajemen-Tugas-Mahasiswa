package dao;

import database.Koneksi;
import java.sql.*;
import java.util.ArrayList;
import model.Tugas;

public class TugasMahasiswaDAO {

    public void updateStatus(int idTugas, int idMahasiswa, String status) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Koneksi.getConnection();
            String sql;
            if (idTugas < 0) {
                // Personal task: update tugas_pribadi
                int idPersonal = -idTugas;
                if ("SELESAI".equalsIgnoreCase(status)) {
                    sql = "UPDATE tugas_pribadi SET status = 'SELESAI' WHERE id_tugas_pribadi = ? AND id_mahasiswa = ?";
                } else {
                    sql = "UPDATE tugas_pribadi SET status = 'BELUM' WHERE id_tugas_pribadi = ? AND id_mahasiswa = ?";
                }
                ps = conn.prepareStatement(sql);
                ps.setInt(1, idPersonal);
                ps.setInt(2, idMahasiswa);
            } else {
                // Course task: update tugas_mahasiswa
                if ("SELESAI".equalsIgnoreCase(status)) {
                    sql = "UPDATE tugas_mahasiswa SET status = 'SELESAI', tanggal_selesai = CURDATE() "
                        + "WHERE id_tugas = ? AND id_mahasiswa = ?";
                } else {
                    sql = "UPDATE tugas_mahasiswa SET status = 'BELUM', tanggal_selesai = NULL "
                        + "WHERE id_tugas = ? AND id_mahasiswa = ?";
                }
                ps = conn.prepareStatement(sql);
                ps.setInt(1, idTugas);
                ps.setInt(2, idMahasiswa);
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    public ArrayList<Tugas> getByMahasiswa(int idMahasiswa) {
        ArrayList<Tugas> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT tm.status, tm.tanggal_selesai, t.id_tugas, t.judul, t.deskripsi, t.deadline, t.tanggal_dibuat, t.id_mk, t.id_dosen, mk.nama_mk, mk.kode_mk FROM tugas_mahasiswa tm "
                       + "JOIN tugas t ON tm.id_tugas = t.id_tugas "
                       + "JOIN mata_kuliah mk ON t.id_mk = mk.id_mk "
                       + "WHERE tm.id_mahasiswa = ? "
                       + "UNION ALL "
                       + "SELECT tp.status, NULL AS tanggal_selesai, -tp.id_tugas_pribadi AS id_tugas, tp.judul, tp.deskripsi, tp.deadline, tp.tanggal_dibuat, tp.id_mk, 0 AS id_dosen, mk.nama_mk, mk.kode_mk FROM tugas_pribadi tp "
                       + "JOIN mata_kuliah mk ON tp.id_mk = mk.id_mk "
                       + "WHERE tp.id_mahasiswa = ? "
                       + "ORDER BY deadline ASC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idMahasiswa);
            ps.setInt(2, idMahasiswa);
            rs = ps.executeQuery();
            while (rs.next()) {
                Tugas tugas = new Tugas(
                        rs.getInt("id_tugas"),
                        rs.getString("judul"),
                        rs.getString("deskripsi"),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        rs.getInt("id_mk"),
                        rs.getInt("id_dosen"),
                        rs.getString("tanggal_dibuat")
                );
                tugas.setNamaMk(rs.getString("nama_mk"));
                tugas.setKodeMk(rs.getString("kode_mk"));
                tugas.setTanggalSelesai(rs.getString("tanggal_selesai"));
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

    public ArrayList<Tugas> getDeadlineDekat(int idMahasiswa) {
        ArrayList<Tugas> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT tm.status, tm.tanggal_selesai, t.id_tugas, t.judul, t.deskripsi, t.deadline, t.tanggal_dibuat, t.id_mk, t.id_dosen, mk.nama_mk, mk.kode_mk FROM tugas_mahasiswa tm "
                       + "JOIN tugas t ON tm.id_tugas = t.id_tugas "
                       + "JOIN mata_kuliah mk ON t.id_mk = mk.id_mk "
                       + "WHERE tm.id_mahasiswa = ? "
                       + "AND tm.status = 'BELUM' "
                       + "AND t.deadline >= CURDATE() "
                       + "AND DATEDIFF(t.deadline, CURDATE()) <= 3 "
                       + "UNION ALL "
                       + "SELECT tp.status, NULL AS tanggal_selesai, -tp.id_tugas_pribadi AS id_tugas, tp.judul, tp.deskripsi, tp.deadline, tp.tanggal_dibuat, tp.id_mk, 0 AS id_dosen, mk.nama_mk, mk.kode_mk FROM tugas_pribadi tp "
                       + "JOIN mata_kuliah mk ON tp.id_mk = mk.id_mk "
                       + "WHERE tp.id_mahasiswa = ? "
                       + "AND tp.status = 'BELUM' "
                       + "AND tp.deadline >= CURDATE() "
                       + "AND DATEDIFF(tp.deadline, CURDATE()) <= 3 "
                       + "ORDER BY deadline ASC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idMahasiswa);
            ps.setInt(2, idMahasiswa);
            rs = ps.executeQuery();
            while (rs.next()) {
                Tugas tugas = new Tugas(
                        rs.getInt("id_tugas"),
                        rs.getString("judul"),
                        rs.getString("deskripsi"),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        rs.getInt("id_mk"),
                        rs.getInt("id_dosen"),
                        rs.getString("tanggal_dibuat")
                );
                tugas.setNamaMk(rs.getString("nama_mk"));
                tugas.setKodeMk(rs.getString("kode_mk"));
                tugas.setTanggalSelesai(rs.getString("tanggal_selesai"));
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
}
