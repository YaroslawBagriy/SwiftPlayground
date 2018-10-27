import UIKit

// Imperative Programming
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
print(evens)

// Functional Programming
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
evens = Array(1...10).filter(isEven)
print(evens)

// Functional Programming Example 2
evens = Array(1...10).filter { (number) in number % 2 == 0 }
print(evens)

// Generic Function Example
func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens = myFilter(source: Array(1...10)) { $0 % 2 == 0 }
print(evens)




