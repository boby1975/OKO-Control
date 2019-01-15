//
//  ObjectIconData.swift
//  OKO-Control
//
//  Created by iMAC on 21.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

//object icon data list
struct ObjectIconData {
    static func getData() -> [ObjectIconModel] {
        var iconDataList = [ObjectIconModel]()
        //object icon list forming
        var n = 0
        while let iconType = ObjectIcon(rawValue: n) {
            iconDataList.append(iconType.typeSet())
            n += 1
        }
        return iconDataList
    }
}

struct ObjectIconModel {
    let objectIcon: UIImage
    
    init (objectIcon: UIImage) {
        self.objectIcon = objectIcon
    }
}

//object icon
enum ObjectIcon: Int {
    case icon1 = 0
    case icon2
    case icon3
    case icon4
    case icon5
    case icon6
    case icon7
    case icon8
    case icon9
    case icon10
    case icon11
    case icon12
    case icon13
    case icon14
    case icon15
    case icon16
    case icon17
    case icon18
    case icon19
    case icon20
    case icon21
    case icon22
    case icon23
    case icon24
    case icon25
    case icon26
    case icon27
    case icon28
    case icon29
    case icon30
    case icon31
    case icon32
    case icon33
    case icon34
    case icon35
    case icon36
    case icon37
    case icon38
    case icon39
    case icon40
    case icon41
    case icon42
    case icon43
    case icon44
    case icon45
    case icon46
    case icon47
    case icon48
    case icon49
    case icon50
    case icon51
    case icon52
    case icon53
    case icon54
    case icon55
    case icon56
    case icon57
    case icon58
    case icon59
    case icon60
    case icon61
    case icon62
    case icon63
    case icon64
   
    
    func typeSet() -> ObjectIconModel {
        switch self {
        case .icon1:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "shuttle"))
        case .icon2:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "car"))
        case .icon3:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "shop"))
        case .icon4:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "truck"))
        case .icon5:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "warehouse"))
        case .icon6:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "bus"))
        case .icon7:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "house"))
        case .icon8:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "caretaker"))
        case .icon9:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "cargo_ship"))
        case .icon10:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "railcar"))
        case .icon11:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "pokemon"))
        case .icon12:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "shipped"))
        case .icon13:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "empty_box"))
        case .icon14:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "bumper"))
        case .icon15:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "cable_car"))
        case .icon16:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "camper"))
        case .icon17:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "car_rental"))
        case .icon18:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "garage"))
        case .icon19:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "suv"))
        case .icon20:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "taxi"))
        case .icon21:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "public_transportation"))
        case .icon22:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "pickup"))
        case .icon23:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "go_kart"))
        case .icon24:
            return ObjectIconModel(objectIcon:#imageLiteral(resourceName: "sedan") )
       case .icon25:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "department"))
        case .icon26:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "wagon"))
        case .icon27:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "convertible"))
        case .icon28:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "transportation"))
        case .icon29:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "tram"))
        case .icon30:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "airplane"))
        case .icon31:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "gas_station"))
        case .icon32:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "weigh_station"))
        case .icon33:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "carousel"))
        case .icon34:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "farm_house"))
        case .icon35:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "dog_house"))
        case .icon36:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "tree_house"))
        case .icon37:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "court_house"))
        case .icon38:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "washing_machine"))
        case .icon39:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "rent"))
        case .icon40:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "heating_room"))
        case .icon41:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "building"))
        case .icon42:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "building2"))
        case .icon43:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "depot"))
        case .icon44:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "bungalow"))
        case .icon45:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "interior"))
        case .icon46:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "wardrobe"))
        case .icon47:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "apartment"))
        case .icon48:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "log_cabin"))
        case .icon49:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "barn"))
        case .icon50:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "mobile_home"))
        case .icon51:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "exterior"))
        case .icon52:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "gate"))
        case .icon53:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "alert"))
        case .icon54:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "farm"))
        case .icon55:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "hangar"))
        case .icon56:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "prisoner"))
        case .icon57:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "monastery"))
        case .icon58:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "city_church"))
        case .icon59:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "library"))
        case .icon60:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "police_station"))
        case .icon61:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "server"))
        case .icon62:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "synagogue"))
        case .icon63:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "pagoda"))
        case .icon64:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "railwey_station"))
       

            
        default:
            return ObjectIconModel(objectIcon: #imageLiteral(resourceName: "arm")) //(self.rawValue)
        }
    }
    
}



