// Copyright © 2019 Square1.
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

open class PlaceholderTextView: UITextView {

  /// Label to configure the placeholder text.
  public let placeholderLabel = UILabel()
  
  @IBInspectable public var textColorPlaceholder: UIColor = .gray {
    didSet {
      placeholderLabel.textColor = textColorPlaceholder
    }
  }
  @IBInspectable public var textPlaceholder: String = "" {
    didSet {
      placeholderLabel.text = textPlaceholder
    }
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureView()
  }
  
  override public init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    configureView()
  }
  
  deinit {
    removeNotifications()
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    
    let placeholderX: CGFloat = textContainer.lineFragmentPadding + textContainerInset.left
    let placeholderY: CGFloat = textContainerInset.top
    let placeholderWidth = frame.width - placeholderX - textContainerInset.right
    let placeholderHeight = frame.height - placeholderY - textContainerInset.bottom
    
    var size = placeholderLabel.sizeThatFits(CGSize(width: placeholderWidth, height: placeholderHeight))
    size.height = min(size.height, placeholderHeight)
    size.width = min(size.width, placeholderWidth)
    placeholderLabel.frame = CGRect(x: placeholderX, y: placeholderY, width: size.width, height: size.height)
  }
  
  // MARK: Private.
  
  private func configureView() {
    placeholderLabel.numberOfLines = 0
    placeholderLabel.font = font
    addSubview(placeholderLabel)
    
    addNotifications()
  }
  
  // MARK: Notifications.
  
  private func addNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  private func removeNotifications() {
    NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
  }
  
  @objc private func textDidChange(notification: Notification) {
    if let object = notification.object as? UITextView, self == object {
      placeholderLabel.isHidden = text.count > 0
    }
  }
}
