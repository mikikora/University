import java.util.Random;

public class Produce implements Runnable {
    Buffor<String > buffor;
    String alfabet = "ABCDEFGHIJKLMNOPQRSTUWXYZabcdefghijklmnopqrstuwxyz";

    public Produce(int n) {
        buffor = new Buffor<String>(n);

    }

    public Buffor GiveBuffor () {
        return this.buffor;
    }


    public void run () {
        Random random = new Random();
        while (true) {
            int size = random.nextInt(100);
            String nowy = "";
            for (int i = 0;i< size;i++) {
                nowy = nowy + alfabet.charAt(random.nextInt(alfabet.length()));
            }
            buffor.Push(nowy);
        }
    }
}
