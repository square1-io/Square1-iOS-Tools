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

import Foundation

extension String {
  
  public var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  public var trimmed: String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  public mutating func trim() {
    self = self.trimmed
  }
  
  public var attributed: NSAttributedString {
    return NSAttributedString(string: self)
  }
  
  public var encodedForURLQuery: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
  
  public var isValidEmail: Bool {
    let pattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return emailPredicate.evaluate(with: self)
  }
  
  public var isValidURL: Bool {
    let pattern = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return predicate.evaluate(with: self)
  }
  
  public func date(withFormat format: String, timeZone: TimeZone = TimeZone.current) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = timeZone
    return dateFormatter.date(from: self)
  }
  
  public var htmlToPlainText: NSAttributedString? {
    guard let encodedData = self.data(using: String.Encoding.utf8) else { return nil }
    
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8]
    do {
      let attributedPlainText = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
      return attributedPlainText
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
  }

}
