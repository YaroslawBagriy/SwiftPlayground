import UIKit
import Foundation

let words = ["Cat", "Chicken", "fish", "Dog",
             "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

// Imperative example
func buildIndex(words: [String]) -> [Entry] {
    var result = [Entry]()
    
    var letters = [Character]()
    for word in words {
        let firstLetter = Character(String(word.first!).uppercased())
        
        if !letters.contains(firstLetter) {
            letters.append(firstLetter)
        }
    }
    
    for letter in letters {
        var wordsForLetter = [String]()
        for word in words {
            let firstLetter = Character(String(word.first!).uppercased())
            
            if firstLetter == letter {
                wordsForLetter.append(word)
            }
        }
        result.append((letter, wordsForLetter))
    }
    return result
}

print(buildIndex(words: words))

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    for item in source {
        if !unique.contains(item) {
            unique.append(item)
        }
    }
    return unique
}

// Functional example
func buildIndexFunctional(words: [String]) -> [Entry] {
    func firstLetter(str: String) -> Character {
        return Character(String(words.first!).uppercased())
    }
    
    return distinct(source: words.map(firstLetter))
        .map {
            (letter) -> Entry in
            return (letter, words.filter {
                (word) -> Bool in
                firstLetter(str: word) == letter
            })
    }
}

print(buildIndexFunctional(words: words))
