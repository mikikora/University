fn even_numbers(array: &Vec<i32>, number: usize) -> Vec<i32> {
    let temp: Vec<i32> = array.clone().into_iter().rev().filter(|x| *x % 2 == 0).collect();
    temp[..number].to_vec().into_iter().rev().collect()
}

#[test]
fn sample_tests() {
  assert_eq!(even_numbers(&vec!(1, 2, 3, 4, 5, 6, 7, 8, 9), 3), vec!(4, 6, 8));
  assert_eq!(even_numbers(&vec!(-22, 5, 3, 11, 26, -6, -7, -8, -9, -8, 26), 2), vec!(-8, 26));
  assert_eq!(even_numbers(&vec!(6, -25, 3, 7, 5, 5, 7, -3, 23), 1), vec!(6));
}
