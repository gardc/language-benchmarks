import math

def is_prime(number):
    if number < 2:
        return False
    if number == 2:
        return True
    if number % 2 == 0:
        return False
    sqrt_n = int(math.sqrt(number)) + 1
    for i in range(3, sqrt_n, 2):
        if number % i == 0:
            return False
    return True

def nth_prime(n):
    count = 0
    number = 1
    while count < n:
        number += 1
        if is_prime(number):
            count += 1
    return number

def main():
    n = 1_000_000  # Adjust n as needed
    print(nth_prime(n))

if __name__ == "__main__":
    main()
