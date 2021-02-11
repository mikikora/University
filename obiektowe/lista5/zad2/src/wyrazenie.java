import java.util.Hashtable;

abstract public class wyrazenie {
    static Hashtable<String, Integer> hst;
    public wyrazenie () {
        hst = new Hashtable<>();
    }
    public void AddVariable (String name, int val) {
        hst.put(name, val);
    }
    abstract public int Oblicz();
    abstract public String ToString();
    abstract public wyrazenie CountDerivative(String name);
}
