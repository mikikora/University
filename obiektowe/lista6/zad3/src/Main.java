public class Main {

    public static void main(String[] args) {
        System.out.println("Hello world!");
        Produce prod = new Produce(10);
        Thread productor = new Thread(prod);
        Thread consumer = new Thread(new Consume(prod.GiveBuffor()));
        productor.start();
        consumer.start();
    }
}
