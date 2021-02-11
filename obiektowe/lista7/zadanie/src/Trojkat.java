import java.io.Serializable;

public class Trojkat extends Figura implements Serializable {
    int h;
    int x1, y1;
    int x2, y2;
    int x3, y3;

    public Trojkat(int Pole, int Obwod, String Nazwa, int h, int x1, int y1, int x2, int y2, int x3, int y3) {
        super(Pole, Obwod, Nazwa);
        this.h = h;
        this.x1 = x2;
        this.x2 = x2;
        this.x3 = x3;
        this.y1 = y1;
        this.y2 = y2;
        this.y3 = y3;
    }

    public Trojkat() {}

    public String toString() {
        return super.toString() + "\n" + "Wysokosc: " + Integer.toString(h) + "\nWierzcholki:\n" + Integer.toString(x1) + " " + Integer.toString(y1) + "\n" + Integer.toString(x2) + " " + Integer.toString(y2) + "\n" + Integer.toString(x3) + " " + Integer.toString(y3);
    }
}
