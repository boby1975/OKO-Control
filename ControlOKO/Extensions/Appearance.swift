//
//  Appearance.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

struct Appearance {
    static func setGlobalAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .skyBlue
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

extension UIColor {
    class var lightGrassGreen: UIColor {
        return UIColor(red: 171.0 / 255.0, green: 236.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
    
    class var skyBlue: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 199.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
    
    class var seafoamBlue: UIColor {
        return UIColor(red: 93.0 / 255.0, green: 220.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
    }
    
    class var liliac: UIColor {
        return UIColor(red: 201.0 / 255.0, green: 138.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var sunflowerYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 205.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var carnation: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 100.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    
    class var peach: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 169.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0)
    }
    
    class var slate: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 107.0 / 255.0, blue: 120.0 / 255.0, alpha: 1.0)
    }
    
    class var darkLimeGreen: UIColor {
        return UIColor(red: 111.0 / 255.0, green: 221.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class func color(for index: Int) -> UIColor {
        switch index % 6 {
        case 0: return .lightGrassGreen
        case 1: return .seafoamBlue
        case 2: return .liliac
        case 3: return .sunflowerYellow
        case 4: return .peach
        default: return .carnation
        }
    }
}




