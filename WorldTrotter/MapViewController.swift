//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Joachim Goennheimer on 23.03.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

//import Foundation

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var showLocation: Bool = false
    var nextAnnotation = 1
    let button = UIButton(frame: CGRect(x: 280, y: 700, width: 150, height: 50))
    
    let annotationsButton = UIButton(frame: CGRect(x: 280, y: 750, width: 150, height: 50))
    
    
    
    override func loadView() {
        
        
        
        mapView = MKMapView()
                        
        view = mapView
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
    
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        
        
        button.backgroundColor = .blue
        button.setTitle("Show location", for: .normal)
        button.addTarget(self, action: #selector(showCurrentLocationButtonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
        annotationsButton.backgroundColor = .green
        annotationsButton.setTitle("Show annotations", for: .normal)
        annotationsButton.addTarget(self, action: #selector(showAnnotation), for: .touchUpInside)
        self.view.addSubview(annotationsButton)
        
        
        print("MapViewController loaded")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "User"
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        
        
        if showLocation == true {
            print(locations)
        } else {
            print("Show Location switched off")
        }
//        let userLocation: CLLocation = locations[0]
    }
    
    @objc func showAnnotation() {
        
        var latitude: CLLocationDegrees
        var longitude: CLLocationDegrees
        
        showLocation = false
        
        switch nextAnnotation {
        case 1:
            latitude = 48.3392
            longitude = 7.8781
            
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Lahr"
            annotation.subtitle = "City of birth"
            mapView.addAnnotation(annotation)
            nextAnnotation = 2
            
        case 2:
//            button.sendActions(for: .touchUpInside)
            latitude = 48.6791
            longitude = 8.8957
            
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Aidlingen"
            annotation.subtitle = "Where I currently live"
            mapView.addAnnotation(annotation)
            nextAnnotation = 1
            nextAnnotation = 3
        case 3:
            latitude = 37.5665
            longitude = 126.9780
            
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Seoul"
            annotation.subtitle = "Best city"
            mapView.addAnnotation(annotation)
            nextAnnotation = 1
        default:
            break
        }
        
        
        
        
        
    }
    
    
    @objc func showCurrentLocationButtonClicked(sender: UIButton!) {
        print("button clicked")
        print(showLocation)
        
        if showLocation == false {
            locationManager.startUpdatingLocation()
            showLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            showLocation = false
        }
    }
    
}
