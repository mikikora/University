public class Constant extends wyrazenie {
    int val;
    Constant (int val) {
        super();
        this.val = val;
    }
    public int Oblicz() {
        return this.val;
    }
    public String ToString() {
        return Integer.toString(this.val);
    }
    public wyrazenie CountDerivative(String name) {
        return new Constant(0);
    }
}
