//
//  Account.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation
import UIKit

//Represents the data of a object
//Converts to a property list dictionary and vice versa
struct Object {
    // saved properties
    let name: String
    let description: String
    let devicePhone: String
    let devicePassword: String
    var deviceType: DeviceType
    let objectIcon: ObjectIcon
    let extraSettings: [ExtraSetting]
    let events: [Event]
    let deviceIMEI: String
    let channel: Int
    
    //calculated properties
    var objectIconModel: ObjectIconModel {
        return ObjectIcon(rawValue: objectIcon.rawValue)!.typeSet()
    }
    
    var command1: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "06", image: #imageLiteral(resourceName: "light_on"), hidden: false)
        default: return MainCommandSet(smsCommand: "01", image: #imageLiteral(resourceName: "arm"), hidden: false)
        }
    }
    
    var command2: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "05", image: #imageLiteral(resourceName: "light_off"), hidden: false)
        default: return MainCommandSet(smsCommand: "00", image: #imageLiteral(resourceName: "disarm"), hidden: false)
        }
    }
    
    var command3: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "08", image: #imageLiteral(resourceName: "settings"), hidden: false)
        case .oko_avto, .oko_navi: return MainCommandSet(smsCommand: "06", image: #imageLiteral(resourceName: "block"), hidden: false)
        case .oko_s2, .obereg, .blits, .oko_u, .dom2 : return MainCommandSet(smsCommand: "06", image: #imageLiteral(resourceName: "light_on"), hidden: false)
            
        default: return MainCommandSet(smsCommand: "*#19", image: #imageLiteral(resourceName: "light_on"), hidden: false)
        }
    }
    
    var command4: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "02", image: #imageLiteral(resourceName: "refresh"), hidden: false)
        case  .oko_avto, .oko_navi: return MainCommandSet(smsCommand: "05", image: #imageLiteral(resourceName: "unblock"), hidden: false)
        case  .oko_s2, .obereg, .blits, .oko_u, .dom2: return MainCommandSet(smsCommand: "05", image: #imageLiteral(resourceName: "light_off"), hidden: false)
        default: return MainCommandSet(smsCommand: "*#10", image: #imageLiteral(resourceName: "light_off"), hidden: false)
        }
    }
    
    var command5: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "08", image: #imageLiteral(resourceName: "settings"), hidden: true)
        case .oko_avto, .oko_navi: return MainCommandSet(smsCommand: "04", image: #imageLiteral(resourceName: "location"), hidden: false)
        case .oko_s2, .obereg, .blits: return MainCommandSet(smsCommand: "08", image: #imageLiteral(resourceName: "settings"), hidden: false)
        case .oko_u, .dom2: return MainCommandSet(smsCommand: "09", image: #imageLiteral(resourceName: "settings"), hidden: false)
        default: return MainCommandSet(smsCommand: "012", image: #imageLiteral(resourceName: "home"), hidden: false)
        }
    }
    
    var command6: MainCommandSet {
        switch deviceType {
        case .oko_socket: return MainCommandSet(smsCommand: "02", image: #imageLiteral(resourceName: "refresh"), hidden: true)
        default: return MainCommandSet(smsCommand: "02", image: #imageLiteral(resourceName: "refresh"), hidden: false)
        }
    }
    
    
    
}





extension Object {
    
    enum Keys: String {
        case name
        case description
        case devicePhone
        case devicePassword
        case deviceType
        case objectIcon
        case events
        case extraSettings
        case deviceIMEI
        case channel
    }
    
    var plistRepresentation: [String: AnyObject] {
        return [
            Keys.name.rawValue: name as AnyObject,
            Keys.description.rawValue: description as AnyObject,
            Keys.devicePhone.rawValue: devicePhone as AnyObject,
            Keys.devicePassword.rawValue: devicePassword as AnyObject,
            Keys.deviceType.rawValue: deviceType.rawValue as AnyObject,
            Keys.objectIcon.rawValue: objectIcon.rawValue as AnyObject,
            Keys.events.rawValue: events.map { $0.plistRepresentation } as AnyObject,
            Keys.extraSettings.rawValue: extraSettings.map { $0.plistRepresentation } as AnyObject,
            Keys.deviceIMEI.rawValue: deviceIMEI as AnyObject,
            Keys.channel.rawValue: channel as AnyObject
        ]
    }
    
    init(plist: [String: AnyObject]) {
        name = plist[Keys.name.rawValue] as! String
        description = plist[Keys.description.rawValue] as! String
        devicePhone = plist[Keys.devicePhone.rawValue] as! String
        devicePassword = plist[Keys.devicePassword.rawValue] as! String
        deviceType = DeviceType(rawValue: plist[Keys.deviceType.rawValue] as! Int)!
        objectIcon = ObjectIcon(rawValue: plist[Keys.objectIcon.rawValue] as! Int)!
        
        events = (plist[Keys.events.rawValue] as! [[String: AnyObject]]).map(Event.init(plist:))
        extraSettings = (plist[Keys.extraSettings.rawValue] as! [[String: AnyObject]]).map(ExtraSetting.init(plist:))
        
        if let imei_ = plist[Keys.deviceIMEI.rawValue] as? String {
            deviceIMEI = imei_
        }
        else {
            deviceIMEI = ""
        }
        
        if let channel_ = plist[Keys.channel.rawValue] as? Int {
            channel = channel_
        }
        else {
            channel = 1
        }
        
    }
}




struct MainCommandSet {
    let smsCommand: String
    let image: UIImage
    let hidden: Bool
}

