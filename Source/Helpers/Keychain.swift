//
//  Keychain.swift
//  Square1Security
//
//  Created by Roberto Pastor Ortiz on 13/2/18.
//  Copyright © 2018 Square1. All rights reserved.
//

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

