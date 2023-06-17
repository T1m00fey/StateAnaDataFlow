//
//  StorageManager.swift
//  StateAnaDataFlow
//
//  Created by Тимофей Юдин on 17.06.2023.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let key = "user"
    
    private let errorUser = User(name: "", isSigned: false)
    
    func fetchUser() -> User {
        guard let data = userDefaults.data(forKey: key) else { return errorUser }
        guard let user = try? JSONDecoder().decode(User.self, from: data) else { return errorUser }
        
        return user
    }
    
    func save(user: User) {
        guard let user = try? JSONEncoder().encode(user) else { return }
        
        userDefaults.set(user, forKey: key)
    }
    
    func deleteUser() {
        guard let user = try? JSONEncoder().encode(errorUser) else { return }
        userDefaults.set(user, forKey: key)
    }
}
