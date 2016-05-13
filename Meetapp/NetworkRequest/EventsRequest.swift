//
//  EventsRequest.swift
//  Meetapp
//
//  Created by Azuan on 13/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class EventsRequest: BaseAPI {
    let realm = try! Realm()
    func getAllEvents(completionHandler: (_: Void) -> Void) {
       Alamofire.request(.GET, withURL("events"))
        .responseJSON(completionHandler: { response in
            for (_, json) in JSON(response.result.value!)["events"] {
                let event = Event()
                event.setData(json)
                
                try! self.realm.write{
                    self.realm.add(event, update: true)
                }
            }

            completionHandler()
        })
    }
}
