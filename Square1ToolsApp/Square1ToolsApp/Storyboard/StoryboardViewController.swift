//
//  StoryboardViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 21/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit

class StoryboardViewController: UIViewController {

  // MARK: - Actions.
  
  @IBAction func sameStoryboard(_ sender: Any) {
    let vc = SameStoryboardViewController.storyboardViewController(storyboardName: .Main)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func otherStoryboard(_ sender: Any) {
    let vc = OtherStoryboardViewController.storyboardViewController(storyboardName: .Other)
    navigationController?.pushViewController(vc, animated: true)
  }
}


