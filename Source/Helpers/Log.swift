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
import os

/// Helper log method for more accurate console prints.
///
/// Print will only happen on DEBUG.
///
/// Inspired by https://github.com/JungleCandy/LoggingPrint/blob/master/LoggingPrint.swift
/// - Parameters:
///   - object: Object to be printed. Can be an expression.
///   - file: Name of the file calling this function. By default, the source file without .swift extension.
///   - function: Name of the function calling this function. By default, same name as function where this is called.
///   - line: Line number where this function is called. By default, line number within the file where the call is made.
public func Log (message: String,
                 _ file: String = #file,
                 _ function: String = #function,
                 _ line: Int = #line) {
  #if DEBUG
    let fileURL = URL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "UI" : "BG"
    
    print("(\(queue)) \(fileURL) \(function) [\(line)]: " + message)
  #endif
}

#if DEBUG
/// Helper log method for more accurate console prints.
///
/// Prints using OSLog. The `logAccess` set the visibility of the logs.
/// If it is private the log message doesn't appear in the logs console when
/// the device isn't connected.
///
/// https://developer.apple.com/documentation/os/logging
///
/// - Parameters:
///   - message: Object to be printed. Can be an expression.
///   - log: OSLog object for this log.
///   - type: OSLogType for this log.
///   - logAccess: the level of privacity of the log. By default is public.
///   - function: Name of the function calling this function. By default, same name as function where this is called.
///   - line: Line number where this function is called. By default, line number within the file where the call is made.
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func Log(_ message: String,
                log: OSLog = OSLog.default,
                type: OSLogType = OSLogType.default,
                _ logAccess: LogAccess = .public,
                _ function: StaticString = #function,
                _ line: Int = #line) {
  
  let customMessage = "\(type.descriptionLog) \(function) [\(line)]: \(message)"
  os_log(logAccess.toStaticString(), log: log, type: type, customMessage)
}

#else

/// Helper log method for more accurate console prints.
///
/// Prints using OSLog. The `logAccess` set the visibility of the logs.
/// If it is private the log message doesn't appear in the logs console when
/// the device isn't connected.
///
/// https://developer.apple.com/documentation/os/logging
///
/// - Parameters:
///   - message: Object to be printed. Can be an expression.
///   - log: OSLog object for this log.
///   - type: OSLogType for this log.
///   - logAccess: the level of privacity of the log. By default is public.
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func Log(_ message: String,
                log: OSLog = OSLog.default,
                type: OSLogType = OSLogType.default,
                _ logAccess: LogAccess = .public) {
  os_log(logAccess.toStaticString(), log: log, type: type, message)
}
#endif

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
extension OSLogType {
  
  fileprivate var descriptionLog: String {
    switch self {
    case OSLogType.info:
      return "ℹ️ℹ️ℹ️(info)"
    case OSLogType.debug:
      return "🔹🔹🔹(debug)"
    case OSLogType.error:
      return "‼️‼️‼️(error)"
    case OSLogType.fault:
      return "💣💣💣(fault)"
    default:
      return "⬜️⬜️⬜️(default)"
    }
  }
}

/// Levels of visibility for logs.
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public enum LogAccess {
  case `public`
  case `private`
  
  fileprivate func toStaticString() -> StaticString {
    switch self {
    case .public: return "%{PUBLIC}@"
    case .private: return "%{PRIVATE}@"
    }
  }
}
