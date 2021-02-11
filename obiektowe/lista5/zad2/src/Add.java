public class Add extends Operator {
    Add (wyrazenie left, wyrazenie right) {
        super(left, right);
        op = "+";
    }
    public int operate (int right, int left) {
        return right + left;
    }
    public wyrazenie CountDerivative (String name) {
        return new Add(left.CountDerivative(name), right.CountDerivative(name));
    }
}
