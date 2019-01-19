//
//  ObjectsListDataSource.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

class ObjectsListDataSource: NSObject {
    fileprivate let objects: [Object]
    
    init(objects: [Object]) {
        self.objects = objects
    }
    
    func object(at index: Int) -> Object {
        return objects[index]
    }
    
}

extension ObjectsListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectsListCell", for: indexPath) as! ObjectsListCell
        let index = indexPath.row
        let object = self.object(at: index)
        cell.model = ObjectsListCell.Model(object: object, index: index)
        return cell
    }
    
}
