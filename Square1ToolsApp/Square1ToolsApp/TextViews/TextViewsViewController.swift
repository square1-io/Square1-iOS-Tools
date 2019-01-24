//
//  TextViewsViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 23/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit
import Square1Tools

class TextViewsViewController: UIViewController {
  
  @IBOutlet weak var placeholderTextView: PlaceholderTextView!
  
  // MARK: - Lifecycle and setup.
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    placeholderTextView.becomeFirstResponder()
  }
}
