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

class DateTests: XCTestCase {
  func testDateCreation() {
    let dateString = "2017-02-12 01:17:29"
    let timeZone = TimeZone(identifier: "GMT")!
    let date = Date.with(string: dateString, format: "yyyy-MM-dd HH:mm:ss", timeZone: timeZone)
    
    XCTAssertNotNil(date)
    XCTAssertEqual(date!.component(.day, inTimeZone: timeZone), 12)
    XCTAssertEqual(date!.component(.month, inTimeZone: timeZone), 2)
    XCTAssertEqual(date!.component(.year, inTimeZone: timeZone), 2017)
    XCTAssertEqual(date!.component(.hour, inTimeZone: timeZone), 1)
    XCTAssertEqual(date!.component(.minute, inTimeZone: timeZone), 17)
    XCTAssertEqual(date!.component(.second, inTimeZone: timeZone), 29)
    
  }
}
