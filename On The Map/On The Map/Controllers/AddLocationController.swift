//
//  AddLocationController.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/4/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddLocationController: UIViewController {
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var findLocationButton: UIButton!
    
    var placemark:CLPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewLocation(_ sender: UIButton) {
        if locationTextField.text!.isEmpty {
            showAlert(title: "Location is Required", message: "Please enter a location (City, State)")
        }
        else if urlTextField.text!.isEmpty {
            showAlert(title: "Link is Required", message: "Please enter a valid URL (https://www.udacity.com)")
        }
        else {
            toggleState()
            MapKit.CLGeocoder().geocodeAddressString(locationTextField.text!) { (placemarkers, error) in
                guard let placemarkers = placemarkers else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Finding Location", message: error!.localizedDescription)
                        self.toggleState()
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.toggleState()
                }
                
                if placemarkers.count > 0 {
                    self.placemark = placemarkers[0]
                    self.performSegue(withIdentifier: "finishAddingLocation", sender: self)
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FinishAddingLocationController
        destination.placemark = self.placemark
        destination.link = urlTextField.text!
        destination.mapString = locationTextField.text!
    }
    
    
    fileprivate func toggleState() {
        locationTextField.isEnabled = !locationTextField.isEnabled
        urlTextField.isEnabled = !urlTextField.isEnabled
        findLocationButton.isEnabled = !findLocationButton.isEnabled
        
        if activityIndicatorView.isAnimating {
            activityIndicatorView.stopAnimating()
        } else {
            activityIndicatorView.startAnimating()
        }
    }
}
