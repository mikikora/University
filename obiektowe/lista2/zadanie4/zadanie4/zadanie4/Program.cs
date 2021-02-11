using System;
using System.Collections.Generic;

namespace zadanie4
{
    class LazyList
    {
        List<int> lista = new List<int>();
        int dlugosc;
        Random rnd = new Random();

        public LazyList()
        {
            dlugosc = 0;
        }

        public int size()
        {
            return dlugosc;
        }

        public int element(int x)
        {

            while (this.size() < x)
            {

                lista.Add(rnd.Next());
                dlugosc++;
            }
            return lista[x-1];
        }


    }


    class MainClass
    {
        public static void Main(string[] args)
        {
            LazyList moja_lista = new LazyList();
            Console.WriteLine(moja_lista.size());
            Console.WriteLine(moja_lista.element(40));
            Console.WriteLine(moja_lista.size());
            Console.WriteLine(moja_lista.element(25));
            Console.WriteLine(moja_lista.size());
            Console.WriteLine(moja_lista.element(40));
        
        }
    }
}
