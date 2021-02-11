//też nie działa
fn is_end(a: &[u64], i: usize) -> bool {
    i > a.len() - 1
}

fn is_zero(a: &[u64], i:usize) ->bool {
    if !is_end(a, i) {
        if a[i] == 0 {
            return !is_zero(a, i+1);
        }
    }
    false
}

fn will_be_zero(a: &[u64], i: usize) -> bool {
    if is_end(a, i+1) || a[i] == 1 {
        return true;
    }
    is_zero(a, i+1)
}

fn is_odd(a: &[u64], i: usize) -> bool {
    if is_end(a, i+1) || a[i] % 2 == 1 {
        return true;
    }
    is_zero(a, i+1)
}

fn mod2 (a: &[u64], i: usize) -> u64 {
    if is_end(a, i) || a[i] % 2 == 1 || is_zero(a, i+1) {
        return 1;
    }
    0
}

fn mod4 (a: &[u64], i: usize) -> u64 {
    if is_end(a, i) {
        return 1;
    }
    match a[i] % 4 {
        0 => if is_zero(a, i+1) {return 1} else {return 0},
        1 => return 1,
        2 => if is_zero(a, i+1) {return 1} else {if will_be_zero(a, i+1) {return 2} else {return 0}},
        3 => if is_odd(a, i+1) {return 3} else {return 1},
        _ => return 4 //exception
    }
}

fn mod10 (a: &[u64]) -> u64 {
    let p: Vec<Vec<u64>> = vec![
    vec![0],      // 0^1=0, 0^2=0 ...
    vec![1],      // 1^1=1, 1^2=1 ...
    vec![2,4,8,6], // 2^1=2, 2^2=4 ...
    vec![3,9,7,1], // 3^1=3, 3^2=9 ...
    vec![4,6],
    vec![5],
    vec![6],
    vec![7,9,3,1],
    vec![8,4,2,6],
    vec![9,1]];
    let mod_a = a[0] % 10;
    if is_zero(a, 1) {
        return 1;
    }
    let row = &p[mod_a as usize];
    match row.len() {
        1 => return row[0],
        2 => return row[(1 - mod2(a, 1)) as usize],
        4 => return row[((mod4(a, 1) + 3) % 4) as usize],
        _ => return 10 //exception
    }
}

fn last_digit(lst: &[u64]) -> u64 {
    if lst.len() == 0 {
        return 1;
    }
    mod10(lst)
}

fn main() {
    //print!("{}\n", last_digit(&vec![12,30,21]));
    print!("{}\n", last_digit(&vec![])); //1
    print!("{}\n", last_digit(&vec![0, 0])); // 1),
    print!("{}\n", last_digit(&vec![0, 0, 0])); //, 0),
    print!("{}\n", last_digit(&vec![1, 2])); //, 1),
    print!("{}\n", last_digit(&vec![3, 4, 5])); //, 1),
    print!("{}\n", last_digit(&vec![4, 3, 6])); //, 4),
    print!("{}\n", last_digit(&vec![7, 6, 21])); //, 1),
    print!("{}\n", last_digit(&vec![12, 30, 21])); //, 6),
    print!("{}\n", last_digit(&vec![2, 2, 2, 0])); //, 4),
    print!("{}\n", last_digit(&vec![937640, 767456, 981242])); //, 0),
    print!("{}\n", last_digit(&vec![123232, 694022, 140249])); //, 6),
    print!("{}\n", last_digit(&vec![499942, 898102, 846073])); //, 6)
}
