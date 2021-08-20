//
//  Planetary.swift
//  Photo Grid View
//
//  Created by Surya Pratap Singh on 18/08/21.
//

import UIKit

class Planetary {
    
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?
    
    init(dictionary: [String:Any]) {
        if dictionary.isEmpty {
            return
        }
        self.date = dictionary["date"] as? String ?? ""
        self.explanation = dictionary["explanation"] as? String ?? ""
        self.hdurl = dictionary["hdurl"] as? String ?? ""
        self.media_type = dictionary["media_type"] as? String ?? ""
        self.service_version = dictionary["service_version"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
    }
}
