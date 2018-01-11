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

extension Date {
  
  public var day: Int {
    return component(.day)
  }
  
  public var month: Int {
    return component(.month)
  }
  
  public var year: Int {
    return component(.year)
  }
  
  public var hours: Int {
    return component(.hour)
  }
  
  public var minutes: Int {
    return component(.minute)
  }
  
  public var seconds: Int {
    return component(.second)
  }
  
  public func component(_ component: Calendar.Component) -> Int{
    return Calendar.current.component(component, from: self)
  }
  
  public var local: Date? {
    let timeZone = TimeZone.current
    let seconds = timeZone.secondsFromGMT(for: self)
    return Date(timeInterval: TimeInterval(seconds), since: self)
  }
  
  public var GMT: Date? {
    let timeZone = TimeZone.current
    let seconds = -timeZone.secondsFromGMT(for: self)
    return Date(timeInterval: TimeInterval(seconds), since: self)
  }
  
  public func add(_ units: Int, to component: Calendar.Component) -> Date? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([component], from: self)
    
    switch component {
    case .day:
      guard var days = components.day else { return nil }
      days += units
    case .month:
      guard var months = components.month else { return nil }
      months += units
    case .year:
      guard var years = components.year else { return nil }
      years += units
    case .hour:
      guard var hours = components.hour else { return nil }
      hours += units
    case .minute:
      guard var minutes = components.minute else { return nil }
      minutes += units
    case .second:
      guard var seconds = components.second else { return nil }
      seconds += units
    default:
      return nil
    }
    
    return calendar.date(byAdding: components, to: self)
  }
  
  public func hours(in timeZone: TimeZone) -> Int {
    var calendar = Calendar.current
    calendar.timeZone = timeZone
    return calendar.component(.hour, from: self)
  }
  
  public func stringWith(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  public var is12hFormatEnabled: Bool {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    
    let dateString = formatter.string(from: Date())
    let amRange = dateString.range(of: formatter.amSymbol)
    let pmRange = dateString.range(of: formatter.pmSymbol)
    
    return !(pmRange == nil && amRange == nil)
  }
}

private typealias DateStatics = Date
extension DateStatics {

  public static var dateComponents: Set<Calendar.Component> {
    return [.day, .month, .year]
  }

  public static var timeComponents: Set<Calendar.Component> {
    return [.hour, .minute, .second]
  }

  public static func with(date: Date, time: Date) -> Date? {
    let calendar = Calendar.current

    let dComponents = calendar.dateComponents(dateComponents, from: date)
    let tComponents = calendar.dateComponents(timeComponents, from: time)

    var newComponents = DateComponents()
    newComponents.year = dComponents.year
    newComponents.month = dComponents.month
    newComponents.day = dComponents.day
    newComponents.hour = tComponents.hour
    newComponents.minute = tComponents.minute
    newComponents.second = tComponents.second

    return calendar.date(from: newComponents)
  }

  public static func with(string: String, format: String, timeZone: TimeZone = TimeZone.current) -> Date? {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = format
    dateFormat.timeZone = timeZone

    return dateFormat.date(from: string)
  }
}
