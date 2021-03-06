//
//  OnTheMapController.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation
import UIKit

class OnTheMapController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if StudentLocationModel.studentLocations.count == 0 {
            loadStudentLocations()
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewPin))
        self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshPins)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reload()
    }
    
    @objc fileprivate func logout(){
        UdacityClient.logout()
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func refreshPins() {
        print("refresh")
        loadStudentLocations()
    }
    
    @objc fileprivate func addNewPin() {
        print("addNewPin")
        performSegue(withIdentifier: "addLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "CANCEL", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    func loadStudentLocations() {
        StudentLocationClient.getStudentLocations { (locations, error) in
            StudentLocationModel.studentLocations = locations
            self.reload()
        }
    }
    
    func openUrl(url: String) {
        let app = UIApplication.shared
        if let toOpen = URL(string: url) {
            app.open(toOpen, options: [:], completionHandler: nil)
        }
    }
    
    
    func reload() {
        print("reload")
    }
}
