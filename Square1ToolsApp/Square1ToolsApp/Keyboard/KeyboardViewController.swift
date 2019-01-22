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
  
  override func keyboardWillShow(withFrame frame: CGRect) {}

  override func keyboardDidShow(withFrame frame: CGRect) {}
  
  override func keyboardWillHide() {}
  
  override func keyboardDidHide() {}
  
  override func keyboardWillChange(toFrame frame: CGRect) {}
  
  override func keyboardDidChange(toFrame frame: CGRect) {}
}
