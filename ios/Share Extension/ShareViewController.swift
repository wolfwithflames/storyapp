//
//  ShareViewController.swift
//  Share Extension
//
//  Created by Keyur Tailor on 08/05/24.
//

import UIKit
import Social
import receive_sharing_intent

class ShareViewController: RSIShareViewController {

    // override func isContentValid() -> Bool {
    //     // Do validation of contentText and/or NSExtensionContext attachments here
    //     return true
    // }

    // override func didSelectPost() {
    //     // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    //     // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    //     self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    // }

    // override func configurationItems() -> [Any]! {
    //     // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    //     return []
    // }

    // Use this method to return false if you don't want to redirect to host app automatically.
    // Default is true
    // override func shouldAutoRedirect() -> Bool {
    //     return true
    // }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isHidden = true
    }
}