
fn count_red_beads(n: u32) -> u32 {
    if n == 0{
        0
    }
    else {
        2 * (n-1)
    }
}

#[test]
fn test() {
  assert_eq!(count_red_beads(0), 0);
  assert_eq!(count_red_beads(1), 0);
  assert_eq!(count_red_beads(3), 4);
  assert_eq!(count_red_beads(5), 8);
  assert_eq!(count_red_beads(10), 18);
  assert_eq!(count_red_beads(6), 10);
  assert_eq!(count_red_beads(12), 22);
  assert_eq!(count_red_beads(13), 24);
  assert_eq!(count_red_beads(20), 38);
  assert_eq!(count_red_beads(19), 36);
}


fn main() {
    println!("{} {} {} {} {} {}", count_red_beads(10), count_red_beads(6), count_red_beads(12), count_red_beads(13),
 count_red_beads(20), count_red_beads(19))
}
