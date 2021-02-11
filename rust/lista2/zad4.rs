fn count_bits(n: i64) -> u32 {
  n.count_ones()
}

#[test]
fn returns_expected() {
    assert_eq!(count_bits(0), 0);
    assert_eq!(count_bits(4), 1);
    assert_eq!(count_bits(7), 3);
    assert_eq!(count_bits(9), 2);
    assert_eq!(count_bits(10), 2);
    assert_eq!(count_bits(-15), 61);
    assert_eq!(count_bits(1024), 1);
    assert_eq!(count_bits(-1), 64);
    assert_eq!(count_bits(6000), 7);
    assert_eq!(count_bits(7), 3);
    assert_eq!(count_bits(-4), 62);
}
