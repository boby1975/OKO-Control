//
//  CreateObjectViewController.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit
import os.log

class CreateObjectViewController: UIViewController, Stateful {
    
    //MARK: Properties
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var descriptionTextField: UITextField!
    @IBOutlet fileprivate weak var devicePhoneTextField: UITextField!
    @IBOutlet fileprivate weak var devicePasswordTextField: UITextField!
    @IBOutlet fileprivate weak var deviceTypePickerView: UIPickerView!
    @IBOutlet fileprivate weak var objectIconPickerView: UIPickerView!
    @IBOutlet fileprivate weak var saveButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var cancelButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var deleteObjectButton: UIButton!
    @IBOutlet fileprivate weak var MainStackView: UIStackView!
    @IBOutlet fileprivate weak var objectIconPickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var objectIconPickerTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var deviceTypePickerTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var deviceTypePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var deviceIMEITextField: UITextField!
    @IBOutlet fileprivate var checkLabels: [UILabel]!
    @IBOutlet fileprivate var viaButtons: [UIButton]!
    
    var stateController: StateController!
    //var appSettingsController: AppSettingsController!
    
    var object: Object?
    
    var selectedIndex: Int?
    var selectedChannel = 1
    var editObjectMode = false
    
    
    var deviceTypePicker: DeviceTypePickerView!
    var objectIconPicker: ObjectIconPickerView!
    
    fileprivate var observers: [NSObjectProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("CreateObjectDidLoad")
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        devicePhoneTextField.delegate = self
        devicePasswordTextField.delegate = self
        deviceIMEITextField.delegate = self
        
        //device type picker
        deviceTypePicker = DeviceTypePickerView()
        deviceTypePicker.selectPickerRowDelegate = self
        deviceTypePicker.deviceTypeDataList = DeviceTypeData.getData()
        deviceTypePickerView.transform = CGAffineTransform(rotationAngle: -90*(.pi/180)) //for horizontal picker
        deviceTypePickerView.delegate = deviceTypePicker
        deviceTypePickerView.dataSource = deviceTypePicker
        deviceTypePickerView.selectRow(3, inComponent: 0, animated: true)
        
        
        //object icon picker
        objectIconPicker = ObjectIconPickerView()
        objectIconPicker.objectIconDataList = ObjectIconData.getData()
        objectIconPickerView.transform = CGAffineTransform(rotationAngle: -90*(.pi/180)) //for horizontal picker
        objectIconPickerView.delegate = objectIconPicker
        objectIconPickerView.dataSource = objectIconPicker
        objectIconPickerView.selectRow(6, inComponent: 0, animated: true)
    
        
        
        //check if update mode - update views
        if let object = object {
            editObjectMode = true
            deleteObjectButton.isHidden = false
            navigationItem.title = object.name
            objectIconPickerView.selectRow(object.objectIcon.rawValue, inComponent: 0, animated: true)
            nameTextField.text   = object.name
            descriptionTextField.text = object.description
            deviceTypePickerView.selectRow(object.deviceType.rawValue, inComponent: 0, animated: true)
            devicePhoneTextField.text = object.devicePhone
            devicePasswordTextField.text = object.devicePassword
            deviceIMEITextField.text = object.deviceIMEI
            selectOption(at: object.channel)
            
        }
        else {
            //new object
            selectOption(at: selectedChannel)
            deleteObjectButton.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerNotifications()
        
        deviceTypePickerHeightConstraint.constant = view.frame.width
        deviceTypePickerTopConstraint.constant = 20 + 150/2 - view.frame.width/2
        deviceTypePickerView.layoutIfNeeded()
        
        objectIconPickerHeightConstraint.constant = view.frame.width
        objectIconPickerTopConstraint.constant = 5 + 50/2 - view.frame.width/2
        objectIconPickerView.layoutIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterNotifications()
    }
    
    //MARK: Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard identifier == "SaveObjectSegue" else {
            return true
        }
        guard nameTextField.text?.characters.count == 0 ||
            devicePhoneTextField.text?.characters.count == 0 ||
            devicePasswordTextField.text?.characters.count == 0 ||
            (deviceIMEITextField.text?.characters.count == 0 && selectedChannel == 0 ) else {
            return true
        }
        
        let title = NSLocalizedString("Missing value!", comment: "")
        let message = NSLocalizedString("Enter all fields", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        return false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveObjectSegue" else {            
            print ("Exit")
            return
        }
        if let selectedDeviceType = DeviceType(rawValue: deviceTypePickerView.selectedRow(inComponent: 0)),
            let selectedObjectIcon = ObjectIcon(rawValue: objectIconPickerView.selectedRow(inComponent: 0) ) {
                
            let object = Object(name: nameTextField.text ?? "", description: descriptionTextField.text ?? "", devicePhone: devicePhoneTextField.text ?? "", devicePassword: devicePasswordTextField.text ?? "", deviceType: selectedDeviceType,  objectIcon: selectedObjectIcon, extraSettings: [], events: [], deviceIMEI: deviceIMEITextField.text ?? "", channel: selectedChannel)
        
            if editObjectMode {
                stateController.update(object, selectedIndex!)
                print ("Update object")
            }
            else {
                stateController.add(object)
                print ("Save new object")
            }
        }
        else {
            print("Exit without saving")
        }
        
    }
    
    
    //MARK: Actions
    
    @IBAction func deleteObject(_ sender: Any) {
        print ("Delete object button pressed")
        
        //alert message
        let alertController = UIAlertController(title: nil, message:
            NSLocalizedString("Object", comment: "") + " \"" + nameTextField.text! + "\" " + NSLocalizedString("will be deleted!!!", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        
        
        let deleteObjectAction = UIAlertAction(
        title: NSLocalizedString("Delete", comment: ""), style: UIAlertActionStyle.destructive) {
            (action) -> Void in

            self.deleteObject()
        }
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.default,handler: nil))
        
        alertController.addAction(deleteObjectAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func changeVia(_ sender: UIButton) {
        
        //select options
        let index = viaButtons.index(of: sender)!
        selectOption(at: index)
        print ("index: \(index)")
    }
    
    
    //MARK: Private Methods

    func deleteObject() {
        stateController.remove(selectedIndex!)
        print ("Delete object \"" + nameTextField.text! + "\" with index: " + String(describing: selectedIndex))
        performSegue(withIdentifier: "CancelObjectSegue", sender: self)
        
    }
    
}


extension CreateObjectViewController: DidSelectPickerRowDelegate{
    
    //MARK: DidSelectPickerRowDelegate
    func didSelectPickerRow(row: Int) {
        print("select device type row: " + String(row))
    }
    
}


extension CreateObjectViewController: UITextFieldDelegate {
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            navigationItem.title = textField.text
        }
    }
    
}

private extension CreateObjectViewController {
    
    //MARK: Privat method
    func registerNotifications() {
        let defaultCenter = NotificationCenter.default
        let appPasswordObserver = defaultCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil, using: { _ in
            //self.appSettingsController.checkAppPasswordAlert(viewController: self)
            self.storyboard?.checkAppPasswordAlert(viewController: self)
        })
        observers = [appPasswordObserver]
    }
    
    func unregisterNotifications() {
        observers.forEach({ NotificationCenter.default.removeObserver($0) })
    }
    
    func selectOption(at index: Int) {
        selectedChannel = index
        for (labelIndex, label) in checkLabels.enumerated() {
            label.isHidden = index != labelIndex
        }
    }
    
}
