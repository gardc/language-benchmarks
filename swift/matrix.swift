import Foundation

func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    if number == 2 { return true }
    if number % 2 == 0 { return false }
    let sqrtN = Int(Double(number).squareRoot())
    for i in stride(from: 3, through: sqrtN, by: 2) {
        if number % i == 0 { return false }
    }
    return true
}

func nthPrime(_ n: Int) -> Int {
    var count = 0
    var number = 1
    while count < n {
        number += 1
        if isPrime(number) {
            count += 1
        }
    }
    return number
}

func main() {
    for i in 999_990...1_000_000 {
        let prime = nthPrime(i)
        print("The \(i)th prime number is: \(prime)")
    }
}

main()
