//
//  GalleryListViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Taryn Parker on 2/16/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Google
class GalleryListViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {
var locationManager = CLLocationManager()
   
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000 {
            locationManager.stopUpdatingLocation()
        }
        
    }

    func getDirectionsTo(destinationItem: MKMapItem) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler { (response:MKDirectionsResponse?, error:NSError?) -> Void in
            let routes = response?.routes
            let route = routes!.first
            
            var x = 1
            let directionsString = NSMutableString()
            for step in route!.steps {
                directionsString.appendString("\(x): \(step.instructions)")
                x++
            }
        }
        
    }
    
    
    
    @IBAction func onSignOutTapped(sender: AnyObject) {
        //unauth() is the logout method for the current user.
        DataService.dataService.CURRENT_USER_REF.unauth()
        GIDSignIn.sharedInstance().signOut()
        //remove the user's uid from storage
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        //Head back to login
        let loginViewcontroller = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewcontroller
        print("method firing")
        

    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        cell?.backgroundColor = UIColor.grayColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
