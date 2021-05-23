//
//  RealmHepler.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import Foundation
import RealmSwift

class RealmHepler {
    
    private init(){}
    
    private static let realm = try! Realm()
    
    class func setDataToDatabase(_ data: EntityWithCustomObjects) {
        let convertedData = convertFromEntityAppToEntityR(data)
        try! realm.write {
            realm.add(convertedData)
        }
        
    }
    
    class func getDataFromDatabase() -> EntityWithCustomObjects? {
        let databaseData = realm.objects(EntityWithCustomObjectsR.self)
        guard databaseData.count != 0 else {return nil}
        return convertFromEntityRToEntityApp(databaseData[0])
    }
    
    
    // MARK: converting
    class private func convertFromEntityAppToEntityR(_ data: EntityWithCustomObjects) -> EntityWithCustomObjectsR{
        let convertedData = EntityWithCustomObjectsR()
        
        convertedData.name = data.name!
        
        convertedData.location = LocationR()
        convertedData.location?.gps_lat.value = data.location?.gps_lat
        convertedData.location?.gps_lng.value = data.location?.gps_lng
        
        let convertedObjects = List<ObjectWithStatusesR>()
        
        for object in data.objects! {
            let convertedObject = ObjectWithStatusesR()
            let convertedObjectGuts = ObjectGutsR()
            let convertedStatuses = List<StatusR>()
            
            convertedObjectGuts.name = object.object.name
            convertedObjectGuts.object_id.value = object.object.object_id
            convertedObjectGuts.title = object.object.title
            
            convertedObject.object = convertedObjectGuts
            
            if object.statuses != nil {
                for status in object.statuses! {
                    let convertedStatus = StatusR()
                    let convertedStatusGuts = StatusGutsR()
                    
                    convertedStatusGuts.object_id.value = status.status?.object_id
                    convertedStatusGuts.tag.value = status.status?.tag
                    
                    convertedStatus.status = convertedStatusGuts
                    
                    convertedStatuses.append(convertedStatus)
                }
            }
            
            
            convertedObject.statuses = convertedStatuses
            
            convertedObjects.append(convertedObject)
        }
        
        convertedData.objects = convertedObjects
        
        return convertedData
        
    }
    
    class private func convertFromEntityRToEntityApp(_ data: EntityWithCustomObjectsR) -> EntityWithCustomObjects{
        var convertedData = EntityWithCustomObjects()
        
        convertedData.name = data.name
        
        convertedData.location = Location()
        convertedData.location?.gps_lat = data.location?.gps_lat.value
        convertedData.location?.gps_lng = data.location?.gps_lng.value
        
        var convertedObjects = [ObjectWithStatuses]()
        
        for object in data.objects {
            
            var convertedObjectGuts = ObjectGuts()
            var convertedStatuses = [Status]()
            
            convertedObjectGuts.name = object.object!.name
            convertedObjectGuts.object_id = object.object!.object_id.value
            convertedObjectGuts.title = object.object!.title
            
            
            var convertedObject = ObjectWithStatuses(object: convertedObjectGuts)

            for status in object.statuses {
                var convertedStatus = Status()
                var convertedStatusGuts = StatusGuts()
                
                convertedStatusGuts.object_id = status.status?.object_id.value
                convertedStatusGuts.tag = status.status?.tag.value
                
                convertedStatus.status = convertedStatusGuts
                
                convertedStatuses.append(convertedStatus)
            }

            convertedObject.statuses = convertedStatuses
            
            convertedObjects.append(convertedObject)
        }
        
        convertedData.objects = convertedObjects
        
        return convertedData
        
    }
}
