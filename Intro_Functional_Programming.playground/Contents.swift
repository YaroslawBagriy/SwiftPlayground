import Foundation

enum RideCategory: String {
    case family
    case kids
    case thrill
    case scary
    case relaxing
    case water
}

typealias Minutes = Double
struct Ride {
    let name: String
    let categories: Set<RideCategory>
    let waitTime: Minutes
}

// Immutability and Side Effects

// Creating immutable state creates solutions to problems of concurrency.
// Immutable state means it is free of side effects.
// Functions in your code wouldn’t alter elements outside of themselves and no spooky effects would appear when function calls occur.


let parkRides = [
    Ride(name: "Raging Rapids", categories: [.family, .thrill, .water], waitTime: 45.0),
    Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
    Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
    Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0),
    Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0)
]


// Modularity

// Imperative way to sort names
func sortedNames(of rides: [Ride]) -> [String] {
    var sortedRides = rides
    var key: Ride
    
    // Looping over all the rides passed into the function
    for i in (0..<sortedRides.count) {
        key = sortedRides[i]
        
        // Performing an insertion sort
        for j in stride(from: i, to: -1, by: -1) {
            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
                sortedRides.remove(at: j + 1)
                sortedRides.insert(key, at: j)
            }
        }
    }
    
    
    // Gathering the names of the sorted rides
    var sortedNames = [String]()
    for ride in sortedRides {
        sortedNames.append(ride.name)
    }
    
    return sortedNames
}

var originalNames = [String]()
for ride in parkRides {
    originalNames.append(ride.name)
}


print(originalNames)

print("Sorted Park Rides: " + "\(sortedNames(of: parkRides))")


// First-Class and Higher-Order Functions

// In FP languages functions are first-class citizens, meaning that functions are treated just like other objects, and can be assigned to variables.

// Filter: It accepts another function as a parameter. This other function accepts as an input a single value from the array, and returns a Bool.

func waitTimeIsShort(ride: Ride) -> Bool {
    return ride.waitTime < 15.0
}

var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
print(shortWaitTimeRides)

// Trailing closure
shortWaitTimeRides = parkRides.filter { $0.waitTime < 15.0 }
print(shortWaitTimeRides)


extension RideCategory: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}

extension Ride: CustomStringConvertible {
    var description: String {
        return "⚡️Ride(name: \"\(name)\", waitTime: \(waitTime), categories: \(categories))"
    }
}


// Map: accepts a single function as a parameter, and in turn, it produces an array of the same length after being applied to each element of the collection.


print(parkRides.map { $0.name }.sorted(by: <))


// Reduce: takes two parameters. The first is a starting value of a generic type Element, and the second is a function that combines a value of type Element with an element in the collection to produce another value of type Element.

let totalWaitTime = parkRides.reduce(0.0) { (total, ride) in total + ride.waitTime }
print(totalWaitTime)


// Partial Functions: This concept allows you to encapsulate one function within another, which allows you to define a part of a function while passing another component of it as a parameter.

func filter(for category: RideCategory) -> ([Ride]) -> [Ride] {
    return { (rides: [Ride]) in
        rides.filter { $0.categories.contains(category) }
    }
}

let kidRideFilter = filter(for: .kids)
print(kidRideFilter(parkRides))


// Pure Functions: A function can be considered pure if it meets two criteria:
//  1. The function always produces the same output when given the same input, e.g., the output only depends on its input.
//  2. The function creates zero side effects outside of it.

func ridesWithWaitTimeUnder(_ waitTime: Minutes, from rides: [Ride]) -> [Ride] {
    return rides.filter { $0.waitTime < waitTime }
}

// Example Unit Test
var shortWaitRides = ridesWithWaitTimeUnder(15, from: parkRides)
assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
print(shortWaitRides)

// Referential Transparency: An element of a program is referentially transparent if you can replace it with its definition and always produce the same result. It makes for predictable code and allows the compiler to perform optimizations. Pure functions satisfy this condition.

shortWaitRides = parkRides.filter { $0.waitTime < 15 }
assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
print(shortWaitRides)

// Recursion: occurs whenever a function calls itself as part of its function body.

extension Ride: Comparable {
    static func <(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.waitTime < rhs.waitTime
    }
    
    static func ==(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Array where Element: Comparable {
    func quickSorted() -> [Element] {
        if self.count > 1 {
            let (pivot, remaining) = (self[0], dropFirst())
            let lhs = remaining.filter { $0 <= pivot }
            let rhs = remaining.filter { $0 > pivot }
            return lhs.quickSorted() as [Element] + [pivot] + rhs.quickSorted()
        }
        return self
    }
}

print(parkRides.quickSorted())
print(parkRides)


// A great place to start working with FP techniques is in your Model layer, your ViewModel layer, and anywhere your application's business logic appears.
// By taking a functional, declarative approach, your code can be more concise and clear. As well, your code will be easier to test when isolated into modular functions that are free from side effects.
