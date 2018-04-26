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

// Extension for UITableView with helpers to use PullToRefreshView
public extension UITableView {
  
  /// Adds passed `pullToRefreshView` as header of the table view.
  ///
  /// - Parameter pullToRefreshView: PullToRefreshView to use as header.
  public func addPullToRefresh(_ pullToRefreshView: PullToRefreshView) {
    tableHeaderView = pullToRefreshView
    contentInset = UIEdgeInsetsMake(-pullToRefreshView.bounds.height,
                                    0.0,
                                    0.0,
                                    contentInset.bottom)
  }
  
  
  /// Returns `true` if header pullToRefreshView is ready, otherwise `false`.
  public var pullRefreshReady: Bool {
    guard let pullToRefreshView = tableHeaderView as? PullToRefreshView else {
      return false
    }
    return pullToRefreshView.isReady
  }
  
  
  /// Calls the `startRefreshAnimation` function of header pullToRefreshView
  /// Also, it adapts the content inset of the tableView.
  public func startRefreshAnimation() {
    contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, contentInset.bottom)
    if let pullToRefreshView = tableHeaderView as? PullToRefreshView {
      pullToRefreshView.startRefreshAnimation()
    }
  }
  
  /// Calls the `stopRefreshAnimation` function of header pullToRefreshView
  /// Also, it adapts the content inset of the tableView.
  ///
  /// - Parameters:
  ///   - animated: `true` if we want o animate the hiding of the pullToRefreshView.
  ///   - completion: completion block to execute after hiding the pullToRefreshView.
  public func stopRefreshAnimation(animated: Bool = true,
                                   _ completion: (() -> ())? = nil) {
    guard let pullToRefreshView = tableHeaderView as? PullToRefreshView else {
      return
    }

    if animated {

      UIView.animate(withDuration: 0.3, animations: {
        self.contentInset = UIEdgeInsetsMake(-pullToRefreshView.bounds.height,
                                             0.0,
                                             0.0,
                                             self.contentInset.bottom)
      }) { _ in
        pullToRefreshView.stopRefreshAnimation()
        completion?()
      }
      
    } else {
      
      self.contentInset = UIEdgeInsetsMake(-pullToRefreshView.bounds.height,
                                           0.0,
                                           0.0,
                                           self.contentInset.bottom)
      pullToRefreshView.stopRefreshAnimation()
      completion?()
    }
  }
}

