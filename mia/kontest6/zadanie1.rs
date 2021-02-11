use std::io::{stdin};
use std::io::{self, Write};

fn ask(l:usize, r:usize) -> u32 {
    println!("? {} {}", l, r);
    io::stdout().flush().ok().expect("Could not flush stdout");
    let mut s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let n: u32 = s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<u32>>().pop().unwrap();
    return n;
}


fn main() {
    let mut s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let n: usize = s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<usize>>().pop().unwrap();
    let sum = ask(1, n);

    let mut tab: [u32; 1000] = [0; 1000];
    tab[0] = sum - ask(2,n);
    tab[(n-1) as usize] = sum - tab[0];
    for i in 2..n {
        tab[i-1] = ask(i-1, i) - tab[i-2];
        tab[n-1] -= tab[i-1];
    }
    print!("! ");
    for i in 0..n {
        print!("{} ", tab[i]);
    }
}
