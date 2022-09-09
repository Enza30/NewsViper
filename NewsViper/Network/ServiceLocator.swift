//
//  ServiceLocator.swift
//  NewsViper
//
//  Created by Farendza Muda on 09/09/22.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    private lazy var services: Dictionary<String, Any> = [:]
    
    private init(){}
    
    private func typeName(some:Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        self.services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
