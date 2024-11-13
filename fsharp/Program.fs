open System

// Function to check if a number is prime
let isPrime (number: int) = 
    if number < 2 then false
    elif number = 2 then true
    elif number % 2 = 0 then false
    else 
        let boundary = int (sqrt (float number))
        seq {3 .. 2 .. boundary} 
        |> Seq.exists (fun i -> number % i = 0) 
        |> not

// Function to find the nth prime number
let nthPrime n =
    let rec findPrime count number =
        if count = n then number
        else
            let nextNumber = number + 1
            if isPrime nextNumber 
            then findPrime (count + 1) nextNumber
            else findPrime count nextNumber
    findPrime 0 0

// Loop from 999,990 to 1,000,000 and print the nth prime for each n
for n in 999_990 .. 1_000_000 do
    let prime = nthPrime n
    printfn "The %dth prime number is: %d" n prime
