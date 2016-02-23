//
//  ViewController.swift
//
//
//  Created by Joseph Mouer on 2/22/16.
//
//

import UIKit
import GoogleMaps
import Google
import CoreLocation

var tableView: UITableView!

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var tableView: GMtableView!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var galleries = [NSDictionary]()
    
    var galleryArray  = [Gallery]()
    
    var latitude: Double!
    
    var mapTasks = MapTasks()
    
    var longitude: Double!
    
    var locationManager = CLLocationManager()
    
    var didFindMyLocation = false
    
    var locationMarker: GMSMarker!
    
    var markersArray: Array<GMSMarker> = []
    
    var placesClient: GMSPlacesClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        googleMapView.delegate = self
        
        googleMapView.settings.myLocationButton = true
        googleMapView.myLocationEnabled = true
        
        googleMapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        self.tableView.backgroundColor = UIColor.clearColor();
        self.tableView.rowHeight = 50
        
        
        let url = NSURL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=art_galleries+in+Chicago&key=AIzaSyDNopD2lCPhs0z-Uap3f8EPUt9R3gGjGjg")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (data , response, error ) -> Void in
            do {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    as! NSDictionary
                print(jsonDict)
                self.galleries = jsonDict ["results"] as! [NSDictionary]
                for dictionary in self.galleries {
                    let galleryObject:Gallery = Gallery(galleryDictionary: dictionary)
                    self.galleryArray.append(galleryObject)
                }
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
                
            }
            catch let error as NSError {
                print("jsonError: \(error.localizedDescription)")
                
            }
            
        }
        
        task.resume()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
            googleMapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
            googleMapView.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
    
    
    // MARK Change Map Type View
    
    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                self.googleMapView.mapType = GoogleMaps.kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
               self.googleMapView.mapType = GoogleMaps.kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                self.googleMapView.mapType = GoogleMaps.kGMSTypeHybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
    // MARK: TableView Implementation
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        let gallery = galleries[indexPath.row] as NSDictionary
        cell.textLabel?.text = gallery.objectForKey("name") as? String
        cell.textLabel?.numberOfLines = 0
        let address = galleries[indexPath.row] as NSDictionary
        cell.detailTextLabel?.text = address.objectForKey("formatted_address") as? String
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text
        let gallery = galleries[indexPath.row] as NSDictionary
        let address = gallery.objectForKey("formatted_address") as? String
        let lat = gallery.objectForKey("lat")
        let lng = gallery.objectForKey("lng")
        if let text = text {
            print("did select and the text is \(text)")
            print (address)
            print (lat)
            print (lng)
            
       //     let  position = CLLocationCoordinate2DMake(lat, lng)
        //    let marker = GMSMarker(position: position)
//            marker.title = "Hello World"
//            marker.map = googleMapView
            
        }
        
    }
    
    
    
}


