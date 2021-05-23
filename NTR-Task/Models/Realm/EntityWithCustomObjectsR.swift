//
//  EntityWithCustomObjectsR.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class EntityWithCustomObjectsR: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: LocationR? = nil
    var objects = List<ObjectWithStatusesR>()
}
