//
//  DeviceType.swift
//  OKO-Control
//
//  Created by iMAC on 20.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

//device type list
struct DeviceTypeData {
    static func getData() -> [DeviceTypeModel] {
        var typeDataList = [DeviceTypeModel]()
        //device type name list forming
        var n = 0
        while let deviceType = DeviceType(rawValue: n) {
            typeDataList.append(deviceType.typeSet())
            n += 1
        }
        return typeDataList
    }
}

struct DeviceTypeModel {
    let deviceName: String
    let deviceDescription: String
    let deviceImage: UIImage
    
    init (deviceName: String, deviceDescription: String, deviceImage: UIImage) {
        self.deviceName = deviceName
        self.deviceDescription = deviceDescription
        self.deviceImage = deviceImage
    }
}

enum DeviceType: Int {
    case oko_pro = 0
    case dom3
    case oko_u2
    case oko_7s
    case dom2_r2
    case oko_s2
    case oko_socket
    case oko_avto
    case oko_navi
    case oko_u
    case dom2
    case blits
    case obereg
    
    func typeSet() -> DeviceTypeModel {
        switch self {
        case .oko_pro:
            return DeviceTypeModel( deviceName: "OKO-PRO", deviceDescription: "oko-pro", deviceImage: #imageLiteral(resourceName: "oko_pro") )
        case .dom3:
            return DeviceTypeModel( deviceName: NSLocalizedString("DOM", comment: "") + "-3", deviceDescription: "dom3", deviceImage: #imageLiteral(resourceName: "dom3") )
        case .oko_u2:
            return DeviceTypeModel( deviceName: "OKO-U2", deviceDescription: "oko-u2", deviceImage: #imageLiteral(resourceName: "oko_u2"))
        case .oko_7s:
            return DeviceTypeModel( deviceName: "OKO-7S", deviceDescription: "oko-7s", deviceImage: #imageLiteral(resourceName: "oko_7s") )
        case .dom2_r2:
            return DeviceTypeModel( deviceName: NSLocalizedString("DOM", comment: "") + "-2 R2", deviceDescription: "dom2r2", deviceImage: #imageLiteral(resourceName: "dom2r2") )
        case .oko_s2:
            return DeviceTypeModel( deviceName: "OKO-S2", deviceDescription: "oko-s2", deviceImage: #imageLiteral(resourceName: "oko_s2") )
        case .oko_socket:
            return DeviceTypeModel( deviceName: NSLocalizedString("DOMOVOY", comment: "") + "-8C", deviceDescription: "oko-socket", deviceImage: #imageLiteral(resourceName: "domovoy"))
        case .oko_avto:
            return DeviceTypeModel( deviceName: "OKO-AVTO", deviceDescription: "oko-avto", deviceImage: #imageLiteral(resourceName: "avto") )
        case .oko_navi:
            return DeviceTypeModel( deviceName: "OKO-NAVI", deviceDescription: "oko-navi", deviceImage: #imageLiteral(resourceName: "navi"))
        case .oko_u:
            return DeviceTypeModel( deviceName: "OKO-U/S", deviceDescription: "oko-u/s", deviceImage: #imageLiteral(resourceName: "oko_u"))
        case .dom2:
            return DeviceTypeModel( deviceName: NSLocalizedString("DOM", comment: "") + "-2", deviceDescription: "dom2", deviceImage: #imageLiteral(resourceName: "dom2"))
        case .blits:
            return DeviceTypeModel( deviceName: NSLocalizedString("BLITS", comment: ""), deviceDescription: "blits", deviceImage: #imageLiteral(resourceName: "blits"))
        case .obereg:
            return DeviceTypeModel( deviceName: NSLocalizedString("OBEREG", comment: ""), deviceDescription: "obereg", deviceImage: #imageLiteral(resourceName: "obereg") )
        default:
            return DeviceTypeModel( deviceName: String(self.rawValue), deviceDescription: "unknown", deviceImage: #imageLiteral(resourceName: "car") )
            
        }
    }
    
}


