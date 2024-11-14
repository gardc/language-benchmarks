#!/bin/bash

# Create bin directory if it doesn't exist
mkdir -p ./bin

# # Create Matrix pre-benchmark
# echo "Creating Matrix pre-benchmark..."
# python3 ./create_matrix.py
# mv matrix_size.txt ./bin/
# mv ./*.bin ./bin/

# Compile Go
echo "Compiling Go..."
cd ./go/
go build -o ../bin/go_bin main.go
cd ..

# Compile C#
echo "Compiling C#..."
cd ./csharp/
dotnet publish -c Release -o ./csharp_out
mv ./csharp_out/csharp ../bin/csharp_bin
cd ..

# Compile F#
echo "Compiling F#..."
cd ./fsharp/
dotnet build -c Release
cd ..

# Compile Rust
echo "Compiling Rust..."
cd rust/matrix
RUSTFLAGS="-C target-cpu=native" cargo build --release
mv ./target/release/matrix ../../bin/rust_bin
cd ../..

# Compile zig
echo "Compiling zig..."
cd zig/
zig build -Doptimize=ReleaseFast
cd ..
mv ./zig/zig-out/bin/zig ./bin/zig_bin

# Compile TS with Bun
echo "Compiling TS with Bun..."
cd ts/
bun build ./index.ts --compile --outfile ts_bin
cd ..
mv ./ts/ts_bin ./bin/ts_bin

# Compile C++ Clang
echo "Compiling C++..."
cd cpp/
clang++ -std=c++17 -Ofast -mtune=native -Wall -Wextra -pedantic -o ../bin/cpp_bin_clang main.cc
cd ..

# Compile C++ GCC
echo "Compiling C++..."
cd cpp/
g++ -std=c++20 -Ofast -mtune=native -Wall -Wextra -pedantic -o ../bin/cpp_bin_gcc main.cc
cd ..

# Swift
echo "Compiling Swift..."
cd swift/
swiftc -O -whole-module-optimization matrix.swift -o matrix_swift
cd ..
mv ./swift/matrix_swift ./bin/swift_bin

# Run benchmarks
echo "Running benchmarks..."
cd bin
hyperfine --warmup 1 --runs 1 --show-output --export-markdown ../benchmark_results.md \
    './go_bin' \
    './csharp_bin' \
    './rust_bin' \
    './zig_bin' \
    './cpp_bin_gcc' \
    './cpp_bin_clang' \
    'dotnet run --project ../csharp/csharp.csproj -c Release' \
    './ts_bin' \
    './swift_bin'


#    'dotnet run --project ../fsharp/fsharp.fsproj -c Release' \
#    'python3 ../python/main.py' \
