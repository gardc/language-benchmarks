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

# Run benchmarks
echo "Running benchmarks..."
cd bin
hyperfine --warmup 2 --runs 5 \
    './go_matrix' \
    './csharp_matrix' \
    './rust_matrix'
