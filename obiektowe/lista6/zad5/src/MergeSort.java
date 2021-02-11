public class MergeSort extends Thread {
    int[] tab;
    int n;

    public MergeSort (int[] a) {
        this.tab = a;
        this.n = a.length;

        //for (int i = 0;i < n;i++) System.out.print(tab[i] + " ");
    }

    void Sort() {

        int[] tab1 = new int[n/2];
        int[] tab2 = new int[n - n/2];
        int a = 0;

        for (int i = 0; i < n; i++) {
            if (i < n/2) tab1[i] = tab[i];
            else tab2[a++] = tab[i];
        }
        //***************************
        //for (int i = 0; i < n/2;i++) System.out.print(tab1[i] + " ");
        //System.out.print("\n");
        //for (int i = 0; i < n - n/2; i++) System.out.print(tab2[i] + " ");
        //****************************
        MergeSort m1 = new MergeSort(tab1);
        MergeSort m2 = new MergeSort(tab2);
        Merge w = new Merge(m1.Result(), m2.Result());
        this.tab = w.Merge();
    }

    public void run() {
        if (n <= 1);
        else this.Sort();
    }

    public int[] Result () {
        this.run();
        return this.tab;
    }

}
