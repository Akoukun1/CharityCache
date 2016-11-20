//
//  MapViewController.swift
//  CharityCache
//
//  Created by Aditya Koukuntla on 11/19/16.
//  Copyright © 2016 CharityCache. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        centerMapOnLocation(currentLocation)
        
        ann.title = "Get \(self.title!) coupon, $20.00"
        mapView.addAnnotations([ann])
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Clicked")
        
        let alertController = UIAlertController(title: "Congrats", message: "Grabbed a \(self.title!) coupon worth $20.00 ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapClicked(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }


}

extension MapViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
            }
            return view
    }
}
