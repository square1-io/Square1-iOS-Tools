//
//  LabelsViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 23/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit

class LabelsViewController: UIViewController {

  @IBOutlet weak var labelColor: UILabel!
  @IBOutlet weak var labelLineHeight: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    labelColor.setColor(color: .red, range: "different color")
    
    labelLineHeight.setText(text: "Label with a custom line height. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed convallis posuere orci ut tincidunt. Proin gravida tempor tellus, ut lacinia nisl sollicitudin id.", lineHeight: 25)
  }
}
