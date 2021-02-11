public class Variable extends wyrazenie {
    String var;
    Variable(String name) {
        super();
        this.var = name;
    }
    public int Oblicz() {
        return hst.get(var);
    }
    public String ToString() {
        return this.var;
    }
    public wyrazenie CountDerivative (String name) {
        if (var == name) return new Constant(1);
        else return new Constant(0);
    }
}
