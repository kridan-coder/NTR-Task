//
//  ObjectWithStatusesR.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class ObjectWithStatusesR: Object {
    @objc dynamic var object: ObjectGutsR? = nil
    var statuses = List<StatusR>()
}
