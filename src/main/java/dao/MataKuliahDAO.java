package dao;

import database.Koneksi;
import java.sql.*;
import java.util.ArrayList;
import model.MataKuliah;

public class MataKuliahDAO {

    public ArrayList<MataKuliah> getAll() {
        ArrayList<MataKuliah> list = new ArrayList<>();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM mata_kuliah ORDER BY semester, nama_mk");
            while (rs.next()) {
                list.add(new MataKuliah(
                        rs.getInt("id_mk"),
                        rs.getString("kode_mk"),
                        rs.getString("nama_mk"),
                        rs.getInt("semester")
                ));
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

    public ArrayList<MataKuliah> getBySemester(int semester) {
        ArrayList<MataKuliah> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Koneksi.getConnection();
            ps = conn.prepareStatement("SELECT * FROM mata_kuliah WHERE semester = ? ORDER BY nama_mk");
            ps.setInt(1, semester);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new MataKuliah(
                        rs.getInt("id_mk"),
                        rs.getString("kode_mk"),
                        rs.getString("nama_mk"),
                        rs.getInt("semester")
                ));
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
