const std = @import("std");
const math = std.math;

fn isPrime(number: i32) bool {
    if (number < 2) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    const sqrt_n = @intFromFloat(@sqrt(@as(f32, @floatFromInt(number))));
    var i: i32 = 3;
    while (i <= sqrt_n) : (i += 2) {
        if (number % i == 0) return false;
    }
    return true;
}

fn nthPrime(n: i32) i32 {
    var count: i32 = 0;
    var number: i32 = 1;
    while (count < n) : (number += 1) {
        if (isPrime(number)) {
            count += 1;
        }
    }
    return number;
}

pub fn main() !void {
    const n: i32 = 500000; // Adjust n as needed
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{nthPrime(n)});
}

test "basic test" {
    try std.testing.expectEqual(nthPrime(1), 2);
    try std.testing.expectEqual(nthPrime(2), 3);
    try std.testing.expectEqual(nthPrime(3), 5);
}
