//
//  MapsViewController.swift
//  Meetapp
//
//  Created by Azuan on 14/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapsViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    var events = try! Realm().objects(Event)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.startUpdatingLocation()
        
        for event in events {
            let annotation = MKPointAnnotation()
            annotation.title = event.name
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: event.location!.latitude,
                longitude: event.location!.longitude
            )
            map.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let annotation = MKPointAnnotation()
        annotation.title = "You are here"
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        map.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        map.setRegion(region, animated: true)

        manager.stopUpdatingLocation()
    }
}
