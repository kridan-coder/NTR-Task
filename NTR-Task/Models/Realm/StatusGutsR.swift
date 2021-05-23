//
//  StatusGuts.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class StatusGutsR: Object {
    var object_id = RealmOptional<Int>()
    var tag = RealmOptional<Int>()
}
