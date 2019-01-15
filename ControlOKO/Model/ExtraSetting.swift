//
//  Setting.swift
//  OKO-Control
//
//  Created by iMAC on 18.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation

struct ExtraSetting {
    
    let item: SettingItem
    let category: SettingCategory
    let type: SettingType
    let state: SettingState
    let id: Int
    let name: String
    let command: String
    let hidden: Bool
}

enum SettingItem: Int {
    case item1
    case item2
    case item3
    case item4
}

enum SettingCategory: Int {
    case mainboard
    case board_ext1
    case board_ext2
    case board_ext3
    case board_ext4
    
}

enum SettingType: Int {
    case input
    case output
    case power
    case arm
    case command
}

enum SettingState: Int {
    case on
    case off
    case norma
    case alarm
}

extension ExtraSetting {
    
    enum Keys: String {
        case id
        case name
        case command
        case hidden
        case item
        case type
        case state
        case category
    }
    
    var plistRepresentation: [String: AnyObject] {
        return [
            Keys.id.rawValue: id as AnyObject,
            Keys.name.rawValue: name as AnyObject,
            Keys.command.rawValue: command as AnyObject,
            Keys.hidden.rawValue: hidden as AnyObject,
            Keys.item.rawValue: item.rawValue as AnyObject,
            Keys.type.rawValue: type.rawValue as AnyObject,
            Keys.state.rawValue: state.rawValue as AnyObject,
            Keys.category.rawValue: category.rawValue as AnyObject
        ]
    }
    
    init(plist: [String: AnyObject]) {
        id = plist[Keys.id.rawValue] as! Int
        name = plist[Keys.name.rawValue] as! String
        command = plist[Keys.command.rawValue] as! String
        hidden = plist[Keys.hidden.rawValue] as! Bool
        item = SettingItem(rawValue: plist[Keys.item.rawValue] as! Int)!
        type = SettingType(rawValue: plist[Keys.type.rawValue] as! Int)!
        state = SettingState(rawValue: plist[Keys.state.rawValue] as! Int)!
        category = SettingCategory(rawValue: plist[Keys.category.rawValue] as! Int)!
    }
}

