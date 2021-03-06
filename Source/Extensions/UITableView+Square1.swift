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
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0;
    }
    
    /// Total number of rows adding all sections.
    var numberOfRows : Int {
        var rowCount = 0
        
        for section in 0..<numberOfSections {
            rowCount += numberOfRows(inSection: section)
        }
        
        return rowCount
    }
    
    /// IndexPath for last row in table (including all sections).
    var indexPathForLastRow : IndexPath {
        return indexPathForLastRow(inSection: lastSection)
    }
    
    /// IndexPath for last row in passed section.
    ///
    /// - Parameter section: Section to get the last row to.
    /// - Returns: IndexPath of last row or row 0 if section is empty.
    func indexPathForLastRow(inSection section: Int) -> IndexPath {
        guard numberOfRows(inSection: section) != 0 else {
            return IndexPath(row: 0, section: section)
        }
        
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// Registers UITableViewCell class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the UITableViewCell to register.
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Registers UITableViewCell class of provided type if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the UITableViewCell to register.
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Dequeues reusable UITableViewCell cell if implements ReusableView protocol.
    ///
    /// - Parameter indexPath: indexPath of dequeing UITableViewCell.
    /// - Returns: Dequeued UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
                                                fatalError("Couldn't dequeue UITableViewCell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    /// Dequeues reusable UITableViewCell cell if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter indexPath: indexPath of dequeing UITableViewCell.
    /// - Returns: Dequeued UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView, T: NibLoadableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
                                                fatalError("Couldn't dequeue UITableViewCell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    /// Registers UITableViewHeaderFooterView view class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the UITableViewHeaderFooterView to register.
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Registers UITableViewHeaderFooterView view class of provided type if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the UITableViewHeaderFooterView to register.
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Dequeues reusable UITableViewHeaderFooterView calls if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter indexPath: IndexPath of dequeing UITableViewHeaderFooterView.
    /// - Returns: Dequeued UITableViewHeaderFooterView.
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for indexPath: IndexPath) -> T where T: ReusableView, T: NibLoadableView {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Couldn't dequeue UITableViewHeaderFooterView with identidier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    
    /// Registers cell Nib with passed name and reuse identifier.
    ///
    /// - Parameters:
    ///   - nibName: Name of the Nib file.
    ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
    ///   - reuseIdentifier: Name for the reuse identifier.
    @available(iOS, deprecated, message: "Please use the register method based on ReusableView and/or NibLoadableView protocols")
    func registerCell(withNibName nibName: String,
                      bundle: Bundle? = Bundle.main,
                      reuseIdentifier: String? = nil) {
        let reuseId: String = reuseIdentifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: reuseId)
    }
    
    /// Removes footer view from table.
    func removeFooterView() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    /// Removes header view from table.
    func removeHeaderView() {
        tableHeaderView = UIView(frame: CGRect.zero)
    }
    
    
    /// Reload table with completion closure after reload.
    ///
    /// - Parameter completion: Closure to be executed after reload.
    func reloadData(completion: (() -> ())?) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { finished in
            if let completion = completion {
                completion()
            }
        }
    }
    
    /// Fits table header height to content.
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
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame.size.height = headerSize.height
        
        tableHeaderView = headerView
        headerView.removeConstraints(tempWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
