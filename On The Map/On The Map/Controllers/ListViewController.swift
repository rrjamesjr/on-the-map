//
//  ListViewController.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: OnTheMapController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reload()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationModel.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinTableViewCell")!
        
        let studentLocation = StudentLocationModel.studentLocations[indexPath.row]
        
        cell.textLabel?.text = studentLocation.getFullName()
    //    cell.imageView?.image = UIImage(named: "icon_pin")
        cell.detailTextLabel?.text = studentLocation.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openUrl(url: StudentLocationModel.studentLocations[indexPath.row].mediaURL)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func reload() {
        tableView.reloadData()
    }
    
}
