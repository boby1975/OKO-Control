//
//  StateController.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation

//Model controller
//Keeps the state of the objects
//Stores the objects data into the StorageController
class StateController {
    fileprivate let storageController: StorageController
    fileprivate(set) var objects: [Object]
    
    init(storageController: StorageController) {
        self.storageController = storageController
        self.objects = storageController.fetchObjects()
    }
    
    func add(_ object: Object) {
        objects.append(object)
        storageController.save(objects)
    }
    
    func remove(_ index: Int) {
        objects.remove(at: index)
        storageController.save(objects)
    }
    
    func update(_ object: Object, _ index: Int) {
        objects[index] = object
        storageController.save(objects)
    }
        
}
