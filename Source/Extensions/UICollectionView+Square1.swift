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
    
    /// Registers UICollectionViewCell class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the cell to register.
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Registers UICollectionViewCell class of provided type if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the cell to register.
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Dequeues reusable UICollectionViewCell calls if implements ReusableView protocol.
    ///
    /// - Parameter indexPath: indexPath of dequeing cell.
    /// - Returns: Dequeued cell
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
                                                fatalError("Couldn't dequeue cell with identidier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    /// Dequeues reusable UICollectionViewCell calls if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter indexPath: indexPath of dequeing cell.
    /// - Returns: Dequeued cell
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView, T: NibLoadableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Couldn't dequeue cell with identidier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    /// Registers section header view class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    public func registerSectionHeader<T: UICollectionViewCell>(_: T.Type) where T:ReusableView {
        registerSupplementaryView(T.self,
                                  of: UICollectionView.elementKindSectionHeader)
    }
    
    /// Registers section footer view class of provided type if implements ReusableView protocol and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    public func registerSectionHeader<T: UICollectionViewCell>(_: T.Type) where T:ReusableView, T: NibLoadableView {
        registerSupplementaryView(T.self,
                                  of: UICollectionView.elementKindSectionHeader)
    }
    
    /// Registers section footer view class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    public func registerSectionFooter<T: UICollectionViewCell>(_: T.Type) where T:ReusableView {
        registerSupplementaryView(T.self,
                                  of: UICollectionView.elementKindSectionFooter)
    }
    
    /// Registers section footer view class of provided type if implements ReusableView protocol and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    public func registerSectionFooter<T: UICollectionViewCell>(_: T.Type) where T:ReusableView, T: NibLoadableView {
        registerSupplementaryView(T.self,
                                  of: UICollectionView.elementKindSectionFooter)
    }
    
    /// Registers supplementary view class of provided type if implements ReusableView protocol.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    public func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type,
                                                                       of kind: String) where T: ReusableView {
        register(T.self,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Registers supplementary view class of provided type if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameter _: Type of the supplementary view to register.
    /// - kind: Kind of supplementary view.
    public func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type,
                                                                       of kind: String) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Dequeues reusable UICollectionReusableView if implements ReusableView and NibLoadableView protocols.
    ///
    /// - Parameters:
    ///   - _: Type of the supplementary view to dequeue.
    ///   - kind: Kind of supplementary view.
    ///   - indexPath: IndexPath of the supplementary view to dequeue
    /// - Returns: Dequeued UICollectionReusableView
    public func dequeueSupplementaryView<T: UICollectionReusableView>(_: T.Type,
                                                                      of kind: String,
                                                                      for indexPath: IndexPath) -> T where T: ReusableView {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: T.defaultReuseIdentifier,
                                                                       for: indexPath) as? T else {
           fatalError("Couldn't dequeue UICollectionReusableView with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return supplementaryView
    }
    
    /// Registers cell Nib with passed name and reuse identifier.
    ///
    /// - Parameters:
    ///   - nibName: Name of the Nib file.
    ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
    ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
    @available(iOS, deprecated, message: "Please use the register method based on ReusableView and/or NibLoadableView protocols")
    public func registerCell(withNibName nibName: String,
                             bundle: Bundle? = Bundle.main,
                             reuseIdentifier: String? = nil) {
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
    @available(iOS, deprecated, message: "Please use the registerSectionHeader method based on ReusableView and/or NibLoadableView protocols")
    public func registerHeader(withNibName nibName: String,
                               bundle: Bundle? = Bundle.main,
                               reuseIdentifier: String? = nil ) {
        registerSupplementaryView(withNibName: nibName,
                                  bundle: bundle,
                                  kind: UICollectionView.elementKindSectionHeader,
                                  reuseIdentifier: reuseIdentifier)
    }
    
    /// Registers footer Nib with passed name and reuse identifier.
    ///
    /// - Parameters:
    ///   - nibName: Name of the Nib file.
    ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
    ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
    @available(iOS, deprecated, message: "Please use the registerSectionFooter method based on ReusableView and/or NibLoadableView protocols")
    public func registerFooter(withNibName nibName: String,
                               bundle: Bundle? = Bundle.main,
                               reuseIdentifier: String? = nil ) {
        registerSupplementaryView(withNibName: nibName,
                                  bundle: bundle,
                                  kind: UICollectionView.elementKindSectionFooter,
                                  reuseIdentifier: reuseIdentifier)
    }
    
    /// Registers supplementary view kind Nib with passed name and reuse identifier.
    ///
    /// - Parameters:
    ///   - nibName: Name of the Nib file.
    ///   - bundle: Bundle where Nib file is. By default is the Main Bundle.
    ///   - kind: Kind of supplementary view.
    ///   - reuseIdentifier: Name for the reuse identifier. If not present, nibName will be used as reuse identifier.
    @available(iOS, deprecated, message: "Please use the registerSupplementaryView method based on ReusableView and/or NibLoadableView protocols")
    public func registerSupplementaryView(withNibName nibName: String,
                                          bundle: Bundle? = Bundle.main,
                                          kind: String,
                                          reuseIdentifier: String? = nil) {
        let reuseId: String = reuseIdentifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseId)
    }
}
