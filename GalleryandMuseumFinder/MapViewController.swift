//
//  MapViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/18/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onSignOutTapped(sender: AnyObject) {
        //unauth() is the logout method for the current user.
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        //remove the user's uid from storage
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        //Head back to login
        let loginViewcontroller = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewcontroller
        print("method firing")

    }
}
