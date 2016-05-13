//
//  BaseAPI.swift
//  Meetapp
//
//  Created by Azuan on 13/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

class BaseAPI {
    let baseURL = "http://malaysia.herokuapp.com/api/"
    
    func withURL(url: String) -> String {
        return "\(baseURL)\(url)"
    }
}
