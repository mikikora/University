public class Buffor<T> {

    class Elem<T> {
        T val;
        Elem (T a) {this.val = a;}
        T Get () {return this.val;}
    }

    Elem<T>[] tab;
    int to_get;
    int to_push;
    int size;

    public Buffor (int n) {
        this.tab = new Elem[n];
        to_push = 0;
        to_get = 0;
        size = n;
    }

    public boolean IsFull () {
        return to_push == to_get && ((to_push == size - 1 && tab[0] != null) || (to_push < size - 1 && tab[to_push + 1] != null));
    }

    public synchronized void Push (T val) {
        if (this.IsFull()) {
            try {
                System.out.println("\nzatrzymane Push\n");
                wait();
            }catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        if (to_push + 1 == size) {
            tab[to_push] = new Elem<T>(val);
            to_push = 0;
        } else tab[to_push++] = new Elem<T>(val);
        notifyAll();
    }

    public boolean IsEmpty () {
        return to_get == to_push && ((to_get == size - 1 && tab[0] == null) || (to_get < size - 1 && tab[to_get + 1] == null));
    }

    public synchronized T Get () {
        if (this.IsEmpty()) {
            try {
                System.out.println("\nzatrzymane Get\n");
                wait();
            }catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        T res = tab[to_get].Get();
        tab[to_get++] = null;
        if (to_get == size) to_get = 0;
        notifyAll();
        return res;
    }
}
