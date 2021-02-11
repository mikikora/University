import java.io.Serializable;

public class Figura implements Serializable {
    public int Pole;
    public int Obwod;
    public String Nazwa;

    public Figura(int Pole, int Obwod, String Nazwa) {
        this.Pole = Pole;
        this.Obwod = Obwod;
        this.Nazwa = Nazwa;
    }

    public Figura() {}

    public String toString() {
        return "Pole: " + Integer.toString(Pole) + "\nObwod: " + Integer.toString(Obwod) + "\nNazwa: " + Nazwa;
    }
}
