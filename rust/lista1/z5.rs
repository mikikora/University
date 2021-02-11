
fn printer_error(s: &str) -> String {
    let mut sum = 0u64;
    for e in s.chars() {
        if e > 'm' {
            sum += 1;
        }
    }
    format!("{}/{}", sum, s.len())
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn should_pass_all_the_tests_provided() {
        assert_eq!(&printer_error("aaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyz"), "3/56");
        assert_eq!(&printer_error("kkkwwwaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyz"), "6/60");
        assert_eq!(&printer_error("kkkwwwaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyzuuuuu"), "11/65");
        assert_eq!(&printer_error("qqqqqdddddrrrgggyhjuddddderrrrrrrrrrrrrrrrrrrrrrrrrrrrreeeeeeegggddddddddqqqqqq"), "45/79");
        assert_eq!(&printer_error("jjjjjjjjjjjjjjjjjjjjjjjyyyyyyyyyyyyyyyyyyyyyttttttttttttttvgfredsssssssssssssss"), "52/79");
        assert_eq!(&printer_error("bsgttttttttttttttttrwfsuuuuuuuuuuuuuuuuuuhytgnnnnnnnnnnnnnnnnnnnnnnnkiuhwbsj"), "66/76");
        assert_eq!(&printer_error("gfgffffffffffffffwwwwwwwwwwwwwwttttttttttttaaaaaaaaagggggggggggzbsgejmmmmmmmmmm"), "28/79");
        assert_eq!(&printer_error("abccdefhsuejakeusbsjkeusjakeiaksnqwedfrtgyjshznsjeksmagsgggggggggggg"), "20/68");
        assert_eq!(&printer_error("qwertyuiopasdfghjklzxcvbnmlkjhgfdsaqwerrtyyuiiookkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"), "24/78");
        assert_eq!(&printer_error("qazxswedcvfrtgbnhyujmkiolpqazxswedcvfdewsazxvghhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", "24/76");
    }
}
