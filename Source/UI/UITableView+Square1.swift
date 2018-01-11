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

extension UITableView {
  var lastSection: Int {
    return numberOfSections > 0 ? numberOfSections - 1 : 0;
  }
  
  var numberOfRows : Int {
    var rowCount = 0
    
    for section in 0...numberOfSections {
      rowCount += numberOfRows(inSection: section)
    }
    
    return rowCount
  }
  
  var indexPathForLastRow : IndexPath {
    return indexPathForLastRow(inSection: lastSection)
  }
  
  func indexPathForLastRow(inSection section: Int) -> IndexPath {
    guard numberOfRows(inSection: section) != 0 else {
      return IndexPath(row: 0, section: section)
    }
    
    return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
  }
  
  func registerCell(withNibName nibName: String, bundle: Bundle? = Bundle.main) {
    registerCell(withNibName: nibName, bundle: bundle, reuseIdentifier: nibName)
  }
  
  func registerCell(withNibName nibName: String, bundle: Bundle? = Bundle.main, reuseIdentifier: String) {
    let nib = UINib(nibName: nibName, bundle: bundle)
    register(nib, forCellReuseIdentifier: reuseIdentifier)
  }
  
  func removeFooterView() {
    tableFooterView = UIView(frame: CGRect.zero)
  }
  
  func removeHeaderView() {
    tableHeaderView = UIView(frame: CGRect.zero)
  }
  
  func scrollToTop(animated: Bool) {
    setContentOffset(CGPoint.zero, animated: animated)
  }
  
  func scrollToBottom(animated: Bool) {
    let Yoffset = contentSize.height + contentInset.bottom - bounds.size.height
    
    if Yoffset > 0 {
      let bottomOffset = CGPoint(x: 0, y: Yoffset)
      setContentOffset(bottomOffset, animated: animated)
    }
  }
  
  func reloadData(completion: (() -> ())?) {
    UIView.animate(withDuration: 0, animations: {
      self.reloadData()
    }) { finished in
      if let completion = completion {
        completion()
      }
    }
  }
  
  func layoutTableViewHeaderView() {
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
