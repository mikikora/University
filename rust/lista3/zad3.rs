struct Cipher {
    orig_alphabet: Vec<char>,
    new_alphabet: Vec<char>
}

impl Cipher {
  fn new(map1: &str, map2: &str) -> Cipher {
    let orig_alphabet = map1.chars().collect();
    let new_alphabet = map2.chars().collect();
    Cipher { orig_alphabet, new_alphabet }
  }

  fn encode(&self, string: &str) -> String {
    let mut res = String::new();
    for a in string.chars() {
        let mut added = false;
        for i in 0..self.orig_alphabet.len() {
            if a == self.orig_alphabet[i] {
                res.push(self.new_alphabet[i]);
                added = true;
            }
        }
        if !added {
            res.push(a);
        }
    }
    res
  }

  fn decode(&self, string: &str) -> String {
    let mut res = String::new();
    for a in string.chars() {
        let mut added = false;
        for i in 0..self.new_alphabet.len() {
            if a == self.new_alphabet[i] {
                res.push(self.orig_alphabet[i]);
                added = true;
            }
        }
        if !added {
            res.push(a);
        }
    }
    res
  }
}

#[test]
fn examples() {
  let map1 = "abcdefghijklmnopqrstuvwxyz";
  let map2 = "etaoinshrdlucmfwypvbgkjqxz";

  let cipher = Cipher::new(map1, map2);

  assert_eq!(cipher.encode("abc"), "eta");
  assert_eq!(cipher.encode("xyz"), "qxz");
  assert_eq!(cipher.decode("eirfg"), "aeiou");
  assert_eq!(cipher.decode("erlang"), "aikcfu");
}
