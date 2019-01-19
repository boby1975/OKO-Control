//
//  ObjectViewController.swift
//  ControlOKO
//
//  Created by iMAC on 06.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit
import MessageUI
import AudioToolbox

class ObjectViewController: UIViewController, AppSettings {

    //MARK: Properties
    @IBOutlet weak var armImage: UIImageView!
    @IBOutlet weak var disarmImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var refreshImage: UIImageView!
    @IBOutlet weak var releOnImage: UIImageView!
    @IBOutlet weak var releOffImage: UIImageView!
       
    var object: Object!
    var appSettingsController: AppSettingsController!
    var selectedIndex: Int!
    
    var tcpClient: Socket?
    fileprivate var observers: [NSObjectProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("ObjectDidLoad")
        if object.channel == 0 {
            tcpClient = Socket(server: appSettingsController.server, port: appSettingsController.port )
            tcpClient?.delegate = self
        }
        
        // Do any additional setup after loading the view.
        navigationItem.title = object.name
        
        setGestureRecognizer()
        
        armImage.image = object.command1.image
        disarmImage.image = object.command2.image
        releOnImage.image = object.command3.image
        releOffImage.image = object.command4.image
        homeImage.image = object.command5.image
        refreshImage.image = object.command6.image
        
        armImage.isHidden = object.command1.hidden
        disarmImage.isHidden = object.command2.hidden
        releOnImage.isHidden = object.command3.hidden
        releOffImage.isHidden = object.command4.hidden
        homeImage.isHidden = object.command5.hidden
        refreshImage.isHidden = object.command6.hidden
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("ObjectViewController WillAppear")
        registerNotifications()
        startSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("ObjectViewController DidDisappear")
        unregisterNotifications()
        stopSession()
    }
    
    
    
    //MARK: Actions
    func tapOneAct(sender: UITapGestureRecognizer){
        
        if let tag = sender.view?.tag {
            
            var command=""
            switch tag {
            case 1:
                print("Command1 Tapped")
                command=object.command1.smsCommand
            case 2:
                print("Command2 Tapped")
                command=object.command2.smsCommand
            case 3:
                print("Command3 Tapped")
                command=object.command3.smsCommand
            case 4:
                print("Command4 Tapped")
                command=object.command4.smsCommand
            case 5:
                print("Command5 Tapped")
                command=object.command5.smsCommand
            case 6:
                print("Command6 Tapped")
                command=object.command6.smsCommand
            default:
                print("Nothing Tapped")
            }
            
            switch object.channel {
            case 0:
                //via internet
                sendInternetCommand(password: object.devicePassword, command: command, imei: object.deviceIMEI)
                break
                
            case 1:
                //via SMS
                sendSMSCommand(command: object.devicePassword + command, phone: object.devicePhone)
                break
                
            default:
                break
            }
            
        }
    }
    
    
    //MARK: Private Methods
    func setGestureRecognizer() {
        let tapGestureArmImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        let tapGestureDisarmImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        let tapGestureHomeImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        let tapGestureRefreshImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        let tapGestureReleOnImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        let tapGestureReleOffImage = UITapGestureRecognizer(target: self, action: #selector(tapOneAct(sender:)))
        
        //add gesture into Views.
        armImage.isUserInteractionEnabled=true
        armImage.tag = 1
        armImage.addGestureRecognizer(tapGestureArmImage)
        
        disarmImage.isUserInteractionEnabled=true
        disarmImage.tag = 2
        disarmImage.addGestureRecognizer(tapGestureDisarmImage)
        
        releOnImage.isUserInteractionEnabled=true
        releOnImage.tag = 3
        releOnImage.addGestureRecognizer(tapGestureReleOnImage)
        
        releOffImage.isUserInteractionEnabled=true
        releOffImage.tag = 4
        releOffImage.addGestureRecognizer(tapGestureReleOffImage)
        
        homeImage.isUserInteractionEnabled=true
        homeImage.tag = 5
        homeImage.addGestureRecognizer(tapGestureHomeImage)
        
        refreshImage.isUserInteractionEnabled=true
        refreshImage.tag = 6
        refreshImage.addGestureRecognizer(tapGestureRefreshImage)
    }
    
    
    func sendSMSCommand(command: String="", phone: String="") {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            
            controller.body = command
            controller.recipients = [phone]
            
            self.present(controller, animated: true, completion: nil)
        }
        else {
            print("SMS services are not available")
            
            //alert message
            let alertController = UIAlertController(title: nil, message:
                NSLocalizedString("SMS services are not available", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func sendInternetCommand(password: String, command: String, imei: String) {
        if (tcpClient?.socketIsOpen)! {
            tcpClient?.sendMessage(message: "{" + imei + "/COMMAND:"  + password + command + ";/iOS_OKO-Control}\n")
        }
        else {
            self.view.makeToast(NSLocalizedString("No connection to server", comment: ""), duration: 1)
        }
        
    }
    
    func registerNotifications() {
        let defaultCenter = NotificationCenter.default
        let appPasswordObserver = defaultCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil, using: { _ in
            self.storyboard?.checkAppPasswordAlert(viewController: self)
            self.startSession()
        })
        observers = [appPasswordObserver]
    }
    
    func unregisterNotifications() {
        observers.forEach({ NotificationCenter.default.removeObserver($0) })
    }
    
    func startSession() {
        if object.channel == 0 {
            self.view.makeToast(NSLocalizedString("Try connect to server", comment: ""), duration: 0.2)
            tcpClient?.setupNetworkCommunication()
        }
    }
    
    func stopSession() {
        if object.channel == 0 {
            tcpClient?.stopSession()
            self.view.makeToast(NSLocalizedString("Stop session", comment: ""), duration: 0.2)
        }
    }
    
}

extension ObjectViewController: MFMessageComposeViewControllerDelegate {
    
    //MARK: MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        var msg=""
        // Check the result or perform other tasks.
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            msg = NSLocalizedString("Message was cancelled", comment: "")
        case MessageComposeResult.failed.rawValue:
            msg = NSLocalizedString("Message failed", comment: "")
        case MessageComposeResult.sent.rawValue:
            msg = NSLocalizedString("Message was sent", comment: "")
        default:
            break;
        }
        print(msg)
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil) //self.
        self.view.makeToast(msg, duration: 1)
    }
    
}

extension ObjectViewController: SocketStreamDelegate {
    //MARK: SocketStreamDelegate
    func socketDidConnect(stream:Stream) {
        sendInternetCommand(password: object.devicePassword, command: "70", imei: object.deviceIMEI)
        self.view.makeToast(NSLocalizedString("Connected to server", comment: ""), duration: 0.2)
    }
    
    func socketDidReceiveMessage(stream:Stream, message:String) {
        print ("Received: \(message)")
        if message.starts(with: "{" + object.deviceIMEI + ",") {
            var msg = ""
            let messageArray = message.split(separator: ",")
            switch messageArray[1] {
            case "20", "0020": //dec32
                msg = "Armed"
                break
            case "21", "0021": //dec33
                msg = "Disarmed"
                break
            case "28", "0028", "01B6": //dec40
                msg = "Rele ON"
                break
            case "29", "0029", "01B7": //dec41
                msg = "Rele OFF"
                break
            case "FE","00FE": //dec254
                //msg = "Device ACK"
                break
            default:
                break
            }
            if msg != "" {
                self.view.makeToast(NSLocalizedString(msg, comment: ""), duration: 3)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // vibration
                
            }
        }
        if message.starts(with: "COMMAND:") {
            self.view.makeToast(NSLocalizedString("Server ACK", comment: ""), duration: 0.2)
        }
        
    }
    
    func socketErrorOccurred(stream:Stream) {
        self.view.makeToast(NSLocalizedString("Socket error", comment: ""), duration: 1)
        //restart session
        startSession()
    }
    
    func socketDidSendMessage(message:String) {
        self.view.makeToast(NSLocalizedString("Send command", comment: ""), duration: 0.5)
        
    }
}
