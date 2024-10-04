# Language Benchmarks: Matrix Multiplication 🚀

This project compares the performance of matrix multiplication implementations in Go, C#, and Rust. It's designed to benchmark these languages using a common, computationally intensive task in a very simple matter. The benchmark is far from perfect, but it's realistically practical.

## 🧮 What it does

Each implementation:

1. Generates two 2000x2000 matrices filled with random double-precision floating-point numbers.
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
  Time (mean ± σ):     20.877 s ±  0.586 s    [User: 20.789 s, System: 0.088 s]
  Range (min … max):   20.340 s … 21.502 s    3 runs

Benchmark 2: ./csharp/csharp_out/csharp
  Time (mean ± σ):     10.582 s ±  0.151 s    [User: 10.500 s, System: 0.056 s]
  Range (min … max):   10.409 s … 10.692 s    3 runs

Benchmark 3: ./rust/matrix/target/release/matrix
  Time (mean ± σ):     18.525 s ±  0.080 s    [User: 18.466 s, System: 0.048 s]
  Range (min … max):   18.452 s … 18.610 s    3 runs

Summary
  ./csharp/csharp_out/csharp ran
    1.75 ± 0.03 times faster than ./rust/matrix/target/release/matrix
    1.97 ± 0.06 times faster than ./go/go_matrix
```

Which means C# on .NET 9 is surprisingly 1.75 times faster than Rust and 1.97 times faster than Go in this example.

### Disclaimer

Micro benchmarks like this can be misleading and should be taken with a grain of salt. Real-world performance can vary greatly depending on the specifics of the application and the workload. Always profile your specific use case to determine the best language for your needs. I'm sure Rust can be optimized further to be faster than C# again, but this was the first naive implementations of the matrix multiplication algorithm.

## 📁 Project Structure

- `go/`: Go implementation
- `csharp/`: C# implementation
- `rust/matrix/`: Rust implementation
- `test.sh`: Benchmark script
