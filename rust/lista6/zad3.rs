fn print(n: i32) -> Option<String> {
    if n <= 0 || n % 2 == 0 {
        return None;
    }
    let len: i32 = n / 2 + 1;
    let mut res = String::new();
    for i in 1..(len+1) {
        res.push_str(&" ".repeat((len - i) as usize));
        res.push_str(&"*".repeat((2 * i - 1) as usize));
        res.push('\n');
    }
    for i in 1..len {
        res.push_str(&" ".repeat(i as usize));
        res.push_str(&"*".repeat((2 * (len - i) - 1) as usize));
        res.push('\n');
    }
    Some(res)
}

#[test]
fn basic_test() {
  assert_eq!(print(3), Some(" *\n***\n *\n".to_string()) );
  assert_eq!(print(5), Some("  *\n ***\n*****\n ***\n  *\n".to_string()) );
  assert_eq!(print(-3),None);
  assert_eq!(print(2),None);
  assert_eq!(print(0),None);
  assert_eq!(print(1), Some("*\n".to_string()) );
}
