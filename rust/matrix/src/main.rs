use std::str::FromStr;
use std::io::Read;

fn main() -> std::io::Result<()> {
    // Read matrix size
    let size_str = std::fs::read_to_string("matrix_size.txt")?;
    let size = usize::from_str(size_str.trim()).expect("Invalid size");

    // Load matrices from binary files
    let matrix_a = load_matrix("matrix_a.bin", size)?;
    let matrix_b = load_matrix("matrix_b.bin", size)?;

    // Benchmark: Perform matrix multiplication
    let result = multiply_matrices(&matrix_a, &matrix_b, size);

    // Output a value to prevent optimization
    println!("Result[0][0]: {}", result[0]);

    Ok(())
}

fn load_matrix(filename: &str, size: usize) -> std::io::Result<Vec<f64>> {
    let mut file = std::fs::File::open(filename)?;
    let mut buffer = vec![0u8; size * size * std::mem::size_of::<f64>()];
    file.read_exact(&mut buffer)?;

    Ok(buffer
        .chunks_exact(8)
        .map(|chunk| f64::from_le_bytes(chunk.try_into().unwrap()))
        .collect())
}

fn multiply_matrices(a: &[f64], b: &[f64], size: usize) -> Vec<f64> {
    let mut result = vec![0.0; size * size];
    for i in 0..size {
        for k in 0..size {
            let a_ik = a[i * size + k];
            for j in 0..size {
                result[i * size + j] += a_ik * b[k * size + j];
            }
        }
    }
    result
}