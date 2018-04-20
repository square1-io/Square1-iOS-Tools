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

import Foundation

// Extension for helper functions dealing with `UITabBarController`
extension UITabBarController {
  
  /// Helper method to check if tabBar has been hidden using `setTabBar`.
  private var isTabBarHidden: Bool {
    return !tabBar.frame.intersects(view.frame)
  }
  
  /// Hides or shows the TabBar animating or not.
  ///
  /// - Parameters:
  ///   - hidden: `true` to hide or `false` to show.
  ///   - animated: `true` for animate transition, otherwise `false`. By default is `true`.
  ///   - completion: comletion block to execute after transition finish.
  public func setTabBar(hidden: Bool,
                        animated: Bool = true,
                        completion: ((Bool) -> ())? = nil) {
    guard isTabBarHidden != hidden else { return }

    let height = tabBar.frame.size.height
    let offsetY = hidden ? height : -height
    let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
    let vc: UIViewController? = viewControllers?[selectedIndex]
    
    var newInsets: UIEdgeInsets? = vc?.view.layoutMargins
    
    if #available(iOS 11.0, *) {
      newInsets = vc?.additionalSafeAreaInsets
    }
    
    newInsets?.bottom -= offsetY
    
    if hidden, let insets = newInsets {
      set(childViewController: vc, insets: insets)
    }
  
    guard animated else {
      tabBar.frame = endFrame
      return
    }
    
    weak var tabBarRef = self.tabBar
    
    UIView.animate(withDuration: 0.3, animations: {
      tabBarRef?.frame = endFrame
    }, completion: { [weak self] finished in
      if !hidden, finished, let insets = newInsets {
        self?.set(childViewController: vc, insets: insets)
      }
    })
  }

  private func set(childViewController cvc: UIViewController?, insets: UIEdgeInsets) {
    if #available(iOS 11.0, *) {
      cvc?.additionalSafeAreaInsets = insets
    } else {
      cvc?.view.layoutMargins = insets
    }
    cvc?.view.setNeedsLayout()
  }
}
