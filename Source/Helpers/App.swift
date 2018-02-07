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

/// Helper class to retrieve info from app's main bundle .plist file.
public class App {
  
  /// Current version of the app, retrieved from the main bundle .plist file.
  public static var version: String? {
    return infoValue(forKey: "CFBundleShortVersionString")
  }
  
  /// Current build number of the app, retrieved from the main bundle .plist file.
  public static var buildNumber: String? {
    return infoValue(forKey: "CFBundleVersion")
  }
  
  /// App name, retrieved from, retrieved from the main bundle .plist file.
  public static var name: String? {
    return infoValue(forKey: "CFBundleName")
  }
  
  /// Gets value from main bundle .plist file.
  ///
  /// - Parameter key: key name for desired value.
  /// - Returns: the desired value or nil if it doesn't exist.
  private static func infoValue(forKey key:String) -> String? {
    return Bundle.main.infoDictionary?[key] as? String
  }
  
}
