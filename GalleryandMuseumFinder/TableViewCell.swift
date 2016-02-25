//
//  TableViewCell.swift
//  GalleryandMuseumFinder
//
//  Created by Joseph Mouer on 2/5/16.
//  Copyright © 2016 Joseph Mouer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isOpen: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
