using System;
using System.IO;
using System.Runtime.InteropServices;

class Program
{
    static void Main()
    {
        // Read matrix size from a file
        int size = int.Parse(File.ReadAllText("matrix_size.txt"));

        // Load matrices A and B from binary files
        double[] matrixA = LoadMatrix("matrix_a.bin", size);
        double[] matrixB = LoadMatrix("matrix_b.bin", size);

        // Perform matrix multiplication and store the result
        double[] result = MultiplyMatrices(matrixA, matrixB, size);

        // Output a single value from the result matrix to prevent optimization
        Console.WriteLine($"Result[0]: {result[0]}");
    }

    // Function to load a matrix from a binary file
    static double[] LoadMatrix(string filename, int size)
    {
        byte[] bytes = File.ReadAllBytes(filename);
        double[] matrix = new double[size * size];
        Buffer.BlockCopy(bytes, 0, matrix, 0, bytes.Length);
        return matrix;
    }

    // Function to multiply two matrices
    static double[] MultiplyMatrices(double[] a, double[] b, int size)
    {
        double[] result = new double[size * size];

        for (int i = 0; i < size; i++)
        {
            for (int k = 0; k < size; k++)
            {
                double a_ik = a[i * size + k];
                for (int j = 0; j < size; j++)
                {
                    result[i * size + j] += a_ik * b[k * size + j];
                }
            }
        }

        return result;
    }
}