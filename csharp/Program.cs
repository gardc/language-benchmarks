const int size = 1500; // Adjust this size to change runtime
double[,] matrixA = GenerateMatrix(size);
double[,] matrixB = GenerateMatrix(size);
double[,] result = MultiplyMatrices(matrixA, matrixB, size);

// Optional: Output a single value to prevent optimizations
Console.WriteLine("Result[0,0]: " + result[0, 0]);

double[,] GenerateMatrix(int size)
{
    var rand = new Random();
    double[,] matrix = new double[size, size];
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            matrix[i, j] = rand.NextDouble();
        }
    }
    return matrix;
}

double[,] MultiplyMatrices(double[,] a, double[,] b, int size)
{
    double[,] result = new double[size, size];
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            double sum = 0;
            for (int k = 0; k < size; k++)
            {
                sum += a[i, k] * b[k, j];
            }
            result[i, j] = sum;
        }
    }
    return result;
}
