use rand::Rng;

fn main() {
    let size = 1500; // Adjust this size to change runtime
    let matrix_a = generate_matrix(size);
    let matrix_b = generate_matrix(size);
    let result = multiply_matrices(&matrix_a, &matrix_b, size);

    // Optional: Output a single value to prevent optimizations
    println!("Result[0][0]: {}", result[0][0]);
}

fn generate_matrix(size: usize) -> Vec<Vec<f64>> {
    let mut rng = rand::thread_rng();
    let mut matrix = vec![vec![0.0; size]; size];
    for i in 0..size {
        for j in 0..size {
            matrix[i][j] = rng.gen::<f64>();
        }
    }
    matrix
}

fn multiply_matrices(a: &Vec<Vec<f64>>, b: &Vec<Vec<f64>>, size: usize) -> Vec<Vec<f64>> {
    let mut result = vec![vec![0.0; size]; size];
    for i in 0..size {
        for j in 0..size {
            let mut sum = 0.0;
            for k in 0..size {
                sum += a[i][k] * b[k][j];
            }
            result[i][j] = sum;
        }
    }
    result
}
