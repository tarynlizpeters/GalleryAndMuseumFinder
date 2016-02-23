//
//  CommentViewController.swift
//  GalleryandMuseumFinder
//
//  Created by Taryn Parker on 2/16/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var mirrorToTextFieldLabel: UILabel!
    var commentsText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentsText = commentTextField.text!
        self.mirrorToTextFieldLabel.text = commentsText
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
