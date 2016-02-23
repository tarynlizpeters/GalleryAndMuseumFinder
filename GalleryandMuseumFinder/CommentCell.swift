//
//  CommentCell.swift
//  GalleryandMuseumFinder
//
//  Created by Danny Vasquez on 2/23/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import Firebase
class CommentCell: UITableViewCell {
    
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalLikesLabel: UILabel!
    @IBOutlet weak var thumbVoteImage: UIImageView!
    var comment: Comment!
    var voteRef: Firebase!
    override func awakeFromNib() {
        super.awakeFromNib()
        //UITapGesture is set programmatically.
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }
    
    
    
    func configureCell(comment: Comment) {
        self.comment = comment
        //set the labels and the textView
        self.commentText.text = comment.commentText
        self.totalLikesLabel.text = "Total Likes: \(comment.commentVotes)"
        self.usernameLabel.text = comment.username
        
        //set the votes as a child of the current user in firebase and save the joke's
        voteRef = DataService.dataService.CURRENT_USER_REF.childByAppendingPath("votes").childByAppendingPath(comment.commentKey)
        //observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        voteRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let thumbsUpDown = snapshot.value as? NSNull {
                //current user hasn't voted for the comment yet.
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "disklike")
            }else {
                // current user liked the comment!
                self.thumbVoteImage.image = UIImage(named: "like")
            }
        })
    }
    
    
    
    func likeTapped(sender: UITapGestureRecognizer) {
        //observeSingleEventOfType listens for a tap by the current user.
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "dislike")
                //addSubtractVote in Comment.swift, handle the like(vote)
                self.comment.addSubtractVote(true)
                
                //setValue saves the vote(like) as true for the current user.
                //voteRef is a reference to the user's "votes" path.
                self.voteRef.setValue(true)
            }else {
                self.thumbVoteImage.image = UIImage(named: "like")
                self.comment.addSubtractVote(false)
                self.voteRef.removeValue()
            }
        })
    }
    
    
    
}