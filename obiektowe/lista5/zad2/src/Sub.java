public class Sub extends Operator {
    Sub (wyrazenie left, wyrazenie right) {
        super(left, right);
        op = "-";
    }
    public int operate (int right, int left) {
        return left - right;
    }
    public wyrazenie CountDerivative (String name) {
        return new Sub(left.CountDerivative(name), right.CountDerivative(name));
    }
}
