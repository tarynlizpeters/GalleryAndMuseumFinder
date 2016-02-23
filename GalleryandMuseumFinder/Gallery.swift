//
//  Galleries.swift
//  GalleryandMuseumFinder
//
//  Created by Joseph Mouer on 2/21/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import Foundation


class Gallery: NSObject {
    var name: String!
    var formattedAddress: String!
    var latitude: Double!
    var longitude: Double!
    
    
    
    init(galleryDictionary: NSDictionary) {
        
        name = galleryDictionary["name"] as! String
        formattedAddress = galleryDictionary["formatted_address"] as! String
       
        latitude = galleryDictionary["latitdue"] as! Double
        longitude = galleryDictionary["longitude"] as! Double
        
    }
}