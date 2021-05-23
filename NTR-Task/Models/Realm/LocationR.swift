//
//  LocationR.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class LocationR: Object {
    let gps_lat = RealmOptional<Double>()
    let gps_lng = RealmOptional<Double>()
}
