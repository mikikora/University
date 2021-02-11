use std::collections::HashMap;

fn comp(a: Vec<i64>, b: Vec<i64>) -> bool {
    let mut map: HashMap<i64, i64> = HashMap::new();
    for i in b {
        match map.insert(i, 1) {
            Some(x) => map.insert(i, x+1),
            None => None,
        };
    }
    for e in a {
        let pow = e * e;
        match map.get(&pow) {
            Some(&x) => map.insert(pow, x-1),
            None => return false,
        };
        if map.get(&pow) == Some(&0) {
            map.remove(&pow);
        }
    }
    map.is_empty()
}

fn testing(a: Vec<i64>, b: Vec<i64>, exp: bool) -> () {
    assert_eq!(comp(a, b), exp)
}

#[test]
fn tests_comp() {

    let a1 = vec![121, 144, 19, 161, 19, 144, 19, 11];
    let a2 = vec![11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19];
    testing(a1, a2, true);
    let a1 = vec![121, 144, 19, 161, 19, 144, 19, 11];
    let a2 = vec![11*21, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19];
    testing(a1, a2, false);

}
