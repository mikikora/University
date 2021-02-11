using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zadanie1
{
    class IntStream
    {
        protected int liczba;
        public int max = 2147483647;

        protected bool czy_koniec;
        
        public IntStream()
        {
            liczba = 0;
        }
        
        public void reset ()
        {
            liczba = 0;
            czy_koniec = false; 
        }

        protected bool eos()
        {
            return czy_koniec;
        }

        public int next()
        {
            if (liczba >= max) czy_koniec = true;
            if (eos() == true)
            {
                return 0;
            }
            else
            {
                return liczba++;

            }
            
        }

    }

    class PrimeStream : IntStream
    {
        private bool czy_pierwsza (int a)
        {
            if (a == 0 || a == 1) return false;
            if (a == 2) return true;
            for (int i = 2; i * i <= a; i++)
            {
                if (a % i == 0) return false;
            }
            return true;
        }


        public int next()
        {
            while (!base.czy_koniec && !czy_pierwsza(base.liczba))
            {
                liczba++;
                if (liczba == base.max)
                {
                    base.czy_koniec = true;
                }
            }
            return base.next();
        }
    }

    class RandomStream : IntStream
    {
        Random rand; 
        
        public RandomStream()
        {
            rand = new Random();
        }

        public int next(int przedzial)
        {
            base.liczba = rand.Next(przedzial);
            return base.next();
        }
    }

    class RandomWordStream
    {
        string litery = "abcdefghijklmnopqrstuwxyvzABCDEFGHIJKLMNOPRQRSTUWXYZV";
        PrimeStream pierwsza = new PrimeStream();
        RandomStream losowa = new RandomStream();

        int p;

        public string give_me_my_string ()
        {
            string wynik = "";
            p = pierwsza.next();
            for (int i = 0; i < p; i++)
            {
                wynik = wynik + litery[losowa.next(litery.Length)];
            }
            return wynik;
        }

    }



    class Program
    {
        static void Main(string[] args)
        {
            RandomWordStream losowy_string = new RandomWordStream();
            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(losowy_string.give_me_my_string());
                
            }
            Console.ReadLine();
        }
    }
}
