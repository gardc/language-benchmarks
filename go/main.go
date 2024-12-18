package main

import (
	"fmt"
	"math"
)

func isPrime(number int) bool {
	if number < 2 {
		return false
	}
	if number == 2 {
		return true
	}
	if number%2 == 0 {
		return false
	}
	sqrtN := int(math.Sqrt(float64(number)))
	for i := 3; i <= sqrtN; i += 2 {
		if number%i == 0 {
			return false
		}
	}
	return true
}

func nthPrime(n int) int {
	count := 0
	number := 1
	for count < n {
		number++
		if isPrime(number) {
			count++
		}
	}
	return number
}

func main() {
	start := 999_990
	end := 1_000_000

	for n := start; n <= end; n++ {
		result := nthPrime(n)
		fmt.Printf("The %dth prime number is: %d\n", n, result)
	}
}
