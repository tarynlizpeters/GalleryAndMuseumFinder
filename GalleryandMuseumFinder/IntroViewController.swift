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

    override func viewDidLoad() {
        super.viewDidLoad()

        //if we have the uid stored, the user is already  logged in - no need to sign in
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            //proceed to enter the app
            self.performSegueWithIdentifier("EnterAppSegue", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
