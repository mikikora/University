use std::io::{stdin};

fn main() {
    let mut s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let _n: usize = s.split_whitespace().map(|x| x.parse::<usize>().unwrap()).collect::<Vec<usize>>().pop().unwrap();
    s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let mut v: Vec<u32> = s.split_whitespace().map(|x| x.parse::<u32>().unwrap()).collect();

    v.reverse();
    let mut dp: u32 = 0u32;
    let mut sum: u32 = 0u32;
    for e in v.into_iter() {
        if dp == 0 {
            dp = e;
        } else if e + sum - dp > dp {
            dp = e + sum - dp;
        } 
        sum += e;
    }
    println!("{} {}", sum - dp, dp);
}
