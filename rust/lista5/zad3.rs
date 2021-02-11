fn solution(n: f64) -> f64 {
    let fl = n.floor();
    let cl = n.ceil();
    let mid = cl - 0.5;
    if (fl-n).abs() > (cl-n).abs() {
        if (mid - n).abs() > (cl - n).abs() {
            return cl;
        }
        else {
            return mid;
        }
    }
    else {
        if (mid - n).abs() > (fl - n).abs() {
            return fl;
        }
        else {
            return mid;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::solution;

    #[test]
    fn sample_tests() {
        assert_eq!(solution(4.2), 4.0);
        assert_eq!(solution(4.4), 4.5);
        assert_eq!(solution(4.6), 4.5);
        assert_eq!(solution(4.8), 5.0);
    }
}
