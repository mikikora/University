fn good_vs_evil(good: &str, evil: &str) -> String {
    let mut goods: Vec<i32> = good.split(' ').map(|x| x.parse::<i32>().unwrap()).collect();
    goods.push(0);
    let evils: Vec<i32> = evil.split(' ').map(|x| x.parse::<i32>().unwrap()).collect();
    let g_val = vec![1, 2, 3, 3, 4, 10, 0];
    let e_val = vec![1, 2, 2, 2, 3, 5, 10];
    let mut sum = 0i32;
    for i in 0..goods.len() {
        sum += goods[i] * g_val[i] - evils[i] * e_val[i];
    }
    if sum > 0 {
        return String::from("Battle Result: Good triumphs over Evil");
    }
    if sum < 0 {
        return String::from("Battle Result: Evil eradicates all trace of Good");
    }
    String::from("Battle Result: No victor on this battle field")
}

#[test]
fn returns_expected() {
    assert_eq!(good_vs_evil("0 0 0 0 0 10", "0 0 0 0 0 0 0"), "Battle Result: Good triumphs over Evil");
    assert_eq!(good_vs_evil("0 0 0 0 0 0", "0 0 0 0 0 0 10"), "Battle Result: Evil eradicates all trace of Good");
    assert_eq!(good_vs_evil("0 0 0 0 0 10", "0 0 0 0 0 0 10"), "Battle Result: No victor on this battle field");
    assert_eq!(good_vs_evil("1 2 1 0 1 0", "4 0 0 2 0 0 0"), "Battle Result: Good triumphs over Evil");
}
