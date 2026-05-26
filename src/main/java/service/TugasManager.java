package service;

import dao.TugasDAO;
import dao.TugasMahasiswaDAO;
import java.util.ArrayList;
import model.Tugas;

public class TugasManager {

    private TugasDAO dao;
    private TugasMahasiswaDAO tmDao;

    public TugasManager() {
        dao = new TugasDAO();
        tmDao = new TugasMahasiswaDAO();
    }

    public void tambahTugas(Tugas tugas) {
        dao.insert(tugas);
    }

    public void hapusTugas(int idTugas) {
        dao.delete(idTugas);
    }

    public void updateTugas(Tugas tugas) {
        dao.update(tugas);
    }

    public void ubahStatus(int idTugas, int idMahasiswa, String status) {
        tmDao.updateStatus(idTugas, idMahasiswa, status);
    }

    public ArrayList<Tugas> getSemuaTugas() {
        return dao.getAll();
    }

    public ArrayList<Tugas> getByDosen(int idDosen) {
        return dao.getByDosen(idDosen);
    }

    public ArrayList<Tugas> getByMahasiswa(int idMahasiswa) {
        return tmDao.getByMahasiswa(idMahasiswa);
    }

    public ArrayList<Tugas> getDeadlineDekat(int idMahasiswa) {
        return tmDao.getDeadlineDekat(idMahasiswa);
    }
    
    public Tugas getTugasById(int idTugas) {
        return dao.getById(idTugas);
    }

    public void tambahTugasPersonal(Tugas tugas, int idMahasiswa) {
        dao.insertPersonal(tugas, idMahasiswa);
    }
}