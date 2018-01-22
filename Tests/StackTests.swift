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

class StackTests: XCTestCase {
  
  var stack = Stack<Int>()
  
  func testEmpty() {
    XCTAssertTrue(stack.isEmpty)
  }
  
  func testNotEmpty() {
    stack.push(5)
    XCTAssertFalse(stack.isEmpty)
  }
  
  func testEmptyMultiple() {
    stack.push(3)
    stack.push(1)
    stack.push(2)
    
    let _ = stack.pop()
    let _ = stack.pop()
    let _ = stack.pop()
    
    XCTAssertTrue(stack.isEmpty)
  }
  
  func testCountZero() {
    XCTAssertTrue(stack.count == 0)
  }
  
  func testCountOne() {
    stack.push(5)
    XCTAssertEqual(stack.count, 1)
  }
  
  func testCountMultiplePush() {
    stack.push(3)
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(1)
    stack.push(2)
    
    XCTAssertEqual(stack.count, 6)
  }
  
  func testCountPushPop() {
    stack.push(3)
    stack.push(1)
    stack.push(2)
    
    let _ = stack.pop()
    let _ = stack.pop()
    let _ = stack.pop()
    
    XCTAssertEqual(stack.count, 0)
  }
  
  func testPop() {
    stack.push(1)
    
    XCTAssertEqual(stack.pop(), 1)
  }
  
  func testPopMultiple() {
    stack.push(1)
    stack.push(2)
    stack.push(3)
    
    let _ = stack.pop()
    let _ = stack.pop()
    
    stack.push(4)
    stack.push(5)
    
    let _ = stack.pop()
    
    XCTAssertEqual(stack.count, 2)
  }
  
  func testTop() {
    stack.push(1)
    stack.push(2)
    
    XCTAssertEqual(stack.top(), 2)
  }
  
  func testTopMultiple() {
    stack.push(1)
    stack.push(2)
    stack.push(3)
    
    let _ = stack.pop()
    let _ = stack.pop()
    
    stack.push(4)
    stack.push(5)
    
    let _ = stack.pop()
    
    XCTAssertEqual(stack.top(), 4)
  }
  
  func testTopEmpty() {
    stack.push(1)
    stack.push(3)
    
    let _ = stack.pop()
    let _ = stack.pop()
    
    XCTAssertNil(stack.top())
  }
  
  func testPopEmpty() {
    XCTAssertNil(stack.pop())
  }
}
