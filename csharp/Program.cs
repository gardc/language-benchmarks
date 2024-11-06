bool IsPrime(int number)
{
    if (number < 2) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    int boundary = (int)Math.Sqrt(number);
    for (int i = 3; i <= boundary; i += 2)
        if (number % i == 0)
            return false;
    return true;
}

int NthPrime(int n)
{
    int count = 0;
    int number = 1;
    while (count < n)
    {
        number++;
        if (IsPrime(number))
            count++;
    }
    return number;
}

int n = 1_000_000; // Adjust n as needed
Console.WriteLine(NthPrime(n));
