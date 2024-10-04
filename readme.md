# Language Benchmarks: Matrix Multiplication 🚀

This project compares the performance of matrix multiplication implementations in Go, C#, and Rust. It's designed to benchmark these languages using a common, computationally intensive task.

## 🧮 What it does

Each implementation:
1. Generates two 1500x1500 matrices filled with random double-precision floating-point numbers.
2. Multiplies these matrices.
3. Outputs the value at position [0,0] of the result matrix to prevent compiler optimizations.

## 🛠️ Languages and Tools

- Go
- C# (.NET 9.0)
- Rust
- Hyperfine (for benchmarking)

## 🚀 Getting Started

1. Ensure you have Go, .NET SDK, Rust, and Hyperfine installed on your system.
2. Clone this repository
3. Run the benchmark script `chmod +x test.sh && ./test.sh`


## 📊 Benchmark Results

Run the `test.sh` script to see the benchmark results. The script will compile each implementation and run them 10 times each, with 3 warmup runs.

### My Results: 

```
Running benchmarks...
Benchmark 1: ./go/go_matrix
  Time (mean ± σ):      4.194 s ±  0.181 s    [User: 4.165 s, System: 0.026 s]
  Range (min … max):    4.054 s …  4.505 s    5 runs

Benchmark 2: ./csharp/csharp_out/csharp
  Time (mean ± σ):      3.715 s ±  0.128 s    [User: 3.671 s, System: 0.031 s]
  Range (min … max):    3.589 s …  3.891 s    5 runs

Benchmark 3: ./rust/matrix/target/release/matrix
  Time (mean ± σ):      3.602 s ±  0.088 s    [User: 3.575 s, System: 0.020 s]
  Range (min … max):    3.507 s …  3.746 s    5 runs

Summary
  ./rust/matrix/target/release/matrix ran
    1.03 ± 0.04 times faster than ./csharp/csharp_out/csharp
    1.16 ± 0.06 times faster than ./go/go_matrix
```
Which means Rust is just barely faster than C#, and Go is 1.16 ± 0.06 times slower than Rust. All fast languages!

## 📁 Project Structure

- `go/`: Go implementation
- `csharp/`: C# implementation
- `rust/matrix/`: Rust implementation
- `test.sh`: Benchmark script
