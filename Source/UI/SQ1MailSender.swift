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

import Foundation
import MessageUI

typealias Attachment = [String: Any]

class SQ1MailSender {
  
  var message: String = ""
  var subject: String = ""
  var to: [String] = []
  var cc: [String]?
  var bcc: [String]?
  var attachments: [Attachment]?
  var isHTML: Bool = false
  
  private let kDataKey = "data"
  private let kMimeTypeKey = "mimeType"
  private let kFileNameKey = "fileName"
  
  weak var delegate: MFMailComposeViewControllerDelegate?
  
  func showMailComposer(from viewController: UIViewController) {
    if MFMailComposeViewController.canSendMail() {
      let mailComposer = MFMailComposeViewController()
      mailComposer.setSubject(subject)
      mailComposer.setMessageBody(message, isHTML: isHTML)
      mailComposer.setToRecipients(to)
      mailComposer.setCcRecipients(cc)
      mailComposer.setBccRecipients(bcc)
      mailComposer.mailComposeDelegate = delegate
      
      if let attachments = attachments {
        for attachment in attachments {
          mailComposer.addAttachmentData(attachment[kDataKey] as! Data,
                                         mimeType: attachment[kMimeTypeKey] as! String,
                                         fileName: attachment[kFileNameKey] as! String)
        }
      }
      
      viewController.present(mailComposer, animated: true, completion: nil)
    }
  }
  
  func addAttachment(withData data: Data?, mimeType: String?, fileName: String?) {
    if let data = data, let mimeType = mimeType, let fileName = fileName {
      let attachment: [String : Any] = [kDataKey: data,
                                        kMimeTypeKey: mimeType,
                                        kFileNameKey: fileName]
      attachments?.append(attachment)
    }
  }
  
}
