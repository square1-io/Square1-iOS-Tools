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


/// Helpers for Date.
public extension Date {
    
    /// Day of the Date.
    var day: Int {
        return component(.day)
    }
    
    /// Month of the Date.
    var month: Int {
        return component(.month)
    }
    
    /// Year of the Date.
    var year: Int {
        return component(.year)
    }
    
    /// Hour of the Date.
    var hours: Int {
        return component(.hour)
    }
    
    /// Minutes of the Date.
    var minutes: Int {
        return component(.minute)
    }
    
    /// Seconds of the Date.
    var seconds: Int {
        return component(.second)
    }
    
    /// Component of the Date on passed time zone.
    ///
    /// - Parameters:
    ///   - component: Desired `Component`.
    ///   - timeZone: `TimeZone` to use. By default is the current one.
    /// - Returns: `Component` after applying the passed time zone.
    func component(_ component: Calendar.Component,
                   inTimeZone timeZone: TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        return calendar.component(component, from: self)
    }
    
    /// Local version of the Date.
    var local: Date? {
        let timeZone = TimeZone.current
        let seconds = timeZone.secondsFromGMT(for: self)
        return Date(timeInterval: TimeInterval(seconds), since: self)
    }
    
    /// GMT version of the Date.
    var GMT: Date? {
        let timeZone = TimeZone.current
        let seconds = -timeZone.secondsFromGMT(for: self)
        return Date(timeInterval: TimeInterval(seconds), since: self)
    }
    
    /// New Date adding a `units` amount to `component` of Date.
    ///
    /// - Parameters:
    ///   - units: Number to units to add.
    ///   - component: Date component to add units to.
    /// - Returns: New Date adding units or nil if something went wrong.
    func add(_ units: Int,
             to component: Calendar.Component) -> Date? {
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
    
    /// String representation of the Date.
    ///
    /// - Parameter format: String representation of the desired output format.
    /// - Returns: Date's string representation
    func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
    /// Helper to check if 12h format is enabled.
    var is12hFormatEnabled: Bool {
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


/// Static helpers for Date.
public extension DateStatics {
    
    /// Components for simple date (day, month and year).
    static var dateComponents: Set<Calendar.Component> {
        return [.day, .month, .year]
    }
    
    /// Components for simple time (hours, minutes and seconds).
    static var timeComponents: Set<Calendar.Component> {
        return [.hour, .minute, .second]
    }
    
    /// New Date created mixing date and time components from two different Date objects.
    ///
    /// - Parameters:
    ///   - date: Date who will provide the date components.
    ///   - time: Date who will provide the time components.
    /// - Returns: New mixed Date
    static func with(date: Date,
                     time: Date) -> Date? {
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
    
    /// New Date with string representation, provided format and time zone.
    ///
    /// - Parameters:
    ///   - string: String representation of the date.
    ///   - format: Expected format for the string representation.
    ///   - timeZone: Time zone for the Date. By default is the current one.
    /// - Returns: New Date based on string representation
    static func with(string: String,
                     format: String,
                     timeZone: TimeZone = TimeZone.current) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = timeZone
        
        return dateFormat.date(from: string)
    }
}
