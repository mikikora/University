struct Sudoku{
    data: Vec<Vec<u32>>,
}


impl Sudoku{
    fn is_valid(&self) -> bool {
        if (0..self.data.len()).any(|x| self.data[x as usize].len() != self.data.len()) {
            return false;
        }
        let l: u32 = self.data.len() as u32;
        for i in 0..self.data.len() {
            if !(1..l+1).all(|x| self.data[i as usize].contains(&x)) {
                return false;
            }
            let mut temp: Vec<u32> = Vec::new();
            for j in 0..self.data.len() {
                temp.push(self.data[j as usize][i as usize]);
            }
            if !(1..l+1).all(|x| temp.contains(&x)) {
                return false;
            }
        }
        let n: i64 = (self.data.len() as f64).sqrt() as i64;
        for i in 0..n {
            for j in 0..n {
                let mut temp: Vec<u32> = Vec::new();
                for k in n*i..(n*i)+n {
                    for l in n*j..(n*j)+n {
                        temp.push(self.data[k as usize][l as usize]);
                    }
                }
                if !(1..l+1).all(|x| temp.contains(&x)) {
                    return false;
                }

            }
        }

        true
    }
}

#[test]
fn good_sudoku() {
    let good_sudoku_1 = Sudoku{
        data: vec![
                vec![7,8,4, 1,5,9, 3,2,6],
                vec![5,3,9, 6,7,2, 8,4,1],
                vec![6,1,2, 4,3,8, 7,5,9],

                vec![9,2,8, 7,1,5, 4,6,3],
                vec![3,5,7, 8,4,6, 1,9,2],
                vec![4,6,1, 9,2,3, 5,8,7],

                vec![8,7,6, 3,9,4, 2,1,5],
                vec![2,4,3, 5,6,1, 9,7,8],
                vec![1,9,5, 2,8,7, 6,3,4]
            ]
    };

    let good_sudoku_2 = Sudoku{
        data: vec![
                vec![1, 4,  2, 3],
                vec![3, 2,  4, 1],

                vec![4, 1,  3, 2],
                vec![2, 3,  1, 4],
            ]
    };
    assert!(good_sudoku_1.is_valid());
    assert!(good_sudoku_2.is_valid());
}

#[test]
fn bad_sudoku() {
    let bad_sudoku_1 = Sudoku{
        data: vec![
                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],

                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],

                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],
                vec![1,2,3, 4,5,6, 7,8,9],
            ]
    };

    let bad_sudoku_2 = Sudoku{
        data: vec![
                vec![1,2,3,4,5],
                vec![1,2,3,4],
                vec![1,2,3,4],
                vec![1],
            ]
    };
    assert!(!bad_sudoku_1.is_valid());
    assert!(!bad_sudoku_2.is_valid());
}
