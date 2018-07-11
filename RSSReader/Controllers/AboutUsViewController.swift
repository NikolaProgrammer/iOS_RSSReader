//
//  AboutUsViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 11.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsViewController: BaseViewController {
    
    //MARK: Actions
    @IBAction func feedbackButtonTapped(_ sender: UIButton) {
        let phoneNumbers: [String] = ["+3752912345678", "+3754412345678"]
        
        let actionSheet = UIAlertController(title: NSLocalizedString("feedback", comment: ""), message: NSLocalizedString("choose the number", comment: ""), preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        
        for number in phoneNumbers {
            let action = UIAlertAction(title: number, style: .default) { (action) in
                let phoneUrl = URL(string: "tel://\(number)")
                UIApplication.shared.open(phoneUrl!, options: [:], completionHandler: nil)
            }
            
            actionSheet.addAction(action)
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let sharingText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        let activityController = UIActivityViewController(activityItems: [sharingText], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let mailController = MFMailComposeViewController()
            mailController.delegate = self
            
            present(mailController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("This device cannot send email messages", comment: ""), preferredStyle: .alert)
            let cancel = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
    }
}

extension AboutUsViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}












