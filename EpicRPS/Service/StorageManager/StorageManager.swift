//
//  StorageManager.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import Foundation

//MARK: - StorageManagerProtocol

protocol StorageManagerProtocol {
    func set<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
    func codableData<T: Decodable>(forKey key: StorageManager.Keys) -> T?
}


//MARK: - Storage Manager

final class StorageManager {
    enum Keys: String {
        case statistics
    }
    
    
    private let defaults = UserDefaults.standard
    
    
    private func store(_ object: Any?, key: String) {
        defaults.setValue(object, forKey: key)
    }
    
    
    private func restore(forKey key: String) -> Any? {
        defaults.object(forKey: key)
    }
}


//MARK: - StorageManagerProtocol Implementation

extension StorageManager: StorageManagerProtocol {
    func set<T>(object: T?, forKey key: Keys) where T : Encodable {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func codableData<T>(forKey key: Keys) -> T? where T : Decodable {
        guard let data = restore(forKey: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
