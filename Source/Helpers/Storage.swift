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

/// Helper class to manage saving and reading of codable objects on disk.
/// Inspired by Saoud Rizwan, https://gist.github.com/saoudrizwan/b7ab1febde724c6f30d8a555ea779140
public class Storage {
  
  private init() {}
  
  
  /// Enum matching available directories for saving/reading.
  public enum Directory {
    case documents
    case cache
    
    /// The url for the directory.
    fileprivate var url: URL {
      var searchPathDirectory: FileManager.SearchPathDirectory
      
      switch self {
      case .documents:
        searchPathDirectory = .documentDirectory
      default:
        searchPathDirectory = .cachesDirectory
      }
      
      if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
        return url
      } else {
        fatalError("Error getting URL for directory \(searchPathDirectory)")
      }
    }
    
    
    /// Clears all files on the directory.
    public func clear() {
      do {
        let contents = try FileManager.default.contentsOfDirectory(at: self.url, includingPropertiesForKeys: nil, options: [])
        for fileUrl in contents {
          try FileManager.default.removeItem(at: fileUrl)
        }
      } catch {
        Log("Error cleaning directory \(self)")
        return
      }
    }
  }
  
  
  /// Saves an `Encodable` object into `directory` with name `fileName`.
  ///
  /// - Parameters:
  ///   - object: `Encodable` object to save.
  ///   - directory: `Directory` that will be use to save the object.
  ///   - fileName: name of the file who will save the object.
  public static func save<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
    let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
    
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(object)
      FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    } catch {
      fatalError("Error saving \(object): \(error.localizedDescription)")
    }
  }
  
  
  /// Reads a `Decodable` with name `fileName` object from `directory`.
  ///
  /// - Parameters:
  ///   - fileName: name of the file who stores the object.
  ///   - directory: `Directory` who helds the file.
  ///   - type: type of object we're reading.
  /// - Returns: desired `Decodable` object.
  public static func read<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
    let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
    
    if !FileManager.default.fileExists(atPath: url.path) {
      return nil
    }
    
    if let data = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let object = try decoder.decode(type, from: data)
        return object
      } catch {
        Log("Error reading from \(url.path): \(error.localizedDescription)")
        return nil
      }
      
    } else {
      return nil
    }
  }
  
  
  /// Deletes a file from `directory`
  ///
  /// - Parameters:
  ///   - fileName: name of file to delete.
  ///   - directory: directory who helds the file.
  public static func delete(_ fileName: String, from directory: Directory) {
    let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
    if FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.removeItem(at: url)
      } catch {
        Log("Error deleting file \(fileName) from \(directory): \(error.localizedDescription)")
      }
    }
  }
  
  
  /// Checks if specified file exists in `directory`
  ///
  /// - Parameters:
  ///   - fileName: name of file to check.
  ///   - directory: directory who should held the file.
  /// - Returns: `true` if file exists, otherwise `false`
  public static func fileExists(_ fileName: String, in directory: Directory) -> Bool {
    let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
    return FileManager.default.fileExists(atPath: url.path)
  }
}
