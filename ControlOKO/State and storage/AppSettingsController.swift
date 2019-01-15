//
//  Constans.swift
//  ControlOKO
//
//  Created by iMAC on 06.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//


import UIKit

class AppSettingsController {
    
    enum Keys: String {
        case AppPassword
        case Server
        case Port
    }
    
    let defaults = UserDefaults.standard
    
    var appPassword: String {
        get {
            return defaults.object(forKey: Keys.AppPassword.rawValue)  as! String
        }
        set {
            defaults.set(newValue, forKey: Keys.AppPassword.rawValue)
        }
    }
    
    var server: String {
        get {
            return defaults.object(forKey: Keys.Server.rawValue)  as! String
        }
        set {
            defaults.set(newValue, forKey: Keys.Server.rawValue)
        }
    }
    
    var port: Int {
        get {
            return defaults.object(forKey: Keys.Port.rawValue)  as! Int
        }
        set {
            defaults.set(newValue, forKey: Keys.Port.rawValue)
        }
    }
    
    init() {
        defaults.register(defaults: [Keys.AppPassword.rawValue: ""])
        defaults.register(defaults: [Keys.Server.rawValue: "ok.webhop.net"])
        defaults.register(defaults: [Keys.Port.rawValue: 31200])
    }
    
    
    
    func checkAppPasswordAlert_ (viewController: UIViewController) {
        print ("Check app password: \(viewController)")
        
        guard viewController.isOnScreen else {
            return
        }
        
        if appPassword == "" {
            return
        }
        
        let alert = UIAlertController(title: NSLocalizedString("Enter App Password", comment: ""), message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            $0.placeholder = NSLocalizedString("<App Password>", comment: "")
            $0.textAlignment = .center
            $0.isSecureTextEntry = true
            $0.keyboardType = .numbersAndPunctuation
            $0.enablesReturnKeyAutomatically = true
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }

        alert.addTextField {
            $0.text = self.appPassword
            $0.isHidden = true
        }
        
        let loginAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        
        loginAction.isEnabled = false
        alert.addAction(loginAction)

        viewController.present(alert, animated: true, completion: nil)
        
    }
    
}


