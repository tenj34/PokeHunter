//
//  Annotation.swift
//  PokeHunter
//
//  Created by Juan Tenezaca on 2/25/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Annotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var supplies: Supplies
    
    init(coord: CLLocationCoordinate2D, supplies: Supplies) {
        self.coordinate = coord
        self.supplies = supplies
    }
}
