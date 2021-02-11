using System;


namespace zad3
{
    class Program
    {


        public interface IGraph
        {
            void Generate(int w, int k);
            //void Add(string w, string[] k);
            string[] Neighbours(string w);
        }

        class MatrixGraph : IGraph
        {
            int w;
            string[] wiezy;
            bool[,] matrix;

            public MatrixGraph(int w, int k)
            {
                this.w = w;
                this.Generate(this.w, k);
            }

            string ToString(int a)
            {
                string numbers = "0123456789";
                string wynik = "";
                while (a > 0)
                {
                    wynik += numbers[a % 10];
                    a /= 10;
                }
                return wynik;
            }

            public void Generate(int w, int k)
            {
                wiezy = new string[w];
                matrix = new bool[w, w];
                for (int i = 0; i < w; i++)
                {
                    wiezy[i] = "w" + ToString(i);
                }
                Random random = new Random();
                for (int i = 0; i < w; i++)
                {
                    for (int j = 0; j < w; j++) matrix[i, j] = false;
                }
                for (int i = 0; i < k; i++)
                {
                    int a = random.Next() % w;
                    int b = random.Next() % w;
                    matrix[a, b] = (random.Next() % 2 == 0 ? false : true);
                }

            }

            /*void Add(string w, string[]k)
            {
                string[] nowe_wiezy = new string[this.w + 1];
                for (int i = 0;i<this.w;i++)
                {
                    nowe_wiezy[i] = this.wiezy[i];
                }
                nowe_wiezy[this.w] = w;
                this.wiezy = nowe_wiezy;
                this.w++;
                bool[,] new_matrix = new bool[this.w, this.w];
                for (int i = 0; i < this.w; i++)
                {
                    for (int j = 0; j < this.w; j++)
                    {
                        if (i != this.w-1 && j != this.w)
                        {
                            new_matrix[i, j] = this.matrix[i, j];
                        }
                        else
                        {
                            if ()
                        }
                    }
                }*/

            public string[] Neighbours(string w)
            {
                MyList<string> wynik = new MyList<string>("abc");
                wynik.Pop();
                int sprawdzany = this.w;
                for (int i = 0; i < this.w; i++)
                {
                    if (wiezy[i] == w) sprawdzany = i;
                }
                if (sprawdzany == this.w) Console.WriteLine("cos jest nie tak" + w);
                for (int i = 0; i < this.w; i++)
                {
                    if (this.matrix[sprawdzany, i]) wynik.Add(this.wiezy[i]);
                }
                return wynik.Sasiedzi();
            }


        }

        public class MyList<T>
        {
            T[] lista;
            int dl;
            public MyList (T pierwszy)
            {
                lista = new T[1];
                dl = 1;
                lista[0] = pierwszy;
            }

            public bool IsEmpty()
            {
                return dl == 0;
            }

            public void Add (T what)
            {
                T[] new_lista = new T[dl + 1];
                for (int i = 0; i < dl;i++)
                {
                    new_lista[i] = this.lista[i];
                }
                new_lista[dl++] = what;
                this.lista = new_lista;
            }

            public T Pop ()
            {
                //Console.WriteLine(dl);
                //Console.WriteLine(this.IsEmpty());
                T[] new_lista = new T[dl - 1];
                T do_wyjecia = this.lista[0];
                for (int i = 1; i < dl; i++) new_lista[i - 1] = this.lista[i];
                this.lista = new_lista;
                dl--;
                return do_wyjecia;
            }

            public T[] Sasiedzi()
            {
                return this.lista;
            }

            public bool IsIn(T what)
            {
                for (int i = 0; i < dl; i++)
                {
                    if (Equals(this.lista[i], what)) return true;

                }
                return false;
            }
        }

        public class ListGraph : IGraph
        {
            int w;
            string[] wiezy;
            MyList<int>[] sasiedzi;

            public ListGraph (int w, int k)
            {
                this.w = w;
                Generate(w, k);
            }

            string ToString(int a)
            {
                string numbers = "0123456789";
                string wynik = "";
                while (a > 0)
                {
                    wynik += numbers[a % 10];
                    a /= 10;
                }
                return wynik;
            }

            public void Generate (int w, int k)
            {
                wiezy = new string[w];
                for (int i = 0; i < w; i++)
                {
                    wiezy[i] = "w" + ToString(i);
                }
                Random random = new Random();
                sasiedzi = new MyList<int>[w];
                for (int i = 0; i < k; i++)
                {
                    int wylosowany = random.Next() % w;
                    int polaczony = random.Next() % w;
                    if (sasiedzi[wylosowany] == null)
                    {
                        sasiedzi[wylosowany] = new MyList<int>(polaczony);
                    }
                    else
                    {
                        while (sasiedzi[wylosowany].IsIn(polaczony)) polaczony = random.Next() % w;
                        sasiedzi[wylosowany].Add(polaczony);
                    }
                }
            }
            public string[] Neighbours(string w)
            {
                int i;
                for (i = 0; wiezy[i] != w; i++) { }
                int[] do_oddania = sasiedzi[i].Sasiedzi();
                string[] wynik = new string[do_oddania.Length];
                for (int j = 0; j < do_oddania.Length; j++)
                {
                    wynik[j] = "w" + ToString(do_oddania[j]);
                }
                return wynik;
            }
        }

        public class BFS
        {
            public string[] FindWay(IGraph graph, string start, string end)
            {
                MyList<string> queue = new MyList<string>(start);
                MyList<int> fathers_q = new MyList<int>(-1);
                MyList<string> seen = new MyList<string>(start);
                MyList<int> father = new MyList<int>(-1);
                bool koniec;
                koniec = false;
                while (!queue.IsEmpty() && !koniec)
                {
                    //Console.WriteLine(queue.IsEmpty());
                    string akt = queue.Pop();
                    int ojciec = fathers_q.Pop();
                    string[] sasiedzi_akt = graph.Neighbours(akt);
                    for (int i = 0; !koniec && i < sasiedzi_akt.Length;i++)
                    {
                        if (seen.IsIn(sasiedzi_akt[i])) { }
                        else if (Equals(sasiedzi_akt[i], end))
                        {
                            koniec = true;
                            seen.Add(sasiedzi_akt[i]);
                            father.Add(father.Sasiedzi().Length - 1);
                        }
                        else
                        {
                            queue.Add(sasiedzi_akt[i]);
                            seen.Add(sasiedzi_akt[i]);
                            father.Add(father.Sasiedzi().Length - 1);
                            fathers_q.Add(father.Sasiedzi().Length - 1);
                        }
                    }
                }
                //Console.WriteLine("jestem gdzieś tutaj");
                if (!koniec) return new string[0];
                string[] wynikowa = seen.Sasiedzi();
                int[] fathers = father.Sasiedzi();
                int droga = fathers[fathers.Length - 1];
                MyList<string> lista_drogi = new MyList<string>(wynikowa[droga]);
                droga = fathers[droga];
                while (droga > 0)
                {
                    lista_drogi.Add(wynikowa[droga]);
                    droga = fathers[droga];
                }
                string[] lista = lista_drogi.Sasiedzi();
                string[] wynik = new string[lista.Length];
                int k = lista.Length - 1;
                for (int i = 0; i < lista.Length; i++) wynik[i] = lista[k--];
                return wynik;
            }
        }

        static void Main(string[] args)
        {
            DateTime time = DateTime.Now;
            Console.WriteLine(time);
            
            IGraph g = new ListGraph(100, 1000);
            string[] a = g.Neighbours("w1");
            for (int i = 0; i < a.Length; i++)
            {
                if (a[i] != "")
                {
                    //Console.WriteLine(a[i]);
                }

            }
            IGraph graph = new MatrixGraph(100, 1000);
            BFS poszukaj = new BFS();
            string[] wynik = poszukaj.FindWay(graph, "w1", "w2");
            for (int i = 0; i < wynik.Length; i++) Console.WriteLine(wynik[i]);

            Console.WriteLine(time - DateTime.Now);
        }
    }
}