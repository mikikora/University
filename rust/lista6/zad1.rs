fn encode(msg: String, n: i32) -> Vec<i32> {
    let mut key = Vec::new();
    let mut a = n;
    while a > 0 {
        key.push(a%10);
        a /= 10;
    }
    key.reverse();
    let mut letters: Vec<i32> = msg.chars().map(|x| (x as i32) - 96i32).collect();
    let mut i = 0 as usize;
    for j in 0..letters.len() {
        letters[j as usize] = letters[j as usize] + key[i];
        i += 1;
        if i >= key.len() {
            i = 0 as usize;
        }
    }
    letters
}


#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn fixed_tests() {
        assert_eq!(encode("scout".to_string(), 1939), vec![20, 12, 18, 30, 21]);
        assert_eq!(encode("masterpiece".to_string(), 1939), vec![14, 10, 22, 29, 6, 27, 19, 18, 6, 12, 8]);
    }
}
