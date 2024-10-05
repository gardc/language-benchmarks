// Read matrix size
int size = int.Parse(File.ReadAllText("matrix_size.txt"));

// Load matrices from binary files
double[][] matrixA = LoadMatrix("matrix_a.bin", size);
double[][] matrixB = LoadMatrix("matrix_b.bin", size);

// Benchmark: Perform matrix multiplication
double[][] result = MultiplyMatrices(matrixA, matrixB, size);

// Output a value to prevent optimization
Console.WriteLine("Result[0][0]: " + result[0][0]);

double[][] LoadMatrix(string filename, int size)
{
    double[][] matrix = new double[size][];
    for (int i = 0; i < size; i++)
    {
        matrix[i] = new double[size];
    }

    byte[] buffer = File.ReadAllBytes(filename);
    int offset = 0;
    for (int i = 0; i < size; i++)
    {
        Buffer.BlockCopy(buffer, offset, matrix[i], 0, size * sizeof(double));
        offset += size * sizeof(double);
    }

    return matrix;
}

double[][] MultiplyMatrices(double[][] a, double[][] b, int size)
{
    double[][] result = new double[size][];
    for (int i = 0; i < size; i++)
    {
        result[i] = new double[size];
    }

    for (int i = 0; i < size; i++)
    {
        for (int k = 0; k < size; k++)
        {
            double a_ik = a[i][k];
            for (int j = 0; j < size; j++)
            {
                result[i][j] += a_ik * b[k][j];
            }
        }
    }
    return result;
}
