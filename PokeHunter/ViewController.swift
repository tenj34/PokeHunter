//
//  ViewController.swift
//  PokeHunter
//
//  Created by Juan Tenezaca on 2/19/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print ("We are ready to use")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if updateCount < 3 {
            let region  = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 400, 400)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate{
        
        let region  = MKCoordinateRegionMakeWithDistance(coord, 400, 400)
        mapView.setRegion(region, animated: true)
        updateCount += 1
      }
    }
}

