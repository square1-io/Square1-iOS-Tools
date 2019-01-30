//
//  ViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 21/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

  private lazy var items: [String] = {
    return ["Keyboard",
            "Storyboard",
            "Labels",
            "TextViews",
            "Logs"]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Private.
  
  func goToKeyboard() {
    performSegue(withIdentifier: "toKeyboard", sender: nil)
  }
  
  func goToStoryboard() {
    performSegue(withIdentifier: "toStoryboard", sender: nil)
  }
  
  func goToLabels() {
    performSegue(withIdentifier: "toLabels", sender: nil)
  }
  
  func goToTextViews() {
    performSegue(withIdentifier: "toTextViews", sender: nil)
  }
  
  func goToLogs() {
    performSegue(withIdentifier: "toLogs", sender: nil)
  }
  
  // MARK: - TableView DataSource.
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    
    cell.textLabel?.text = items[indexPath.row]
    
    return cell
  }
  
  // MARK: - TableView Delegate.
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    switch indexPath.row {
    case 0:
      goToKeyboard()
    case 1:
      goToStoryboard()
    case 2:
      goToLabels()
    case 3:
      goToTextViews()
    case 4:
      goToLogs()
    default:
      break
    }
  }
}

