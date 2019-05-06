// Copyright © 2018 Square1.
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

import UIKit

/// Helpers for UIScrollView.
public extension UIScrollView {
  
  /// Scrolls to the top of the table.
  ///
  /// - Parameter animated: Animate scrolling of not.
  func scrollToTop(animated: Bool) {
    setContentOffset(CGPoint.zero, animated: animated)
  }
  
  /// Scrolls to the bottom of the table.
  ///
  /// - Parameter animated: Animate scrolling of not.
  func scrollToBottom(animated: Bool) {
    let Yoffset = contentSize.height + contentInset.bottom - bounds.size.height
    
    if Yoffset > 0 {
      let bottomOffset = CGPoint(x: 0, y: Yoffset)
      setContentOffset(bottomOffset, animated: animated)
    }
  }
  
  
  /// Executes a provided `selector` from `target` once reached `threshold` from the end of the content view.
  ///
  /// - Parameters:
  ///   - threshold: point where selector should be triggered
  ///   - target: target who will execute the selector
  ///   - selector: selector to execute
  func executeWhenReachingEnd(threshold: CGFloat,
                              target: UIViewController,
                              selector: Selector) {
    let y = contentOffset.y + bounds.size.height - contentInset.bottom
    let h = contentSize.height
    let actionThreshold = threshold < 0 ? threshold : -threshold
    
    if y > h + actionThreshold {
      if target.responds(to: selector) {
        target.perform(selector)
      }
    }
  }
  
}
