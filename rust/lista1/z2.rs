
fn string_to_number(s: &str) -> i32 {
  let res = s.parse::<i32>().unwrap();
  res
}

#[cfg(test)]
mod tests {
    use super::string_to_number;

    #[test]
    fn returns_expected() {
      assert_eq!(string_to_number("1234"), 1234);
      assert_eq!(string_to_number("605"), 605);
      assert_eq!(string_to_number("1405"), 1405);
      assert_eq!(string_to_number("-7"), -7);
      assert_eq!(string_to_number("-739"), 739);
      assert_eq!(string_to_number("0"), 0);
      assert_eq!(string_to_number("1024"), 1024);
      assert_eq!(string_to_number("-1024"), -1024);
      assert_eq!(string_to_number("3"), 3);
      assert_eq!(string_to_number("10"), 10);
    }
}
