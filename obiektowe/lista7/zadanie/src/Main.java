public class Main {
    public static void main(String args[]) {

        switch (args[0]) {
            case "Figura":
                FiguraInterface fu = new FiguraInterface(args[1]);
                break;
            case "Trojkat":
                TrojkatInterface tr = new TrojkatInterface(args[1]);
                break;
            case "Kolo":
                KoloInterface ko = new KoloInterface(args[1]);
                break;
            default:
                System.out.println("Nie ma takiej klasy");
        }
        return;
    }
}
