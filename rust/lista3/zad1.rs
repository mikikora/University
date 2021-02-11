fn row_sum_odd_numbers(n:i64) -> i64 {
    n*n*n
}

#[test]
fn returns_expected() {
  assert_eq!(row_sum_odd_numbers(1), 1);
  assert_eq!(row_sum_odd_numbers(9), 729);
  assert_eq!(row_sum_odd_numbers(15), 3375);
  assert_eq!(row_sum_odd_numbers(3), 27);
  assert_eq!(row_sum_odd_numbers(10), 1000);
  assert_eq!(row_sum_odd_numbers(42), 74088);
  assert_eq!(row_sum_odd_numbers(19), 6859);
  assert_eq!(row_sum_odd_numbers(7), 343);
  assert_eq!(row_sum_odd_numbers(32), 32768);
  assert_eq!(row_sum_odd_numbers(51), 132651);

}
