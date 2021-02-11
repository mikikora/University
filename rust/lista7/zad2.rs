use std::collections::BTreeMap;

fn letter_frequency(input: &str) -> BTreeMap<char, i32> {
    let mut res: BTreeMap<char, i32> = BTreeMap::new();
    let letters: Vec<char> = input.chars().map(|x| x.to_ascii_lowercase()).collect();
    for e in letters.into_iter() {
        if !e.is_ascii_alphabetic() {
            continue;
        }
        match res.insert(e, 1) {
            Some(x) => res.insert(e, x+1),
            None => None,
        };
    }
    res
}

#[cfg(test)]
mod tests {
    use std::collections::BTreeMap;
    use super::letter_frequency;

    #[test]
    fn simpleword() {
        let answer: BTreeMap<char, i32> =
        [('a', 2),
         ('c', 1),
         ('l', 1),
         ('t', 1),
         ('u', 1)]
         .iter().cloned().collect();

      assert_eq!(letter_frequency("actual"), answer);
    }

    #[test]
    fn sequence() {
        let answer: BTreeMap<char, i32> =
        [('a', 3),
         ('b', 2),
         ('f', 1),
         ('p', 1),
         ('s', 1),
         ('t', 2),
         ('u', 1),
         ('x', 5)]
         .iter().cloned().collect();

      assert_eq!(letter_frequency("AaabBF UttsP xxxxx"), answer);
    }
}
