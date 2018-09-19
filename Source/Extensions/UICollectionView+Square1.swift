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

// Helpers for UICollectionView.
public extension UICollectionView {
  
  /// Registers cell Nib with passed name and reuse identifier.
  ///
  /// - Parameters:
  ///   - nibName: Name of the Nib file.
  ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
  ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
  public func registerCell(withNibName nibName: String, bundle: Bundle? = Bundle.main, reuseIdentifier: String? = nil) {
    let reuseId: String = reuseIdentifier ?? nibName
    let nib = UINib(nibName: nibName, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: reuseId)
  }
  
  
  /// Registers header Nib with passed name and reuse identifier.
  ///
  /// - Parameters:
  ///   - nibName: Name of the Nib file.
  ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
  ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
  public func registerHeader(withNibName nibName: String, bundle: Bundle? = Bundle.main, reuseIdentifier: String? = nil ) {
    registerSupplementaryView(withNibName: nibName, bundle: bundle, kind: UICollectionView.elementKindSectionHeader, reuseIdentifier: reuseIdentifier)
  }
  
  /// Registers footer Nib with passed name and reuse identifier.
  ///
  /// - Parameters:
  ///   - nibName: Name of the Nib file.
  ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
  ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
  public func registerFooter(withNibName nibName: String, bundle: Bundle? = Bundle.main, reuseIdentifier: String? = nil ) {
    registerSupplementaryView(withNibName: nibName, bundle: bundle, kind: UICollectionView.elementKindSectionFooter, reuseIdentifier: reuseIdentifier)
  }
  
  
  /// Registers supplementary view kind Nib with passed name and reuse identifier.
  ///
  /// - Parameters:
  ///   - nibName: Name of the Nib file.
  ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
  ///   - kind: Kind of supplementary view.
  ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
  public func registerSupplementaryView(withNibName nibName: String, bundle: Bundle? = Bundle.main, kind: String, reuseIdentifier: String? = nil) {
    let reuseId: String = reuseIdentifier ?? nibName
    let nib = UINib(nibName: nibName, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseId)
  }
}
