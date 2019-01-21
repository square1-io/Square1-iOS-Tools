//
//  Storyboardable.swift
//  Square1Tools
//
//  Created by Ginés Navarro Fernández on 21/01/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

import Foundation

public protocol Storyboardable: class {}

public extension Storyboardable where Self: UIViewController {
  
  /// Get the view controller from Storyboard.
  ///
  /// - Parameters:
  ///   - controllerIdentifier: Storyboard ID of controller. If nil it will use the name of the class.
  ///   - storyboardName: Name of the storyboard.
  static func storyboardViewController(controllerIdentifier: String? = nil,
                                       storyboardName: String) -> Self {
    
    let controllerID = controllerIdentifier ?? String(describing: self)
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as? Self else {
      fatalError("Could not instantiate controller identifier: \(controllerID), from storyboard: \(storyboardName)")
    }
    
    return vc
  }
}
