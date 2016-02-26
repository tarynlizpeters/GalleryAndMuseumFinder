//
//  IntroViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Taryn Parker on 2/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import Firebase



class IntroViewController: UIViewController {

    @IBOutlet weak var newAccountButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //if we have the uid stored, the user is already  logged in - no need to sign in
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            //proceed to enter the app
            func autoSegue() {
                self.performSegueWithIdentifier("EnterAppSegue2", sender: self)
            }

            
//            var timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "autoSegue:", userInfo: nil, repeats: false)

//            self.dismissViewControllerAnimated(true, completion: { () -> Void in
//                self.performSegueWithIdentifier("EnterAppSegue2", sender: self)
            
            
//            self.performSegueWithIdentifier("EnterAppSegue", sender: nil)
            
//            newAccountButton.hidden = true
//            loginButton.hidden = true
        }

    }

 
  
}
