import { readFileSync } from "fs";

// Read matrix size from a file
const size: number = parseInt(readFileSync("matrix_size.txt", "utf-8"));

// Load matrices A and B from binary files
const matrixA: Float64Array = loadMatrix("matrix_a.bin", size);
const matrixB: Float64Array = loadMatrix("matrix_b.bin", size);

// Perform matrix multiplication and store the result
const result: Float64Array = multiplyMatrices(matrixA, matrixB, size);

// Output a single value from the result matrix to prevent optimization
console.log(`Result[0][0]: ${result[0]}`);

// Function to load a matrix from a binary file
function loadMatrix(filename: string, size: number): Float64Array {
  const buffer: Buffer = readFileSync(filename);
  return new Float64Array(buffer.buffer, buffer.byteOffset, size * size);
}

// Function to multiply two matrices
function multiplyMatrices(
  a: Float64Array,
  b: Float64Array,
  size: number
): Float64Array {
  const result: Float64Array = new Float64Array(size * size);

  for (let i = 0; i < size; i++) {
    for (let k = 0; k < size; k++) {
      const a_ik = a[i * size + k];
      for (let j = 0; j < size; j += 4) {
        result[i * size + j] += a_ik * b[k * size + j];
        result[i * size + j + 1] += a_ik * b[k * size + j + 1];
        result[i * size + j + 2] += a_ik * b[k * size + j + 2];
        result[i * size + j + 3] += a_ik * b[k * size + j + 3];
      }
    }
  }

  return result;
}