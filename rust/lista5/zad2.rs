fn descending_order(x: u64) -> u64 {
    let mut v: Vec<char> = x.to_string().chars().collect();
    v.sort_by(|a, b| b.cmp(a));
    let s: String = v.into_iter().collect();
    s.parse::<u64>().unwrap()
}

#[test]
fn returns_expected() {
    assert_eq!(descending_order(0), 0);
    assert_eq!(descending_order(1), 1);
    assert_eq!(descending_order(15), 51);
    assert_eq!(descending_order(1021), 2110);
    assert_eq!(descending_order(123456789), 987654321);
    assert_eq!(descending_order(145263), 654321);
    assert_eq!(descending_order(1254859723), 9875543221);
}
