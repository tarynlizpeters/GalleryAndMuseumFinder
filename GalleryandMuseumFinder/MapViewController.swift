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
import Google

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {
    
    var googleMapView = GMSMapView()
    var placePicker: GMSPlacePicker!
    var latitude: Double!
    var longitude: Double!

    @IBOutlet var mapViewContainer: UIView!

    
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

        self.view.addSubview(googleMapView)
        
        let marker = GMSMarker()
        
        
        marker.map = googleMapView
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        self.googleMapView = GMSMapView(frame: self.mapViewContainer.frame)
//        self.googleMapView.animateToZoom(18.0)
//        self.view.addSubview(googleMapView)
//    }
    
    

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == .AuthorizedWhenInUse {
                googleMapView.myLocationEnabled = true
            }
            
        }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            // 1
            let location:CLLocation = locations.last!
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            
            // 2
            let coordinates = CLLocationCoordinate2DMake(self.latitude, self.longitude)
            let marker = GMSMarker(position: coordinates)
            marker.title = "I am here"
            marker.map = self.googleMapView
            self.googleMapView.animateToLocation(coordinates)
    }
    
   
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError){
            
            print("An error occurred while tracking location changes : \(error.description)")
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

    @IBAction func showPlacePicker(sender: AnyObject) {
        
        // 1
        let center = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        self.placePicker = GMSPlacePicker(config: config)
        
        // 2
        placePicker.pickPlaceWithCallback { (place: GMSPlace?, error: NSError?) -> Void in
            
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            // 3
            if let place = place {
                let coordinates = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
                let marker = GMSMarker(position: coordinates)
                marker.title = place.name
                marker.map = self.googleMapView
                self.googleMapView.animateToLocation(coordinates)
            } else {
                print("No place was selected")
            }
        }
    }

}


    

    




