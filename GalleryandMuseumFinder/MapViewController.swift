//
//  MapViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez and Joseph Mouer on 2/18/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var gMapView: GMSMapView!
    var googleMapView = GMSMapView()
   
    var placesClient: GMSPlacesClient?
    var locationManager = CLLocationManager()
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        googleMapView.myLocationEnabled = true

        
        let marker = GMSMarker()
        marker.map = googleMapView
    }
    

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == .AuthorizedWhenInUse {
                googleMapView.myLocationEnabled = true
            }
            
        }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            googleMapView.camera = GMSCameraPosition.cameraWithTarget(newLocation.coordinate, zoom: 15.0)
            googleMapView.settings.myLocationButton = true
            self.view = self.googleMapView
            marker.position = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
            marker.map = self.googleMapView
        }
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


    

    




