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
            MapKit.CLGeocoder().geocodeAddressString(locationTextField.text!) { (placemarkers, error) in
                guard let placemarkers = placemarkers else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Finding Location", message: error!.localizedDescription)
                    }
                    return
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
        let annotation = MKPointAnnotation()
        if let city = self.placemark.locality,
            let state = self.placemark.administrativeArea,
            let country = self.placemark.country {
            
            annotation.title = "\(city), \(state), \(country)"
        }
        if let coordinate = self.placemark.location?.coordinate {
            annotation.coordinate = coordinate
        }
        destination.annotation = annotation
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
