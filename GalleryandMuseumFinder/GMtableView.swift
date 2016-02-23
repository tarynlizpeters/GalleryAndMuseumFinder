//
//  GMtableView.swift
//  GalleryandMuseumFinder
//
//  Created by Joseph Mouer on 2/22/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation
import UIKit

class GMtableView: UITableView, UITableViewDelegate {
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        if (point.y<0){
            return nil
        }
        return hitView
    }
}