import java.io.Serializable;

public class Kolo extends Figura implements Serializable {
    public int x;
    public int y;
    public int radiant;

    public Kolo (int Pole, int Obwod, String Nazwa, int x, int y, int r) {
        super(Pole, Obwod, Nazwa);
        this.x = x;
        this.y = y;
        this.radiant = r;
    }

    public Kolo() {}

    public String toString() {
        return super.toString() + "\n" + "Wspolzedne Srodka: " + Integer.toString(x) + " " + Integer.toString(y) + "\nDlugosc promienia: " + Integer.toString(radiant);
    }
}
