#include <iostream>
#include <cmath>

bool is_prime(int number)
{
    if (number < 2)
        return false;
    if (number == 2)
        return true;
    if (number % 2 == 0)
        return false;
    int sqrt_n = static_cast<int>(std::sqrt(number));
    for (int i = 3; i <= sqrt_n; i += 2)
    {
        if (number % i == 0)
            return false;
    }
    return true;
}

int nth_prime(int n)
{
    int count = 0;
    int number = 1;
    while (count < n)
    {
        number++;
        if (is_prime(number))
            count++;
    }
    return number;
}

int main()
{
    int n = 1'000'000; // Adjust n as needed
    std::cout << nth_prime(n) << std::endl;
}