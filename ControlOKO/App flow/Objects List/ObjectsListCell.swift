//
//  ObjectsListCell.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

class ObjectsListCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var coloredView: UIView!
    @IBOutlet fileprivate weak var objectIconView: UIView!    
    @IBOutlet fileprivate weak var objectIconImage: UIImageView!
    
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            nameLabel.text = model.name
            descriptionLabel.text = model.description
            coloredView.backgroundColor = model.color
            objectIconImage.image = model.iconImage
        }
    }
}

extension ObjectsListCell {
    struct Model {
        let name: String
        let description: String
        let color: UIColor
        let iconImage: UIImage
        
        init(object: Object, index: Int) {
            name = object.name
            description = object.description 
            color = UIColor.color(for: index)
            iconImage = object.objectIconModel.objectIcon
        }
    }
}

