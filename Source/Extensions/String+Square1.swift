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


/// A collection of helpers for String type.
public extension String {
  
  /// Localized version of the current string, if available. If not, uses the same string.
  public var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  /// Trimmed copy of the current string.
  public var trimmed: String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  /// Trimms the current string.
  public mutating func trim() {
    self = self.trimmed
  }
  
  /// Attributed copy of the current string.
  public var attributed: NSAttributedString {
    return NSAttributedString(string: self)
  }
  
  /// URL query encoded copy of the current string.
  public var encodedForURLQuery: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
  
  /// Basic match of the current string with email regular expression.
  public var isValidEmail: Bool {
    let pattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return emailPredicate.evaluate(with: self)
  }
  
  /// Basic match of the current string with HTTP URL regular expression.
  public var isValidURL: Bool {
    let pattern = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return predicate.evaluate(with: self)
  }
  
  /// Date object based on the current string, if it represents a Date.
  ///
  /// - Parameters:
  ///   - format: Expected format for the date string.
  ///   - timeZone: Time zone to be used on the format. By default is the current one.
  /// - Returns: A Date object based on the current string or nil if something went wrong.
  public func date(withFormat format: String, timeZone: TimeZone = TimeZone.current) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = timeZone
    return dateFormatter.date(from: self)
  }
  
  /// HTML Attributed string based on the current HTML raw string or nil if something went wrong.
  public var htmlToAttributed: NSAttributedString? {
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
  
  public func replace(pattern: String, with replacement: String, options: NSRegularExpression.Options) -> String {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: options)
      return regex.stringByReplacingMatches(in: self, options: [], range: self.nsrange, withTemplate: replacement)
    } catch {
      return self
    }
  }
  
  
  /// A `NSRange` for all the length of the current string.
  public var nsrange: NSRange {
    return NSRange(location: 0, length: utf16.count)
  }
  
  /// Returns a subtring for the given `NSRange`.
  ///
  /// - Parameter nsrange: `NSRange` to use.
  /// - Returns: substring or nil if `NSRange` can't be converted to `Range`.
  public func substring(with nsrange: NSRange) -> String? {
    guard let range = Range(nsrange, in: self) else { return nil }
    return String(self[range])
  }
  
  
  /// Returns an array of matches for the given `NSRegularExpression` patterns.
  ///
  /// - Parameters:
  ///   - pattern: The pattenr to use on `NSRegularExpression`.
  ///   - options: Options for creating the `NSRegularExpression`. By default is [].
  /// - Returns: Array of `NSTextCheckingResult` with the matches or nil if something went wrong
  public func regexpMatchesWith(pattern: String, options: NSRegularExpression.Options = []) -> [NSTextCheckingResult]? {
    do {
      let regexp = try NSRegularExpression(pattern: pattern, options: options)
      return regexp.matches(in: self, options: [], range: self.nsrange)
    } catch {
      return nil
    }
  }

}
