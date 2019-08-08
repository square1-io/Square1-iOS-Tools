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
import UIKit

/// Helpers for UILabel.
public extension UILabel {
    
    /// Set a color for substring of text.
    ///
    /// - Parameter
    ///   - color: `UIColor` of string.
    ///   - range: The content `String`.
    func setColor(color: UIColor, range string: String) {
        guard let text = text else {
            return
        }
        
        let newAttributedString = attributedText?.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString(string:text)
        let range = (text as NSString).range(of: string)
        newAttributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = newAttributedString
    }
    
    /// Set text with line height. It keeps the attributedText properties.
    ///
    /// - Parameter
    ///   - text: label text.
    ///   - lineHeight: line height.
    func setText(text: String, lineHeight: CGFloat) {
        if text.count == 0 { return }
        
        self.text = text
        
        guard let paragraphAtt = attributedText?.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle else {
            return
        }
        
        guard let attributedString = attributedText?.mutableCopy() as? NSMutableAttributedString,
            let paragraphStyle = paragraphAtt.mutableCopy() as? NSMutableParagraphStyle else {
                return
        }
        
        paragraphStyle.lineSpacing = lineHeight
        attributedString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}
