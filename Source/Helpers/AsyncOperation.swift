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

import Foundation


/// Base async `Operation` subclass.
///
/// Inspired by https://gist.github.com/Sorix/57bc3295dc001434fe08acbb053ed2bc
public class AsyncOperation: Operation {

  enum State: String {
    case ready = "Ready"
    case executing = "Executing"
    case finished = "Finished"
    fileprivate var keyPath: String {
      return "is" + self.rawValue
    }
  }
  
  private var state = State.ready {
    willSet {
      willChangeValue(forKey: state.keyPath)
      willChangeValue(forKey: newValue.keyPath)
    }
    didSet {
      didChangeValue(forKey: state.keyPath)
      didChangeValue(forKey: oldValue.keyPath)
    }
  }
  
  public override var isAsynchronous: Bool { return true }
  public override var isExecuting: Bool { return state == .executing }
  
  public override func start() {
    if isCancelled {
      state = .finished
    } else {
      state = .ready
      main()
    }
  }
  
  public override func main() {
    if isCancelled {
      state = .finished
    } else {
      state = .executing
    }
  }
  
  public func finish() {
    state = .finished
  }
}
