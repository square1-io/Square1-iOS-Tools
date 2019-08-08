// Copyright © 2019 Square1.
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

public protocol Storyboardable: AnyObject {}

public extension Storyboardable where Self: UIViewController {
    
    /// Get the view controller from Storyboard.
    ///
    /// - Parameters:
    ///   - controllerIdentifier: Storyboard ID of controller. If nil it will use the name of the class.
    ///   - storyboardName: Name of the storyboard.
    static func storyboardViewController(controllerIdentifier: String? = nil,
                                         storyboardName: String) -> Self {
        
        let controllerID = controllerIdentifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as? Self else {
            fatalError("Could not instantiate controller identifier: \(controllerID), from storyboard: \(storyboardName)")
        }
        
        return vc
    }
}
