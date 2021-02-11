public class Merge {

    int[] tab1;
    int[] tab2;
    int n;
    int m;

    public Merge (int[] a, int[] b) {
        this.tab1 = a;
        this.tab2 = b;
        this.n = a.length;
        this.m = b.length;
    }

    public int[] Merge () {
        int[] res = new int[n + m];
        int a = 0;
        int b = 0;
        for (int i = 0; i < n + m; i++) {
            if (a >= n) res[i] = tab2[b++];
            else if (b >= m) res[i] = tab1[a++];
            else if (tab1[a] < tab2[b]) res[i] = tab1[a++];
            else res[i] = tab2[b++];
        }
        return res;
    }
}
