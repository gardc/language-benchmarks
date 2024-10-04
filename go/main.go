package main

import (
	"fmt"
	"math/rand"
)

func main() {
	size := 2000 // Adjust this size to change runtime
	matrixA := generateMatrix(size)
	matrixB := generateMatrix(size)
	result := multiplyMatrices(matrixA, matrixB, size)

	// Optional: Output a single value to prevent optimizations
	fmt.Println("Result[0][0]:", result[0][0])
}

func generateMatrix(size int) [][]float64 {
	matrix := make([][]float64, size)
	for i := range matrix {
		matrix[i] = make([]float64, size)
		for j := range matrix[i] {
			matrix[i][j] = rand.Float64()
		}
	}
	return matrix
}

func multiplyMatrices(a, b [][]float64, size int) [][]float64 {
	result := make([][]float64, size)
	for i := range result {
		result[i] = make([]float64, size)
	}

	for i := 0; i < size; i++ {
		for j := 0; j < size; j++ {
			sum := 0.0
			for k := 0; k < size; k++ {
				sum += a[i][k] * b[k][j]
			}
			result[i][j] = sum
		}
	}
	return result
}
