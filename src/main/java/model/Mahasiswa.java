package model;

public class Mahasiswa extends User {

    private int idMahasiswa;
    private String nim;
    private int semester;

    public Mahasiswa(int idUser,
                     String nama,
                     String email,
                     String password,
                     int idMahasiswa,
                     String nim,
                     int semester) {

        super(idUser, nama, email, password);
        this.idMahasiswa = idMahasiswa;
        this.nim = nim;
        this.semester = semester;
    }

    @Override
    public String tampilDashboard() {

        return "Dashboard Mahasiswa";
    }

    public int getIdMahasiswa() {
        return idMahasiswa;
    }

    public void setIdMahasiswa(int idMahasiswa) {
        this.idMahasiswa = idMahasiswa;
    }

    public String getNim() {
        return nim;
    }

    public void setNim(String nim) {
        this.nim = nim;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }
}