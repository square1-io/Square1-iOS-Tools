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
    
    func test01_Empty() {
        XCTAssertTrue(queue.isEmpty)
    }
    
    func test02_NotEmpty() {
        queue.enqueue(1)
        XCTAssertFalse(queue.isEmpty)
    }
    
    func test03_EmptyMultiple() {
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        
        XCTAssertTrue(queue.isEmpty)
    }
    
    func test04_CountZero() {
        XCTAssertEqual(queue.count, 0)
    }
    
    func test05_CountOne() {
        queue.enqueue(1)
        XCTAssertEqual(queue.count, 1)
    }
    
    func test06_CountMultipleEmpty() {
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        
        XCTAssertEqual(queue.count, 0)
    }
    
    func test07_CountMultiple() {
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        XCTAssertEqual(queue.count, 6)
    }
    
    func test08_Dequeue() {
        queue.enqueue(1)
        
        XCTAssertEqual(queue.dequeue(), 1)
    }
    
    func test09_DequeueMultiple() {
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        
        queue.enqueue(3)
        
        XCTAssertEqual(queue.dequeue(), 3)
    }
    
    func test10_Front() {
        queue.enqueue(1)
        
        XCTAssertEqual(queue.front(), 1)
    }
    
    func test11_FrontMultiple() {
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        let _ = queue.dequeue()
        
        queue.enqueue(3)
        
        XCTAssertEqual(queue.front(), 3)
    }
    
    func test12_FrontEmpty() {
        XCTAssertNil(queue.front())
    }
    
    func test13_DequeueEmpty() {
        XCTAssertNil(queue.dequeue())
    }
}
