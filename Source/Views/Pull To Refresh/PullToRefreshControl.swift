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

/// Helper view to implement pull to refresh custom controls.
/// *IMPORTANT*: This class doesn't implements any layout.
open class PullToRefreshControlView: UIView {
  
  // MARK: - Properties
  /// Refresh control associated
  public weak var refreshControl: UIRefreshControl!
  
  /// Function to be overrided by child, displaying animation while executing refresh.
  /// Must call super at some point in overriding.
  open func beginRefreshAnimation() {}
  
  /// Function to be overrided by child, finishing animation after refresh.
  /// Must call super at some point in overriding.
  open func endRefreshAnimation() {
    resetPull()
  }
  
  /// Sets the progress of the pull to 0.
  public func resetPull() {
    pullAt(0)
  }
  
  /// Function to be overrided by child.
  ///
  /// - Parameter progress: value between 0.0 and 1.0 showing the status of the pull completion.
  open func pullAt(_ progress: CGFloat) {}

}

/// Helper subclass of `UIRefreshControl` to help implement pull to refresh custom controls.
public class PullToRefreshControl: UIRefreshControl {

  public private (set) var isAnimating = false
  
  /// Setting this with a valid nib Name will load the custom view ti use inside the pull to refresh.
  public var customViewNibName: String? {
    didSet {
      guard let nibName = customViewNibName else {
        return
      }
      if let nib = Bundle.main.loadNibNamed(nibName,
                                            owner: nil,
                                            options: nil)?.first as? PullToRefreshControlView {
        self.customView = nib
      }
    }
  }
  
  /// Sets the custom view to be used inside the pull to refresh.
  public var customView: PullToRefreshControlView? {
    didSet {
      guard let customView = customView else {
        return
      }
      backgroundColor = .clear
      tintColor = .clear
      customView.frame = self.bounds
      customView.refreshControl = self
      addSubview(customView)
    }
  }
  
  
  /// Call this method inside `scrollViewDidScroll` to update the pull animation progress if needed.
  public func updatePullAnimation() {
    let pullDistance = max(0.0, -frame.origin.y)
    
    if pullDistance > 0 {
      let pullProgress = min( max(pullDistance, 0.0), 100.0) / 100.0
      if !isRefreshing {
        customView?.pullAt(pullProgress)
      }
    }
  }

  
  /// Call this method inside to trigger the refreshing animation if needed.
  override public func beginRefreshing() {
    isAnimating = true
    customView?.beginRefreshAnimation()
    super.beginRefreshing()
  }
  
  
  /// Call this method to stop the refresing animetion and hide the refresh control.
  override public func endRefreshing() {
    isAnimating = false
    customView?.endRefreshAnimation()
    super.endRefreshing()
  }
  
}


// Extension to help use the custom refresh control on any tableview.
extension UITableView {
  public func addCustomRefreshControl(_ refreshControl: PullToRefreshControl) {
    addSubview(refreshControl)
  }
}

// Extension to help use the custom refresh control on any collection view.
extension UICollectionView {
  public func addCustomRefreshControl(_ refreshControl: PullToRefreshControl) {
    alwaysBounceVertical = true
    addSubview(refreshControl)
  }
}

