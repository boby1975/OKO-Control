//
//  UIStoryboard.swift
//  OKO-Control
//
//  Created by iMAC on 10.10.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

//Creates the global instances of the model controllers
fileprivate let globalState = State()

extension UIStoryboard {
    fileprivate var state: State {
        return globalState
    }
    
    //performs dependency injection
    func configure(viewController: UIViewController) {
        
        print ("UIStoryboard dependency injection: \(viewController)")
        
        if let navigationController = viewController as? UINavigationController {
            //to hook dependency injection to the first view controller
            navigationController.viewControllers.first.map(configure(viewController:))
        }
        if let tabBarController = viewController as? UITabBarController {
            //to hook dependency injection to the first contained view controller
            tabBarController.viewControllers?.first.map(configure(viewController:))
            //to hook dependency injection to the new contained view controller
            tabBarController.delegate = self
        }
        
        //to hook dependency injection to view controller by storyboard segues with class InjectingSegue
        if let statefulController = viewController as? Stateful {
            statefulController.stateController = state.stateController
        }
        if let appSettingsController = viewController as? AppSettings {
            appSettingsController.appSettingsController = state.appSettingsController
        }

    }
}

//Every time a new contained view controller comes on screen, the tab bar controller notifies its delegate. This is where we can hook our dependency injection to the contained view controller
extension UIStoryboard: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print ("UIStoryboard UITabBarControllerDelegate dependency injection: \(tabBarController)")
        configure(viewController: viewController)
        return true
    }
}

extension UIStoryboard {
    
    func checkAppPasswordAlert (viewController: UIViewController) {
        print ("Check app password: \(viewController)")
        
        guard viewController.isOnScreen else {
            return
        }
        
        if state.appSettingsController.appPassword == "" {
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
            $0.text = self.state.appSettingsController.appPassword
            $0.isHidden = true
        }
        
        let loginAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        
        loginAction.isEnabled = false
        alert.addAction(loginAction)
        
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func editAppPasswordAlert (viewController: UIViewController) {
        
        print ("Edit app password")
        
        let appPassword = state.appSettingsController.appPassword
        var appPasswordTextField: UITextField?
        
        let alertController = UIAlertController(
            title: NSLocalizedString("Settings", comment: ""),
            message: NSLocalizedString("Enter app password (empty - OFF).", comment: ""),
            preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelSettingsAction = UIAlertAction(
        title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.default) {
            (action) -> Void in
            print ("Cancel app password settings")
        }
        
        let setSettingsAction = UIAlertAction(
        title: NSLocalizedString("Save", comment: ""), style: UIAlertActionStyle.destructive) {
            (action) -> Void in
            
            if let appPassword = appPasswordTextField?.text {
                print("App Password = \(appPassword)")
                self.state.appSettingsController.appPassword = appPassword
            } else {
                print("No app Password entered")
            }
            
        }
        
        alertController.addTextField {
            (txtAppPassword) -> Void in
            appPasswordTextField = txtAppPassword
            appPasswordTextField!.isSecureTextEntry = true
            appPasswordTextField?.textAlignment = .center
            appPasswordTextField!.placeholder = NSLocalizedString("<App password here>", comment: "")
            appPasswordTextField?.text = appPassword
            appPasswordTextField?.keyboardType = .numbersAndPunctuation
            appPasswordTextField?.enablesReturnKeyAutomatically = true
            
        }
        
        alertController.addAction(cancelSettingsAction)
        alertController.addAction(setSettingsAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
}

extension UIViewController {
    var isOnScreen: Bool {
        return isViewLoaded && view.window != nil
    }
}

extension UIAlertController {
    func textDidChangeInLoginAlert() {
        if let password = textFields?[0].text, let appPassword = textFields?[1].text,
            let action = actions.last {
            action.isEnabled =  password == appPassword
        }
        
    }
}


