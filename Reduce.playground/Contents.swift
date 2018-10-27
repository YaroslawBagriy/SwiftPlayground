import UIKit

// Imperative approach
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
    evenSum += i
}

print(evenSum)

// Reactive Approach
evenSum = Array(1...10)
    .filter { (number) in number % 2 == 0 }
    .reduce(0) { (total, number) in total + number }

print(evenSum)

// Reduce is a tremendously versatile Array method that executes a function once for each element, accumulating the results.

// Reduce Example #2
let maxNumber = Array(1...10)
    .reduce(0) { (total, number) in max(total, number) }

print(maxNumber)

// Reduce Example #3
let numbers = Array(1...10)
    .reduce("numbers: ") {(total, number) in total + "\(number) "}

print(numbers)

let digits = ["3", "1", "4", "1"]
let reducedArray = digits.reduce("") {(total, number) in total + number}

print(reducedArray)

// Reduce array implementation
extension Array {
    func myReduce<T, U>(seed:U, combiner:(U, T) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(current, item as! T)
        }
        return current
    }
}
