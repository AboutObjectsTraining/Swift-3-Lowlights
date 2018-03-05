// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest

class StringTests: XCTestCase
{
    override func setUp() {
        super.setUp(); print()
    }
    override func tearDown() {
        print(); super.tearDown()
    }
    
    func testSubstringAndPadding() {
        let stars = "✭✭✭✭✭"
        let index = stars.characters.index(stars.characters.startIndex, offsetBy: 3)
        let s = stars[stars.characters.startIndex..<index]
        
        // Swift 4:
        //
        // let index = stars.index(stars.startIndex, offsetBy: 3)
        // let s = stars[..<index]
        
        print(s)
        
        let padded = s.padding(toLength: 5, withPad: "✩", startingAt: 0)
        print(padded)
    }
    
    func testSubstringDroppingFirstLast() {
        let stars = "✭✭✭✭✭✩✩✩✩✩"
        let charView1 = stars.characters.dropFirst(2)
        print(charView1)
        // CharacterView(_core: Swift._StringCore(_baseAddress: Optional(0x0000000101362454), _countAndFlags: 9223372036854775816, _owner: nil), _coreOffset: 2)

        let charView2 = charView1.dropLast(3)
        print(charView2)
        
        let s = String(charView2)
        print(s)
        
        // Swift 4:
        //
        // let s = stars.dropFirst(2).dropLast(3)
        // print(s)
    }
}
