//
//  StorageController.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import Foundation

//Model controller
class StorageController {
    fileprivate let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    fileprivate var objectsFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("Objects")
            .appendingPathExtension("plist")
    }
    
    func save(_ objects: [Object]) {
        let objectsPlist = objects.map { $0.plistRepresentation } as NSArray
        objectsPlist.write(to: objectsFileURL, atomically: true)
    }
    
    func fetchObjects() -> [Object] {
        guard let objectPlists = NSArray(contentsOf: objectsFileURL) as? [[String: AnyObject]] else {
            return []
        }
        return objectPlists.map(Object.init(plist:))
    }
}
