use std::str::FromStr;

fn main() {
    // Read matrix size
    let size_str = std::fs::read_to_string("matrix_size.txt").expect("Failed to read size file");
    let size = usize::from_str(size_str.trim()).expect("Invalid size");

    // Load matrices from binary files
    let matrix_a = load_matrix("matrix_a.bin", size);
    let matrix_b = load_matrix("matrix_b.bin", size);

    // Benchmark: Perform matrix multiplication
    let result = multiply_matrices(&matrix_a, &matrix_b, size);

    // Output a value to prevent optimization
    println!("Result[0][0]: {}", result[0][0]);
}

fn load_matrix(filename: &str, size: usize) -> Vec<Vec<f64>> {
    let data = std::fs::read(filename).expect("Failed to read file");
    let mut matrix = vec![vec![0.0f64; size]; size];

    let mut offset = 0;
    for i in 0..size {
        for j in 0..size {
            let bytes = &data[offset..offset + 8];
            matrix[i][j] = f64::from_le_bytes(bytes.try_into().unwrap());
            offset += 8;
        }
    }
    matrix
}

fn multiply_matrices(a: &Vec<Vec<f64>>, b: &Vec<Vec<f64>>, size: usize) -> Vec<Vec<f64>> {
    let mut result = vec![vec![0.0; size]; size];
    for i in 0..size {
        for k in 0..size {
            let a_ik = a[i][k];
            for j in 0..size {
                result[i][j] += a_ik * b[k][j];
            }
        }
    }
    result
}
