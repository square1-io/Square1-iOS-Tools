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
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow(notification:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardDidShow(notification:)),
                                           name: UIResponder.keyboardDidShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide(notification:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardDidHide(notification:)),
                                           name: UIResponder.keyboardDidHideNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillChange(notification:)),
                                           name: UIResponder.keyboardWillChangeFrameNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardDidChange(notification:)),
                                           name: UIResponder.keyboardDidChangeFrameNotification,
                                           object: nil)
  }
  
  /// Stops listening to all keyboard notification.
  public func stopListeningToKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(notification: NSNotification) {
    keyboardWillShow(withFrame: frame(from: notification), animation: animation(from: notification))
  }
  
  @objc private func keyboardDidShow(notification: NSNotification) {
    keyboardDidShow(withFrame: frame(from: notification))
  }
  
  @objc private func keyboardWillHide(notification: NSNotification) {
    keyboardWillHide(withFrame: frame(from: notification), animation: animation(from: notification))
  }
  
  @objc private func keyboardDidHide(notification: NSNotification) {
    keyboardDidHide()
  }
  
  @objc private func keyboardWillChange(notification: NSNotification) {
    keyboardWillChange(toFrame: frame(from: notification), animation: animation(from: notification))
  }
  
  @objc private func keyboardDidChange(notification: NSNotification) {
    keyboardDidChange(toFrame: frame(from: notification))
  }
  
  private func frame(from notification: NSNotification) -> CGRect {
    guard let keyboardInfo = notification.userInfo else {
      return CGRect.zero
    }
    let keyboardFrameValue = keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardFrameValue.cgRectValue
  }
  
  public class KeyboardAnimation: NSObject {
    public let duration: Float?
    public let curve: UIView.AnimationCurve?
    
    init(duration: Float?, curve: UIView.AnimationCurve?) {
      self.duration = duration
      self.curve = curve
      
      super.init()
    }
  }
  
  private func animation(from notification: NSNotification) -> KeyboardAnimation {
    let keyboardInfo = notification.userInfo
    
    let duration = keyboardInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
    
    var animationCurve: UIView.AnimationCurve? = nil
    if let curve = keyboardInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
      animationCurve = UIView.AnimationCurve(rawValue: curve.intValue)
    }
    
    return KeyboardAnimation(duration: duration?.floatValue, curve: animationCurve)
  }
  
  /// Method to be called on UIKeyboardWillShow notification. Must be overrided with desired implementation.
  ///
  /// - Parameter   frame: Frame of presented keyboard.
  ///               animation: KeyboardAnimation of presented keyboard.
  @objc open func keyboardWillShow(withFrame frame: CGRect, animation: KeyboardAnimation) {}
  
  /// Method to be called on UIKeyboardDidShow notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  @objc open func keyboardDidShow(withFrame frame: CGRect) {}
  
  /// Method to be called on UIKeyboardWillHide notification. Must be overrided with desired implementation.
  ///
  /// - Parameter   frame: Frame of presented keyboard.
  ///               animation: KeyboardAnimation of presented keyboard.
  @objc open func keyboardWillHide(withFrame frame: CGRect, animation: KeyboardAnimation) {}
  
  /// Method to be called on UIKeyboardDidHide notification. Must be overrided with desired implementation.
  @objc open func keyboardDidHide() {}
  
  /// Method to be called on UIKeyboardWillChangeFrame notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  ///             animation: KeyboardAnimation of presented keyboard.
  @objc open func keyboardWillChange(toFrame frame: CGRect, animation: KeyboardAnimation) {}
  
  /// Method to be called on UIKeyboardDidChangeFrame notification. Must be overrided with desired implementation.
  ///
  /// - Parameter frame: Frame of presented keyboard.
  @objc open func keyboardDidChange(toFrame frame: CGRect) {}
  
  
  /// Helper method to get precedent `UIViewController` in navigation stack
  public var previousViewControllerInNavigationStack: UIViewController? {
    guard let nav = navigationController, nav.viewControllers.count >= 2 else {
      return nil
    }
    let numViewControllers = nav.viewControllers.count
    return nav.viewControllers[numViewControllers - 2]
  }
}
