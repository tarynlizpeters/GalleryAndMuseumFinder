//
//  MapViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/18/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Google
class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GIDSignInUIDelegate  {
    
   // @IBOutlet weak var googleMapView: GMSMapView!
    var googleMapView = GMSMapView()
   
    var placesClient: GMSPlacesClient?
    var locationManager = CLLocationManager()
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
    
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.view = googleMapView

        
        let camera = GMSCameraPosition.cameraWithLatitude(41.889736,
            longitude: -87.63209, zoom: 10.0)
        googleMapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        googleMapView.myLocationEnabled = true
        googleMapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(41.889736, -87.63209 )
        marker.title = "Chicago"
        marker.snippet = "Illinois"
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
    
    
    
//    override func viewWillAppear(animated: Bool) {
//        googleMapView .addObserver(self, forKeyPath: "myLocation", options: 0, context: nil)
//        
//        func dealloc (){
//        googleMapView .removeObserver(self, forKeyPath: "myLocation")
//        }
//    }
//    
//    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "myLocation" {
//            myLocation = location.CLLocation
//            
//            CLLocationCoordinate2D target =
//        }
//    }

//    @IBAction func button(sender: UIBarButtonItem) {
//        placesClient?.currentPlaceWithCallback({
//            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            self.nameLabel.text = "No current place"
//            self.addressLabel.text = ""
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                let place = placeLikelihoodList.likelihoods.first?.place
//                if let place = place {
//                    self.nameLabel.text = place.name
//                    self.addressLabel.text = place.formattedAddress.componentsSeparatedByString(", ")
//                        .joinWithSeparator("\n")
//                }
//            }
//        })
//    }

    

        
    

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
}


    

    




