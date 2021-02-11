
fn square_area_to_circle(size:f64) -> f64 {
    let a:f64 = size.sqrt();
    (a / 2f64) * (a / 2f64) * std::f64::consts::PI
}

fn assert_close(a:f64, b:f64, epsilon:f64) {
    assert!( (a-b).abs() < epsilon, format!("Expected: {}, got: {}",b,a) );
}

#[test]
fn returns_expected() {
  assert_close(square_area_to_circle(9.0), 7.0685834705770345, 1e-8);
  assert_close(square_area_to_circle(20.0), 15.70796326794897, 1e-8);
  assert_close(square_area_to_circle(3.14), 2.4661502330679874, 1e-8);
  assert_close(square_area_to_circle(58.7), 46.102872191430215, 1e-8);
  assert_close(square_area_to_circle(30.003), 23.56218052137247, 1e-8);
  assert_close(square_area_to_circle(9.5), 7.461282552275757, 1e-8);
  assert_close(square_area_to_circle(22.0), 17.27875959474386, 1e-8);
  assert_close(square_area_to_circle(7.58), 5.953318078552658, 1e-8);
  assert_close(square_area_to_circle(66.6), 52.30751768227005, 1e-8);
  assert_close(square_area_to_circle(37.852), 29.72889128092021, 1e-8);
}
