import UIKit


// 1.1 Fibonacci Sequence

// 1.1.1 A first recursive attempt
func fib1(n: UInt) -> UInt {
    return fib1(n: n - 1) + fib1(n: n - 2)
}

// 1.1.2 Utilizing base cases
func fib2(n: UInt) -> UInt {
    // Base Case
    if (n < 2) {
        return n
    }
    
    // Recursive Case
    return fib2(n: n - 1) + fib2(n: n - 2)
}

// 1.1.3 Memoization to the resuce
// Fibonacci with memoization feature
var fibMemo: [UInt: UInt] = [0: 0, 1: 1]
func fib3(n: UInt) -> UInt {
    // New Base Case
    if let result = fibMemo[n] {
        return result
    } else {
        // Recursive Case
        fibMemo[n] = fib3(n: n - 1) + fib3(n: n - 2)
    }
    
    return fibMemo[n]!
}

print(fib3(n: 50))

// 1.1.4 Keep it simple, Fibonacci
func fib4(n: UInt) -> UInt {
    if (n == 0) {
        return n
    }
    
    // Base Case
    var last: UInt = 0
    var next: UInt = 1
    
    for _ in 1..<n {
        (last, next) = (next, last + next)
    }
    
    return next
}

// Naive recursive solutions can come with significant performance costs.
