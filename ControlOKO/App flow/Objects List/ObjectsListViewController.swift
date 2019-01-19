//
//  ObjectsListViewController.swift
//  OKO-Control
//
//  Created by iMAC on 15.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit

class ObjectsListViewController: UIViewController, Stateful {
    
    //MARK: Properties
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var appPasswordButton: UIButton!
    
    
    var stateController: StateController!
    //var appSettingsController: AppSettingsController!
    
    fileprivate var dataSource: ObjectsListDataSource!
    var editObjectMode = false
    
    fileprivate var observers: [NSObjectProtocol] = []
    
    //This method is called only once in the lifetime of a view controller, so you use it for things that need to happen only once.
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("ObjectListDidLoad")
        tableView.delegate = self
        
        //table row autoresize
        tableView.estimatedRowHeight = 122.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //You override this method for tasks that need you need to  repeat every time a view controller comes on screen. Keep in mind that this method can be called multiple times for the same instance of a view controller.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
        dataSource = ObjectsListDataSource(objects: stateController.objects)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    //This method gets called after the view controller appears on screen. You can use it to start animations in the user interface, to start playing a video or a sound, or to start collecting data from the network.
    //viewDidAppear(_:)
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterNotifications()
    }

    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "CreateObjectSegue":
            print ("CreateObjectSegue")

        case "EditObjectSegue":
            print ("EditObjectSegue")
            if let navigationController = segue.destination as? UINavigationController,
                let createObjectViewController = navigationController.viewControllers.first as? CreateObjectViewController,
                let selectedIndex = tableView.indexPathForSelectedRow?.row {
                
                let object = dataSource.object(at: selectedIndex)
                createObjectViewController.object = object
                createObjectViewController.selectedIndex = selectedIndex
            }
            
        case "ObjectSegue":
            print ("ObjectSegue")
            if let objectViewController = segue.destination as? ObjectViewController,
                let selectedIndex = tableView.indexPathForSelectedRow?.row {
                
                let object = dataSource.object(at: selectedIndex)
                objectViewController.object = object
                objectViewController.selectedIndex = selectedIndex

            }
            
        default:
            print ("segue ID: " + segue.identifier!)
            break
        }
    }
    
    //MARK: Unwind segue
    @IBAction func cancelObjectCreation(_ segue: UIStoryboardSegue) {}
    @IBAction func saveObject(_ segue: UIStoryboardSegue) {}
    
    
    //MARK: Actions
    @IBAction func setEditMode(_ sender: UIBarButtonItem) {
        
        //print (navigationItem.leftBarButtonItem)
        
        if !editObjectMode {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ObjectsListViewController.setEditMode(_:)))
            print ("Edit click")
            editObjectMode = true
        }
        else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ObjectsListViewController.setEditMode(_:)))
            print ("Done click")
            editObjectMode = false
        }
        
    }
    
    @IBAction func editAppPassword(_ sender: UIButton) {
        self.storyboard?.editAppPasswordAlert(viewController: self)
    }
    

}



extension ObjectsListViewController: UITableViewDelegate {
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)");
        
        if !editObjectMode {
            performSegue(withIdentifier: "ObjectSegue", sender: self)
        }
        else {
            performSegue(withIdentifier: "EditObjectSegue", sender: self)
        }
    }
    
}

private extension ObjectsListViewController {
    
    //MARK: Privat method
    func registerNotifications() {
        let defaultCenter = NotificationCenter.default
        let appPasswordObserver = defaultCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil, using: { _ in
            self.storyboard?.checkAppPasswordAlert(viewController: self)
        })
        observers = [appPasswordObserver]
    }
    
    func unregisterNotifications() {
        observers.forEach({ NotificationCenter.default.removeObserver($0) })
    }
    
}
