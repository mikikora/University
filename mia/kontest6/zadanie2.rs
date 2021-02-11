use std::io::{stdin};
use std::cmp;

fn read() -> String {
    let mut s = String::new();
    stdin().read_line(&mut s).expect("wrong string");
    s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    s.split_whitespace().next().unwrap().to_string()
}

fn check(s: String, c: char) -> u32 {
    let mut sum = 0u32;
    for i in s.chars() {
        if i != c {
            sum += 1;
        }
    }
    sum
}

fn count(s: String, c: char) -> u32 {
    if s.len() == 1 {
        if s.eq(&c.to_string()) {
            return 0;
        } else {
            return 1;
        }
    }
    let mut l = s;
    let r = l.split_off(l.len()/2);
    return cmp::min(count(r.clone(), (c as u8 + 1) as char) + check(l.clone(), c), count(l, (c as u8 + 1) as char) + check(r, c));
}

fn main() {
    let mut st = String::new();
    stdin().read_line(&mut st).expect("Wrong string");
    let t = st.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<u32>>().pop().unwrap();
    for _i in 0..t {
        let s = read();
        println!("{}", count(s, 'a'));

    }
}
