# generate_matrices.py
import numpy as np

def main():
    size = 2000  # Adjust as needed
    matrix_a = np.random.rand(size, size).astype(np.float64)
    matrix_b = np.random.rand(size, size).astype(np.float64)

    matrix_a.tofile('matrix_a.bin')
    matrix_b.tofile('matrix_b.bin')

    # Save size information
    with open('matrix_size.txt', 'w') as f:
        f.write(str(size))

if __name__ == '__main__':
    main()
