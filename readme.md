# Language Benchmarks: Matrix Multiplication 🚀

This project compares the performance of matrix multiplication implementations in several languages I find interesting. It's designed to benchmark these languages using a common, computationally intensive task in a simple manner. The benchmark is not perfect, but it's realistically practical. Optimization is done as far as it's practical, which I think means right up until SIMD is involved.

## 🧮 What it does

Each implementation:

1. Uses only standard library and no unsafe code (Rust).
2. Loads two 2000x2000 matrices filled with random double-precision floating-point numbers.
3. Multiplies these matrices.
4. Outputs the value at position [0,0] of the result matrix to prevent compiler over-optimizations.

## 🛠️ Languages and Tools

- Go
- C# (.NET 9.0)
- Rust
- Zig
- TypeScript (Bun)
- Clang++ and GCC (G++) for C++
- Swift
- Hyperfine (for benchmarking)
- Python 3 with numpy (for matrix generation)

## 🚀 Getting Started

1. Ensure you have all the tools listed above installed on your system.
2. Clone this repository
3. Run the benchmark script `chmod +x test.sh && ./test.sh`

## 📊 Benchmark Results

Run the `test.sh` script to see the benchmark results. The script will compile each implementation and run them 10 times each, with 3 warmup runs.

### My Results:
On MacBook Pro M3 Pro 36GB RAM:

```
Summary
  ./rust_matrix ran
    1.00 ± 0.00 times faster than ./cpp_matrix_clang
    1.02 ± 0.02 times faster than ./cpp_matrix_gcc
    1.04 ± 0.03 times faster than ./zig_matrix
    3.05 ± 0.12 times faster than ./go_matrix
    3.51 ± 0.06 times faster than ./ts_matrix
    4.00 ± 0.07 times faster than ./swift_matrix
    4.22 ± 0.11 times faster than ./csharp_matrix
```
It's basically Rust, Zig and C++ that compete in top tier. What I find surprising is how performant Bun is, it's basically as fast as Go with (subjectively) more ergonomic code utilizing TypeScript.

### Disclaimer

Micro benchmarks like this can be misleading and should be taken with a grain of salt. Real-world performance can vary greatly depending on the specifics of the application and the workload. Always profile your specific use case to determine the best language for your needs. I'm sure Rust can be optimized further to be faster than C# again, but this was the first naive implementations of the matrix multiplication algorithm.

It's also worth noting that this benchmark was originally made within an hour so further improvements are needed to actually make the implementations fair, WIP. Adding more languages in the future can also be interesting.

Also, CPU & memory usage is not taken into account in this benchmark. For future improvement, it would be interesting to add this to the benchmark.

## 📁 Project Structure

- `go/`: Go implementation
- `csharp/`: C# implementation
- `rust/matrix/`: Rust implementation
- `zig/`: Zig implementation
- `cpp/`: C++ implementation
- `ts/` TypeScript implementation compiled with Bun
- `test.sh`: Benchmark script
- `generate_matrix.py`: Python script to generate matrices
- `bin/`: Binary files for each implementation and the generated 2000x2000 matrices