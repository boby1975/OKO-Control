//
//  ObjectIconPickerView.swift
//  OKO-Control
//
//  Created by iMAC on 21.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

class ObjectIconPickerView: UIPickerView {
    var objectIconDataList: [ObjectIconModel]!
    let customWidth: CGFloat = 50
    let customHeight: CGFloat = 50
    
}

extension ObjectIconPickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return objectIconDataList.count
    }
}

extension ObjectIconPickerView: UIPickerViewDelegate {
 
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView (frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        
        let objectIcon = UIImageView(frame: CGRect(x: 1, y: 1, width: customHeight-2, height: customHeight-2))
        objectIcon.image = objectIconDataList[row].objectIcon
        view.addSubview(objectIcon)
        
        view.transform  = CGAffineTransform(rotationAngle: 90*(.pi/180))
        
        return view
    }
    
}
