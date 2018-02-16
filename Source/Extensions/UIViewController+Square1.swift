// Copyright © 2017 Square1.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import SafariServices


/// Helpers for UIViewController
extension UIViewController {
  
  /// Displays basic UIAlertController.
  ///
  /// - Parameters:
  ///   - message: Message for alert.
  ///   - title: Title for alert.
  ///   - okTitle: OK button title for alert.
  ///   - cancelTitle: Cancel button title for alert.
  ///   - confirmHandler: Confirm action closure.
  ///   - cancelHandler: Cancel action closure.
  public func showAlert(message: String?,
                 title: String?,
                 okTitle: String? = nil,
                 cancelTitle: String? = nil,
                 confirmHandler: ((UIAlertAction?) -> ())? = nil,
                 cancelHandler: ((UIAlertAction?) -> ())? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: okTitle ?? "OK".localized,
                                 style: .default,
                                 handler: confirmHandler)
    alert.addAction(okAction)
    
    if let cancelHandler = cancelHandler {
      let cancelAction = UIAlertAction(title: cancelTitle ?? "Cancel".localized, style: .cancel, handler: cancelHandler)
      alert.addAction(cancelAction)
    }
    
    present(alert, animated: true, completion: nil)
  }
  
  /// Pushes new UIViewController in different Storyboard after executing preparation closure.
  ///
  /// - Parameters:
  ///   - name: Name of Storyboard.
  ///   - vcID: ID for new UIViewController.
  ///   - preparation: Preparation closure executed before push.
  public func push(fromStoryboard name: String? = nil,
                   vcID: String,
                   preparation: ((UIViewController) -> ())? = nil) {
    guard let navigationController = navigationController else { return }
    
    guard let sb = storyboard(named: name) else { return }
    guard let vc = viewController(fromStoryboard: sb, withID: vcID),
          !(vc is UINavigationController) else { return }
    
    preparation?(vc)
    
    navigationController.pushViewController(vc, animated: true)
  }

  /// Presents modally new UIViewController in different Storyboard after executing preparation closure.
  ///
  /// - Parameters:
  ///   - name: Name of Storyboard.
  ///   - vcID: ID for new UIViewController.
  ///   - preparation: Preparation closure executed before presentation.
  ///   - completion: Completion closure executed after presentation.
  public func modal(fromStoryboard name: String? = nil,
                    vcID: String,
                    preparation: ((UIViewController) -> ())? = nil,
                    completion: (() -> ())? = nil) {
    guard let sb = storyboard(named: name) else { return }
    guard let vc = viewController(fromStoryboard: sb, withID: vcID) else { return }
    
    preparation?(vc)
    
    present(vc, animated: true, completion: completion)
  }
  
  /// UIStoryboard object with passed name.
  ///
  /// - Parameters:
  ///   - name: Name for desired Storyboard.
  ///   - bundle: Bundle for Storyboard. By default id Main Bundle.
  /// - Returns: UIStoryboard object or nil if something went wrong.
  public func storyboard(named name: String?,
                         bundle: Bundle? = nil) -> UIStoryboard? {
    guard let name = name, !name.trimmed.isEmpty else { return storyboard }
    return UIStoryboard(name: name, bundle: bundle)
  }
  
  /// UIViewController object with passed ID in storyboard.
  ///
  /// - Parameters:
  ///   - storyboard: Storyboard object where view controller should be.
  ///   - vcID: ID for view controller.
  /// - Returns: UIViewControler object of nil if something went wrong.
  public func viewController(fromStoryboard storyboard: UIStoryboard,
                             withID vcID: String?) -> UIViewController? {
    guard let viewControllerID = vcID, !viewControllerID.trimmed.isEmpty else {
      return storyboard.instantiateInitialViewController()
    }
    
    return storyboard.instantiateViewController(withIdentifier: viewControllerID)
  }

  /// Opens URL with SFSafariViewController.
  ///
  /// - Parameter url: URL to be opened.
  public func openWithSafariVC(url: URL) {
    let svc = SFSafariViewController(url: url)
    present(svc, animated: true, completion: nil)
  }
  

  /// Listens to all keyboard notifications.
  public func listenToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange(notification:)), name: .UIKeyboardDidChangeFrame, object: nil)
  }
  
  /// Stops listening to all keyboard notification.
  func stopListeningToKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidChangeFrame, object: nil)
  }
  
  @objc private func keyboardWillShow(notification: NSNotification) {
    keyboardWillShow(withFrame: frame(from: notification))
  }
  
  @objc private func keyboardDidShow(notification: NSNotification) {
    keyboardDidShow(withFrame: frame(from: notification))
  }
  
  @objc private func keyboardWillHide(notification: NSNotification) {
    keyboardWillHide()
  }
  
  @objc private func keyboardDidHide(notification: NSNotification) {
    keyboardDidHide()
  }
  
  @objc private func keyboardWillChange(notification: NSNotification) {
    keyboardWillChange(toFrame: frame(from: notification))
  }
  
  @objc private func keyboardDidChange(notification: NSNotification) {
    keyboardDidChange(toFrame: frame(from: notification))
  }
  
  private func frame(from notification: NSNotification) -> CGRect {
    guard let keyboardInfo = notification.userInfo else {
      return CGRect.zero
    }
    let keyboardFrameValue = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardFrameValue.cgRectValue
  }
  
  /// Method to be called on UIKeyboardWillShow notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  open func keyboardWillShow(withFrame frame: CGRect) {
    Log("You must override keyboardWillShow")
  }
  
  /// Method to be called on UIKeyboardDidShow notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  open func keyboardDidShow(withFrame frame: CGRect) {
    Log("You must override keyboardDidShow")
  }
  
  /// Method to be called on UIKeyboardWillHide notification. Must be overrided with desired implementation.
  open func keyboardWillHide() {
    Log("You must override keyboardWillHide")
  }
  
  /// Method to be called on UIKeyboardDidHide notification. Must be overrided with desired implementation.
  open func keyboardDidHide() {
    Log("You must override keyboardDidHide")
  }
  
  /// Method to be called on UIKeyboardWillChangeFrame notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  open func keyboardWillChange(toFrame frame: CGRect) {
    Log("You must override keyboardWillChange")
  }
  
  /// Method to be called on UIKeyboardDidChangeFrame notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  open func keyboardDidChange(toFrame frame: CGRect) {
    Log("You must override keyboardDidChange")
  }
}
