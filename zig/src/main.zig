const std = @import("std");
const math = std.math;
const print = std.debug.print;

pub fn is_prime(number: u32) bool {
    if (number < 2) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;

    const sqrtN = math.sqrt(number);

    var i: u32 = 3;
    while (i <= sqrtN) : (i += 2) {
        if (number % i == 0) return false;
    }

    return true;
}

pub fn nth_prime(n: u32) u32 {
    var count: u32 = 0;
    var number: u32 = 1;
    while (count < n) {
        number += 1;
        if (is_prime(number)) {
            count += 1;
        }
    }
    return number;
}

pub fn main() void {
    var i: u32 = 999_990;
    while (i <= 1_000_000) : (i += 1) {
        const nthPrime = nth_prime(i);
        print("The {}th prime number is: {}\n", .{ i, nthPrime });
    }
}
