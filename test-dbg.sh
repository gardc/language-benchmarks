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

# Java
echo "Compiling Java..."
cd java/
./gradlew jar
cd ..
mv ./java/app/build/libs/app.jar ./bin-dbg/java_bin.jar

# Compile C#
echo "Compiling C#..."
cd ./csharp/
dotnet publish -c Release -o ./csharp_out
mv ./csharp_out/csharp ../bin-dbg/csharp_bin
cd ..

# Run benchmarks
echo "Running benchmarks..."
cd bin-dbg
hyperfine --warmup 0 --runs 2 --show-output --export-markdown ../dbg_benchmark_results.md \
    './rust_bin' \
    './zig_bin' \
    './cpp_bin_gcc' \
    './cpp_bin_clang' \
    'java -jar java_bin.jar' \
    './csharp_bin'
