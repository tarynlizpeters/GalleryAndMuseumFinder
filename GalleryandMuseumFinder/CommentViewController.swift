//
//  CommentViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Taryn Parker on 2/16/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//
//Here, the user will enter a joke, and we will send it to where it needs to go to display, instantly, on all devices.

import UIKit
import Firebase

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var mirrorToTextFieldLabel: UILabel!
    var currentUsername = ""
    var commentText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentText = commentTextField.text!
        self.mirrorToTextFieldLabel.text = commentText
        self.mirrorToTextFieldLabel.text = commentText
        //get the username of the currrent user, and set it to the currentUsername, so we can so we can add it to the joke.
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: {snapshot in
            if let currentUser = snapshot.value.objectForKey("username") {
                print("Username: \(currentUser)")
                self.currentUsername = currentUser as! String
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    
    
    @IBAction func saveComment(sender: AnyObject) {
        let commentText = commentTextField.text
        
        if commentText != "" {
            //build the new comment
            //anyobject is needed because of the votes of type int.
            
            let newComment: Dictionary<String, AnyObject> = [
                "commentText": commentText!,
                "votes": 0,
                "author": currentUsername
            ]
            
            //send it over to dataservice to seal the deal.
            DataService.dataService.createNewComment(newComment)
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
        }
    }
    
    
    
    
    
}