//
//  Comment.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/23/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation
import Firebase
class Comment {
    private var _commentRef: Firebase!
    private var _commentKey: String!
    private var _commentText: String!
    private var _commentVotes: Int!
    private var _username: String!
    
    var commentKey: String {
        return _commentKey
    }
    
    var commentText: String {
        return _commentText
    }
    
    var commentVotes: Int {
        return _commentVotes
    }
    
    var username: String {
        return _username
    }
    
    //initialize the new comment
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._commentKey = key
        // within the comment, or key, the following properties are children
        if let votes = dictionary["votes"] as? Int {
            self._commentVotes = votes
        }
        
        if let comment = dictionary["commentText"] as? String {
            self._commentText = comment
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        }else {
            self._username = ""
        }
        
        //the above properties are assigned to their key
        
        self._commentRef = DataService.dataService.COMMENT_REF.childByAppendingPath(self._commentKey)
    }
    
    
    //addSubtractVote(), in Joke.swift, uses the boolean value to add or subtract the vote from the joke. Then, Firebase’s setValue() method is used to update the vote in the Joke side of the database.
    func addSubtractVote(addVote: Bool) {
        if addVote {
            _commentVotes = _commentVotes + 1
        }else {
            _commentVotes = _commentVotes - 1
        }
        //save the new total
        _commentRef.childByAppendingPath("votes").setValue(_commentVotes)
    }
}