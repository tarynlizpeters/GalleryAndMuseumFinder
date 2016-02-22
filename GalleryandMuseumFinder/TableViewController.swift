//
//  TableViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Joseph Mouer on 2/21/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var galleries = [NSDictionary]()
    var galleryArray  = [Gallery]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let url = NSURL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=galleries+in+Chicago&key=AIzaSyDUwrY1h6zZuVWvtvO9-tNcgz6sW361UrU")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (data , response, error ) -> Void in
            do {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    as! NSDictionary
                let resultsArray = jsonDict ["results"] as! NSArray
                for dictionary in resultsArray {
                    let newGalDict:Gallery = Gallery.init(galleryDictionary: dictionary as! NSDictionary)
                    self.galleryArray.append(newGalDict)
                }
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
                
            }
            catch let error as NSError {
                print("jsonError: \(error.localizedDescription)")
                
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        let gallery = galleries[indexPath.row]
        cell.textLabel!.text = gallery.objectForKey("location") as? String
        return cell
    }
    
    
}
