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

/// Stack data structure (LIFO).
/// Inspired by https://github.com/raywenderlich/swift-algorithm-club/tree/master/Stack
public struct Stack<T> {
    
    /// Array storing stack elements.
    private var elements: [T] = []
    
    /// Is stack empty or not?
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    /// Number of elements in the stack.
    public var count: Int {
        return elements.count
    }
    
    /// Pushes a new element into the stack.
    ///
    /// - Parameter element: the element to enter the stack
    public mutating func push(_ element: T) {
        elements.append(element)
    }
    
    /// Pops the top element of the stack.
    ///
    /// - Returns: top element in the stack of nil if is empty
    public mutating func pop() -> T? {
        return elements.popLast()
    }
    
    /// Gets top element of the stack without popping it.
    ///
    /// - Returns: top element in the stack of nil if is empty
    public func top() -> T? {
        return elements.last
    }
}
