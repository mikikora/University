fn longest(a1: &str, a2: &str) -> String {
    let mut chars: Vec<char> = a1.chars().collect();
    chars.append(&mut a2.chars().collect());
    chars.sort();
    chars.dedup();
    chars.into_iter().collect()

}

#[cfg(test)]
    mod tests {
    use super::*;

    fn testing(s1: &str, s2: &str, exp: &str) -> () {
        println!("s1:{:?} s2:{:?}", s1, s2);
        println!("{:?} {:?}", longest(s1, s2), exp);
        println!("{}", longest(s1, s2) == exp);
        assert_eq!(&longest(s1, s2), exp)
    }

    #[test]
    fn basic_tests() {
        testing("aretheyhere", "yestheyarehere", "aehrsty");
        testing("loopingisfunbutdangerous", "lessdangerousthancoding", "abcdefghilnoprstu");
        testing("cosfnidjks", "fjkndspalkcn", "acdfijklnops");
        testing("qsakjdfasdcds", "iujoefwlaknsxm", "acdefijklmnoqsuwx");
        testing("qertgfdswertg", "qiewfdbskjnzmxn", "bdefgijkmnqrstwxz");
        testing("juytrfghgfd", "qewrtgyhjnhbvc", "bcdefghjnqrtuvwy");
        testing("wqerftgbvcdfvghty", "ewirjbdfncnx", "bcdefghijnqrtvwxy");
        testing("qwerfgvcxzx", "jkblopijuhn", "bcefghijklnopqruvwxz");
        testing("iouhjkkhgffgd", "jhgfdtyukmnbvcf", "bcdfghijkmnotuvy");
        testing("cxserfdsedx", "kjuhygfvbnmkjhg", "bcdefghjkmnrsuvxy");
        testing("iuytrdcvbnh", "wertyukmnbvftyhb", "bcdefhikmnrtuvwy");
        testing("tyuikmnbgfdxc", "lkiuytrdsxcbh", "bcdfghiklmnrstuxy");
        testing("xsertyhbngfguij", "lkmnhugvgfdxsa", "abdefghijklmnrstuvxy");
    }
}
