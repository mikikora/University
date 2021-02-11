fn core(n: i32) -> (Vec<i32>, Vec<i32>) {
    let mut a = vec![1i32, 1i32];
    let mut j = vec![0i32, 0i32];
    for i in 1..n-1 {
        a.push(i + 1 - j[a[i as usize] as usize]);
        j.push(i + 1 - a[j[i as usize] as usize]);
    }
    (a, j)
}

fn john(n: i32) -> Vec<i32> {
    core(n).1
}
fn ann(n: i32) -> Vec<i32> {
    core(n).0
}
fn sum_john(n: i32) -> i32 {
    core(n).1.into_iter().sum()
}
fn sum_ann(n: i32) -> i32 {
    core(n).0.into_iter().sum()
}

fn test_john(n: i32, exp: Vec<i32>) -> () {
    assert_eq!(john(n), exp)
}
fn test_ann(n: i32, exp: Vec<i32>) -> () {
    assert_eq!(ann(n), exp)
}
fn test_sum_john(n: i32, exp: i32) -> () {
    assert_eq!(sum_john(n), exp)
}
fn test_sum_ann(n: i32, exp: i32) -> () {
    assert_eq!(sum_ann(n), exp)
}

#[test]
fn test_test_john() {
    test_john(11, vec![0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6]);
    test_john(14, vec![0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8]);
}
#[test]
fn test_test_ann() {
    test_ann(6, vec![1, 1, 2, 2, 3, 3]);
    test_ann(15, vec![1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9]);
}
#[test]
fn test_test_sum_john() {
    test_sum_john(75, 1720);
    test_sum_john(78, 1861);
}
#[test]
fn test_test_sum_ann() {
    test_sum_ann(115, 4070);
    test_sum_ann(150, 6930);
}
