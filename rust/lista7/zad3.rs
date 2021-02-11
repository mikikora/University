fn fcn(n: i32) -> i64 {
    2i64.pow(n as u32)
}

/*
Dowód na to, że powyższy algorytm działa
//Zasady pisania równań z latexa//
u_0 = 1
u_1 = 2
(Rozważmy wzór po zmianie indeksów względem zadanych w zadaniu)
6u_{n-2}u_{n-1}-5u_{n-2}u_n+u_{n-1}u_n = 0
pokażę, że u_{n} = 2^{n}
Indukcja po n
n = 0: 2^0 = 1 = u_0
n = 1: 2^1 = 2 = u_1
załóżmy że działa dla n.
Rożważmy n+1:
6u_{n-1}u_n - 5u_{n-1}+u_{n+1}+u_nu_{n+1} = 0
wiemy, że u_n = 2^n i u_{n-1} = 2^{n-1}
6*2^{n-1}*2^n - 5*2^{n-1}u_{n+1} + 2^n*u_{n+1} = 0
u_{n+1} = \fraq{-6*2^{n-1}*2^n}{2^n-5*2^{n-1}}
u_{n+1} = \fraq{-6*2^{n-1}*2^n}{2^{n-1}(2-5)}
u_{n+1} = 2 * 2^n = 2^{n+1}
co kończy dowód.
*/

fn testequal(n: i32, exp: i64) -> () {
    assert_eq!(exp, fcn(n))
}
#[test]
fn basics() {
    testequal(17, 131072);
    testequal(21, 2097152);
}
