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


// 1.2 Trivial Compression

struct CompressedGene {
    let length: Int
    private let bitVector: CFMutableBitVector
    
    init(original: String) {
        length = original.count
        // Default allocator, need 2 * length number of bits
        bitVector = CFBitVectorCreateMutable(kCFAllocatorDefault, length * 2)
        // Fills the bit vector with 0s
        CFBitVectorSetCount(bitVector, length * 2)
        compress(gene: original)
    }
    
    func decompress() -> String {
        var gene: String = ""
        for index in 0..<length {
            // Start of each nucleotide
            let nStart = index * 2
            let firstBit = CFBitVectorGetBitAtIndex(bitVector, nStart)
            let secondBit = CFBitVectorGetBitAtIndex(bitVector, nStart + 1)
            switch(firstBit, secondBit) {
                case (0, 0): // 00 A
                    gene += "A"
                case (0, 1): // 01 C
                    gene += "C"
                case (1, 0): // 01 G
                    gene += "G"
                case (1, 1): // 11 T
                    gene += "T"
                default:
                    break // Unreachable, but need default
            }
        }
        
        return gene
    }
    
    private func compress(gene: String) {
        for (index, nucleotide) in gene.uppercased().enumerated() {
            // Start of each new nucleotide
            let nStart = index * 2
            switch nucleotide {
                case "A": // 00
                    CFBitVectorSetBitAtIndex(bitVector, nStart, 0)
                    CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 0)
                case "C": // 01
                    CFBitVectorSetBitAtIndex(bitVector, nStart, 0)
                    CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 1)
                case "G": // 10
                    CFBitVectorSetBitAtIndex(bitVector, nStart, 1)
                    CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 0)
                case "T": // 11
                    CFBitVectorSetBitAtIndex(bitVector, nStart, 1)
                    CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 1)
                default:
                    print("Unexpected character \(nucleotide) at \(index)")
            }
        }
    }
}

print(CompressedGene(original: "ACCTGGCATTGCA").decompress())


// 1.3 Unbreakable Encryption

typealias OTPKey = [UInt8]
typealias OTPKeyPair = (key1: OTPKey, key2: OTPKey)

// 1.3.1 Getting the data in order
func randomOTPKey(length: Int) -> OTPKey {
    var randomKey: OTPKey = OTPKey()
    for _ in 0..<length {
        let randomKeyPoint = UInt8(arc4random_uniform(UInt32(UInt8.max)))
        randomKey.append(randomKeyPoint)
    }
    return randomKey
}

// 1.3.2 Encrypting and Decrypting

func encryptOTP(original: String) -> OTPKeyPair {
    let dummy = randomOTPKey(length: original.utf8.count)
    let encrypted: OTPKey = dummy.enumerated().map { (arg) -> UInt8 in
        
        let (i, e) = arg
        return e ^ original.utf8[original.utf8.index(original.utf8.startIndex, offsetBy: i)]
        
    }
    
    return (dummy, encrypted)
}

func decryptOT(keyPair: OTPKeyPair) -> String? {
    let decrypted: OTPKey = keyPair.key1.enumerated().map { i, e in
        e ^ keyPair.key2[i]
    }
    
    return String(bytes: decrypted, encoding: String.Encoding.utf8)
}

// Testing encrpytion and decryption code
var encryptedOTPKeyPair = encryptOTP(original: "test")
print(encryptedOTPKeyPair)
print(decryptOT(keyPair: encryptedOTPKeyPair)!)


// 1.4 Calculating PI


