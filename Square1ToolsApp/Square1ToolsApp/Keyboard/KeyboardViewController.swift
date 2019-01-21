//
//  KeyboardViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 21/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit
import Square1Tools

class KeyboardViewController: UIViewController {
  
  // MARK: - Lifecycle.
  
  deinit {
    stopListeningToKeyboardNotifications()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    listenToKeyboardNotifications()
  }
  
  // MARK: - KeyboardNotifications
}
