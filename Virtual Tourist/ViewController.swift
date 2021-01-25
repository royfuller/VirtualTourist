//
//  TravelLocationsMapViewController.swift
//  Virtual Tourist
//
//  Created by Roy Fuller on 1/24/21.
//

import UIKit
import MapKit

class TravelLocationsMapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

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

    // MARK: Gesture recognizer delegate methods

    // The below code was copied from https://knowledge.udacity.com/questions/249077
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

