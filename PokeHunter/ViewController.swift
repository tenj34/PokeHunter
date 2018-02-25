//
//  ViewController.swift
//  PokeHunter
//
//  Created by Juan Tenezaca on 2/19/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    var supplieses : [Supplies] = [] // excuse the grammar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSupplies()
        
        supplieses = getAllSupplies()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.delegate = self
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                // spawn an object
                
                if let coord = self.manager.location?.coordinate{
                
                    let anno  = Annotation(coord: coord, supplies: Supplies)
                anno.coordinate = coord

                let randolat = (Double(arc4random_uniform(200)) - 100.0)/500000.0
                let randolon = (Double(arc4random_uniform(200)) - 100.0)/500000.0
                anno.coordinate.longitude += randolon
                anno.coordinate.latitude += randolat
                self.mapView.addAnnotation(anno)
                }
            })
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       
        if annotation is MKUserLocation {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            annoView.image = UIImage(named: "boy-4")
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50
            
            annoView.frame = frame
            
            return annoView
            
        }
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
       annoView.image = UIImage(named: "matches")
       var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        
        annoView.frame = frame
        
        return annoView
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if updateCount < 3 {
            let region  = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate{
        
        let region  = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
        mapView.setRegion(region, animated: true)
        updateCount += 1
      }
    }
}

