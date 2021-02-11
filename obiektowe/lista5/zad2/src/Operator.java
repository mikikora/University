abstract public class Operator extends wyrazenie {
    String op;
    wyrazenie left;
    wyrazenie right;
    Operator (wyrazenie left, wyrazenie right) {
        super();
        this.left = left;
        this.right = right;
    }
    abstract int operate(int right, int left);
    public int Oblicz() {
        return operate(this.left.Oblicz(), this.right.Oblicz());
    }
    public String ToString() {
        return "(" + this.left.ToString() + " " + this.op + " " + this.right.ToString() + ")";
    }
    abstract public wyrazenie CountDerivative (String name);
}
