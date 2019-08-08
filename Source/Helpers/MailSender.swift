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


/// Local `typealias` for email attachment.
fileprivate typealias MailAttachment = [String: Any]


/// Helper class to use MFMailComposeViewController.
public class MailSender {
    
    /// Message for the email.
    public var message: String = ""
    
    /// Subject for the email.
    public var subject: String = ""
    
    /// Email address for destination.
    public var to: [String] = []
    
    /// CC email address, if needed.
    public var cc: [String]?
    
    /// BSS email address, if needed.
    public var bcc: [String]?
    
    /// Array of attachments for the email, if needed.
    private var attachments: [MailAttachment]?
    
    /// Flag indicating that email has HTML format.
    public var isHTML: Bool = false
    
    private let kDataKey = "data"
    private let kMimeTypeKey = "mimeType"
    private let kFileNameKey = "fileName"
    
    public weak var delegate: MFMailComposeViewControllerDelegate?
    
    public init() {}
    
    
    /// Displays an MFMailComposeViewController over passed UIViewController.
    ///
    /// - Parameter viewController: UIViewController who will display the MFMailComposeViewController.
    public func showMailComposer(from viewController: UIViewController) {
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
    
    
    /// Adds a new attachment to the compsed email.
    ///
    /// - Parameters:
    ///   - data: Data representation of the attachment.
    ///   - mimeType: MIMEType for the attachment.
    ///   - fileName: Name for the attachment.
    public func addAttachment(withData data: Data, mimeType: String, fileName: String) {
        let attachment: [String : Any] = [kDataKey: data,
                                          kMimeTypeKey: mimeType,
                                          kFileNameKey: fileName]
        attachments?.append(attachment)
    }
    
}
