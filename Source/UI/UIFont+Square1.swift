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

extension UIFont {
  
  var bold: UIFont {
    guard let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) else { return self }
    guard let boldFont = boldFontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.name] as? UIFont else { return self }
    return boldFont
  }
  
  var italic: UIFont {
    guard let italicFontDescriptor = fontDescriptor.withSymbolicTraits(.traitItalic) else { return self }
    guard let italicFont = italicFontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.name] as? UIFont else { return self }
    return italicFont
  }
  
  var boldItalic: UIFont {
    guard let boldItalicFontDescriptor = fontDescriptor.withSymbolicTraits([.traitBold, .traitBold]) else { return self }
    guard let boldItalicFont = boldItalicFontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.name] as? UIFont else { return self }
    return boldItalicFont
  }
  
}
