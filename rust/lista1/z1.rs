fn string_to_number(s: &str) -> i32 {
  let res = s.parse::<i32>().unwrap();
  res
}

fn count_red_beads(n: u32) -> u32 {
    if n == 0{
        0
    }
    else {
        2 * (n-1)
    }
}

fn square_area_to_circle(size:f64) -> f64 {
    let a:f64 = size.sqrt();
    (a / 2f64) * (a / 2f64) * std::f64::consts::PI
}

fn printer_error(s: &str) -> String {
    let mut sum = 0u64;
    for e in s.chars() {
        if e > 'm' {
            sum += 1;
        }
    }
    format!("{}/{}", sum, s.len())
}

fn main() {
    print!("{}", string_to_number("-56"))
}
