fn dbl_linear(n: u32) -> u32{
    let mut u: Vec<u32> = vec![1];
    let mut x = 0u32;
    let mut y = 0u32;
    for _i in 0..n {
        let next_x = 2 * u[x as usize] + 1;
        let next_y = 3 * u[y as usize] + 1;
        if next_x <= next_y {
            u.push(next_x);
            x += 1;
            if next_x == next_y {
                y += 1;
            }
        }
        else {
            u.push(next_y);
            y += 1;
        }
    }
    u[n as usize]
}

#[cfg(test)]
mod tests {
    use super::dbl_linear;
    fn testing(n: u32, exp: u32) -> () {
        assert_eq!(dbl_linear(n), exp)
    }

    #[test]
    fn basics_dbl_linear() {
        testing(10, 22);
        testing(20, 57);
        testing(30, 91);
        testing(50, 175);
        testing(100, 447);
    }
}
