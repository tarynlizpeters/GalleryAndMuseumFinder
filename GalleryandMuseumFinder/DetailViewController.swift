//
//  DetailViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Taryn Parker on 2/16/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var comments = [Comment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //observeEventType is called whenever anything changes  in the firebase - new jokes or votes.
        // its also called here in viewdidload().
        //It's always listening.
        DataService.dataService.COMMENT_REF.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            //the snapshot is a current look at our jokes data.
            print(snapshot.value)
            self.comments = []
            if let  snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    //make our comments array for the tableview.
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let comment = Comment(key: key, dictionary: postDictionary)
                        
                        //Items are returned chronlogically, but it's more fun with the newest jokes first.
                        self.comments.insert(comment, atIndex: 0)
                    }
                }
                
            }
            //be sure tableview updates when there is a new data.
            self.tableView.reloadData()
        })
    }

    
    
    

    
    
   // #progma delegates
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        //we are using a custom cell
        if let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? CommentCell {
            //send the single comment to the configureCell() in the CommentCell.
            cell.configureCell(comment)
            return cell
        }else {
            return CommentCell()
        }
    }
    
    
    
    
//    @IBAction func onSignOutTapped(sender: AnyObject) {
//        //unauth() is the logout method for the current user.
//        DataService.dataService.CURRENT_USER_REF.unauth()
//        
//        //remove the user's uid from storage
//        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
//        
//        //Head back to login
//        let loginViewcontroller = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
//        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewcontroller
//        print("method firing")
//
//    }
    
    
    
    

}
