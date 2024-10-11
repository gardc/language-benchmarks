// Read matrix size from a file
int size = int.Parse(File.ReadAllText("matrix_size.txt"));

// Load matrices A and B from binary files
double[][] matrixA = LoadMatrix("matrix_a.bin", size);
double[][] matrixB = LoadMatrix("matrix_b.bin", size);

// Perform matrix multiplication and store the result
double[][] result = MultiplyMatrices(matrixA, matrixB, size);

// Output a single value from the result matrix to prevent optimization
Console.WriteLine("Result[0][0]: " + result[0][0]);

// Function to load a matrix from a binary file
double[][] LoadMatrix(string filename, int size)
{
    // Initialize the matrix
    double[][] matrix = new double[size][];
    for (int i = 0; i < size; i++)
    {
        matrix[i] = new double[size];
    }

    // Read all bytes from the file
    byte[] buffer = File.ReadAllBytes(filename);
    int offset = 0;

    // Copy data from buffer to matrix
    for (int i = 0; i < size; i++)
    {
        Buffer.BlockCopy(buffer, offset, matrix[i], 0, size * sizeof(double));
        offset += size * sizeof(double);
    }

    return matrix;
}

// Function to multiply two matrices
double[][] MultiplyMatrices(double[][] a, double[][] b, int size)
{
    // Initialize the result matrix
    double[][] result = new double[size][];
    for (int i = 0; i < size; i++)
    {
        result[i] = new double[size];
    }

    // Perform matrix multiplication
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
