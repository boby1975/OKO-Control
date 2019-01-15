//
//  InjectingSegue.swift
//  OKO-Control
//
//  Created by iMAC on 10.10.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

class InjectingSegue: UIStoryboardSegue {
    override func perform() {
        print ("PerfomSegue to \(destination)")
        destination.storyboard?.configure(viewController: destination)
        super.perform()
    }
}
