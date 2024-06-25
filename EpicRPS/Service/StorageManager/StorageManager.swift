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
    func codableData<T: Decodable>(_ type: T.Type, forKey key: StorageManager.Keys) -> T?
    func set(object: Any?, forKey key: StorageManager.Keys)
    func get(forKey key: StorageManager.Keys) -> Any?
}


//MARK: - Storage Manager

final class StorageManager {
    
    enum Keys: String {
        case userScore
        case computerScore
        case userVictory
        case userLoses
        case computerVictory
        case computerLoses
    }
    
    static let shared = StorageManager()
    
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
    func set(object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
    }
    
    func get(forKey key: StorageManager.Keys) -> Any? {
        defaults.object(forKey: key.rawValue)
    }
    
    
    func set<T: Encodable>(object: T?, forKey key: Keys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func codableData<T: Decodable>(_ type: T.Type, forKey key: Keys) -> T? {
        guard let data = restore(forKey: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(type.self, from: data)
    }
}
