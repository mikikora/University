fn to_byte(c: char) -> Option<i32> {
    let pos = c as i32;
    if 65 <= pos && pos <= 90 {
        return Some(pos - 64);
    }
    if 97 <= pos && pos <= 122 {
        return Some(pos - 96)
    }
    None
}

fn alphabet_position(text: &str) -> String {
    let mut res = String::new();
    for e in text.chars() {
        match to_byte(e) {
            Some(x) => res.push_str(&(x.to_string().as_mut_str().to_owned() + &" ".to_string())),
            None => (),
        };

    }
    res.pop();
    res
}

#[test]
fn returns_expected() {
    assert_eq!(
        alphabet_position("The sunset sets at twelve o' clock."),
        "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11".to_string()
    );
    assert_eq!(
        alphabet_position("The narwhal bacons at midnight."),
        "20 8 5 14 1 18 23 8 1 12 2 1 3 15 14 19 1 20 13 9 4 14 9 7 8 20".to_string()
    );
}
