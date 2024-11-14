#!/bin/bash

# Create bin dbg directory if it doesn't exist
mkdir -p ./bin-dbg

# Compile Rust
echo "Compiling Rust..."
cd rust/matrix
RUSTFLAGS="-C target-cpu=native" cargo build --release
mv ./target/release/matrix ../../bin-dbg/rust_bin
cd ../..

# Compile zig
echo "Compiling zig..."
cd zig/
zig build -Doptimize=ReleaseFast
cd ..
mv ./zig/zig-out/bin/zig ./bin-dbg/zig_bin

# Compile C++ Clang
echo "Compiling C++ with Clang for max performance..."
cd cpp/
clang++ -std=c++20 -Ofast -march=native -ffast-math -fno-exceptions -fno-rtti -fno-sanitize=all -fno-stack-protector -fno-signed-zeros -fno-trapping-math -funroll-loops -flto -o ../bin-dbg/cpp_bin_clang main.cc
cd ..

# Compile C++ GCC
echo "Compiling C++ with GCC for max performance..."
cd cpp/
g++ -std=c++20 -Ofast -march=native -ffast-math -fno-exceptions -fno-rtti -fno-sanitize=all -fno-stack-protector -fno-signed-zeros -fno-trapping-math -funroll-loops -flto -o ../bin-dbg/cpp_bin_gcc main.cc
cd ..

# Run benchmarks
echo "Running benchmarks..."
cd bin
hyperfine --warmup 0 --runs 1 --show-output --export-markdown ../dbg_benchmark_results.md \
    './rust_bin' \
    './zig_bin' \
    './cpp_bin_gcc' \
    './cpp_bin_clang' \
