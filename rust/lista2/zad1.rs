fn get_count(string: &str) -> usize {
  let mut vowels_count: usize = 0;
  let vowels = ['a', 'e', 'i', 'o', 'u'];

  for e in string.chars() {
      if vowels.contains(&e) {
          vowels_count += 1;
      }
  }
  vowels_count
}


#[test]
fn my_tests() {
  assert_eq!(get_count("abracadabra"), 5);
  assert_eq!(get_count("this is a testing sentence"), 8);
  assert_eq!(get_count("i dont know what to test"), 6);
  assert_eq!(get_count("another pointless sentence"), 9);
  assert_eq!(get_count("where are you"), 6);
  assert_eq!(get_count("never gonna give you up"), 9);
  assert_eq!(get_count("havana unanana"), 7);
  assert_eq!(get_count("subscribe to pewdiepie"), 9);
  assert_eq!(get_count("testing is fine"), 5);
  assert_eq!(get_count("you need to bre really creative"), 12);
  assert_eq!(get_count("like alkjfeuwoibnsafneioaf"), 12);
}
