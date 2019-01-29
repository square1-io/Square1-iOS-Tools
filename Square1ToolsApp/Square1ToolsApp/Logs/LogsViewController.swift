//
//  LogsViewController.swift
//  Square1ToolsApp
//
//  Created by Ginés Navarro Fernández on 29/01/2019.
//  Copyright © 2019 Ginés Navarro Fernández. All rights reserved.
//

import UIKit
import Square1Tools

class LogsViewController: UIViewController {
  
  // MARK: - Actions
  @IBAction func printLogs(_ sender: UIButton) {
    Log("Default message", log: Logs.test)
    Log("Debug message", log: Logs.test, type: .debug)
    Log("Info message", log: Logs.test, type: .info)
    Log("Ohter default message", log: Logs.test, type: .default)
    Log("Error message", log: Logs.test, type: .error)
    Log("Fault message", log: Logs.test, type: .fault)
  }
}
