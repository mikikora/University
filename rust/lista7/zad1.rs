fn chessboard_cell_color(cell1: &str, cell2: &str) -> bool {
    let mut letters: Vec<u8> = cell1.chars().map(|x| x as u8).collect();
    for e in cell2.chars() {
        letters.push(e as u8);
    }
    letters[0] -= 65;
    letters[2] -= 65;
    letters[1] -= 48;
    letters[3] -= 49;
    (letters[0] + letters[1]) % 2 != (letters[2] + letters[3]) % 2

}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn basic_tests() {
        assert_eq!(chessboard_cell_color("A1", "C3"), true);
        assert_eq!(chessboard_cell_color("A1", "H3"), false);
        assert_eq!(chessboard_cell_color("A1", "A2"), false);
        assert_eq!(chessboard_cell_color("A1", "C1"), true);
        assert_eq!(chessboard_cell_color("A1", "A1"), true);
    }
}
