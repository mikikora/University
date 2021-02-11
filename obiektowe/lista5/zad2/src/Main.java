
public class Main {

    public static void main(String[] args) {
        System.out.println("Zadanie 2\n");
        wyrazenie moje = new Add(new Constant(4), new Variable("x"));
        System.out.println(moje.ToString());
        moje.AddVariable("x", 5);
        System.out.println(moje.Oblicz());
        wyrazenie moje2 = new Sub(new Div(new Variable("z"), new Constant(123)), new Mult(new Add(new Variable("c"), new Variable("z")), new Constant(3)));
        moje2.AddVariable("z", -3);
        moje2.AddVariable("c", 0);
        System.out.println(moje2.ToString());
        System.out.println(moje2.Oblicz());
        //****************************************************************
        //zadanie 4
        System.out.println("\nZadanie 4\n");
        System.out.println(moje.CountDerivative("x").ToString());
        System.out.println(moje2.CountDerivative("z").ToString());

    }
}
