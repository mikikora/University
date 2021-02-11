use std::collections::BTreeMap;

fn stock_list(list_art: Vec<&str>, list_cat: Vec<&str>) -> String {
    if list_art.is_empty() || list_cat.is_empty() {
        return String::from("");
    }
    let mut dict: BTreeMap<String, i64> = BTreeMap::new();
    for e in list_cat.iter() {
        dict.insert(e.to_string(), 0);
    }
    for e in list_art.into_iter() {
        let book: Vec<&str> = e.split(' ').collect();
        let letter = book[0].chars().next().unwrap().to_string();
        match dict.get(&letter) {
            Some(x) => dict.insert(letter, x + book[1].parse::<i64>().unwrap()),
            None => None,
        };
    }
    let mut res = String::new();
    for e in list_cat.iter() {
        res = res + "(" + e + " : " + &dict.get(*e).unwrap().to_string() + ") - ";
    }
    res.pop();
    res.pop();
    res.pop();
    res
}

#[cfg(test)]
    mod tests {
    use super::*;

    fn dotest(list_art: Vec<&str>, list_cat: Vec<&str>, exp: &str) -> () {
        println!("list_art: {:?};", list_art);
        println!("list_cat: {:?};", list_cat);
        let ans = stock_list(list_art, list_cat);
        println!("actual:\n{:?};", ans);
        println!("expect:\n{:?};", exp);
        println!("{};", ans == exp);
        assert_eq!(ans, exp);
        println!("{};", "-");
    }

    #[test]
    fn basic_tests() {
        let mut b = vec!["BBAR 150", "CDXE 515", "BKWR 250", "BTSQ 890", "DRTY 600"];
        let mut c = vec!["A", "B", "C", "D"];
        dotest(b, c, "(A : 0) - (B : 1290) - (C : 515) - (D : 600)");

        b = vec!["ABAR 200", "CDXE 500", "BKWR 250", "BTSQ 890", "DRTY 600"];
        c = vec!["A", "B"];
        dotest(b, c, "(A : 200) - (B : 1140)");

    }
}
