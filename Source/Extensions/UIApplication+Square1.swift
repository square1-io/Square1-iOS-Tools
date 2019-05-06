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

/// Helpers for UIApplication.
public extension UIApplication {
    
    /// Simple variable to change Status Bar color.
    var statusBarColor: UIColor? {
        get {
            guard let statusBarView = value(forKey: "statusBar") as? UIView else { return nil }
            return statusBarView.backgroundColor
        }
        
        set {
            guard let statusBarView = value(forKey: "statusBar") as? UIView else { return }
            statusBarView.backgroundColor = newValue
        }
    }
    
    /// Opens passed URL object.
    ///
    /// - Parameter url: URL to be opened on the App.
    func open(url: URL) {
        guard canOpenURL(url) else { return }
        if #available(iOS 10.0, *) {
            open(url, options: [:], completionHandler: nil)
        } else {
            openURL(url)
        }
    }
    
    /// Returns `true` if app is running in a Split or Slide Over window.
    var isSplitOrSlideOver: Bool {
        guard let w = self.delegate?.window, let window = w else {
            return false
        }
        
        return window.frame.equalTo(window.screen.bounds)
    }
    
    /// Makes a phone call to `phone` if possible.
    ///
    /// - Parameter phone: phone number.
    func call(phone: String) {
        if let url = urlForCall(phone: phone), canOpenURL(url) {
            open(url: url)
        } else {
            if #available(iOS 10.0, *) {
                Log("Can't call to phone \(phone)", type: .default)
            } else {
                print("Can't call to phone \(phone)")
            }
        }
    }
    
    /// Helper function to create a phone call URL
    ///
    /// - Parameter phone: phone number.
    /// - Returns: phone call URL.
    private func urlForCall(phone: String) -> URL? {
        return URL(string: "tel://\(phone)")
    }
}
