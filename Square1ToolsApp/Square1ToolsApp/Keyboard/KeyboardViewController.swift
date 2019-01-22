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
  
  override func keyboardWillShow(withFrame frame: CGRect, animation: UIViewController.KeyboardAnimation) {
    let duration = animation.duration ?? 0.3
    var options: UIView.AnimationOptions? = nil
    if let curve = animation.curve {
      options = UIView.AnimationOptions(rawValue: UInt(curve << 16))
    }
    
    UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options ?? [], animations: {
      self.view.frame.origin.y -= frame.height
    }, completion: nil)
  }

  override func keyboardDidShow(withFrame frame: CGRect) {}
  
  override func keyboardWillHide(withFrame frame: CGRect, animation: UIViewController.KeyboardAnimation) {
    let duration = animation.duration ?? 0.3
    var options: UIView.AnimationOptions? = nil
    if let curve = animation.curve {
      options = UIView.AnimationOptions(rawValue: UInt(curve << 16))
    }
    
    UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options ?? [], animations: {
      self.view.frame.origin.y = 0
    }, completion: nil)
  }
  
  override func keyboardDidHide() {}
  
  override func keyboardWillChange(toFrame frame: CGRect) {}
  
  override func keyboardDidChange(toFrame frame: CGRect) {}
}

extension KeyboardViewController: UITextFieldDelegate {
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
