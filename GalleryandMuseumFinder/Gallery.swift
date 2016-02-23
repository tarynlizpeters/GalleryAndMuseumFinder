//
//  Galleries.swift
//  GalleryandMuseumFinder
//
//  Created by Joseph Mouer on 2/21/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation


class Gallery {
    var name: String!
    var formattedAddress: String!
    
    
    init(galleryDictionary: NSDictionary) {
        
        name = galleryDictionary["name"] as! String
        formattedAddress = galleryDictionary["formatted_address"] as! String
        
    }
}