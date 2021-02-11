use std::collections::HashMap;

fn dec2_fact_string(nb: u64) -> String {
    let mut digits: HashMap<u64, char> = HashMap::new();
    let mut i = 0u64;
    for j in 0..10 {
        digits.insert(i, j.to_string().chars().next().unwrap());
        i += 1;
    }
    for j in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".to_string().chars() {
        digits.insert(i, j);
        i += 1;
    }
    i = 1;
    let mut num = nb;
    let mut res = String::new();
    while num > 0 {
        res.insert(0, *digits.get(&(num % i)).unwrap());
        num /= i;
        i += 1;
    }
    res
}

fn fact_string_2dec(s: String) -> u64 {
    let mut digits: HashMap<char, u64> = HashMap::new();
    let mut i = 0u64;
    for j in 0..10 {
        digits.insert(j.to_string().chars().next().unwrap(), i);
        i += 1;
    }
    for j in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".to_string().chars() {
        digits.insert(j, i);
        i += 1;
    }
    i = 1u64;
    let mut res = 0u64;
    let mut st = s;
    let mut fact = 1u64;
    loop {
        match st.pop() {
            Some(x) => res += digits.get(&x).unwrap() * fact,
            None => return res,
        };
        fact *= i;
        i += 1;
    }

}

fn testing1(nb: u64, exp: &str) -> () {
    assert_eq!(&dec2_fact_string(nb), exp)
}

fn testing2(s: &str, exp: u64) -> () {
    assert_eq!(fact_string_2dec(s.to_string()), exp)
}

#[test]
fn basics_dec2_fact_string() {

    testing1(2982, "4041000");
    testing1(463, "341010");

}
#[test]
fn basics_fact_string_2dec() {

    testing2("4041000", 2982);
    testing2("341010", 463);

}
