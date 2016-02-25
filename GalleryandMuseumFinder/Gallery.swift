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
    var stringLat: String!
    var stringLong: String!
    
    
    init(galleryDictionary: NSDictionary) {
        let geometryDictionary = galleryDictionary["geometry"]
        let locationDictionary = geometryDictionary!["location"]
    
        name = galleryDictionary["name"] as! String
        formattedAddress = galleryDictionary["formatted_address"] as! String
        latitude = locationDictionary!!["lat"] as! Double
        longitude = locationDictionary!!["lng"] as! Double
//        self.latitude = Double(self.stringLat)!
//        self.longitude = Double(self.stringLong)!
    }
}