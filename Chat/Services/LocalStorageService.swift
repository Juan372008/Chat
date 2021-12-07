//
//  LocalStorageService.swift
//  Chat
//
//  Created by Juan Gallo on 8/5/21.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId:String?, username:String?){
        
        let defaults = UserDefaults.standard
        
        defaults.set(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(username, forKey: Constants.LocalStorage.usernameKey)
    }
    
    static func loadUser() ->PhotoUser {
        
        let defaults = UserDefaults.standard
        let userId = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        let username = defaults.value(forKey: Constants.LocalStorage.usernameKey) as? String
        
        if userId != nil && username != nil {
            return PhotoUser(userId: userId!, username: username!)
        }
        else {
            return PhotoUser(userId: "", username: "")
        }
    }
    
    static func clearUser() {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.setValue(nil, forKey: Constants.LocalStorage.usernameKey)
        
    }
}
