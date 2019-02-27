// Copyright © 2017 Square1.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import Square1Tools

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test01_Trimmed() {
        let string = "   Trimmed"
        XCTAssertEqual(string.trimmed, "Trimmed")
    }
    
    func test02_Trimm() {
        var string = "   Trimmed"
        string.trim()
        XCTAssertEqual(string, "Trimmed")
    }
    
    func test03_ValidEmail() {
        let email = "thisisavalidemail@gmail.com"
        XCTAssertTrue(email.isValidEmail())
    }
    
    func test04_InvalidEmail() {
        let email = "foaisdhfoiasdfaoisdf"
        XCTAssertFalse(email.isValidEmail())
    }
    
    func test05_ValidURL() {
        let url = "http://www.google.es"
        XCTAssertTrue(url.isValidURL)
    }
    
    func test06_InvalidURL() {
        let url = "/agusiha7bgu/usvukdsvkua/bj"
        XCTAssertFalse(url.isValidURL)
    }
    
    func test07_StringToDate() {
        let string = "10/07/1981"
        let date = string.date(withFormat: "dd/MM/yyyy")
        XCTAssertNotNil(date)
    }
    
    func test08_IncorrectStringToDate() {
        let string = "This is not a date"
        let date = string.date(withFormat: "dd/MM/yyyy")
        XCTAssertNil(date)
    }
    
    func test09_NSRange() {
        let string = "This is a text"
        XCTAssertEqual(string.nsrange.length, 14)
        XCTAssertEqual(string.nsrange.location, 0)
    }
    
    func test10_NSRangedSubstring() {
        let string = "This is a text"
        let nsrange = NSRange(location: 10, length: 4)
        XCTAssertEqual(string.substring(with: nsrange), "text")
    }
    
    func test11_RegexpReplacing() {
        var string = "This is a text with numbers 123456789"
        string = string.replace(pattern: "\\d", with: "", options: [])
        XCTAssertEqual(string, "This is a text with numbers ")
    }
    
    func test12_RegexpMatchesArray() {
        let string = "Hello 1 this 2 is 3 a test 4"
        let pattern = "\\d"
        XCTAssertEqual(string.regexpMatchesWith(pattern: pattern)?.count, 4)
    }
    
    func test13_MD5() {
        let string = "Hello world!!"
        let expected = "1d94dd7dfd050410185a535b9575e184"
        XCTAssertEqual(string.md5, expected)
    }
    
    func test14_SHA1() {
        let string = "Hello world!!"
        let expected = "a59b02741bff27a4c3e236332f29aa604c723e85"
        XCTAssertEqual(string.sha1, expected)
    }
    
    func test15_ContainsString() {
        let string = "Hello World!!"
        XCTAssertTrue(string.contains("world"))
        XCTAssertTrue(string.contains("World", ignoringCase: false))
        XCTAssertFalse(string.contains("world", ignoringCase: false))
    }
    
    func test16_Base64Encode() {
        let string = "Hello World!!"
        let expected = "SGVsbG8gV29ybGQhIQ=="
        XCTAssertEqual(string.base64Encoded, expected)
    }
    
    func test17_Base64Decode() {
        let string = "SGVsbG8gV29ybGQhIQ=="
        let expected = "Hello World!!"
        XCTAssertEqual(string.base64Decoded, expected)
    }
    
}
