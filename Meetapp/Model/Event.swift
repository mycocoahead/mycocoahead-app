//
//  Event.swift
//  Meetapp
//
//  Created by Azuan on 13/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFDateHelper
import RealmSwift

class Event: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var desc = ""
    dynamic var startTime = NSDate(timeIntervalSince1970: 1)
    dynamic var location: Location?
    dynamic var isFavorited = false


    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func setData(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        desc = json["description"].stringValue
        startTime = NSDate(fromString: json["start_time"].stringValue, format: .ISO8601(nil))
        location = Location()
        location!.setData(json["location"])
    }
}

class Location: Object {
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0
    dynamic var name = ""
    dynamic var street = ""
    dynamic var city = ""
    dynamic var country = ""
    
    func setData(json: JSON) {
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        name = json["name"].stringValue
        street = json["street"].stringValue
        city = json["city"].stringValue
        country = json["country"].stringValue
    }
}