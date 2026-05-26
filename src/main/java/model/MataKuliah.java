package model;

public class MataKuliah {

    private int idMk;
    private String kodeMK;
    private String namaMK;
    private int semester;

    public MataKuliah(int idMk,
                      String kodeMK,
                      String namaMK,
                      int semester) {

        this.idMk = idMk;
        this.kodeMK = kodeMK;
        this.namaMK = namaMK;
        this.semester = semester;
    }

    public int getIdMk() {
        return idMk;
    }

    public void setIdMk(int idMk) {
        this.idMk = idMk;
    }

    public String getKodeMK() {
        return kodeMK;
    }

    public void setKodeMK(String kodeMK) {
        this.kodeMK = kodeMK;
    }

    public String getNamaMK() {
        return namaMK;
    }

    public void setNamaMK(String namaMK) {
        this.namaMK = namaMK;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }
}