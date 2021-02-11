public class Mult extends Operator {
    Mult (wyrazenie left, wyrazenie right) {
        super(left, right);
        op = "*";
    }
    public int operate (int left, int right) {
        return left * right;
    }
    public wyrazenie CountDerivative (String name) {
        return new Add(new Mult(left.CountDerivative(name), right), new Mult(left, right.CountDerivative(name)));
    }
}
