fn dig_pow(n: i64, p: i32) -> i64 {
    let mut n0 = n;
    let mut sum = 0;
    while n0 > 0 {
        sum += (n0 % 10).pow((n0.to_string().len() as u32) + (p as u32) - 1);
        n0 /= 10;
    }
    if sum % n == 0 {
        return (sum / n) as i64;
    }
    else {
        return -1;
    }
}


#[cfg(test)]
    mod tests {
    use super::*;

    fn dotest(n: i64, p: i32, exp: i64) -> () {
        println!(" n: {:?};", n);
        println!("p: {:?};", p);
        let ans = dig_pow(n, p);
        println!(" actual:\n{:?};", ans);
        println!("expect:\n{:?};", exp);
        println!(" {};", ans == exp);
        assert_eq!(ans, exp);
        println!("{};", "-");
    }

    #[test]
    fn basic_tests() {
        dotest(89, 1, 1);
        dotest(92, 1, -1);
        dotest(46288, 3, 51);

    }
}
