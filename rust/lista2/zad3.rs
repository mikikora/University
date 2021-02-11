fn summy(strng: &str) -> i32 {
    strng.split(' ').into_iter().map(|x| x.parse::<i32>().unwrap()).sum()
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn sample_tests() {
        assert_eq!(summy("1 2 3"), 6);
        assert_eq!(summy("1 2 3 4"), 10);
        assert_eq!(summy("1 2 3 4 5"), 15);
        assert_eq!(summy("10 10"), 20);
        assert_eq!(summy("0 0"), 0);
        assert_eq!(summy("15 -3 -3 -3 -3 -3"), 0);
        assert_eq!(summy("1024 1024"), 2048);
        assert_eq!(summy("1 2 4 8 16 32"), 63);
        assert_eq!(summy("0 10 100 1000"), 1110);
        assert_eq!(summy("-3 2 2 -3"), -2);
        assert_eq!(summy("10 1 0 0 2"), 13);
    }
}
