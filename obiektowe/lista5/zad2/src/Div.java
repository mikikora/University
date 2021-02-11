public class Div extends Operator {
    Div(wyrazenie left, wyrazenie right) {
        super(left, right);
        op = "/";
    }
    public int operate (int right, int left) {
        return right / left;
    }
    public wyrazenie CountDerivative (String name) {
        return new Div(new Sub(new Mult(left.CountDerivative(name), right), new Mult(left, right.CountDerivative(name))), new Mult(right, right));
    }
}
