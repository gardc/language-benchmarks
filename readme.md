# Language Benchmarks: Matrix Multiplication 🚀

This project compares the performance of matrix multiplication implementations in Go, C#, and Rust. It's designed to benchmark these languages using a common, computationally intensive task in a very simple matter. The benchmark is not from perfect, but it's realistically practical.

## 🧮 What it does

Each implementation:

1. Uses only standard library and no unsafe code.
2. Loads two 2000x2000 matrices filled with random double-precision floating-point numbers.
3. Multiplies these matrices.
4. Outputs the value at position [0,0] of the result matrix to prevent compiler optimizations.

## 🛠️ Languages and Tools

- Go
- C# (.NET 9.0)
- Rust
- Hyperfine (for benchmarking)
- Python 3 with numpy (for matrix generation)

## 🚀 Getting Started

1. Ensure you have Go, .NET SDK, Rust, Python 3 and Hyperfine installed on your system.
2. Clone this repository
3. Run the benchmark script `chmod +x test.sh && ./test.sh`

## 📊 Benchmark Results

Run the `test.sh` script to see the benchmark results. The script will compile each implementation and run them 10 times each, with 3 warmup runs.

### My Results:

```
Running benchmarks...
Benchmark 1: ./go_matrix
  Time (mean ± σ):      5.243 s ±  0.025 s    [User: 5.216 s, System: 0.029 s]
  Range (min … max):    5.213 s …  5.270 s    5 runs

Benchmark 2: ./csharp_matrix
  Time (mean ± σ):      3.371 s ±  0.007 s    [User: 3.344 s, System: 0.022 s]
  Range (min … max):    3.364 s …  3.381 s    5 runs

Benchmark 3: ./rust_matrix
  Time (mean ± σ):      4.606 s ±  0.014 s    [User: 4.575 s, System: 0.027 s]
  Range (min … max):    4.595 s …  4.623 s    5 runs

Summary
  ./csharp_matrix ran
    1.37 ± 0.00 times faster than ./rust_matrix
    1.56 ± 0.01 times faster than ./go_matrix
```

Which means C# on .NET 9 is surprisingly 1.37 times faster than Rust and 1.56 times faster than Go in this example.

### Disclaimer

Micro benchmarks like this can be misleading and should be taken with a grain of salt. Real-world performance can vary greatly depending on the specifics of the application and the workload. Always profile your specific use case to determine the best language for your needs. I'm sure Rust can be optimized further to be faster than C# again, but this was the first naive implementations of the matrix multiplication algorithm.

It's also worth noting that this benchmark was originally made within an hour so further improvements are needed to actually make the implementations fair, WIP. Adding more languages in the future can also be interesting.

Also, CPU & memory usage is not taken into account in this benchmark. For future improvement, it would be interesting to add this to the benchmark.

## 📁 Project Structure

- `go/`: Go implementation
- `csharp/`: C# implementation
- `rust/matrix/`: Rust implementation
- `test.sh`: Benchmark script
- `generate_matrix.py`: Python script to generate matrices
- `bin/`: Binary files for each implementation and the generated 2000x2000 matrices