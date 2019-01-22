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

import UIKit

/// Helpers for UIView.
public extension UIView {
  
  /// UIViewController for current UIView or nil if not attacjed to any.
  public var viewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
  
  /// Quick way to add single tap gesture recognition to current UIView.
  ///
  /// - Parameter:
  ///   - target: Target for the selector, if none, will look for cointaining View Controller.
  ///   - selector: Selector to be executed on gesture.
  public func addSingleTapGesture(target: Any? = nil, selector: Selector) {
    addTapGesture(target: target, executing: selector, tapsRequired: 1)
  }
  
  /// Quick way to add double tap gesture recognition to current UIView.
  ///
  /// - Parameter:.
  ///   - target: Target for the selector, if none, will look for cointaining View Controller.
  ///   - selector: Selector to be executed on gesture.
  public func addDoubleTapGesture(target: Any? = nil, selector: Selector) {
    addTapGesture(target: target, executing: selector, tapsRequired: 2)
  }
  
  /// Quick way to add multiple tap gesture recognition to current UIView.
  ///
  /// - Parameters:
  ///   - target: Target for the selector, if none, will look for cointaining View Controller.
  ///   - selector: Selector to be executed on gesture.
  ///   - tapsRequired: number of taps required for selector to be triggered.
  public func addTapGesture(target: Any? = nil, executing selector: Selector, tapsRequired: Int) {
    let tap = UITapGestureRecognizer(target: target != nil ? target : viewController,
                                     action: selector)
    tap.numberOfTapsRequired = tapsRequired
    isUserInteractionEnabled = true
    addGestureRecognizer(tap)
  }
  
}

extension UIView.AnimationCurve {
  
  public func toAnimationOption() -> UIView.AnimationOptions? {
    switch self {
    case .easeInOut: return UIView.AnimationOptions.curveEaseInOut
    case .easeIn: return UIView.AnimationOptions.curveEaseIn
    case .linear: return UIView.AnimationOptions.curveLinear
    case .easeOut: return UIView.AnimationOptions.curveEaseOut
    default: return nil
    }
  }
}
