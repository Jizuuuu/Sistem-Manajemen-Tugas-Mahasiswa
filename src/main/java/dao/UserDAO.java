package dao;

import database.Koneksi;
import java.sql.*;
import model.*;

public class UserDAO {

    public User login(String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                int idUser = rs.getInt("id_user");
                String nama = rs.getString("nama");
                String role = rs.getString("role");
                
                if ("MAHASISWA".equalsIgnoreCase(role)) {
                    String mSql = "SELECT * FROM mahasiswa WHERE id_user = ?";
                    PreparedStatement mPs = conn.prepareStatement(mSql);
                    mPs.setInt(1, idUser);
                    ResultSet mRs = mPs.executeQuery();
                    if (mRs.next()) {
                        int idMahasiswa = mRs.getInt("id_mahasiswa");
                        String nim = mRs.getString("nim");
                        int semester = mRs.getInt("semester");
                        return new Mahasiswa(idUser, nama, email, password, idMahasiswa, nim, semester);
                    }
                    mRs.close();
                    mPs.close();
                } else if ("DOSEN".equalsIgnoreCase(role)) {
                    String dSql = "SELECT * FROM dosen WHERE id_user = ?";
                    PreparedStatement dPs = conn.prepareStatement(dSql);
                    dPs.setInt(1, idUser);
                    ResultSet dRs = dPs.executeQuery();
                    if (dRs.next()) {
                        int idDosen = dRs.getInt("id_dosen");
                        String nidn = dRs.getString("nidn");
                        return new Dosen(idUser, nama, email, password, idDosen, nidn);
                    }
                    dRs.close();
                    dPs.close();
                }
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

    public User getById(int idUser) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            String sql = "SELECT * FROM user WHERE id_user = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUser);
            rs = ps.executeQuery();
            if (rs.next()) {
                String nama = rs.getString("nama");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String role = rs.getString("role");
                
                if ("MAHASISWA".equalsIgnoreCase(role)) {
                    String mSql = "SELECT * FROM mahasiswa WHERE id_user = ?";
                    PreparedStatement mPs = conn.prepareStatement(mSql);
                    mPs.setInt(1, idUser);
                    ResultSet mRs = mPs.executeQuery();
                    if (mRs.next()) {
                        int idMahasiswa = mRs.getInt("id_mahasiswa");
                        String nim = mRs.getString("nim");
                        int semester = mRs.getInt("semester");
                        return new Mahasiswa(idUser, nama, email, password, idMahasiswa, nim, semester);
                    }
                    mRs.close();
                    mPs.close();
                } else if ("DOSEN".equalsIgnoreCase(role)) {
                    String dSql = "SELECT * FROM dosen WHERE id_user = ?";
                    PreparedStatement dPs = conn.prepareStatement(dSql);
                    dPs.setInt(1, idUser);
                    ResultSet dRs = dPs.executeQuery();
                    if (dRs.next()) {
                        int idDosen = dRs.getInt("id_dosen");
                        String nidn = dRs.getString("nidn");
                        return new Dosen(idUser, nama, email, password, idDosen, nidn);
                    }
                    dRs.close();
                    dPs.close();
                }
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
}