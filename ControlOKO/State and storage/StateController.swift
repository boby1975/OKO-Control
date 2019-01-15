//
//  StateController.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation

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
    
    /*
    func update(_ object: Object) {
        for (index, storedObject) in objects.enumerated() {
            guard storedObject.name == object.name else {
                continue
            }
            objects[index] = object
            storageController.save(objects)
            break
        }
    }
    */
    
}
