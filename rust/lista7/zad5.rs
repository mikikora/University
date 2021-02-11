fn len_of_cycle(number: u64, modulo: u64) -> u64 {
    // if modulo == 0 {
    //     return 0;
    // }
    let mut cycle: Vec<u64> = vec![number % modulo];
    let mut temp = (number * number) % modulo;
    while temp != cycle[0 as usize] && temp != 0 {
        cycle.push(temp);
        temp = (temp * number) % modulo;
    }
    if temp == 0 {
        return 0u64;
    }
    // if cycle.len() == 1 {
    //     return 2u64;
    // }
    cycle.len() as u64
    // modulo
}

fn last_digit(lst: &[u64]) -> u64 {
    if lst.len() == 0 {
        return 1u64
    }
    if lst.len() == 1 {
        return (lst[0 as usize] % 10) as u64;
    }
    if lst[0 as usize] == 0 && lst[1 as usize] == 0 {
        return 1u64;
    }
    // print!("a");
    let mut modula: Vec<u64> = vec![10u64, len_of_cycle(lst[0 as usize], 10u64)];
    for i in 1..lst.len() {
        let pom = len_of_cycle(lst[i as usize], modula[i])
        modula.push(pom);
        if pom == 0 {
            break;
        }
    }
    for i in 0..modula.len() {
        println!("{}", modula[i as usize]);
    }
    print!("\n");
    let mut res: u64 = lst[lst.len() - 1 as usize] % modula[modula.len() - 2];
    for i in 1..lst.len() {
        print!("{}\n", res);
        res = lst[lst.len() - i - 1].pow(res as u32) % modula[modula.len() - i - 2];
    }
    res
}

fn main() {
    // print!("abc");
    // print!("{}\n\n", len_of_cycle(7, 10));
    print!("{}", last_digit(&vec![3,4,5]));
}
