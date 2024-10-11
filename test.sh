#!/bin/bash

# Create bin directory if it doesn't exist
mkdir -p ./bin

# Create Matrix pre-benchmark
echo "Creating Matrix pre-benchmark..."
python3 ./create_matrix.py
mv matrix_size.txt ./bin/
mv ./*.bin ./bin/

# Compile Go
echo "Compiling Go..."
cd ./go/
go build -o ../bin/go_matrix main.go
cd ..

# Compile C#
echo "Compiling C#..."
cd ./csharp/
dotnet publish -c Release -o ./csharp_out
mv ./csharp_out/csharp ../bin/csharp_matrix
cd ..

# Compile Rust
echo "Compiling Rust..."
cd rust/matrix
cargo build --release
mv ./target/release/matrix ../../bin/rust_matrix
cd ../..

# Compile zig
echo "Compiling zig..."
cd zig/
zig build -Doptimize=ReleaseFast
cd ..
mv ./zig/zig-out/bin/zig ./bin/zig_matrix

# Compile TS with Bun
echo "Compiling TS with Bun..."
cd ts/
bun build ./index.ts --compile --outfile ts_matrix
cd ..
mv ./ts/ts_matrix ./bin/ts_matrix

# Compile C++ Clang
echo "Compiling C++..."
cd cpp/
clang++ -std=c++17 -Ofast -mtune=native -Wall -Wextra -pedantic -o ../bin/cpp_matrix_clang main.cc
cd ..

# Compile C++ GCC
echo "Compiling C++..."
cd cpp/
g++ -std=c++20 -Ofast -mtune=native -Wall -Wextra -pedantic -o ../bin/cpp_matrix_gcc main.cc
cd ..

# Swift
echo "Compiling Swift..."
cd swift/
swiftc -O -whole-module-optimization matrix.swift -o matrix_swift
cd ..
mv ./swift/matrix_swift ./bin/swift_matrix

# Run benchmarks
echo "Running benchmarks..."
cd bin
hyperfine --warmup 3 --runs 6 --show-output --export-markdown ../benchmark_results.md \
    './go_matrix' \
    './csharp_matrix' \
    './rust_matrix' \
    './zig_matrix' \
    './ts_matrix' \
    './cpp_matrix_clang' \
    './cpp_matrix_gcc' \
    './swift_matrix' \
