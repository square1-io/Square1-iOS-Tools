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
    return tabBar.frame.origin.y >= UIScreen.main.bounds.height
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
    if isTabBarHidden == hidden { return }

    let height = tabBar.frame.size.height
    let offsetY = hidden ? height : -height
    let duration = animated ? 0.3 : 0.0
    
    UIView.animate(withDuration: duration, animations: {
      self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
      self.view.frame = CGRect(x:0,
                               y:0,
                               width: self.view.frame.width,
                               height: self.view.frame.height + offsetY)
      self.view.setNeedsDisplay()
      self.view.layoutIfNeeded()
      
    }, completion: completion )
  }
  
  
}
