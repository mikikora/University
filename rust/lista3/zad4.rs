fn zoom(n: i32) -> String {
    let mut b = true;
    if (n/2)%2 == 1 {
        b = false;
    }
    let mut begin = String::new();
    if b {
        begin.push('■');
    }
    else {
        begin.push('□');
    }
    let mut start = String::new();
    for _i in 0..(n/2) {
        start.push_str(&begin);
        for _j in begin.len() as i32/3..(n - (begin.len() as i32/3)) {
            if b {
                start.push('■');
            }
            else {
                start.push('□');
            }
        }
        start.push_str(&begin.chars().rev().collect::<String>());
        b = !b;
        if b {
            begin.push('■');
        }
        else {
            begin.push('□');
        }
        start.push('\n');
    }
    let mut res = String::new();
    for i in start.chars() {
        res.push(i);
    }
    for i in begin.chars() {
        res.push(i);
    }
    let mut a = begin.chars().rev();
    a.next();
    for i in a {
        res.push(i);
    }
    for i in start.chars().rev() {
        res.push(i);
    }
    res
}


#[test]
fn basic_test_1() {
  assert_eq!(zoom(1), "■");
}

#[test]
fn basic_test_2() {
  assert_eq!(zoom(3), "\
□□□
□■□
□□□"
  );
}

#[test]
fn basic_test_3() {
  assert_eq!(zoom(5), "\
■■■■■
■□□□■
■□■□■
■□□□■
■■■■■"
  );
}

#[test]
fn basic_test_4() {
  assert_eq!(zoom(7), "\
□□□□□□□
□■■■■■□
□■□□□■□
□■□■□■□
□■□□□■□
□■■■■■□
□□□□□□□"
  );
}

#[test]
fn basic_test_5() {
  assert_eq!(zoom(9), "\
■■■■■■■■■
■□□□□□□□■
■□■■■■■□■
■□■□□□■□■
■□■□■□■□■
■□■□□□■□■
■□■■■■■□■
■□□□□□□□■
■■■■■■■■■"
  );
}
