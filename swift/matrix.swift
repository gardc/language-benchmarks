import Foundation

struct MatrixError: Error {
    let message: String
}

func loadMatrix(from filename: String, size: Int) throws -> [Double] {
    let fileURL = URL(fileURLWithPath: filename)
    let data = try Data(contentsOf: fileURL)
    
    guard data.count == size * size * MemoryLayout<Double>.size else {
        throw MatrixError(message: "Invalid file size for matrix: \(filename)")
    }
    
    return data.withUnsafeBytes { bufferPointer in
        Array(bufferPointer.bindMemory(to: Double.self))
    }
}

func multiplyMatrices(_ a: [Double], _ b: [Double], size: Int) -> [Double] {
    var result = [Double](repeating: 0.0, count: size * size)
    
    for i in 0..<size {
        for k in 0..<size {
            let a_ik = a[i * size + k]
            for j in 0..<size {
                result[i * size + j] += a_ik * b[k * size + j]
            }
        }
    }
    
    return result
}

do {
    // Read matrix size
    let sizeString = try String(contentsOfFile: "matrix_size.txt", encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let size = Int(sizeString) else {
        throw MatrixError(message: "Invalid size in matrix_size.txt")
    }

    // Load matrices from binary files
    let matrixA = try loadMatrix(from: "matrix_a.bin", size: size)
    let matrixB = try loadMatrix(from: "matrix_b.bin", size: size)

    // Benchmark: Perform matrix multiplication
    let result = multiplyMatrices(matrixA, matrixB, size: size)

    // Output a value to prevent optimization
    print("Result[0]: \(result[0])")
} catch {
    print("Error: \(error)")
}