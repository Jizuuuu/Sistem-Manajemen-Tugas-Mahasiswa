package model;

public class Dosen extends User {

    private int idDosen;
    private String nidn;

    public Dosen(int idUser,
                 String nama,
                 String email,
                 String password,
                 int idDosen,
                 String nidn) {

        super(idUser, nama, email, password);
        this.idDosen = idDosen;
        this.nidn = nidn;
    }

    @Override
    public String tampilDashboard() {

        return "Dashboard Dosen";
    }

    public int getIdDosen() {
        return idDosen;
    }

    public void setIdDosen(int idDosen) {
        this.idDosen = idDosen;
    }

    public String getNidn() {
        return nidn;
    }

    public void setNidn(String nidn) {
        this.nidn = nidn;
    }
}