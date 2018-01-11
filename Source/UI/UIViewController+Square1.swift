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

extension UIViewController {
  func sq1_openWithSafariVC(url: URL) {
    let svc = SFSafariViewController(url: url)
    present(svc, animated: true, completion: nil)
  }
  
  // MARK: Alert
  
  func showAlert(message: String?,
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
  
  // MARK: Navigation
  
  func pushVC(_ id: String,
              preparation: ((UIViewController) -> ())? = nil) {
    pushVCFromStoryboard(nil, vcID: id, preparation: preparation)
  }
  
  func pushVCFromStoryboard(_ name: String?,
                            vcID: String,
                            preparation: ((UIViewController) -> ())? = nil) {
    guard let navigationController = navigationController else { return }
    
    guard let sb = storyboard(named: name) else { return }
    guard let vc = viewController(from: sb, withID: vcID),
          !(vc is UINavigationController) else { return }
    
    preparation?(vc)
    
    navigationController.pushViewController(vc, animated: true)
  }
  
  func presentModalVC(_ id: String,
                      preparation: ((UIViewController) -> ())?,
                      completion: (() -> ())?) {
    presentModalFromStoryboard(nil, vcID: id, preparation: preparation, completion: completion)
  }
  
  func presentModalFromStoryboard(_ name: String? = nil,
                                  vcID: String,
                                  preparation: ((UIViewController) -> ())?,
                                  completion: (() -> ())?) {
    guard let sb = storyboard(named: name) else { return }
    guard let vc = viewController(from: sb, withID: vcID) else { return }
    
    preparation?(vc)
    
    present(vc, animated: true, completion: completion)
  }
  
  func storyboard(named name: String?, bundle: Bundle? = nil) -> UIStoryboard? {
    guard let name = name, !name.trimmed.isEmpty else { return storyboard }
    return UIStoryboard(name: name, bundle: bundle)
  }
  
  func viewController(from storyboard: UIStoryboard, withID vcID: String?) -> UIViewController? {
    guard let viewControllerID = vcID, !viewControllerID.trimmed.isEmpty else {
      return storyboard.instantiateInitialViewController()
    }
    
    return storyboard.instantiateViewController(withIdentifier: viewControllerID)
  }
  
  // MARK: Safari
  
  func openWithSafariVC(url: URL, completion: (() -> ())? = nil) {
    let safari = SFSafariViewController(url: url)
    present(safari, animated: true, completion: completion)
  }
  
  // MARK: Keyboard
  
  func listenToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange(notification:)), name: .UIKeyboardDidChangeFrame, object: nil)
  }
  
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
  
  open func keyboardWillShow(withFrame frame: CGRect) {
    SQ1Log("You must override keyboardWillShow")
  }
  
  open func keyboardDidShow(withFrame frame: CGRect) {
    SQ1Log("You must override keyboardDidShow")
  }
  
  open func keyboardWillHide() {
    SQ1Log("You must override keyboardWillHide")
  }
  
  open func keyboardDidHide() {
    SQ1Log("You must override keyboardDidHide")
  }
  
  open func keyboardWillChange(toFrame frame: CGRect) {
    SQ1Log("You must override keyboardWillChange")
  }
  
  open func keyboardDidChange(toFrame frame: CGRect) {
    SQ1Log("You must override keyboardDidChange")
  }
}
