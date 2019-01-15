//
//  Transaction.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation

enum EventCategory: Int {
    case ingoing_sms
    case outgoing_sms
    case ingoing_data
    case outgoing_data

}

struct Event {
    
    let date: Date
    let category: EventCategory
    let code: Int
    let description: String
    
}

extension Event {
    
    enum Keys: String {
        case code
        case description
        case date
        case category
    }
    
    var plistRepresentation: [String: AnyObject] {
        return [
            Keys.code.rawValue: code as AnyObject,
            Keys.description.rawValue: description as AnyObject,
            Keys.date.rawValue: date as AnyObject,
            Keys.category.rawValue: category.rawValue as AnyObject
        ]
    }
    
    init(plist: [String: AnyObject]) {
        code = plist[Keys.code.rawValue] as! Int
        description = plist[Keys.description.rawValue] as! String
        date = plist[Keys.date.rawValue] as! Date
        category = EventCategory(rawValue: plist[Keys.category.rawValue] as! Int)!
    }
}

