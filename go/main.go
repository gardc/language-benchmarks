package main

import (
	"encoding/binary"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	// Read matrix size
	sizeData, err := os.ReadFile("matrix_size.txt")
	if err != nil {
		panic(err)
	}
	size, err := strconv.Atoi(strings.TrimSpace(string(sizeData)))
	if err != nil {
		panic(err)
	}

	// Load matrices from binary files
	matrixA := loadMatrix("matrix_a.bin", size)
	matrixB := loadMatrix("matrix_b.bin", size)

	// Benchmark: Perform matrix multiplication
	result := multiplyMatrices(matrixA, matrixB, size)

	// Output a value to prevent optimization
	fmt.Println("Result[0]:", result[0])
}

func loadMatrix(filename string, size int) []float64 {
	data, err := os.ReadFile(filename)
	if err != nil {
		panic(err)
	}

	matrix := make([]float64, size*size)
	err = binary.Read(strings.NewReader(string(data)), binary.LittleEndian, matrix)
	if err != nil {
		panic(err)
	}
	return matrix
}

func multiplyMatrices(a, b []float64, size int) []float64 {
	result := make([]float64, size*size)

	for i := 0; i < size; i++ {
		for k := 0; k < size; k++ {
			a_ik := a[i*size+k]
			for j := 0; j < size; j++ {
				result[i*size+j] += a_ik * b[k*size+j]
			}
		}
	}
	return result
}
