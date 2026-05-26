package model;

public abstract class User {

    protected int idUser;
    protected String nama;
    protected String email;
    protected String password;

    public User(int idUser,
                String nama,
                String email,
                String password) {

        this.idUser = idUser;
        this.nama = nama;
        this.email = email;
        this.password = password;
    }

    public boolean login(String email,
                         String password) {

        return this.email.equals(email)
                && this.password.equals(password);
    }

    public void logout() {

        System.out.println("Logout berhasil");
    }

    public abstract String tampilDashboard();

    public String getNama() {
        return nama;
    }

    public String getEmail() {
        return email;
    }
}