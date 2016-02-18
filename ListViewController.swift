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

class GalleryListViewController: UIViewController, CLLocationManagerDelegate {
var locationManager = CLLocationManager()
   
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
    
    
    
}
