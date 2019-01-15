//
//  State.swift
//  OKO-Control
//
//  Created by iMAC on 10.10.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit
import Foundation

class State {
    let storageController = StorageController()
    let appSettingsController = AppSettingsController()
    let stateController: StateController
    
    init() {
        stateController = StateController(storageController: storageController)
    }
}

protocol Stateful: class {
    var stateController: StateController! { get set }
}

protocol AppSettings: class {
    var appSettingsController: AppSettingsController! { get set }
}
