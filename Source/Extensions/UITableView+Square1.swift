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

/// Helpers for UITableView.
public extension UITableView {
  
  /// Last section of current UITableView.
  public var lastSection: Int {
    return numberOfSections > 0 ? numberOfSections - 1 : 0;
  }
  
  /// Total number of rows adding all sections.
  public var numberOfRows : Int {
    var rowCount = 0
    
    for section in 0...numberOfSections {
      rowCount += numberOfRows(inSection: section)
    }
    
    return rowCount
  }
  
  /// IndexPath for last row in table (including all sections).
  public var indexPathForLastRow : IndexPath {
    return indexPathForLastRow(inSection: lastSection)
  }
  
  /// IndexPath for last row in passed section.
  ///
  /// - Parameter section: Section to get the last row to.
  /// - Returns: IndexPath of last row or row 0 if section is empty.
  public func indexPathForLastRow(inSection section: Int) -> IndexPath {
    guard numberOfRows(inSection: section) != 0 else {
      return IndexPath(row: 0, section: section)
    }
    
    return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
  }
  
  /// Registers cell Nib with passed name and reuse identifier.
  ///
  /// - Parameters:
  ///   - nibName: Name of the Nib file.
  ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
  ///   - reuseIdentifier: Name for the reuse identifier.
  public func registerCell(withNibName nibName: String, bundle: Bundle? = Bundle.main, reuseIdentifier: String? = nil) {
    let reuseId: String = reuseIdentifier ?? nibName
    let nib = UINib(nibName: nibName, bundle: bundle)
    register(nib, forCellReuseIdentifier: reuseId)
  }
  
  /// Removes footer view from table.
  public func removeFooterView() {
    tableFooterView = UIView(frame: CGRect.zero)
  }
  
  /// Removes header view from table.
  public func removeHeaderView() {
    tableHeaderView = UIView(frame: CGRect.zero)
  }
  
  /// Scrolls to the top of the table.
  ///
  /// - Parameter animated: Animate scrolling of not.
  public func scrollToTop(animated: Bool) {
    setContentOffset(CGPoint.zero, animated: animated)
  }
  
  /// Scrolls to the bottom of the table.
  ///
  /// - Parameter animated: Animate scrolling of not.
  public func scrollToBottom(animated: Bool) {
    let Yoffset = contentSize.height + contentInset.bottom - bounds.size.height
    
    if Yoffset > 0 {
      let bottomOffset = CGPoint(x: 0, y: Yoffset)
      setContentOffset(bottomOffset, animated: animated)
    }
  }
  
  /// Reload table with completion closure after reload.
  ///
  /// - Parameter completion: Closure to be executed after reload.
  public func reloadData(completion: (() -> ())?) {
    UIView.animate(withDuration: 0, animations: {
      self.reloadData()
    }) { finished in
      if let completion = completion {
        completion()
      }
    }
  }
  
  /// Fits table header height to content.
  public func layoutTableViewHeaderView() {
    guard let headerView = tableHeaderView else { return }
    layoutIfNeeded()
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerWidth = headerView.bounds.size.width
    let tempWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]",
                                                              options: .init(rawValue: 0),
                                                              metrics: ["width": headerWidth],
                                                              views: ["headerView": headerView])
    
    headerView.addConstraints(tempWidthConstraints)
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    
    let headerSize = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    headerView.frame.size.height = headerSize.height
    
    tableHeaderView = headerView
    headerView.removeConstraints(tempWidthConstraints)
    headerView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  func executeWhenReachingEnd(threshold: CGFloat, target: UIViewController, selector: Selector) {
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
