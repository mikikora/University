fn good_phone_number(s: &str) -> bool {
    let number: Vec<&str> = s.split('-').collect();
    if number[0] != "+1" {
        return false;
    }
    if number[1].len() == 3 {
        match number[1].parse::<i32>() {
            Ok(_x) => (),
            Err(_x) => return false,
        };
    }
    else {
        return false;
    }
    if number[2].len() == 3 {
        match number[2].parse::<i32>() {
            Ok(_x) => (),
            Err(_x) => return false,
        };
    }
    else {
        return false;
    }
    if number[3].len() == 4 {
        match number[3].parse::<i32>() {
            Ok(_x) => (),
            Err(_x) => return false,
        };
    }
    else {
        return false;
    }
    true
}

fn good_version(s: &str) -> bool {
    s.contains('.') && s.find('.').unwrap() != 0 && match s.parse::<f64>() {
        Ok(_x) => true,
        Err(_x) => false
    }
}

fn change(s: &str, prog: &str, new_version: &str) -> String {
    let lines: Vec<&str> = s.split('\n').collect();
    let phone: Vec<&str> = lines[3].split(' ').collect();
    let version: Vec<&str> = lines[5].split(' ').collect();
    if !good_phone_number(phone[1]) || !good_version(version[1]) {
        return "ERROR: VERSION or PHONE".to_string();
    }
    let mut res = "Program: ".to_string() + prog + " Author: g964 Phone: +1-503-555-0090 Date: 2019-01-01 Version: ";
    if version[1] == "2.0" {
        res = res + version[1];
    }
    else {
        res = res + new_version;
    }
    res
}

#[cfg(test)]
    mod tests {
    use super::*;

    fn dotest(s: &str, prog: &str, version: &str, exp: &str) -> () {
        println!("s:{:?}", s);
        println!("prog:{:?}", prog);
        println!("version:{:?}", version);
        let ans = change(s, prog, version);
        println!("actual: {:?}", ans);
        println!("expect: {:?}", exp);
        println!("{}", ans == exp);
        assert_eq!(ans, exp);
        println!("{}", "-");
    }

    #[test]
    fn basic_tests() {
        let s1="Program title: Primes\nAuthor: Kern\nCorporation: Gold\nPhone: +1-503-555-0091\nDate: Tues April 9, 2005\nVersion: 6.7\nLevel: Alpha";
        dotest(s1, "Ladder", "1.1", "Program: Ladder Author: g964 Phone: +1-503-555-0090 Date: 2019-01-01 Version: 1.1");
        let s2="Program title: Balance\nAuthor: Dorries\nCorporation: Funny\nPhone: +1-503-555-0095\nDate: Tues July 19, 2014\nVersion: 6.7\nLevel: Release";
        dotest(s2, "Circular", "1.5", "Program: Circular Author: g964 Phone: +1-503-555-0090 Date: 2019-01-01 Version: 1.5");
        let s13="Program title: Primes\nAuthor: Kern\nCorporation: Gold\nPhone: +1-503-555-0090\nDate: Tues April 9, 2005\nVersion: 67\nLevel: Alpha";
        dotest(s13, "Ladder", "1.1", "ERROR: VERSION or PHONE");

    }
}
