fn number(bus_stops:&[(i32,i32)]) -> i32 {
    let mut people = 0i32;
    for e in bus_stops {
        people += e.0;
        people -= e.1;
    }
    people
}

#[test]
fn returns_expected() {
  assert_eq!(number(&[(10,0),(3,5),(5,8)]), 5);
  assert_eq!(number(&[(3,0),(9,1),(4,10),(12,2),(6,1),(7,10)]), 17);
  assert_eq!(number(&[(3,0),(9,1),(4,8),(12,2),(6,1),(7,8)]), 21);
}
