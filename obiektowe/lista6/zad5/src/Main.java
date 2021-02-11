import java.util.Random;

public class Main {

    public static void main(String[] args) {
        int[] tab = new int[100];
        Random random = new Random();
        for (int i = 0; i < 100; i++) {
            tab[i] = random.nextInt(50);
            System.out.print(tab[i] + " ");
        }
        System.out.print("\n");
        MergeSort m1 = new MergeSort(tab);
        int[] result = m1.Result();
        for (int i = 0; i < result.length;i++) System.out.print(result[i] + " ");
    }
}
