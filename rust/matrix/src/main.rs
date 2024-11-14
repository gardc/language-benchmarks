fn is_prime(number: u32) -> bool {
    if number < 2 {
        return false;
    }
    if number == 2 {
        return true;
    }
    if number % 2 == 0 {
        return false;
    }

    let sqrt = (number as f64).sqrt() as u32;

    for i in (3..=sqrt).step_by(2) {
        if number % i == 0 {
            return false;
        }
    }
    true
}

fn nth_prime(n: u32) -> u32 {
    let mut count = 0;
    let mut number = 1;
    while count < n {
        number += 1;
        if is_prime(number) {
            count += 1;
        }
    }
    number
}

fn main() {
    for i in 999_990..=1_000_000 {
        println!("{}th prime: {}", i, nth_prime(i));
    }
}
