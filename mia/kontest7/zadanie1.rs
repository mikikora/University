use std::io::{stdin};
use std::cmp;


fn add(D: &mut Vec<i64>, a: usize, b: usize, u: usize, lo: usize, hi: usize, v: i64) {
    //println!("{} {} {} {} {} ", u, a, b, lo, hi);
    if a == lo && b == hi {
        D[u] += v;
        return ();
    }
    if b <= a {
        return ();
    }
    let mid = (lo + hi)/2;
    add(D, a, cmp::min(b, mid), 2*u, lo, mid, v);
    add(D, cmp::max(a, mid), b, 2*u+1, mid, hi, v);
}

fn getval(D: &mut Vec<i64>, x: usize, size: usize) -> i64 {
    let mut p = x + size - (size + 1)/2;
    //println!("{}", p);
    let mut res = D[p];
    p = p / 2;
    while p > 0 {
        res += D[p];
        p /= 2;
    }
    res
}


fn main() {
    let mut s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let mut v = s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<usize>>();
    let k = v.pop().unwrap();
    let m = v.pop().unwrap();
    let n = v.pop().unwrap();
    s = String::new();
    stdin().read_line(&mut s).expect("Wrong string");
    let arr = s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<i64>>();
    let mut operations: Vec<Vec<usize>> = Vec::new();
    for _ in 0..m {
        s = String::new();
        stdin().read_line(&mut s).expect("Wrong string");
        operations.push(s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<usize>>());
    }
    let mut query: Vec<Vec<usize>> = Vec::new();
    for _ in 0..k {
        s = String::new();
        stdin().read_line(&mut s).expect("Wrong string");
        query.push(s.split_whitespace().map(|x| x.parse().unwrap()).collect::<Vec<usize>>());
    }
    let size: usize = 2 * 2i64.pow((n as f64).log2().ceil() as u32) as usize;
    let mut D: Vec<i64> = vec![0; size];
    let mut oper_D: Vec<i64> = vec![0;size];
    if D.len() == 0 {
        D = vec![0, 0];
        oper_D = vec![0, 0];
    }
    for i in 0..k {
        let a = query[i][0];
        let b = query[i][1];
        add(&mut oper_D, a, b+1, 1, 1, size/2+1, 1);
    }
    for i in 0..m {
        add(&mut D, operations[i][0], operations[i][1]+1, 1, 1, size/2+1, (operations[i][2] as i64) * getval(&mut oper_D, i+1, size-1));
    }
    for i in 0..n {
        print!("{} ", arr[i]+getval(&mut D, i+1, size-1));
    }
    
}
