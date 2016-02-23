//
//  InitialViewController.swift
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

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: GMtableView!
    
    @IBOutlet var googleMapView: GMSMapView!
    
    var galleries = [NSDictionary]()
    var galleryArray  = [Gallery]()
    var latitude: Double!
    var longitude: Double!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        
        
        self.tableView.backgroundColor = UIColor.clearColor();
        self.tableView.rowHeight = 80
        
        
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
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < self.googleMapView.frame.size.height * -1 ) {
            scrollView .setContentOffset(CGPointMake(scrollView.contentOffset.x, self.googleMapView.frame.size.height * -1), animated: true)
        }
    }
    
}



