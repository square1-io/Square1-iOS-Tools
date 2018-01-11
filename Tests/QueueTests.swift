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

class QueueTests: XCTestCase {
  var queue = Queue<Int>()
  
  func testEmpty() {
    XCTAssertTrue(queue.empty)
  }
  
  func testNotEmpty() {
    queue.enqueue(1)
    XCTAssertFalse(queue.empty)
  }
  
  func testEmptyMultiple() {
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    
    XCTAssertTrue(queue.empty)
  }
  
  func testCountZero() {
    XCTAssertEqual(queue.count, 0)
  }
  
  func testCountOne() {
    queue.enqueue(1)
    XCTAssertEqual(queue.count, 1)
  }
  
  func testCountMultipleEmpty() {
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    
    XCTAssertEqual(queue.count, 0)
  }
  
  func testCountMultiple() {
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    
    XCTAssertEqual(queue.count, 6)
  }
  
  func testDequeue() {
    queue.enqueue(1)
    
    XCTAssertEqual(queue.dequeue(), 1)
  }
  
  func testDequeueMultiple() {
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    
    queue.enqueue(3)
    
    XCTAssertEqual(queue.dequeue(), 3)
  }
  
  func testFront() {
    queue.enqueue(1)
    
    XCTAssertEqual(queue.front(), 1)
  }
  
  func testFrontMultiple() {
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    let _ = queue.dequeue()
    
    queue.enqueue(3)
    
    XCTAssertEqual(queue.front(), 3)
  }
  
  func testFrontEmpty() {
    XCTAssertNil(queue.front())
  }
  
  func testDequeueEmpty() {
    XCTAssertNil(queue.dequeue())
  }
}
