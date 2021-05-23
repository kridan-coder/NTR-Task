//
//  Repository.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import Foundation

// singleton

// for following single-resonsibility principle 2 classes should be created:
// first for handling Repository's objects amount, second for Repository's logic

class Repository {
    
    private init() {}
    
    private var logic = RepositoryLogic()
    
    static var shared = Repository()
    
    func getEntity(onSuccess: @escaping (EntityWithCustomObjects?) -> Void){
        logic.getEntity(onSuccess: onSuccess)
    }
    
    
    private class RepositoryLogic {
        
        var entityWithCustomObjects: EntityWithCustomObjects!
        {
            didSet {
                RealmHepler.setDataToDatabase(entityWithCustomObjects)
            }
        }
        var objectsWithStatuses = [ObjectWithStatuses]()
        
        var statuses: [Status]!
        var entity: Entity!
        
        
        func getEntity(onSuccess: @escaping (EntityWithCustomObjects?) -> Void) {
            
            if Reachability.isConnectedToNetwork(){
                sendRequestEntity { [weak self]response in
                    self?.entity = response
                    
                    self?.sendRequestStatuses{ response in
                        self?.statuses = response
                        self?.convertAndSort()
                        onSuccess((self?.entityWithCustomObjects)!)
                    }
                }
            }
            else {
                onSuccess(RealmHepler.getDataFromDatabase())
            }
            

        }
        

        // MARK: converting and sorting
        
        private func convertAndSort(){
             
            objectsWithStatuses = convertToObjectsWithStatuses(statuses: self.statuses, entity: self.entity)
            
            objectsWithStatuses = sortObjectsWithStatuses(self.objectsWithStatuses)
            
            entityWithCustomObjects = convertToCustomEntity(objects: objectsWithStatuses, entity: entity)
        }
        
        private func sendRequestEntity(onSuccess: @escaping (Entity) -> Void) {
            let apiClient = ApiClient.shared
            apiClient.getEntityData { response in
                onSuccess(response)
            }
        }
        
        private func sendRequestStatuses(onSuccess: @escaping ([Status]) -> Void) {
            let apiClient = ApiClient.shared
            apiClient.getObjectsStatuses{ response in
                onSuccess(response)
            }
        }
        
        private func convertToObjectsWithStatuses(statuses: [Status], entity: Entity) -> [ObjectWithStatuses] {
            var newObjectsWithStatuses = [ObjectWithStatuses]()
            
            var dictionary = [Int : [Status]]()
            
            for status in statuses {
                var array = dictionary[status.status!.object_id!] ?? []
                array.append(status)
                dictionary[status.status!.object_id!] = array
            }
            
            for object in entity.objects!.object! {
                let statuses = dictionary[object.object_id!]
                newObjectsWithStatuses.append(ObjectWithStatuses(object: object, statuses: statuses))
                
            }
            return newObjectsWithStatuses
        }
        
        private func sortObjectsWithStatuses(_ objects: [ObjectWithStatuses]) -> [ObjectWithStatuses] {
            var sortedObjectsWithStatuses = objects
            
            sortedObjectsWithStatuses.sort {x, y in
                if x.statuses != nil && y.statuses == nil {
                    return true
                }
                else if x.statuses == nil && y.statuses != nil {
                    return false
                }
                else if x.statuses != nil && y.statuses != nil {
                    
                    // gets minimum tag from statuses of the object and compares with
                    // another minimum tag
                    
                    return (x.statuses!.min{t1, t2 in
                        return t1.status!.tag! < t2.status!.tag!
                    }?.status!.tag!)! < (y.statuses!.min{t1, t2 in
                        return t1.status!.tag! < t2.status!.tag!
                    }?.status!.tag!)!
                }
                else {
                    
                    if x.object.name! != y.object.name! {
                        return x.object.name! < y.object.name!
                    }
                    else {
                        return x.object.title! < y.object.title!
                    }
                    
                }
                
            }
            
            return sortedObjectsWithStatuses
        }
        
        private func convertToCustomEntity(objects: [ObjectWithStatuses], entity: Entity) -> EntityWithCustomObjects {
            var customEntity = EntityWithCustomObjects()
            customEntity.name = entity.name
            customEntity.location = entity.location
            customEntity.objects = objectsWithStatuses
            return customEntity
        }
    }
}

extension Repository: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
