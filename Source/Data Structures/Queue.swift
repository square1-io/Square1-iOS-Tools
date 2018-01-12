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


/// Queue data structure (FIFO).
/// Inspired by https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue
public struct Queue<T> {
  
  /// Array storing queue elements.
  private var elements: [T] = []
  
  /// Is queue is empty or not?
  public var isEmpty: Bool {
    return elements.isEmpty
  }
  
  /// Number of elements in the queue.
  public var count: Int {
    return elements.count
  }
  
  
  /// Enqueues a new element at the end of the queue.
  ///
  /// - Parameter element: the element to enter the queue
  public mutating func enqueue(_ element: T) {
    elements.append(element)
  }
  
  
  /// Dequeues the first element at the beginning of the queue.
  ///
  /// - Returns: first element of the queue or nil if is empty
  public mutating func dequeue() -> T? {
    guard !isEmpty else { return nil }
    return elements.removeFirst()
  }
  
  
  /// Gets first element of the queue without dequeuing it.
  ///
  /// - Returns: first element of the queue or nil if is empty
  public func front() -> T? {
    return elements.first
  }
}
