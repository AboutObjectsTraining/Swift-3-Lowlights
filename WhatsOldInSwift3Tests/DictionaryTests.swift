// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest

let books = [
    "Emma": 11.95,
    "Henry V": 14.99,
    "1984": 14.99,
    "Utopia": 11.95,
]

extension Dictionary where Key == String, Value == Double
{
    var currencyDescription: String {
        return reduce("[") { String(format:"%@%@\"%@\": %.2f",
                                    $0, $0.characters.count > 1 ? ", " : "",
                                    $1.key, $1.value) } + "]"
    }
//    func printValuesAsCurrency() {
//        for (key, value) in self {
//            print("\(key): \(String(format: "$%.2f", value))")
//        }
//    }
}

extension Dictionary where Value == [(key: String, value: Double)] {
    func printValuesAsCurrency() {
        for (key, value) in self {
            print("\(key): ")
            for element in value {
                print("\t\(element.key): \(element.value)")
            }
        }
    }
}

extension Array where Element == (key: String, value: Double)
{
    var currencyDescription: String {
        return reduce("[") { String(format:"%@%@(key: \"%@\", value: %.2f)",
                                    $0, $0.characters.count > 1 ? ", " : "",
                                    $1.key, $1.value) } + "]"
    }
}

extension Array where Element == Double
{
    var currencyDescription: String {
        return reduce("[") { String(format:"%@%@%.2f",
                                    $0, $0.characters.count > 1 ? ", " : "",
                                    $1) } + "]"
    }
}


class DictionaryTests: XCTestCase
{
    override func setUp() {
        super.setUp()
        print()
    }
    override func tearDown() {
        print()
        super.tearDown()
    }
    
    func testAccessElementsByPositions() {
        guard let index = books.index(forKey: "Emma") else { fatalError() }
        print(books.values[index])
    }

    // In Swift 3, Dictionary's `filter()` method returned an
    // array of key-value tuples instead of a dictionary.
    func testFilter() {
        let cheapBooks = books.filter { $0.value < 12.00 }
        print(cheapBooks.currencyDescription)
        // [(key: "Utopia", value: 11.95), (key: "Emma", value: 11.95)]

        // If you need a Dictionary result, you have to produce one manually
        let cheapBooksDict: [String: Double] = cheapBooks.reduce([:]) {
            var dict = $0
            dict[$1.key] = $1.value
            return dict
        }
        print(cheapBooksDict.currencyDescription)
        // ["Utopia": 11.95, "Emma": 11.95]

    }
    
    // Produces an array of transformed values
    func testMap() {
        let discount = 0.10
        let discountedPrices = books.map { $0.value * (1 - discount) }
        print(discountedPrices.currencyDescription)
        // [10.75, 13.49, 10.75, 13.49]
    }
    
    
    // Inserts any missing keys in dictionary with the provided default value.
    func testSetDefaultValue() {
        var discountedBooks = books
        let keys = ["Emma", "1984", "Foo"]
        for key in keys {
            // Swift 4:
            // discountedBooks[key, default: 0] *= 0.9
            if let value = discountedBooks[key] {
                discountedBooks[key] = value * 0.9
            } else {
                discountedBooks[key] = 0.0
            }
        }

        print(discountedBooks.currencyDescription)
    }
}


let personal = ["home": "703-333-4567", "cell": "202-444-1234"]
let work1 = ["main": "571-222-9876", "mobile": "703-987-5678"]
let work2 = ["main": "571-222-9876", "cell": "703-987-5678"]

extension DictionaryTests
{
    func testMerge() {
//        let p1: [String: Any] = personal.merging(work1) { first, _ in first }
//        print(p1)
//        
//        var phones1 = personal
//        phones1.merge(work1) { "\($0),\($1)" }
//        print(phones1)
//        
//        var phones2 = personal
//        phones2.merge(work2) { _, new in new }
//        print(phones2)
//        
//        var phones3 = personal
//        phones3.merge(work2) { "personal: \($0), work: \($1)" }
//        print(phones3)
//        
//        var phones4: [String: Any] = personal
//        phones4.merge(work2) { (personal: $0, work: $1) }
//        print(phones4)
    }
}

let bookDict: [String: Any] = ["title": "Book Title", "year": 1999, "author": "Plato"]

extension Dictionary.Index {
//    public var description: String {
//        let substrings = String(describing: self).split(separator: "(")
//        return String(substrings.last!.dropLast(3))
//    }
}

extension DictionaryTests
{
    func testContainsKey() throws {
        let key = bookDict.keys.first!
        XCTAssertTrue(bookDict.keys.contains(key))
    }
    
    func testObtainIndexOfKey() throws {
        let index = bookDict.index(forKey: "year")!
        let value = bookDict.values[index] as? String
        XCTAssertEqual(value, bookDict["year"] as? String)
    }
    
    func testIndexes() {
        let titleIndex = bookDict.index(forKey: "title")!
        print(titleIndex)
        let yearIndex = bookDict.index(forKey: "year")!
        print(yearIndex)
        let authorIndex = bookDict.index(forKey: "author")!
        print(authorIndex)
    }
    
    func testSubscriptWithIndex() throws {
        let index = bookDict.index(forKey: "year")!
        print(index)
        let entry = bookDict[index]
        print(entry)
        let key = bookDict.keys[index]
        print(key)
        let value = bookDict.values[index]
        print(value)
    }
    
    func testMutateNestedArray() {
        // NOTE: This works without casts for strongly typed dictionaries
        // (e.g., the following dictionary's type is `[String: [String]]`).
        //
        var dict = [
            "cats": ["leo", "tiger"],
            "dogs": ["spot", "rover"]
        ]
        
        dict["cats"]?.append("kitty")
        
        print(dict)
        XCTAssertEqual(dict["cats"]!.count, 3)
        
        let dogsKey = "dogs"
        let dogName = "fido"
        
        // Append to existing value if present; otherwise, add new element
        // Swift 3:
        //
         if dict.index(forKey: "dogs") != nil {
//            var dogs = dict.values[index]
//            dogs.append(dogName)
            dict["dogs"]?.append(dogName)
//             dict.values[index].append(dogName)
         } else {
             dict[dogsKey] = [dogName]
         }
        //
        // Swift 4:
        //
        // dict[dogsKey, default: [String]()].append(dogName)
        
        print(dict)
        XCTAssertEqual(dict[dogsKey]!.count, 3)
    }
}
