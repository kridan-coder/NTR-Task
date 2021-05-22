//
//  ApiClient.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import Foundation
import Alamofire

// singleton

// for following single-resonsibility principle 2 classes should be created:
// first for handling ApiClient's objects amount, second for ApiClient's logic

class ApiClient {
    
    private init() {}
    
    private var logic = ApiClientLogic()
    
    static var shared = ApiClient()
    
    func getEntityData(onSuccess: @escaping (Entity) -> Void) {
        logic.getEntityData(onSuccess: onSuccess)
    }
    
    func getObjectsStatuses(onSuccess: @escaping ([Status]) -> Void) {
        logic.getObjectsStatuses(onSuccess: onSuccess)
    }
    
    private class ApiClientLogic {
        let baseURL = "https://dl.dropboxusercontent.com/s/"
        
        func getEntityData(onSuccess: @escaping (Entity) -> Void){
            AF.request(baseURL + "ufwuccum01rchdl/entity.json", method: .get).response  { response in
                switch response.result{
                case .failure(let error):
                    print(error.errorDescription ?? "Unhandled error while requesting Entity.")
                case .success(let data):
                    
                    guard let safeData = data else {
                        print("Error: response is empty.")
                        return
                    }
                    onSuccess(try! JSONDecoder().decode(Entity.self, from: safeData))
                    
                }
            }
        }
        
        func getObjectsStatuses(onSuccess: @escaping ([Status]) -> Void){
            AF.request(baseURL + "c9o1x8i45q5872k/statuses.json", method: .get, encoding:  URLEncoding.default).response  { response in
                switch response.result{
                case .failure(let error):
                    print(error.errorDescription ?? "Unhandled error while requesting Object Statuses.")
                case .success(let data):
                    
                    guard let safeData = data else {
                        print("Error: response is empty.")
                        return
                    }
                    
                    onSuccess(try! JSONDecoder().decode([Status].self, from: safeData))
                    
                }
            }
        }
    }
    
    
}

extension ApiClient: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
