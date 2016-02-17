//
//  DataService.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/17/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _COMMENT_REF = Firebase(url: "\(BASE_URL)/comments")
    let rootRef = Firebase(url: "gallerynmuseumfinder.firebaseIO.com")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var COMMENT_REF: Firebase {
        return _COMMENT_REF
    }
    
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        return currentUser
    }
    
    
    
    func createNewAccount(uid: String, user: Dictionary<String, AnyObject>) {
        USER_REF.childByAppendingPath(uid).setValue(user)
        
    }
    
    
    
    
    
    
    
}
