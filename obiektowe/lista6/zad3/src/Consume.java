public class Consume implements Runnable {
    Buffor<String> buffor;

    public Consume (Buffor b) {
        this.buffor = b;
    }

    public void run () {
        while (true) {
            System.out.println(buffor.Get());
        }
    }
}
