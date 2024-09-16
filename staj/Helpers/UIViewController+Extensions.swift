// 
//  UIViewController+Extensions.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit
import MessageUI
import SafariServices
import SVProgressHUD

extension UIViewController: MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate {
    
    public func shareApp() {
        SVProgressHUD.show()
        if let name = URL(string: "https://itunes.apple.com/us/app/id\(Constants.appId)?ls=1&mt=8"), !name.absoluteString.isEmpty {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: {
                SVProgressHUD.dismiss()
            })
        } else {
            // show alert for not available
        }
    }
    
    public func shareString(value: String) {
        SVProgressHUD.show()
        let objectsToShare = [value]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: {
            SVProgressHUD.dismiss()
        })
    }

    
    public func openUrlWithSafari(_ urlString:String) {
        if let url = URL(string: urlString) {
            let controller = SFSafariViewController(url: url)
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            controller.delegate = self
        }
    }
    
    func sendEmail(subject: String) {
        if !MFMailComposeViewController.canSendMail() {
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.showInfo(withStatus:"Mail services are not available")
            return
        }
        
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([Constants.supportMailAddress])
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody("", isHTML: false)
        mailComposeViewController.modalPresentationStyle = .fullScreen
        
        self.present(mailComposeViewController, animated: true, completion: nil)
    }
    
    func openScheme(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                
            })
        }
    }
    
    public func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func stringArrayToData(stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    func dataToStringArray(data: Data) -> [String]? {
      return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
