//
//  FinishAddingLocationController.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/4/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FinishAddingLocationController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var placemark:CLPlacemark!
    var mapString:String = ""
    var link: String = ""
    
    override func viewDidLoad() {
        mapView.delegate = self
        let annotation = MKPointAnnotation()
        if let city = self.placemark.locality,
            let state = self.placemark.administrativeArea,
            let country = self.placemark.country {
            
            annotation.title = "\(city), \(state), \(country)"
        }
        if let coordinate = self.placemark.location?.coordinate {
            annotation.coordinate = coordinate
        }
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: CLLocationDistance(100000), longitudinalMeters: CLLocationDistance(100000))
        mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    @IBAction func finishAddingLocation(_ sender: UIButton) {
        var studentLocation = StudentLocation(objectId: "", uniqueKey: (UdacityClient.userInfo?.account.key)!, firstName: "Rudy", lastName: "James", mapString: mapString, mediaURL: link, latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!, createdAt: "", updatedAt: "")
        
        StudentLocationClient.addStudentLocation(studentLocation: studentLocation) { (response, error) in
            guard let response = response else {
                print(error!)
                self.showAlert(title: "Add Location Failed", message: "Please try again")
                return
            }
            
            studentLocation.objectId = response.objectId
            studentLocation.createdAt = response.createdAt
            
            StudentLocationModel.studentLocations.insert(studentLocation, at: 0)

            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
