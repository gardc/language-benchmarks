#!/bin/bash

# Compile Go
echo "Compiling Go..."
cd ./go/
go build -o go_matrix main.go
cd ..

# Compile C#
cd ./csharp/
echo "Compiling C#..."
dotnet publish -c Release -o ./csharp_out
cd ..

# Compile Rust
echo "Compiling Rust..."
cd rust/matrix
cargo build --release
cd ../..

# Run benchmarks
echo "Running benchmarks..."
hyperfine --warmup 1 --runs 3 \
    './go/go_matrix' \
    './csharp/csharp_out/csharp' \
    './rust/matrix/target/release/matrix'
