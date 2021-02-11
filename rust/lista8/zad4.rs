impl MorseDecoder {

    fn new(&self) -> MorseDecoder {
        MorseDecoder{ morse_code :
            [("....-", "4"),("--..--", ","),(".--", "W"),(".-.-.-", "."),("..---", "2"),(".", "E"),("--..", "Z"),(".----", "1"),(".-..", "L"),
            (".--.", "P"),(".-.", "R"),("...", "S"),("-.--", "Y"),("...--", "3"),(".....", "5"),("--.", "G"),("-.--.", "("),("-....", "6"),
            (".-.-.", "+"),("...-..-", "$"),(".--.-.", "@"),("...---...", "SOS"),("..--.-", "_"),("-.", "N"),("-..-", "X"),("-----", "0"),
            ("....", "H"),("-...", "B"),(".---", "J"),("---...", ","),("-", "T"),("---..", "8"),("-..-.", "/"),("--.-", "Q"),("...-", "V"),
            ("----.", "9"),("--", "M"),("-.-.-.", ";"),("-.-.--", "!"),("..-.", "F"),("..--..", "?"),("-...-", "="),("..-", "U"),(".----.", "'"),
            ("---", "O"),("-.--.-", ")"),("..", "I"),("-....-", "-"),(".-..-.", "\""),(".-", "A"),("-.-.", "C"),("-..", "D"),(".-...", "&"),
            ("--...", "7"),("-.-", "K")].iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()}
            }

    fn decode_morse(&self, encoded: &str) -> String {
        let letters: Vec<&str> = encoded.split("   ").collect();
        let mut res = String::new();
        for e in letters.into_iter() {
            if e == "" {
                continue;
            }
            let lett: Vec<&str> = e.split(' ').collect();
            for f in lett.into_iter() {
                match f {
                    "" => continue,
                    f => res.push_str(self.morse_code.get(f).unwrap()),
                };
            }
            res.push(' ');
        }
        res.pop();
        match res.pop() {
            Some(' ') => (),
            Some(x) => res.push(x),
            None => (),
        };
        res
    }

}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_hey_jude() {
        let decoder = MorseDecoder::new();
        assert_eq!(decoder.decode_morse(".... . -.--   .--- ..- -.. ."), "HEY JUDE");
        assert_eq!(decoder.decode_morse(".... . .-.. .-.. ---   - .... . .-. ."), "HELLO THERE");
        assert_eq!(decoder.decode_morse(" "), "");
    }
}
