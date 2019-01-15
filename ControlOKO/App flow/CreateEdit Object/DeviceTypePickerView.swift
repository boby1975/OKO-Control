//
//  DeviceTypePicker.swift
//  OKO-Control
//
//  Created by iMAC on 20.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

protocol DidSelectPickerRowDelegate {
    func didSelectPickerRow(row: Int)
}

class DeviceTypePickerView: UIPickerView {
    var deviceTypeDataList: [DeviceTypeModel]!
    var selectPickerRowDelegate: DidSelectPickerRowDelegate!
    let customWidth: CGFloat = 150
    let customHeight: CGFloat = 150
    
}

extension DeviceTypePickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return deviceTypeDataList.count
    }
}

extension DeviceTypePickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView (frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        
        let deviceName = UILabel(frame: CGRect(x: 0, y: 0, width: customWidth, height: 15))
        deviceName.text = deviceTypeDataList[row].deviceName
        deviceName.textAlignment = .center
        deviceName.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        view.addSubview(deviceName)
        
        
        let deviceImage = UIImageView(frame: CGRect(x: 5, y: 15, width: customWidth-10, height: customWidth-15))
        deviceImage.image = deviceTypeDataList[row].deviceImage
        view.addSubview(deviceImage)
        
        view.transform  = CGAffineTransform(rotationAngle: 90*(.pi/180))
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //NotificationCenter.default.post(name: .deviceTypePickerChanged, object: self)
        selectPickerRowDelegate?.didSelectPickerRow(row: row)
    }
}
