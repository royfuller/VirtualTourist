//
//  TravelLocationsMapViewController.swift
//  Virtual Tourist
//
//  Created by Roy Fuller on 1/24/21.
//

import UIKit
import MapKit

class TravelLocationsMapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

    // MARK: Variables
    
    var dataController: DataController!
    
    // MARK: Outlets

    @IBOutlet weak var mapView: MKMapView!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Virtual Tourist"
        mapView.delegate = self

        // This code was copied from https://knowledge.udacity.com/questions/249077
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: MapView delegate methods
    
    // The below code was copied from the PinSample app.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = false
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.performSegue(withIdentifier: "showPhotoAlbumView", sender: self)
    }
    
    // MARK: Gesture recognizer delegate methods

    // The below code was copied from https://knowledge.udacity.com/questions/249077
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        VirtualTouristClient.getPhotos(lat: CLLocationDegrees(coordinate.latitude).description, lon: CLLocationDegrees(coordinate.longitude).description) { (errorDescription) in
            if(errorDescription != nil) {
                print(errorDescription!)
            }
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

