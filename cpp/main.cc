#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include <cstdint>

std::vector<double> load_matrix(const std::string& filename, size_t size) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        throw std::runtime_error("Failed to open file: " + filename);
    }

    std::vector<double> matrix(size * size);
    file.read(reinterpret_cast<char*>(matrix.data()), size * size * sizeof(double));

    if (file.gcount() != static_cast<std::streamsize>(size * size * sizeof(double))) {
        throw std::runtime_error("Failed to read complete matrix from: " + filename);
    }

    return matrix;
}

std::vector<double> multiply_matrices(const std::vector<double>& a, const std::vector<double>& b, size_t size) {
    std::vector<double> result(size * size, 0.0);
    for (size_t i = 0; i < size; ++i) {
        for (size_t k = 0; k < size; ++k) {
            double a_ik = a[i * size + k];
            for (size_t j = 0; j < size; ++j) {
                result[i * size + j] += a_ik * b[k * size + j];
            }
        }
    }
    return result;
}

int main() {
    try {
        // Read matrix size
        std::ifstream size_file("matrix_size.txt");
        size_t size;
        size_file >> size;

        if (size_file.fail()) {
            throw std::runtime_error("Invalid size in matrix_size.txt");
        }

        // Load matrices from binary files
        std::vector<double> matrix_a = load_matrix("matrix_a.bin", size);
        std::vector<double> matrix_b = load_matrix("matrix_b.bin", size);

        // Benchmark: Perform matrix multiplication
        std::vector<double> result = multiply_matrices(matrix_a, matrix_b, size);

        // Output a value to prevent optimization
        std::cout << "Result[0][0]: " << result[0] << std::endl;

    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}