//
//  UIViewController+Storyboard.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 21/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import Foundation
import UIKit
import Square1Tools

enum StoryboardName: String {
  case Main
  case Other
}

extension UIViewController: Storyboardable {
  static func storyboardViewController(storyboardName: StoryboardName) -> Self {
    return storyboardViewController(storyboardName: storyboardName.rawValue)
  }
}
