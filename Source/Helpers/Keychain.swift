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


/// Helper to save and read info on Keychain.
public class Keychain {
    
    // MARK: Properties
    let accessGroup: String?
    private let readLock = NSLock()
    
    // MARK: Setup
    public init(accessGroup: String? = nil) {
        self.accessGroup = accessGroup
    }
    
    // MARK: Public
    
    /// Saves string value into keychain.
    ///
    /// - Parameters:
    ///   - value: `String` value to save.
    ///   - key: key assigned to the value.
    /// - Returns: `true` if saving goes well, otherwise `false`.
    @discardableResult
    public func save(_ value: String, forKey key: String) -> Bool {
        if let value = value.data(using: .utf8) {
            return save(value, forKey: key)
        }
        return false
    }
    
    
    /// Saves data into keychain.
    ///
    /// - Parameters:
    ///   - value: `Data` of the object to save.
    ///   - key: key assigned to the value.
    /// - Returns: `true` if saving goes well, otherwise `false`.
    @discardableResult
    public func save(_ value: Data, forKey key: String) -> Bool {
        delete(key)
        var query = self.query(for: key)
        query[kSecValueData as String] = value
        let result = SecItemAdd(query as CFDictionary, nil)
        return result == noErr
    }
    
    
    /// Gets `String` value stored on the keychain.
    ///
    /// - Parameter key: key assigned to the value.
    /// - Returns: Optional `String` depending if value exists in keychain or not.
    public func get(_ key: String) -> String? {
        if let data = getData(key) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    /// Gets `Data` value stored on the keychain.
    ///
    /// - Parameter key: key assigned to the value.
    /// - Returns: Optional `Data` depending if value exists in keychain or not.
    public func getData(_ key: String) -> Data? {
        readLock.lock()
        defer { readLock.unlock() }
        
        var query = self.query(for: key)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if status == noErr {
            return result as? Data
        }
        return nil
    }
    
    
    /// Deletes stored value associated to `key`
    ///
    /// - Parameter key: key assigned to the value.
    /// - Returns: `true` if deleting goes well, otherwise `false`.
    @discardableResult
    public func delete(_ key: String) -> Bool {
        let query = self.query(for: key)
        let result = SecItemDelete(query as CFDictionary)
        return result == noErr
    }
    
    // MARK: Private
    
    /// Helper to create query dictionary to access keychain.
    ///
    /// - Parameter key: key for the query.
    /// - Returns: query dictionary for keychainin
    private func query(for key: String) -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : key,
            kSecAttrAccount as String : key,
            kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock
        ]
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as Any
        }
        
        return query
    }
    
}

