//
//  Entity.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import Foundation

struct Entity: Decodable {
    var name: String? = nil
    var location: Location? = nil
    var objects: ObjectAPI? = nil
}
