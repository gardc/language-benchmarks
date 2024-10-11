import { readFileSync } from "fs";

// Read matrix size from a file
const size: number = parseInt(readFileSync("matrix_size.txt", "utf-8"));

// Load matrices A and B from binary files
const matrixA: number[][] = loadMatrix("matrix_a.bin", size);
const matrixB: number[][] = loadMatrix("matrix_b.bin", size);

// Perform matrix multiplication and store the result
const result: number[][] = multiplyMatrices(matrixA, matrixB, size);

// Output a single value from the result matrix to prevent optimization
console.log(`Result[0][0]: ${result[0][0]}`);

// Function to load a matrix from a binary file
function loadMatrix(filename: string, size: number): number[][] {
  // Initialize the matrix
  const matrix: number[][] = Array(size)
    .fill(null)
    .map(() => new Array(size));

  // Read all bytes from the file
  const buffer: Buffer = readFileSync(filename);

  // Copy data from buffer to matrix
  for (let i = 0; i < size; i++) {
    const row = new Float64Array(buffer.buffer, i * size * 8, size);
    matrix[i] = Array.from(row);
  }

  return matrix;
}

// Function to multiply two matrices
function multiplyMatrices(
  a: number[][],
  b: number[][],
  size: number
): number[][] {
  // Initialize the result matrix
  const result: number[][] = Array(size)
    .fill(null)
    .map(() => new Array(size).fill(0));

  // Perform matrix multiplication
  for (let i = 0; i < size; i++) {
    for (let k = 0; k < size; k++) {
      const a_ik = a[i][k];
      for (let j = 0; j < size; j++) {
        result[i][j] += a_ik * b[k][j];
      }
    }
  }
  return result;
}
