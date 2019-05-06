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
import CommonCrypto

/// A collection of helpers for String type.
public extension String {
    
    /// Localized version of the current string, if available. If not, uses the same string.
    /// Uses Main bundle, default table and no replace value if localization is not found.
    var localized: String {
        return localized()
    }
    
    /// Localized version of the current string.
    ///
    /// - Parameters:
    ///   - bundle: Bundle top look for tableName. Default is Main.
    ///   - tableName: The receiver’s string table to search. If `nil`, will use Localizable.strings
    ///   - value: The value to return if key can’t be found in the table.
    /// - Returns: Localized version of the string
    func localized(bundle: Bundle = .main,
                   table: String? = nil,
                   value: String? = nil) -> String {
        return bundle.localizedString(forKey: self,
                                      value: value,
                                      table: table)
    }
    
    /// Trimmed copy of the current string.
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Trimms the current string.
    mutating func trim() {
        self = self.trimmed
    }
    
    /// Attributed copy of the current string.
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    /// URL query encoded copy of the current string.
    var encodedForURLQuery: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// Basic match of the current string with email regular expression.
    /// - Parameters: stricted: if true it doesn't let email like user+1@mail.com.
    func isValidEmail(stricted: Bool = false) -> Bool {
        let pattern: String
        if stricted {
            pattern = "^[A-Z0-9a-z\\._%-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        } else {
            pattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        }
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return emailPredicate.evaluate(with: self)
    }
    
    /// Basic match of the current string with HTTP URL regular expression.
    var isValidURL: Bool {
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
    func date(withFormat format: String,
              timeZone: TimeZone = TimeZone.current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: self)
    }
    
    /// HTML Attributed string based on the current HTML raw string or nil if something went wrong.
    var htmlToAttributed: NSAttributedString? {
        guard let encodedData = self.data(using: String.Encoding.utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
                                                                           .characterEncoding: String.Encoding.utf8]
        do {
            let attributedPlainText = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
            return attributedPlainText
        } catch let error {
            Log(message: error.localizedDescription)
            return nil
        }
    }
    
    func replace(pattern: String,
                 with replacement: String,
                 options: NSRegularExpression.Options) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            return regex.stringByReplacingMatches(in: self, options: [], range: self.nsrange, withTemplate: replacement)
        } catch {
            return self
        }
    }
    
    
    /// A `NSRange` for all the length of the current string.
    var nsrange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }
    
    /// Returns a subtring for the given `NSRange`.
    ///
    /// - Parameter nsrange: `NSRange` to use.
    /// - Returns: substring or nil if `NSRange` can't be converted to `Range`.
    func substring(with nsrange: NSRange) -> String? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return String(self[range])
    }
    
    
    /// Returns an array of matches for the given `NSRegularExpression` patterns.
    ///
    /// - Parameters:
    ///   - pattern: The pattenr to use on `NSRegularExpression`.
    ///   - options: Options for creating the `NSRegularExpression`. By default is [].
    /// - Returns: Array of `NSTextCheckingResult` with the matches or nil if something went wrong
    func regexpMatchesWith(pattern: String,
                           options: NSRegularExpression.Options = []) -> [NSTextCheckingResult]? {
        do {
            let regexp = try NSRegularExpression(pattern: pattern, options: options)
            return regexp.matches(in: self, options: [], range: self.nsrange)
        } catch {
            return nil
        }
    }
    
    
    /// MD5 hash of the current string.
    var md5: String {
        guard let data = self.data(using: .utf8, allowLossyConversion: true) else { return self }
        
        let hash = data.withUnsafeBytes({ (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        })
        
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    
    /// SHA1 hash of the current string
    var sha1: String {
        guard let data = self.data(using: .utf8, allowLossyConversion: true) else { return self }
        
        let hash = data.withUnsafeBytes({ (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(bytes, CC_LONG(data.count), &hash)
            return hash
        })
        
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    /// Base64 encoded version of the current string.
    var base64Encoded: String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
    
    
    /// Base64 decoded version of the current string.
    var base64Decoded: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Checks if string contains `string`
    ///
    /// - Parameters:
    ///   - string: text to look for
    ///   - ignoringCase: flag to indicate if checking should or shouldn't ignore case. By default is `true`
    /// - Returns: `true` if `string` if found, otherwise `false`
    func contains(_ string: String,
                  ignoringCase: Bool = true) -> Bool {
        if ignoringCase == true {
            return self.range(of: string, options: .caseInsensitive) != nil
        } else {
            return self.range(of: string) != nil
        }
    }
    
    
    /// Returns escaped version of curent String allowing certain characters
    ///
    /// - Parameter allowed: `CharacterSet` of allowed characters. Default is `alphanumerics`
    /// - Returns: Escaped string of nil of something goes wrong
    func escaped(allowed: CharacterSet = .alphanumerics) -> String? {
        return addingPercentEncoding(withAllowedCharacters: allowed)
    }
}
