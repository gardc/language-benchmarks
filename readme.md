# Very simple and useless language Benchmarks 🚀

This project compares the performance of CPU intensive work in several languages I find interesting. It's designed to benchmark these languages using a common, computationally intensive task in a simple manner. The benchmark is not perfect, but might be realistically practical.

## 🧮 What it does

Each implementation finds the nth prime between 999'990 and 1'000'000.

## 🛠️ Languages and Tools

- Go
- C# AOT (.NET 9.0)
- C# (.NET 9.0)
- F# (.NET 9.0)
- Rust (Nightly)
- Zig
- TypeScript (Bun)
- Clang++ and GCC (G++) for C++
- Swift
- Python 3
- Hyperfine (for benchmarking)

## 🚀 Getting Started

1. Ensure you have all the tools listed above installed on your system.
2. Clone this repository
3. Run the benchmark script `chmod +x test.sh && ./test.sh`

## 📊 Benchmark Results

Run the `test.sh` script to see the benchmark results for yourself on your machine.

### My Results:

On MacBook Pro M3 Pro 36GB RAM:

```
Summary
  ./zig_bin ran
    1.01 ± 0.00 times faster than ./csharp_bin
    1.02 ± 0.00 times faster than ./go_bin
    1.07 ± 0.03 times faster than ./cpp_bin_gcc
    1.07 ± 0.00 times faster than dotnet run --project ../csharp/csharp.csproj -c Release
    1.09 ± 0.03 times faster than ./cpp_bin_clang
    1.19 ± 0.03 times faster than ./ts_bin
    1.29 ± 0.02 times faster than ./swift_bin
    1.49 ± 0.02 times faster than ./rust_bin
    3.76 ± 0.06 times faster than dotnet run --project ../fsharp/fsharp.fsproj -c Release
   43.59 ± 0.16 times faster than python3 ../python/main.py
```

### Disclaimer

This is a unrealistic benchmark and it's done very quickly in order to test languages.

## 📁 Project Structure

- `go/`: Go implementation
- `csharp/`: C# implementation
- `fsharp/`: F# implementation
- `rust/matrix/`: Rust implementation
- `zig/`: Zig implementation
- `cpp/`: C++ implementation
- `ts/` TypeScript implementation compiled with Bun
- `python/` Python implementation
- `swift/` Python implementation
- `test.sh`: Benchmark script
- `bin/`: Binary files for each compiled implementation
