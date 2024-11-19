package org.example;

public class NthPrimeCalculator {

    /**
     * Checks if a given number is prime.
     *
     * @param number The number to check for primality.
     * @return true if the number is prime; false otherwise.
     */
    public static boolean isPrime(int number) {
        if (number < 2)
            return false;
        if (number == 2)
            return true;
        if (number % 2 == 0)
            return false;

        int sqrtN = (int) Math.sqrt(number);
        for (int i = 3; i <= sqrtN; i += 2) {
            if (number % i == 0)
                return false;
        }
        return true;
    }

    /**
     * Finds the nth prime number.
     *
     * @param n The ordinal of the prime number to find.
     * @return The nth prime number.
     */
    public static int nthPrime(int n) {
        int count = 0;
        int number = 1;
        while (count < n) {
            number++;
            if (isPrime(number))
                count++;
        }
        return number;
    }

    public static void main(String[] args) {
        // Define the range for n
        int startN = 999_990;
        int endN = 1_000_000;

        for (int n = startN; n <= endN; ++n) {
            int prime = nthPrime(n);
            System.out.println("The " + n + "th prime number is: " + prime);
        }
    }
}
