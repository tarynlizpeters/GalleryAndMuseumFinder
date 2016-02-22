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
        let url = NSURL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=art+galleries+in+Chicago&key=AIzaSyDNopD2lCPhs0z-Uap3f8EPUt9R3gGjGjg")
        
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
//                    self.tableView.reloadData()
                }
                
            }
            catch let error as NSError {
                print("jsonError: \(error.localizedDescription)")
                
               
            }
             self.tableView.reloadData()
        }
        
        task.resume()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        let gallery = galleries[indexPath.row] as NSDictionary
        cell.textLabel?.text = gallery.objectForKey("name") as? String
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}
