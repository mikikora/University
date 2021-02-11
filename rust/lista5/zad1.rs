fn xo(string: &'static str) -> bool {
    let v: Vec<char> = string.chars().collect();
    let x = v.clone().into_iter().filter(|x| *x == 'x' || *x == 'X').fold(0, |a, _x| a + 1);
    let o = v.into_iter().filter(|x| *x == 'o' || *x == 'O').fold(0, |a, _x| a + 1);
    x == o
}

#[test]
fn returns_expected() {
  assert_eq!(xo("xo"), true);
  assert_eq!(xo("Xo"), true);
  assert_eq!(xo("xxOo"), true);
  assert_eq!(xo("xxxm"), false);
  assert_eq!(xo("Oo"), false);
  assert_eq!(xo("ooom"), false);
}
