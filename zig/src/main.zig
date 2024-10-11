const std = @import("std");
const fs = std.fs;

const Errors = error{
    FileSizeMismatch,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) @panic("Memory leak detected");
    }

    const matrix_size_filename = "matrix_size.txt";

    // Read matrix size
    const size_string = try fs.cwd().readFileAlloc(allocator, matrix_size_filename, 1024);
    defer allocator.free(size_string);

    const size = try std.fmt.parseInt(usize, std.mem.trim(u8, size_string, &std.ascii.whitespace), 10);

    // Load matrices from binary files
    const matrix_a = try LoadMatrix("matrix_a.bin", size, allocator);
    defer allocator.free(matrix_a);

    const matrix_b = try LoadMatrix("matrix_b.bin", size, allocator);
    defer allocator.free(matrix_b);

    // Benchmark: Perform matrix multiplication
    const result = try MultiplyMatrices(matrix_a, matrix_b, size, allocator);
    defer allocator.free(result);

    // Output a value to prevent optimization
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Result[0][0]: {d}\n", .{result[0]});
}

fn LoadMatrix(filename: []const u8, size: usize, allocator: std.mem.Allocator) ![]f64 {
    // Allocate a flat array for the matrix
    const matrix_len = size * size;
    const matrix = try allocator.alloc(f64, matrix_len);
    errdefer allocator.free(matrix);

    // Open the binary file
    var file = try fs.cwd().openFile(filename, .{});
    defer file.close();

    // Check if file size matches expected matrix size
    const file_size = try file.getEndPos();
    const expected_size = matrix_len * @sizeOf(f64);

    if (file_size != expected_size) {
        return error.FileSizeMismatch;
    }

    // Read the entire binary file into the matrix
    const matrix_bytes = std.mem.sliceAsBytes(matrix);
    try file.reader().readNoEof(matrix_bytes);

    return matrix;
}

fn MultiplyMatrices(a: []const f64, b: []const f64, size: usize, allocator: std.mem.Allocator) ![]f64 {
    // Allocate result matrix
    const matrix_len = size * size;
    var result = try allocator.alloc(f64, matrix_len);
    errdefer allocator.free(result);

    // Initialize result to zero
    @memset(result, 0);

    // Perform matrix multiplication
    for (0..size) |i| {
        for (0..size) |k| {
            const a_ik = a[i * size + k];
            for (0..size) |j| {
                result[i * size + j] += a_ik * b[k * size + j];
            }
        }
    }

    return result;
}
