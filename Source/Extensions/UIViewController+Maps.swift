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
import MapKit

/// Enum for supported maps apps to open the desired location.
public enum MapsApp {
    case googleMaps
    case appleMaps
    
    fileprivate var scheme: URL {
        switch self {
        case .googleMaps:
            return URL(string:"comgooglemaps://")!
        case .appleMaps:
            return URL(string:"http://maps.apple.com/")!
        }
    }
    
    fileprivate var title: String {
        switch self {
        case .googleMaps:
            return "Google Maps"
        case .appleMaps:
            return "Apple Maps"
        }
    }
    
    fileprivate func action(with handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: self.title, style: .default, handler: handler)
    }
    
    fileprivate var canOpenApp: Bool {
        return UIApplication.shared.canOpenURL(self.scheme)
    }
    
    fileprivate func urlFor(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) -> URL {
        var urlString = ""
        switch self {
        case .googleMaps:
            urlString = String(format: "comgooglemaps://?q=%.6f,%.6f&center=%.6f,%.6f&zoom=14", arguments: [latitude, longitude])
        case .appleMaps:
            urlString = String(format: "http://maps.apple.com/maps?sll=%.6f,%.6f&z=14", arguments: [latitude, longitude])
        }
        
        return URL(string: urlString)!
    }
    
    fileprivate func open(location: CLLocationCoordinate2D,  markerTitle: String) {
        
        switch self {
        case .googleMaps:
            if canOpenApp {
                UIApplication.shared.open(url: urlFor(latitude: location.latitude, longitude: location.longitude, title: markerTitle))
            }
        case .appleMaps:
            let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = markerTitle
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegion(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            
            mapItem.openInMaps(launchOptions: options)
        }
    }
}


// Extension to handle opening Google Maps and Apple Maps.
public extension UIViewController {
    
    /// Displays an action sheet showing supported maps apps if they're installed.
    /// Otherwise, will try to open location with Google Maps first and the Apple Maps.
    /// - Parameters:
    ///   - location: `CLLocationCoordinate2D` to open.
    ///   - markerTitle: title for the marker displayed on the maps app.
    ///   - actionSheetTitle: optional title for the action sheet.
    ///   - message: optional message for the action sheet.
    ///   - cancel: text for the cancel action. By default it will be "Cancel".
    func openOnAvailableMapApps(location: CLLocationCoordinate2D,
                                markerTitle: String,
                                actionSheetTitle: String? = nil,
                                message: String? = nil,
                                cancel: String = "Cancel") {
        let actionSheet = UIAlertController(title: actionSheetTitle, message: message, preferredStyle: .actionSheet)
        
        if MapsApp.googleMaps.canOpenApp {
            actionSheet.addAction(MapsApp.googleMaps.action(with: { _ in
                self.open(location: location, in: .googleMaps, markerTitle: markerTitle)
            }))
        }
        
        if MapsApp.appleMaps.canOpenApp {
            actionSheet.addAction(MapsApp.appleMaps.action(with: { _ in
                self.open(location: location, in: .appleMaps, markerTitle: markerTitle)
            }))
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        if actionSheet.actions.count > 2 {
            present(actionSheet, animated: true)
        } else {
            if MapsApp.googleMaps.canOpenApp {
                self.open(location: location, in: .googleMaps, markerTitle: markerTitle)
            } else {
                self.open(location: location, in: .appleMaps, markerTitle: markerTitle)
            }
        }
    }
    
    
    /// Opens the procided `CLLocationCoordinate2D` on the desired maps app.
    ///
    /// - Parameters:
    ///   - location: `CLLocationCoordinate2D` to open.
    ///   - mapsApp: `MapsApp` to use.
    ///   - markerTitle: title for the marker displayed on the maps app.
    func open(location: CLLocationCoordinate2D,
              in mapsApp: MapsApp,
              markerTitle: String) {
        mapsApp.open(location: location, markerTitle: markerTitle)
    }
}
