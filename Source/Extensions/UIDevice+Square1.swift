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
import CoreTelephony

/// Helpers for UIDevice.
public extension UIDevice {
  
  /// Identifier string for device model.
  var modelIdentifier: String {
    if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
  }
  
  /// Readable name for device model (support for iPod Touch, iPhone, iPad and simulator).
  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
    case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
    case "iPhone8,4":                               return "iPhone SE"
    case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
    case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
    case "iPhone10,3", "iPhone10,6":                return "iPhone X"
    case "iPhone11,2":                              return "iPhone XS"
    case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
    case "iPhone11,8":                              return "iPhone XR"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad6,11", "iPad6,12":                    return "iPad 5"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7 Inch)"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9 Inch)"
    case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9 Inch) (2nd Generation)"
    case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
    case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
    case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5 Inch)"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
  }
  
  /// Is this an iPad?
  var isiPad: Bool {
    return UI_USER_INTERFACE_IDIOM() == .pad
  }
  
  /// Is this an iPhone?
  var isiPhone: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
  }
  
  /// Can this device make phone calls. Also checking if SIM card is inserted.
  var canMakePhoneCall: Bool {
    if UIApplication.shared.openURL(URL(string:"tel://")!) {
      let networkInfo = CTTelephonyNetworkInfo()
      let carrier = networkInfo.subscriberCellularProvider
      let code = carrier?.mobileNetworkCode
      
      return code != nil
      
    } else {
      return false
    }
  }
  
  /// UUID for device.
  var UUID: String? {
    return identifierForVendor?.uuidString
  }
}

