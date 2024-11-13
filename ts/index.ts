function isPrime(number: number): boolean {
  if (number < 2) return false;
  if (number === 2) return true;
  if (number % 2 === 0) return false;
  const sqrtN = Math.floor(Math.sqrt(number));
  for (let i = 3; i <= sqrtN; i += 2) {
    if (number % i === 0) return false;
  }
  return true;
}

function nthPrime(n: number): number {
  let count = 0;
  let number = 1;
  while (count < n) {
    number++;
    if (isPrime(number)) count++;
  }
  return number;
}

function main(): void {
  const start: number = 999_990;
  const end: number = 1_000_000;

  for (let n = start; n <= end; n++) {
    const prime = nthPrime(n);
    console.log(`The ${n}th prime number is: ${prime}`);
  }
}

main();
