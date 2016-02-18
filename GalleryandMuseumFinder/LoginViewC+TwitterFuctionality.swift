//
//  LoginViewC+TwitterFuctionality.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/17/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation
import UIKit
import Firebase
extension LoginViewController {
 
    
    func authWithTwitter() {
        authHelper.selectTwitterAccountWithCallback { ( error, accounts) -> Void in
            self.accounts = accounts as? [ACAccount]
            self.handleMultipleTwitterAccounts(self.accounts)
        }
    }
    
    
    
    func authAccount(account:ACAccount) {
        authHelper.authenticateAccount(account) { (error, authData) -> Void in
            if error != nil {
                //there was a problem authenticating
                print("There was an error authenticating")
                print(error.description)
            }else {
                //authentication succeeded
                print(authData.providerData.description)
                
                let user = ["provider": authData.provider, "username": "\(authData.providerData["username"]!)"]
                DataService.dataService.createNewAccount(authData.uid, user: user)
                
                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.login()
            }
        }
    }
    
    
    func selectTwitterAccount(account:[ACAccount]) {
        let selectUserAlertController = UIAlertController(title: "Select Twitter Account", message: "Please choose your account", preferredStyle: .ActionSheet)
        
        for account in accounts {
            selectUserAlertController.addAction(UIAlertAction(title: account.username, style: .Default, handler: { (alertAction) -> Void in
                let currentTwitterHandle = account.username
                for acc in self.accounts {
                    if acc.username == currentTwitterHandle {
                        self.authAccount(acc)
                    }
                }
            }))
        }
        selectUserAlertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(selectUserAlertController, animated: true, completion: nil)
    }
    
    func handleMultipleTwitterAccounts(accounts: [ACAccount]) {
        switch accounts.count {
        case 0:
            UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/signup")!)
        case 1:
            self.authAccount(accounts[0])
        default:
            self.selectTwitterAccount(accounts)
        }
    }
    
    

    
}