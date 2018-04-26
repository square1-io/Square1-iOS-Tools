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

/// Helper view to implement pull to refresh custom views.
/// Because UICollectionReusableView inherits from UIView, can be used on table and collection views.
/// *IMPORTANT*: This class doesn't implements any layout.
open class PullToRefreshView: UICollectionReusableView {
  
  // MARK: - Properties
  open var isRefreshing = false
  open var isReady = false
  open var refreshThreshold = CGFloat(60)
  
  // MARK: - Public
  
  /// Function to be called on scrollView pull gesture (scrollViewDidScroll).
  ///
  /// - Parameter offset: current offset of the scrollView.
  public func didScrollWith(offset: CGFloat) {
    let visibleOffset = (offset - bounds.height) + refreshThreshold
    
    if visibleOffset < 0 {
      let progress = min(1.0, abs(visibleOffset) / refreshThreshold)
      pullAt(progress)
      isReady = progress == 1
    } else {
      isReady = false
    }
  }
  
  /// Function to be overrided by child.
  ///
  /// - Parameter progress: value between 0.0 and 1.0 showing the status of the pull completion.
  open func pullAt(_ progress: CGFloat) {
  
  }
  
  
  /// Function to be overrided by child, displaying animation while executing refresh.
  /// Must call super at some point in overriding.
  open func startRefreshAnimation() {
    isRefreshing = true
  }
  
  
  /// Function to be overrided by child, finishing animation after refresh.
  /// Must call super at some point in overriding.
  open func stopRefreshAnimation() {
    isRefreshing = false
    resetPull()
  }
  
  /// Sets the progress of the pull to 0.
  public func resetPull() {
    pullAt(0)
  }
}
