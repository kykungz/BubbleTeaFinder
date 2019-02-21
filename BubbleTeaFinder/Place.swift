//
//  Place.swift
//  BubbleTeaFinder
//
//  Created by Kongpon Charanwattanakit on 14/2/2562 BE.
//  Copyright © 2562 Kongpon Charanwattanakit. All rights reserved.
//

import GoogleMaps
import Foundation

class Place {
    let name: String
    let location: CLLocationCoordinate2D
    init(venue: [String: Any]) {
        self.name = venue["name"] as? String ?? ""
        let rawLocation = venue["location"] as? [String: Any] ?? [:]
        let lat = rawLocation["lat"] as? Double ?? 0.0
        let lng = rawLocation["lng"] as? Double ?? 0.0
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
