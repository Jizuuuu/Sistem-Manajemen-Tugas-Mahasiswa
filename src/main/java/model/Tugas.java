package model;

import interfaces.Notifikasi;

public class Tugas implements Notifikasi {

    private int idTugas;
    private String judul;
    private String deskripsi;
    private String deadline;
    private String status;
    private int idMk;
    private int idDosen;
    private String tanggalDibuat;
    private String tanggalSelesai;
    private String namaMk;
    private String kodeMk;

    public Tugas(String judul,
                 String deskripsi,
                 String deadline) {

        this.judul = judul;
        this.deskripsi = deskripsi;
        this.deadline = deadline;
        this.status = "BELUM";
    }

    public Tugas(int idTugas,
                 String judul,
                 String deskripsi,
                 String deadline,
                 String status,
                 int idMk,
                 int idDosen,
                 String tanggalDibuat) {

        this.idTugas = idTugas;
        this.judul = judul;
        this.deskripsi = deskripsi;
        this.deadline = deadline;
        this.status = status;
        this.idMk = idMk;
        this.idDosen = idDosen;
        this.tanggalDibuat = tanggalDibuat;
    }

    @Override
    public void kirimNotifikasi() {

        System.out.println(
                "Deadline tugas "
                + judul
                + " : "
                + deadline
        );
    }

    public int getIdTugas() {
        return idTugas;
    }

    public void setIdTugas(int idTugas) {
        this.idTugas = idTugas;
    }

    public String getJudul() {
        return judul;
    }

    public void setJudul(String judul) {
        this.judul = judul;
    }

    public String getDeskripsi() {
        return deskripsi;
    }

    public void setDeskripsi(String deskripsi) {
        this.deskripsi = deskripsi;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getIdMk() {
        return idMk;
    }

    public void setIdMk(int idMk) {
        this.idMk = idMk;
    }

    public int getIdDosen() {
        return idDosen;
    }

    public void setIdDosen(int idDosen) {
        this.idDosen = idDosen;
    }

    public String getTanggalDibuat() {
        return tanggalDibuat;
    }

    public void setTanggalDibuat(String tanggalDibuat) {
        this.tanggalDibuat = tanggalDibuat;
    }

    public String getTanggalSelesai() {
        return tanggalSelesai;
    }

    public void setTanggalSelesai(String tanggalSelesai) {
        this.tanggalSelesai = tanggalSelesai;
    }

    public String getNamaMk() {
        return namaMk;
    }

    public void setNamaMk(String namaMk) {
        this.namaMk = namaMk;
    }

    public String getKodeMk() {
        return kodeMk;
    }

    public void setKodeMk(String kodeMk) {
        this.kodeMk = kodeMk;
    }
}