//
//  ObjectGutsR.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class ObjectGutsR: Object {
    @objc dynamic var name: String? = nil
    let object_id = RealmOptional<Int>()
    @objc dynamic var title: String? = nil
}
